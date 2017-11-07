
use admin
db.system.users.remove({})    <== removing all users
db.system.version.remove({}) <== removing current version 
db.system.version.insert({ "_id" : "authSchema", "currentVersion" : 3 })

use druid
db.createUser(
   {
     user: "admin",
     pwd: "admin",
     roles: [ "dbAdmin" ]
   }
)
