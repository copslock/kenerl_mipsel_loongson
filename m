Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 14:20:55 +0000 (GMT)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:18787 "EHLO
	atol.icm.edu.pl") by linux-mips.org with ESMTP id <S8224850AbUAOOUy>;
	Thu, 15 Jan 2004 14:20:54 +0000
Received: from rekin.icm.edu.pl (rekin.icm.edu.pl [192.168.1.132])
	by atol.icm.edu.pl (8.12.6/8.12.6/rzm-4.6/icm) with ESMTP id i0FEKg4p019298
	for <linux-mips@linux-mips.org>; Thu, 15 Jan 2004 15:20:43 +0100 (CET)
Received: from rathann by rekin.icm.edu.pl with local (Exim 3.35 #1 (Debian))
	id 1Ah8MU-0008C9-00
	for <linux-mips@linux-mips.org>; Thu, 15 Jan 2004 15:20:42 +0100
Date: Thu, 15 Jan 2004 15:20:41 +0100
From: "Dominik 'Rathann' Mierzejewski" <rathann@icm.edu.pl>
To: linux-mips@linux-mips.org
Subject: Re: Current 2.4 CVS (2.4.24-pre2) doesn't boot on SGI Indy
Message-ID: <20040115142041.GA31453@icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040115141427.GA28546@icm.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20040115141427.GA28546@icm.edu.pl>
User-Agent: Mutt/1.3.28i
Return-Path: <rathann@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rathann@icm.edu.pl
Precedence: bulk
X-list: linux-mips


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry for messing up the thread.
Additional info: dmesg log from successful 2.4.22 boot, attached.

-- 
Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>                                                 
Interdisciplinary Centre for Mathematical and Computational Modelling                               
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810                               

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU revision is: 00002020
FPU revision is: 00002020
Primary instruction cache 16kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 16kB 2-way, linesize 32 bytes.
Linux version 2.4.22 (dominik@indy0) (gcc version 3.3.1 20030626 (Debian prerelease)) #1 Thu Sep 25 15:11:35 CEST 2003
MC: SGI memory controller Revision 3
MC: Probing memory configuration:
 bank0:  32M @ 08000000
 bank1:  32M @ 0a000000
Determined physical RAM map:
 memory: 04000000 @ 08000000 (usable)
On node 0 totalpages: 49152
zone(0): 49152 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda1 auto
Calibrating system timer... 665000 [133.0000 MHz CPU]
Using 66.500 MHz high precision timer.
NG1: Revision 6, 8 bitplanes, REX3 revision B, VC2 revision A, xmap9 revision A, cmap revision D, bt445 revision D
NG1: Screensize 1280x1024
Console: colour SGI Newport 160x64
Calibrating delay loop... 132.71 BogoMIPS
Memory: 61712k/65536k available (1328k kernel code, 3824k reserved, 100k data, 72k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
DS1286 Real Time Clock Driver v1.0
SCSI subsystem driver Revision: 1.00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Sep 25 2003 at 15:38:35
scsi0 : SGI WD93
 sending SDTR 010301410csync_xfer=3c  Vendor: SAMSUNG   Model: WN34324U (gm031)  Rev: 0105
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
SCSI device sda: 8438976 512-byte hdwr sectors (4321 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 72k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 524276k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal

--/9DWx/yDrRhgMJTb--
