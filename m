Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA42642 for <linux-archive@neteng.engr.sgi.com>; Sun, 17 Jan 1999 22:19:07 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA43830
	for linux-list;
	Sun, 17 Jan 1999 22:18:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA36631
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 17 Jan 1999 22:18:19 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA08366
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 Jan 1999 01:18:19 -0500 (EST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA06643
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 Jan 1999 01:18:33 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 18 Jan 1999 01:18:32 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Problems getting 2.1.131 to build.
Message-ID: <Pine.LNX.3.96.990118011528.30635A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


First off, thanks for getting linus.linux.sgi.com back online!

Okay. Here's the log of my build of 2.1.131 from the CVS:

make[3]: Entering directory `/usr/src/newlinux/linux/fs/proc'
egcs -D__KERNEL__ -I/usr/src/newlinux/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
-mcpu=r4600 -mips2 -pipe   -c -o array.o array.c
array.c: In function `get_phys_addr':
array.c:399: warning: int format, pid_t arg (arg 2)
array.c: In function `task_state':
array.c:738: warning: int format, pid_t arg (arg 4)
array.c:738: warning: int format, pid_t arg (arg 5)
array.c:738: warning: int format, uid_t arg (arg 6)
array.c:738: warning: int format, uid_t arg (arg 7)
array.c:738: warning: int format, uid_t arg (arg 8)
array.c:738: warning: int format, uid_t arg (arg 9)
array.c:738: warning: int format, gid_t arg (arg 10)
array.c:738: warning: int format, gid_t arg (arg 11)
array.c:738: warning: int format, gid_t arg (arg 12)
array.c:738: warning: int format, gid_t arg (arg 13)
array.c:741: warning: int format, long int arg (arg 3)
array.c: In function `get_stat':
array.c:947: warning: int format, pid_t arg (arg 6)
array.c:947: warning: int format, pid_t arg (arg 7)
array.c:947: warning: int format, pid_t arg (arg 8)
array.c: In function `get_root_array':
array.c:1351: duplicate case value
array.c:1347: this is the first entry for that value
array.c:1352: warning: implicit declaration of function
`get_ds1286_status'
make[3]: *** [array.o] Error 1
make[3]: Leaving directory `/usr/src/newlinux/linux/fs/proc'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/newlinux/linux/fs/proc'
make[1]: *** [_subdir_proc] Error 2
make[1]: Leaving directory `/usr/src/newlinux/linux/fs'
make: *** [_dir_fs] Error 2

my egcs version:
[root@black linux]# egcs -v
Reading specs from /usr/lib/gcc-lib/mips-linux/egcs-2.90.27/specs
gcc version egcs-2.90.27 980315 (egcs-1.0.2 release)


Any ideas?  Looking at the code, what's CONFIG_SGI_DS1286?

- Alex

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
