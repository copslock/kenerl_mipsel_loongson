Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA85687 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Mar 1999 16:12:19 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA65743
	for linux-list;
	Wed, 10 Mar 1999 16:11:28 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA82729
	for <linux@engr.sgi.com>;
	Wed, 10 Mar 1999 16:11:26 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA00227
	for <linux@engr.sgi.com>; Wed, 10 Mar 1999 16:11:09 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10Kt46-0027TyC@rachael.franken.de>
	for engr.sgi.com!linux; Thu, 11 Mar 1999 01:11:06 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10Kt40-002P04C; Thu, 11 Mar 99 01:11 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id BAA01054;
	Thu, 11 Mar 1999 01:00:22 +0100
Message-ID: <19990311010022.A1006@alpha.franken.de>
Date: Thu, 11 Mar 1999 01:00:22 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jake Griesbach <griesbac@gamera.colorado.edu>
Cc: linux@cthulhu.engr.sgi.com, ralf@uni-koblenz.de
Subject: Re: Linux/Mips installation
References: <19990310002217.A6143@alpha.franken.de> <Pine.LNX.3.96.990310155606.22494A-100000@gamera.colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.990310155606.22494A-100000@gamera.colorado.edu>; from Jake Griesbach on Wed, Mar 10, 1999 at 04:02:08PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Mar 10, 1999 at 04:02:08PM -0700, Jake Griesbach wrote:
> That was it!  I removed the CDROM and internal floptical drive, and the
> installation proceeded.  However, now I get the prom error when rebooting
> that is caused by elf kernels on old proms:
> 
> Cannot load bootp()/vmlinux
> Illegal f_magic number 0x7f45, expected MIPSELMAGIC or MIPSEBMAGIC.

The kernel worked before the installation and doesn't afterwards ? Strange.

> I tried downloading the ecoff kernel you posted in the test directory, but
> I still get the error.  Maybe I haven't installed it correctly, or maybe I
> am not typing the correct boot command.

Really the same error ? The 0x7f45 is part of the elf magic, which the
ECOFF doesnt contain for sure (at least not at the beginning of the file).

> I have unzipped the ecoff kernel and placed it in the installation (remote
> computer's) root directory.  (It does boot over NFS into the installation

If you boot via tftp, you need to put new kernel in your /tftp directory 
(like you did it with the other kernel).

> script.)  I have verified the kernel installed on the local drive after
> installation is the same size.  (I simply copied it over to the local
> drive.)  Do I have to run something equivalent to lilo??

Right now, you have two choices for booting the kernel. Either use
bootp/tftp or put it on your Irix root partition and boot with 
"boot vmlinux root=/dev/sdc1" (or the approriate /dev/sdxx).

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
