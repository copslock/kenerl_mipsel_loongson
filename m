Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA28403 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Mar 1999 10:09:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA40158
	for linux-list;
	Wed, 17 Mar 1999 10:07:22 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA63018
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Mar 1999 10:07:20 -0800 (PST)
	mail_from (gkm@gawd.mb.ca)
Received: from wormwood.gawd.mb.ca (wormwood.gawd.mb.ca [204.112.93.65]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id KAA26021
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Mar 1999 10:07:03 -0800 (PST)
	mail_from (gkm@gawd.mb.ca)
Message-Id: <199903171807.KAA26021@deliverator.sgi.com>
Received: (qmail 16586 invoked from network); 17 Mar 1999 18:06:30 -0000
Received: from moe.gawd.mb.ca (HELO gawd.mb.ca) (204.112.93.66)
  by wormwood.gawd.mb.ca with SMTP; 17 Mar 1999 18:06:30 -0000
X-Mailer: exmh version 2.0.2
To: linux@cthulhu.engr.sgi.com
From: gkm@total.net
Subject: Strange bootp behavior.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Mar 1999 12:06:29 -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've been playing with my 'new' challenge S for awhile and decided I wanted to 
be free of the Irix HD sitting there just for the vmlinux it contains.

I've got other Linux boxes about the house so decided to do a bootp from one 
of them.
The results have been mixed to say the least.
Here's what I do to the PROM:
>> printenv
SystemPartition=scsi(0)disk(1)rdisk(0)partition(8)
OSLoadPartition=scsi(0)disk(2)rdisk(0)partition(0)
OSLoader=sash
OSLoadFilename=/unix
AutoLoad=Yes
TimeZone=PST8PDT
console=d
diskless=0
dbaud=9600
volume=80
sgilogo=y
autopower=y
netaddr=204.112.93.74
eaddr=08:00:69:08:8e:af
ConsoleOut=serial(0)
ConsoleIn=serial(0)
cpufreq=150
>> setenv SystemPartition bootp():/
>> setenv OSLoader vmlinux
>> boot bootp():vmlinux root=/dev/sdb1
(this is what's suggested by the PROM manual for diskless stations)
And here's what happens when the kernel gets going:
SCSI device sda: hdwr sector= 512 bytes. Sectors= 2077833 [1014 MB] [1.0 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2070235 [1010 MB] [1.0 GB]
SCSI device sdc: hdwr sector= 512 bytes. Sectors= 4110000 [2006 MB] [2.0 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:08:8e:af
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3 sdb4
 sdc: sdc1 sdc2 sdc3
VFS: Mounted root (ext2 filesystem) readonly.
Freeing prom memory: 2132k freed
Freeing unused kernel memory: 36k freed
scsidisk I/O error: dev 08:11, sector 528
Warning: unable to open an initial console.
scsidisk I/O error: dev 08:11, sector 528
scsidisk I/O error: dev 08:11, sector 528
scsidisk I/O error: dev 08:11, sector 528
Kernel panic: No init found.  Try passing init= option to kernel.
This is the 2.2.1 tarball released around February 26th.

It seems something is trying to talk to the SCSI drive for the console.

If I leave the PROM booting with sash from the IRIX drive, it works.
(This is also using bootp to get the kernel)
So, now it's even sillier, I'm using a 1 Gig drive for what's probably a 9K 
shell.  :)

Anyone have an idea why this happens, or how to fix?
Second, anyone know where to put the root=/dev/sdb1 so I can have it autoboot 
with bootp?  I've gotten it to autobootp, but it always tries to root off of 
Dev 00:00

Thanks in advance..

Greg
