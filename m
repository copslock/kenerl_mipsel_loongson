Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA60400 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Feb 1999 06:47:36 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA10434
	for linux-list;
	Thu, 4 Feb 1999 06:47:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA16020
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 4 Feb 1999 06:46:59 -0800 (PST)
	mail_from (nachtfalke@usa.net)
Received: from mail.urz.uni-wuppertal.de (mail.urz.uni-wuppertal.de [132.195.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA04347
	for <linux@cthulhu.engr.sgi.com>; Thu, 4 Feb 1999 06:46:11 -0800 (PST)
	mail_from (nachtfalke@usa.net)
Received: from ganymede.priv (root@isdn96.dialin.uni-wuppertal.de [132.195.23.96])
	by mail.urz.uni-wuppertal.de (8.9.1a/8.9.1) with ESMTP id PAA25988592;
	Thu, 4 Feb 1999 15:43:52 +0100 (MET)
Received: (from nachtfalke@localhost)
	by ganymede.priv (8.8.8/8.8.8) id PAA06114;
	Thu, 4 Feb 1999 15:46:37 +0100
From: Alexander Graefe <nachtfalke@usa.net>
Date: Thu, 4 Feb 1999 15:46:37 +0100
To: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
Message-ID: <19990204154637.B5941@ganymede>
References: <19990202155147.A1565@ganymede> <19990203043951.D3920@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95i
In-Reply-To: <19990203043951.D3920@uni-koblenz.de>; from ralf@uni-koblenz.de on Wed, Feb 03, 1999 at 04:39:51AM +0100
X-Goddess: Willow
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Feb 03, 1999 at 04:39:51AM +0100, ralf@uni-koblenz.de wrote:

>  - the exact screen output.  Especially the register dump following the
>    Aiee message is important.

kernel 2.1.100 (the one from the HardHat.tgz)
---snip---
VFS: Mounted root (nfs filesystem)
Adv: done running setup()
Freeing unused kernel memory: 44k freed
page fault from irq handler: 0000
$0 : 00000000 88180000 0000062d 00000000
$4 : 00000000 1004fc00 00000000 00000000
$8 : 00000000 00000000 00000000 abf3f822
$12: 6f2e7072 8bf3d87c 8bf3d800 00000000
$16: 8bf4f000 8bf3b220 0000062d 8815238c
$20: abf4f040 bfb94000 00000000 bfbd4000
$24: 00000000 8bf85b58
$28: 88008000 88009d90 0000000e 880e3f38
epc   : 880e3e74
Status: 1004fc02
Cause : 00000008
Aiee, killing interrupt handler.
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing
---snip---

And then the machine stops dead.

>  - the output of the hinv command.  Hinv is an IRIX command.

Output from hinv:
---snip---
Iris Audio Processor: version A2 revision 4.1.0
1 200 MHZ IP22 Processor
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
CPU: MIPS R4400 Processor Chip Revision: 6.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 16 Kbytes
Instruction cache size: 16 Kbytes
Secondary unified instruction/data cache size: 1 Mbyte
Main memory size: 64 Mbytes
Integral ISDN: Basic Rate Interface unit 0, revision 1.0
Integral Ethernet: ec0, version 1
Integral SCSI controller 0: Version WD33C93B, revision D
Disk drive / removable media: unit 2 on SCSI controller 0
Disk drive: unit 1 on SCSI controller 0
Graphics board: Indy 8-bit
Vino video: unit 0, revision 0, IndyCam connected
---snip---

Bye,
	LeX
-- 
Quidquid latine dictum sit, altum viditur.
