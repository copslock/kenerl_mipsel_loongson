Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA61844 for <linux-archive@neteng.engr.sgi.com>; Thu, 21 Jan 1999 08:07:17 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA01101
	for linux-list;
	Thu, 21 Jan 1999 08:05:16 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA93493
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 21 Jan 1999 08:05:12 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from perron-null.patser.net (9dyn87.breda.casema.net [195.96.116.87]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA00537
	for <linux@cthulhu.engr.sgi.com>; Thu, 21 Jan 1999 08:05:10 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from infopact.nl (indigo2.patser.net [192.168.6.40])
	by perron-null.patser.net (8.9.0/8.9.0) with ESMTP id QAA05482;
	Thu, 21 Jan 1999 16:58:41 +0100
Message-ID: <36A75138.3C924284@infopact.nl>
Date: Thu, 21 Jan 1999 08:09:29 -0800
From: Richard Hartensveld <richard@infopact.nl>
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.5 IP22)
MIME-Version: 1.0
To: Honza Pazdziora <adelton@informatics.muni.cz>
CC: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: mezzanine board
References: <36A749AA.6E28B33E@infopact.nl> <19990121164440.V13229@aisa.fi.muni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Honza Pazdziora wrote:

> >
> > I've got a challenge S with hardhat 5.1 running on it.
>
> Sorry for not answering your question in the first place, but:
>
> I didn't know HardHat 5.1 could run on Challenge S.

Sure, just hook-up a terminal to the serial port, link /dev/console to
/dev/ttyS1 on your nfs-root, and don't forget to change
setup-1.9.1-2.noarch.rpm to add some securetty's so that
you can log in over the network as root. (Hardhat doesn't add a normal user at
installation, a missing future, i think).


> Could you please
> send me the specs (hinv) and kernel details (did you compile yourself
> or picked it up), so that I can update the www pages?
>

Well, no hinv since i'm not running irix on the machine anymore (i boot  it
over the network), but here's the dmesg from within linux.This is a
self-compiled kernel, using the cvs tree from linus.linux, but the kernel
included with the hardhat package installs just as good.
If you wish, i can send you the rebuild setup...noarch.rpm to put on the
webpage for other people who wish to try linux on a S.


If someone is seriously interested in do some other development on this
machine, i'm more then willing to give away a shell account for this person.

 PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 132923392 bytes (129808K,126MB)
ARCH: SGI-IP22
CPU: MIPS-R5000 FPU<MIPS-R5000FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines.
CPU revision is: 00002310
Primary instruction cache 32kb, linesize 32 bytes)
Primary data cache 32kb, linesize 32 bytes)
Linux version 2.1.121 (root@wilderness) (gcc version 2.7.2.2) #1 Thu Jan 14
16:06:11 CET 1999
MC: SGI memory controller Revision 3
R4600/R5000 SCACHE size 512K, linesize 32 bytes.
calculating r4koff... 000dbd78(900472)
Calibrating delay loop... 179.81 BogoMIPS
Memory: 125248k/261652k available (1116k kernel code, 3436k data)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Swansea University Computer Society NET3.039 for Linux 2.1
NET3: Unix domain sockets 0.16 for Linux NET3.038.
Swansea University Computer Society TCP/IP for NET3.037
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5
initialize_kbd: Keyboard reset failed, no ACK
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9830 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 21) is a Zilog8530
DS1286 Real Time Clock Driver v1.0
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jan 14 1999 at 16:09:51
scsi0 : SGI WD93
scsi : 1 host.
Keyboard timeout
Keyboard timeout
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: IBM
DORS-32160    Rev: W80D
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
 sending SDTR 0103013f0csync_xfer=2c  Vendor: IBM       Model:
DCAS-34330        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 6, lun 0
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4197405 [2049 MB] [2.0 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 8467200 [4134 MB] [4.1 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:0a:41:7b
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3 sdb4
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 36k freed
Warning: unable to open an initial console.


Cheers,

Richard
