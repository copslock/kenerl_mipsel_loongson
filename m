Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA130708 for <linux-archive@neteng.engr.sgi.com>; Wed, 22 Oct 1997 15:30:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA27620 for linux-list; Wed, 22 Oct 1997 15:29:26 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA27606 for <linux@cthulhu.engr.sgi.com>; Wed, 22 Oct 1997 15:29:24 -0700
Received: from multi11.netcomi.com (multi11.netcomi.com [204.58.155.211]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA16489
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Oct 1997 15:29:23 -0700
	env-from (mgix@nothingreal.com)
Received: from void (lax-ca62-01.ix.netcom.com [207.93.37.97]) by multi11.netcomi.com (8.8.5/8.7.3) with SMTP id RAA29324 for <linux@cthulhu.engr.sgi.com>; Wed, 22 Oct 1997 17:29:20 -0500
Message-ID: <344E7DB2.167E@nothingreal.com>
Date: Wed, 22 Oct 1997 15:26:58 -0700
From: Emmanuel Mogenet <mgix@nothingreal.com>
Organization: Nothing Real, LLC
X-Mailer: Mozilla 3.01Gold (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Step by step of my experience
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi guys,

I've tried to boot Linux on my old clunky R5k this morning, and
I thought I'd share the step by step with the list.

Basically, I've tried to boot off an EFS filesystem (d4), and here's
how I went about it:

1. /d4 is my third scsi disk, with EFS (/dev/sdc under linux)

2. My irix kernel is in /unix on first disk (/dev/sda), which is XFS.
   Which is OK, since only the kernel is on XFS and the loader can
   handle it.

3. mkdir /d4/lsgi

4. Put ftp://ftp.linux.sgi.com/pub/test/vmlinux-970916-efs.gz in
   /d4/lsgi

5. Put ftp://ftp.linux.sgi.com:/pub/mips-linux/root-be-0.00.cpio.gz in
   /d4/lsgi

6. Extract root-be-0.00.cpio.gz in /d4:
        cd /d4
        gzip -dc lsgi/root-be-0.00.cpio.gz | cpio -icvd

7. Install kernel on /
        cd /d4/lsgi
        gzip -d vmlinux-970916-efs.gz
        cp vmlinux-970916-efs /vmlinux

8. Reboot, go to maintenance mode, launch sash and type:
        scsi(0)disk(1)rdisk(0)partition(0)/vmlinux root=/dev/sdc1

7. The kernel booted, said a great many (good) things and froze with the
   following messages:
        VFS: mounted root (efs filesystem) readonly
        EFS: inode 0x30301 has >EFS_MAX_EXTENTS (43)
        EFS: <6> attempt to access beyond end of device
        08:21 rw=0 want=1190802192, limit=4191574

Conclusion: Wait for Ralf to finish the EFS driver !
This is the exact bug he was talking about.

Also: I read a few mails about typing, under sash, the following:
        boot /vmlinux root=/dev/sdc1

Well, it doesn't work.
First, the syntax for the sash boot command in my PROM is: boot -f
<file> -n <args>
Second, when I did boot -f /vmlinux -n root=/dev/sdc1, it just loaded
the kernel,
but didn't jump into it. It just told me: the entry address is <some hex
number>.

When I did go <some hex number>, it ran linux, but tried to boot off 
tftp.
Obviously it ignored the args.

I'm just wondering: is there many different versions of sash out there ?

I'm off trying to boot off tftpd.
I'll keep the list posted.

Ciao,

        - Mgix


-- 

________________________________________________________________________________
Emmanuel Mogenet <mgix@nothingreal.com>                       PGP Key on
Request
