Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id OAA25746
	for <pstadt@stud.fh-heilbronn.de>; Mon, 12 Jul 1999 14:49:19 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA02686; Mon, 12 Jul 1999 05:46:45 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA59221
	for linux-list;
	Mon, 12 Jul 1999 05:39:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA04565
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 12 Jul 1999 05:39:31 -0700 (PDT)
	mail_from (ednes@zaphod.et.tudelft.nl)
Received: from zaphod.et.tudelft.nl (zaphod.et.tudelft.nl [130.161.38.84]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA02828
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jul 1999 05:39:29 -0700 (PDT)
	mail_from (ednes@zaphod.et.tudelft.nl)
Received: (from ednes@localhost)
	by zaphod.et.tudelft.nl (8.8.7/8.8.7) id OAA16846;
	Mon, 12 Jul 1999 14:39:26 +0200
Message-Id: <199907121239.OAA16846@zaphod.et.tudelft.nl>
Subject: Small problems on Indy
To: linux@cthulhu.engr.sgi.com
Date: Mon, 12 Jul 1999 14:39:26 +0200 (CEST)
Cc: E.Hakkennes@et.tudelft.nl (Edwin Hakkennes)
From: Edwin Hakkennes <E.Hakkennes@et.tudelft.nl>
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

After lurking on the sgi-list for more than a year, I installed one of
our indy's with hardhat. I couldn't get bootp working, so I copied the
install kernel to the efs-root of the Irix (5.2?) disk, which proved a
workable solution.

I have a few questions:

1) The console uses 62 lines, but I can see only 47 of them using an
Iiyama monitor. I also tried a genuine SGI monitor, which gives me all
62 lines. How can I set the number of lines?

2) How can I specify kernel options in the ARC firmware?  

I tried
setenv -p OSLoadOptions "root=/dev/sdb1"
init
printenv OSLoadOptions 
which gives
OSLoadOptions=root=/dev/sd

so this doesn't seem to work.
Can I use rdev on i386 machine for this?

3) What is the prefered partitioning scheme.  I would like to go back
to one disk, with no IRIX installed. So the question is what partition 
types is the arc-firmware able to boot from? (iso,fat)

Can we alternatively store the kernel in the disk-label? From within Linux??

Is the following possible?  

sda1    20 MB      /boot    type=efs (or iso9660, or fat)
sda2   100 MB      /        type=ext2
sda3   whole disk? 				Is this necessary?
sda4   800 MB      /usr     type=ext2
sda5   128 MB      SWAP
sda6   REST        /data    type=ext2

Is linux capable of writing to an efs partition?


Thanks in advance,


Edwin Hakkennes


(I'm running 
Linux version 2.1.100 (root@alex3.med.iacnet.com) (gcc version 2.7.2) #1 Sun Jul 12 17:32:40 EDT 1998
on a 100Mhz Indy:
cpu                     : MIPS
cpu model               : R4600 V1.0
system type             : SGI Indy
BogoMIPS                : 99.94
byteorder               : big endian
unaligned accesses      : 0
wait instruction        : yes
microsecond timers      : no
extra interrupt vector  : no
hardware watchpoint     : no

Hinv of its neighbor running IRIX:

1 100 MHZ IP22 Processor
FPU: MIPS R4610 Floating Point Chip Revision: 0.0
CPU: MIPS R4600 Processor Chip Revision: 1.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 16 Kbytes
Instruction cache size: 16 Kbytes
Main memory size: 64 Mbytes
Iris Audio Processor: version A2 revision 4.1.0
Integral Ethernet: ec0, version 1
Disk drive: unit 1 on SCSI controller 0
Integral SCSI controller 0: Version WD33C93B, revision D
Graphics board: Indy 8-bit
)
