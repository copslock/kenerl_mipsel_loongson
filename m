Received:  by oss.sgi.com id <S305248AbQD2Rr6>;
	Sat, 29 Apr 2000 10:47:58 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:31514 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQD2Rri>;
	Sat, 29 Apr 2000 10:47:38 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA19021; Sat, 29 Apr 2000 10:42:50 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA09542; Sat, 29 Apr 2000 10:47:07 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA89442
	for linux-list;
	Sat, 29 Apr 2000 10:39:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA00709
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 29 Apr 2000 10:38:59 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: from calvin.tor.onramp.ca (calvin.tor.onramp.ca [204.225.88.15]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id KAA08264
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Apr 2000 10:38:58 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: (qmail 6478 invoked from network); 29 Apr 2000 17:38:58 -0000
Received: from imail.hgeng.com (HELO bart.hgeng.com) (199.246.72.233)
  by mail.onramp.ca with SMTP; 29 Apr 2000 17:38:58 -0000
Received: by BART with Internet Mail Service (5.5.2232.9)
	id <HZ2QH1TK>; Sat, 29 Apr 2000 13:38:47 -0400
Message-ID: <E138DB347D10D3119C630008C79F5DEC2B9DC3@BART>
From:   Mike Hill <mikehill@hgeng.com>
To:     "'Florian Lohoff'" <flo@rfc822.org>, linux@cthulhu.engr.sgi.com
Subject: RE: [patch] getting cvs to run on IP22
Date:   Sat, 29 Apr 2000 13:38:42 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2232.9)
Content-Type: text/plain
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>>>>> "Flo" == Florian Lohoff <flo@rfc822.org> writes:

    Flo> Hi, i had the time today and retry getting 2.3.99pre6
    Flo> (current cvs) to run on SGI. I'll just attach the patch with
    Flo> what you get the kernel to work.

Patched but quits like below (native compile).  Am I missing something in my
.config?

Thanks,

Mike


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe
-c -o init/main.o init/main.c
In file included from /usr/src/linux/include/asm/bitops.h:13,
                 from /usr/src/linux/include/linux/fs.h:25,
                 from /usr/src/linux/include/linux/capability.h:13,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/asm/byteorder.h:24: linux/byteorder/big_endian.h: No
such file or directory
init/main.c:24: linux/raid/md.h: No such file or directory
/usr/src/linux/include/asm/bitops.h: In function `ext2_find_next_zero_bit':
In file included from /usr/src/linux/include/linux/fs.h:25,
                 from /usr/src/linux/include/linux/capability.h:13,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/asm/bitops.h:512: warning: implicit declaration of
function `__swab32'
make: *** [init/main.o] Error 1
