Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA89904 for <linux-archive@neteng.engr.sgi.com>; Tue, 9 Mar 1999 13:35:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA64795
	for linux-list;
	Tue, 9 Mar 1999 13:34:26 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA00007
	for <linux@engr.sgi.com>;
	Tue, 9 Mar 1999 13:34:24 -0800 (PST)
	mail_from (griesbac@gamera.colorado.edu)
Received: from gamera.colorado.edu (gamera.Colorado.EDU [128.138.189.223]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA03134
	for <linux@engr.sgi.com>; Tue, 9 Mar 1999 13:34:08 -0800 (PST)
	mail_from (griesbac@gamera.colorado.edu)
Received: from localhost by gamera.colorado.edu
	via sendmail with smtp
	id <m10KU8f-001FGFC@gamera.colorado.edu> (Debian Smail3.2.0.102)
	for <linux@engr.sgi.com>; Tue, 9 Mar 1999 14:34:09 -0700 (MST) 
Date: Tue, 9 Mar 1999 14:34:09 -0700 (MST)
From: Jake Griesbach <griesbac@gamera.colorado.edu>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Linux/Mips installation
In-Reply-To: <19990309214715.B2209@alpha.franken.de>
Message-ID: <Pine.LNX.3.96.990309142512.5281A-100000@gamera.colorado.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hmm.  That still didn't work, although the new kernel booted just fine.  I
still got an Oops message right after I selected the drive to install to.
Could this be a swapon problem?  I also have an internal floppy/floptical
drive (this also appears on the select drive list).  Could this be
throwing things off?  Does this work for R4600 processors?

Here's my hinv output:
CPU: MIPS R4600 Processor Chip Revision: 2.0
FPU: MIPS R4600 Floating Point Coprocessor Revision: 2.0
1 133 MHZ IP22 Processor
Main memory size: 96 Mbytes
Instruction cache size: 16 Kbytes
Data cache size: 16 Kbytes
Integral SCSI controller 0: Version WD33C93B, revision D
  Disk drive: unit 1 on SCSI controller 0
  Disk drive / removable media: unit 2 on SCSI controller 0
  Disk drive: unit 3 on SCSI controller 0
  CDROM: unit 6 on SCSI controller 0
On-board serial ports: 2
On-board bi-directional parallel port
Graphics board: Indy 8-bit
Integral Ethernet: ec0, version 1
Integral ISDN: Basic Rate Interface unit 0, revision 1.0
Iris Audio Processor: version A2 revision 4.1.0
Vino video: unit 0, revision 0, IndyCam connected

Thanks,

Jake Griesbach
University of Colorado


On Tue, 9 Mar 1999, Thomas Bogendoerfer wrote:

> On Mon, Mar 08, 1999 at 09:57:29AM -0700, Jake Griesbach wrote:
> > Do you have any ideas as to what may be wrong?  I'm using the
> > hardhat-sgi-5.1.tar.gz file from
> > ftp://ftp.linux.sgi.com:/pub/linux/mips/RedHat.
> 
> Please try a newer kernel. Take the one from
> 
> ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-2.2.1-990226.tar.gz
> 
> If you have problems with this kernel, please send the output of
> hinv (IRIX command).
> 
> Thomas.
> 
> -- 
>    This device has completely bogus header. Compaq scores again :-|
> It's a host bridge, but it should be called ghost bridge instead ;^)
>                                         [Martin `MJ' Mares on linux-kernel]
> 
