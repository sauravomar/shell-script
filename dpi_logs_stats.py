#!/usr/bin/python3

import sys;
import os;

#from collectors.lib import utils


def getUnProcessedDir(loc):
    unProcessedfileDir = [];
    for dirName, dirs, files in os.walk(loc):
        for fil in files:
            absPath =  dirName + "/" +fil
            if os.listdir(dirName) != "":
                unProcessedfileDir.append(absPath);
    return  unProcessedfileDir;

def main():
    loc="/home/saurav/logs/app/";
    server="dpinym";
    datacenter="NYM";
    #utils.drop_privileges();
    for fil in getUnProcessedDir(loc):
        print ("dpi.feeds.status.server %s "% (server ))
        print ("dpi.feeds.status.file %s "% (fil ))


if __name__ == "__main__":
    sys.stdout.flush();
    sys.exit(main());

