Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 23:26:48 +0000 (GMT)
Received: from darwaza.gdatech.com ([IPv6:::ffff:66.237.41.98]:9543 "EHLO
	kings.gdatech.com") by linux-mips.org with ESMTP
	id <S8225308AbULIX0m>; Thu, 9 Dec 2004 23:26:42 +0000
Received: from kings.gdatech.com (localhost.localdomain [127.0.0.1])
	by kings.gdatech.com (Postfix) with ESMTP id A565F61C0E7;
	Thu,  9 Dec 2004 15:21:33 -0800 (PST)
X-Propel-Return-Path: <gmuruga@gdatech.com>
Received: from kings.gdatech.com ([192.168.200.118])
	by localhost.localdomain ([127.0.0.1]) (port 7027) (Propel SE relay 0.1.0.1557 $Rev$)
	id r4cI152133-1395-1
	for linux-mips@linux-mips.org mlachwani@mvista.com; Thu, 09 Dec 2004 15:21:33 -0800
Received: from sierra.gdatech.com (asg_mda [192.168.200.112])
	by kings.gdatech.com (Postfix) with ESMTP id 64D2861C0E6;
	Thu,  9 Dec 2004 15:21:33 -0800 (PST)
Received: (from nobody@localhost)
	by gdatech.com (8.11.6/8.11.6) id iB9NMcS12782;
	Thu, 9 Dec 2004 15:22:38 -0800
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: gdatech.com
Date: Thu, 9 Dec 2004 15:22:38 -0800
Message-Id: <200412092322.iB9NMcS12782@gdatech.com>
X-Authentication-Warning: sierra.gdatech.com: nobody set sender to gmuruga@gdatech.com using -f
From: "Muruga Ganapathy" <gmuruga@gdatech.com>
To: Manish Lachwani <mlachwani@mvista.com>,
	Muruga Ganapathy <gmuruga@gdatech.com>,
	linux-mips@linux-mips.org
Subject: Re: Forcing IDE to work in PIO mode
X-Mailer: NeoMail 1.25
X-IPAddress: 63.111.213.196
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-Path: <gmuruga@gdatech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gmuruga@gdatech.com
Precedence: bulk
X-list: linux-mips

Manish, 

My previous mail was based on the sources from kernerl.org and the dmesg
below. 

Thanks
G.Muruganandam

=======================================================
Linux version 2.4.27-sb1-swarm-bn (root@hattusa) (gcc version 3.3.4 (Debian

1:34

swarm setup: M41T81 RTC detected.

This kernel optimized for board runs with CFE

Determined physical RAM map:

 memory: 003b0000 @ 00000000 (usable)

 memory: 0f254400 @ 00c36c00 (usable)

 memory: 00886c00 @ 003b0000 (reserved)

hm, page 003b0000 reserved twice.

hm, page 003b1000 reserved twice.

Initial ramdisk at: 0x803b0000 (8940544 bytes)

On node 0 totalpages: 65163

zone(0): 65163 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: root=/dev/ram console=duart0 initrd=886C00@803B0000

Console: colour dummy device 80x25

Calibrating delay loop... 532.48 BogoMIPS

Memory: 245068k/251920k available (2077k kernel code, 6860k reserved, 120k

data)

Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)

Inode cache hash table entries: 16384 (order: 5, 131072 bytes)

Mount cache hash table entries: 512 (order: 0, 4096 bytes)

Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)

Page-cache hash table entries: 65536 (order: 6, 262144 bytes)

Checking for 'wait' instruction...  unavailable.

POSIX conformance testing by UNIFIX

Detected 2 available CPU(s)

Starting CPU 1... Slave cpu booted successfully

Waiting on wait_init_idle (map = 0x2)

All processors have done init_idle

PCI: Skipping PCI probe.  Bus is not initialized.

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

Starting kswapd

VFS: Disk quotas vdquot_6.5.1

Journalled Block Device driver loaded

devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)

devfs: boot_options: 0x0

Dummy keyboard driver installed.

pty: 256 Unix98 ptys configured

Generic MIPS RTC Driver v1.0

RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

eth0: SiByte Ethernet at 0x10064000, address: 00-02-4C-FE-0D-D6

eth0: enabling TCP rcv checksum

eth1: SiByte Ethernet at 0x10065000, address: 00-02-4C-FE-0D-D7

eth1: enabling TCP rcv checksum

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4

ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx

SiByte onboard IDE configured as device 0

Linux Kernel Card Services 3.1.22

  options:  [pci] [cardbus]

sibyte-pcmcia: Looking up addr 0x10061130: 0x03ff (IO size)

sibyte-pcmcia: Looking up addr 0x10061230: 0x1100 (IO Base Address)

sibyte-pcmcia: Memory region 0x11000000 of size 0x04000000 requested.

sibyte-pcmcia: Setting up "sb1250pc" procfs entry

SiByte onboard PCMCIA-IDE configured as device 1

mice: PS/2 mouse device common for all mice

Initializing Cryptographic API

NET4: Linux TCP/IP 1.0 for NET4.0

IP: routing cache hash table of 2048 buckets, 16Kbytes

TCP: Hash tables configured (established 16384 bind 16384)





> Please point me to the 2.4.26 or 2.4.27 code that you are referring to
> 
> Thanks
> Manish Lachwani
> 
> Muruga Ganapathy wrote:
> > Manish, 
> > 
> > Thanks for the pointer.
> > 
> > I am looking for the PCMCIA-IDE driver for the SWARM board in 2.6.x
> > I did see this driver in 2.4.26/27 but not in 2.6.10.
> > 
> > Do you have any suggestions on porting the PCMCIA-IDE driver from 2.4.27
> > to 2.6.x?
> > 
> > Regards
> > G.Muruganandam
> > 
> > 
> >>I had posted a patch to this mailing list a few days back. The patch 
> >>applies cleanly to the current tree and is currently checked in: 
> >>drivers/ide/mips/swarm.c
> >>
> >>Using this patch, Broadcom SWARM IDE works well
> >>
> >>Thanks
> >>Manish Lachwani
> >>
> >>Muruga Ganapathy wrote:
> >>
> >>>Thanks Manish for the information.  
> >>> 
> >>>BTW, do you have patch to make the swarm IDE work in 2.6.6-rc3 
> >>> 
> >>>Regards 
> >>>G.Muruganandam 
> >>> 
> >>> 
> >>>
> >>>
> >>>>Muruga Ganapathy wrote: 
> >>>>
> >>>>
> >>>>>Hello,  
> >>>>>
> >>>>>How do I force the IDE to work in the PIO mode by including the  
> >>>>>option like "hdb=noprobe" in the setup.c? 
> >>>>>
> >>>>>
> >>>>>My kernel version is 2.6.6 
> >>>>>
> >>>>>Thanks 
> >>>>>G.Muruganandam 
> >>>>>
> >>>>
> >>>>
> >>>>Hello ! 
> >>>>
> >>>>I would have thought "ide=nodma" at the command line would have 
> >>>
> >>>worked 
> >>>
> >>>
> >>>>Thanks 
> >>>>Manish Lachwani 
> >>>>
> >>>>
> >>>
> >>> 
> >>>************************************************************* 
> >>>GDA Technologies, Inc.		 
> >>>1010 Rincon Circle  
> >>>San Jose CA, 95131 
> >>>Phone	(408) 432-3090 
> >>>Fax	(408) 432-3091 
> >>> 
> >>>Accelerate Your Innovation	 
> >>>************************************************************** 
> >>
**
