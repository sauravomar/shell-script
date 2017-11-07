#---------Move the apps folder-------------
cd $WORKSPACE/apps

#------------ Run Maven-------------------
mvn clean install -P$profile

#------------ Sonar check------------------

if [ "$runSonarForPullRequest" = "true" ]; then
  mvn sonar:sonar -Dsonar.analysis.mode=issues -Dsonar.bitbucket.branchName=${branch} -X
  exit 0  #running only sonar check
else
  mvn -DskipTests sonar:sonar -Dsonar.analysis.mode=publish -Dsonar.bitbucket.branchName=${branch} -X
fi
#--------- Release to Nexus -----------------


  if [ "$ShouldRelease" = "true" && "$profile" = "prod" ]; then
     echo "#######################################################"
     echo "#################  STARTED RELEASING ##################"
      
     echo "Maven RELEASE START"
     mvn --batch-mode jgitflow:release-start -Darguments=-DskipTests -DreleaseVersion=${RealseVersion} -DdevelopmentVersion=${NextDevelopmentVersion}-SNAPSHOT -P ${profile};
     

     echo "Maven RELEASE FINISH"
     mvn --batch-mode jgitflow:release-finish -Darguments=-DskipTests -DreleaseVersion=${RealseVersion} -DdevelopmentVersion=${NextDevelopmentVersion}-SNAPSHOT -P ${profile};

     echo "################# COMPLETED RELEASING ##################"
     echo "#######################################################"
  fi

  ### Move to docker file folder
  cd $WORKSPACE/

  ### Remove the already created images
  if [ "$updateImage" = "true" &&   $(docker images --format '{{.Repository}}' | grep 'dsp-auth') ]; then
       echo "Docker image identified to delete"
       docker rmi $(docker images --format '{{.Repository}}' | grep 'dsp-auth')
  fi

  ### We have to build a profile specific docker image
  if [ "$profile" = "prod" ] || [ "$profile" = "staging" ]; then
     docker build --build-arg profile=prod -t dsp-auth .

  ### Prepare a new tag version, to ensure we have a staging version of docker image
    tag_version=""
    if [ "$profile" = "staging" ]; then
       tag_version="Staging_"
    fi
  fi

  DOCKER_IMAGE_URL=230367374156.dkr.ecr.us-east-1.amazonaws.com/capabilities:datamanagement-"$tag_version$RealseVersion"

  #-------Get AWS Login credentials----------------------
  $(aws ecr get-login --region us-east-1)

  #-------Have docker create a tag which can be used to deploy--------------
  docker tag dsp-auth:latest $DOCKER_IMAGE_URL

  #------Once the image is created, we need to push that image to aws ECR which was configured--------------
  docker push $DOCKER_IMAGE_URL

  #--------Create a new task definition and upload the image to the same---------
  TASK_FAMILY="activation"
  SERVICE_NAME="dsp-auth-service";
  CLUSTER_NAME="dsp-auth";

  if [ "$profile" = "staging" ]; then
     SERVICE_NAME=$SERVICE_NAME-staging
     CLUSTER_NAME=$CLUSTER_NAME-staging;
  fi

  NEW_DOCKER_IMAGE="$DOCKER_IMAGE_URL"

  #----------Logic to replace new docker image ---------------
  OLD_TASK_DEF=$(aws ecs describe-task-definition --task-definition $TASK_FAMILY --output json --region us-east-1)
  NEW_TASK_DEF=$(echo $OLD_TASK_DEF | jq --arg NDI $NEW_DOCKER_IMAGE '.taskDefinition.containerDefinitions[0].image=$NDI')

  #-----------Command update in task definition---------------------
  FINAL_TASK=$(echo $NEW_TASK_DEF | jq '.taskDefinition|{family: .family, volumes: .volumes, containerDefinitions: .containerDefinitions}')

  #--------- Update New version----------------------
  aws ecs register-task-definition --family $TASK_FAMILY --cli-input-json "$(echo $FINAL_TASK)" --region us-east-1
  aws ecs update-service --service $SERVICE_NAME --task-definition $TASK_FAMILY --cluster $CLUSTER_NAME --region us-east-1
