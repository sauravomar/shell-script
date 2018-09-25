#!/usr/bin/python3

from stat import S_ISREG, ST_CTIME, ST_MODE
import sys;
import os;
import time;
import glob


#from collectors.lib import utils

def getFileWithExtension(loc,extn):
   outPutFiles = {};
   # get all entries in the directory w/ stats
   entries = (os.path.join(loc, fn) for fn in os.listdir(loc))
   entries = ((os.stat(path), path) for path in entries)

   # leave only regular files, insert creation date
   entries = ((stat[ST_CTIME], path)
                         for stat, path in entries if S_ISREG(stat[ST_MODE]))
   #NOTE: on Windows `ST_CTIME` is a creation date
   #  but on Unix it could be something else
   #NOTE: use `ST_MTIME` to sort by a modification date

   for cdate, path in sorted(entries):
       if path.endswith(extn):
           outPutFiles[os.path.basename(path)] = cdate;

   return  outPutFiles;
def main():
    loc="/root/logs/compressed";
    server="dpinym";
    datacenter="NYM";
    #utils.drop_privileges();
    filesWithTS = getFileWithExtension(loc,".gz.ready");
    for fil in filesWithTS:
        print ("dpi.feeds.status.server %s "% (server ))
        print ("dpi.feeds.status.file %s "% (filesWithTS[fil] ))
        print ("dpi.feeds.status.ts %s "% (fil))


if __name__ == "__main__":
    sys.stdout.flush();
    sys.exit(main());

