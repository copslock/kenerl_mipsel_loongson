Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA50318 for <linux-archive@neteng.engr.sgi.com>; Sat, 9 May 1998 20:08:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA16801079
	for linux-list;
	Sat, 9 May 1998 20:06:31 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA22495054
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 9 May 1998 20:06:28 -0700 (PDT)
Received: from mdhill.interlog.com (mdhill.interlog.com [199.212.154.112]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id UAA03174
	for <linux@cthulhu.engr.sgi.com>; Sat, 9 May 1998 20:06:24 -0700 (PDT)
	mail_from (mike@mdhill.interlog.com)
Received: (from mike@localhost) by mdhill.interlog.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id XAA02041; Sat, 9 May 1998 23:05:23 -0400
From: Michael Hill <mdhill@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sat,  9 May 1998 23:05:22 -0400 (EDT)
To: linux@cthulhu.engr.sgi.com
Subject: Evidence of Drive Activity to Report
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <13652.59663.188834.236218@mdhill.interlog.com>
Reply-To: mdhill@interlog.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Using the pre-compiled 2.1.99 from Linus (thanks, Alex) here are my
results.  The drive is (and was) partitioned as option drive, and I
re-ran Installer.  Entering 'boot /vmlinux root=/dev/sdb' I get this:

[snip]
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 1070496 [522 MB]
[0.5 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2400302 [1172 MB]
[1.2 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:07:e3:0d
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3
fat_read_super: Did not find valid FSINFO signature. Found 0x0
[MS-DOS FS Rel. 12,FAT 0, check=n,conv=b,uid=o,gid=0,umask=022,bmap]
[me=0x0,cs=0,#f=0,fs=0,fl=0,ds=0,de=0,data=0,se=8199,ts=524288,ls=30825,rc=0,fc=0]
Transaction block size = 512


However, with 'boot /vmlinux root=/dev/sdb1' I get this:

[snip]
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 1070496 [522 MB]
[0.5 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2400302 [1172 MB]
[1.2 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:07:e3:0d
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 32k freed
INIT: version 2.71 booting
Activating swap partitions
hostname: localhost
Checking root filesystems.
WARNING: Your /etc/fstab does not contain the fsck passno
        field.  I will kludge around things for you, but you
        should fix your /etc/fstab file as soon as you can.

Parallelizing fsck version 1.10 (24-Apr-97)
[/sbin/fsck.ext2] fsck.ext2 -a /

..and then nothing.  But the main reason I believe that the SGI/Linux
project is not dead is that, for the first time, the kernel made my
hard drive chatter at me before giving up the ghost.

Who knows what I should do next?

Mike
-- 
Michael Hill
Toronto, Canada
mdhill@interlog.com
