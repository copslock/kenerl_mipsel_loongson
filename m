Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2004 03:02:28 +0000 (GMT)
Received: from law10-f54.law10.hotmail.com ([IPv6:::ffff:64.4.15.54]:51724
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225564AbUA3DCU>; Fri, 30 Jan 2004 03:02:20 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 29 Jan 2004 19:02:09 -0800
Received: from 24.209.41.112 by lw10fd.law10.hotmail.msn.com with HTTP;
	Fri, 30 Jan 2004 03:02:09 GMT
X-Originating-IP: [24.209.41.112]
X-Originating-Email: [juszczec@hotmail.com]
X-Sender: juszczec@hotmail.com
From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
To: linux-mips@linux-mips.org
Subject: readdir() problems
Date: Fri, 30 Jan 2004 03:02:09 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F54DrroFpJasS000386db@hotmail.com>
X-OriginalArrivalTime: 30 Jan 2004 03:02:09.0413 (UTC) FILETIME=[735CD350:01C3E6DD]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips


Hi folks

I'm running on a Helio pda, r3912 chip, little endian.  I've used crosstool 
to create a cross compiler with

gcc 3.2.3
glibc 2.2.3

When I run the following code (linked static or dynamic):

#include <stdio.h>
#include <sys/types.h>
#include <dirent.h>
#include <errno.h>

main(int argc, char **argv){
        DIR* dir;
        struct dirent* entry;
        int len;
        int hlen;
        char* name;
        char* buf;

        printf("in dirtest main()\n");
        fprintf(stderr,"in dirtest main()\n");
        dir = opendir("/bin");
        if (dir == 0) {
          fprintf(stderr,"opendir returned 0\n");
        }
        else{
                fprintf(stderr,"opendir returned dir=%x\n",dir);
        }

        entry=readdir(dir);
        fprintf(stderr,"after readdir\n");
        printf("errno=%d\n",errno);
        if (entry != 0){
          fprintf(stderr,"entry=%x\n",entry);
          name = entry->d_name;
          fprintf(stderr,"name=%s\n",name);
          while ((entry = readdir(dir)) != 0) {
                name = entry->d_name;
                fprintf(stderr,"name=%s\n",name);
          }
        }
        else{
          fprintf(stderr,"readdir failed and you can't reference entry\n");
        }

        closedir(dir);

}

I get the following output:

/bin # ./dirtest
in dirtest main()
opendir returned dir=100000c8

I can only assume its crashing after entry=readdir(dir)
Does anyone know of any readdir() problems in linux-mips world?

Mark

_________________________________________________________________
Learn how to choose, serve, and enjoy wine at Wine @ MSN. 
http://wine.msn.com/
