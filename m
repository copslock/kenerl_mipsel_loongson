Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA308231 for <linux-archive@neteng.engr.sgi.com>; Sat, 20 Dec 1997 16:19:25 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA01465 for linux-list; Sat, 20 Dec 1997 16:18:52 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA01460 for <linux@engr.sgi.com>; Sat, 20 Dec 1997 16:18:50 -0800
Received: from netscape.com (h-205-217-237-46.netscape.com [205.217.237.46]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA22982
	for <linux@engr.sgi.com>; Sat, 20 Dec 1997 16:18:49 -0800
	env-from (shaver@netscape.com)
Received: from dredd.mcom.com (dredd.mcom.com [205.217.237.54])
	by netscape.com (8.8.5/8.8.5) with ESMTP id QAA07113
	for <linux@engr.sgi.com>; Sat, 20 Dec 1997 16:18:20 -0800 (PST)
Received: from netscape.com ([205.217.243.3]) by dredd.mcom.com
          (Netscape Messaging Server 3.0)  with ESMTP id AAA13525
          for <linux@engr.sgi.com>; Sat, 20 Dec 1997 16:18:18 -0800
Message-ID: <349C6008.1C2F9866@netscape.com>
Date: Sat, 20 Dec 1997 16:17:12 -0800
From: Mike Shaver <shaver@netscape.com>
Organization: Package Reflectors
X-Mailer: Mozilla 4.02 [en] (X11; U; IRIX 6.2 IP22)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Linux-installer-0.1.tar.gz
Content-Type: multipart/mixed; boundary="------------DFDF405DBCEAC354DDB30F43"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------DFDF405DBCEAC354DDB30F43
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

ftp://ftp.linux.sgi.com/pub/mips-linux/GettingStarted/Linux-installer-0.1.tar.gz
has the goods.

I've attached the INSTALL file that comes with it -- comments welcome.

I'm going to see if I can't fix that RPM problem now, because that would
let me cut the cpio size down further.

Share and enjoy!

Mike
--------------DFDF405DBCEAC354DDB30F43
Content-Type: text/plain; charset=us-ascii; name="INSTALL"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="INSTALL"

First, you must pick a partition.  I can't help you with this, beyond
assuring you that you don't want to choose one that IRIX needs.  This
partition can be on a new drive, etc.  Anything SCSI is fine, I suspect,
although I've only tried disk drives.

Once you've chosen a partition, make a symbolic link to it so that
you don't slip up and toast something: I chose "drive".

Now, it's a matter of a few simple steps:
1: make the ext2 partition:
   indy #./mke2fs drive
   [much information flies by]
   
2: start the installer, and make your basic devices:
  indy #./installer drive
  cjwsh> MAKEDEV
  [device info]
  
3: still in the installer, load the bootstrap file
  cjwsh> cpio root-be-0.01.cpio
  [piles of cpio extraction information]
  cjwsh> exit
  [ a moderately lengthy pause, and possibly a bus error -- don't worry
    about it ]
  indy #

4: check the filesystem, and repair minor damage
  indy #./e2fsck -fy drive
  [ diagnostic messages, including a few bad bits found -- all is well ]

5: copy the kernel into place in the root of your EFS partition
  indy #gzip -dc vmlinux.gz > /vmlinux
  [ XXX need info on how to boot from non-default devices ]

6: reboot!
  At the boot prompt, you'll want to enter something like:
  boot vmlinux root=/dev/sdb3
  Your choice of root= parameter will vary.  sda is the first SCSI device,
  sdb the second, etc., all assigned in increasing order of SCSI ID.  The
  partition number also varies, and it doesn't necessarily match the
  "slice ID" from IRIX.  Experiment a bit -- you can't hurt anything.
  If it prompts you to enter a runlevel, you got it right.  Enter 's'
  and press Enter when prompted for a root password.  You're in, and there
  are tools there to allow you to configure your network and ftp out.

Known problems:
- RPM doesn't work, so you can't continue the installation easily.  Fixing
  this is my first priority, and I suspect it's a library issue.
- telnet doesn't work, because it's missing ncurses.  Duh.
- If you want to change anything, you need to remount the root drive
  read-write.  This should be made easier in the future when I remember
  to fix the /etc/mtab stuff, but in the meantime, I use this:
  # mount -t ext -n -orw,remount /dev/sdc4 /
  (sdc4 is my root partition)
  # mount -t proc none /proc
  # cat /proc/mounts > /etc/mtab
- the installer should include "netcfg" to ease the network setup.

  

--------------DFDF405DBCEAC354DDB30F43--
