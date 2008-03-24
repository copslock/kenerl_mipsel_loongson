Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2008 05:40:38 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:25488 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20022130AbYCXFkf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Mar 2008 05:40:35 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 62511315D4B
	for <linux-mips@linux-mips.org>; Mon, 24 Mar 2008 05:40:26 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Mon, 24 Mar 2008 05:40:26 +0000 (UTC)
Received: from jennifer.localdomain ([192.168.7.225]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 23 Mar 2008 22:40:23 -0700
Message-ID: <47E73EC5.1080507@avtrex.com>
Date:	Sun, 23 Mar 2008 22:40:21 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: SGI Indy looking for a home...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2008 05:40:23.0475 (UTC) FILETIME=[8E16F830:01C88D71]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

I have an SGI Indy located in San Jose, CA that is looking for a home.  
Gratis to anyone that will take it away and make good use of it.

This bad boy has a whopping 256MB RAM (The maximum for an Indy I think), 
and a 1GB + 2GB disks.  It also sports an adapter so that you can attach 
a standard VGA monitor (must have sync on green, Samgung flat panels 
seem to work, but not my Cornerstone CRT).  Hook up standard PS-2 mouse 
and keyboard (not included), and you are ready to go with this fine 
MIPS64 system.

Currently it is running Debian, I am not sure the exact clock speed 
(probably 150MHz) as I don't have a monitor attached to view hwinv.  But 
here is the info I have handy:

daney@indy:~$ cat /proc/cpuinfo
system type             : SGI Indy
processor               : 0
cpu model               : R4400SC V5.0  FPU V0.0
BogoMIPS                : 74.49
wait instruction        : no
microsecond timers      : yes
tlb_entries             : 48
extra interrupt vector  : no
hardware watchpoint     : yes
ASEs implemented        :
VCED exceptions         : 476805
VCEI exceptions         : 4876

daney@indy:~$ dmesg
Linux version 2.6.18-4-r4k-ip22 (Debian 2.6.18.dfsg.1-12etch2) 
(dannf@debian.org) (gcc version 4.1.2 20061115 (prerelease) (Debian 
4.1.1-21)) #1 Tue May 8 03:48:00 UTC 2007
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU revision is: 00000450
FPU revision is: 00000500
MC: SGI memory controller Revision 3
MC: Probing memory configuration:
 bank0: 128M @ 08000000
 bank1: 128M @ 10000000
Determined physical RAM map:
 memory: 0000000010000000 @ 0000000008000000 (usable)

.
.
.
Calibrating system timer... 300000 [150.0000 MHz CPU]
Using 75.000 MHz high precision timer.
NG1: Revision 6, 24 bitplanes, REX3 revision B, VC2 revision A, xmap9 
revision A, cmap revision C, bt445 revision D
NG1: Screensize 1024x768
Console: colour SGI Newport 128x48
.
.
.
eth0: SGI Seeq8003 08:00:69:07:94:d1
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.26 - 22/Feb/2003, Compiled May  8 2007 at 03:26:34
scsi0 : SGI WD93
 sending SDTR 0103013f0csync_xfer=2c<5>  Vendor: SGI       Model: 
SEAGATE ST31230N  Rev: 0272
  Type:   Direct-Access                      ANSI SCSI revision: 02
 sending SDTR 0103013f0csync_xfer=2c<5>  Vendor: SGI       Model: 
SEAGATE ST32430N  Rev: 0272
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 2070235 512-byte hdwr sectors (1060 MB)
sda: Write Protect is off
sda: Mode Sense: 87 00 10 08
SCSI device sda: drive cache: write through w/ FUA
SCSI device sda: 2070235 512-byte hdwr sectors (1060 MB)
sda: Write Protect is off
sda: Mode Sense: 87 00 10 08
SCSI device sda: drive cache: write through w/ FUA
 sda: sda1 sda2 sda9 sda11
sd 0:0:1:0: Attached scsi disk sda
SCSI device sdb: 4197405 512-byte hdwr sectors (2149 MB)
sdb: Write Protect is off
sdb: Mode Sense: 87 00 10 08
SCSI device sdb: drive cache: write through w/ FUA
SCSI device sdb: 4197405 512-byte hdwr sectors (2149 MB)
sdb: Write Protect is off
sdb: Mode Sense: 87 00 10 08
SCSI device sdb: drive cache: write through w/ FUA
 sdb: sdb1 sdb2 sdb9 sdb11
sd 0:0:2:0: Attached scsi disk sdb


daney@indy:~$ cat /proc/partitions
major minor  #blocks  name

   8     0    1035117 sda
   8     1     851136 sda1
   8     2     130944 sda2
   8     9      52173 sda9
   8    11    1034253 sda11
   8    16    2098702 sdb
   8    17    1966167 sdb1
   8    18     130625 sdb2
   8    25       1567 sdb9
   8    27    2098360 sdb11
