Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA86865 for <linux-archive@neteng.engr.sgi.com>; Fri, 25 Dec 1998 16:39:19 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA93909
	for linux-list;
	Fri, 25 Dec 1998 16:39:12 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA29242
	for <linux@engr.sgi.com>;
	Fri, 25 Dec 1998 16:39:10 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA00982
	for <linux@engr.sgi.com>; Fri, 25 Dec 1998 16:37:49 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-07.uni-koblenz.de [141.26.249.7])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA11672
	for <linux@engr.sgi.com>; Sat, 26 Dec 1998 01:37:46 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id VAA05965;
	Fri, 25 Dec 1998 21:28:30 +0100
Message-ID: <19981225212830.A5953@uni-koblenz.de>
Date: Fri, 25 Dec 1998 21:28:30 +0100
From: ralf@uni-koblenz.de
To: Anand Natarajasundaram <annatara@hotmail.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
Subject: Re: Help... Linux on MIPS.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19981224042617.21150.qmail@hotmail.com>; from Anand Natarajasundaram on Wed, Dec 23, 1998 at 08:26:16PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Dec 23, 1998 at 08:26:16PM -0800, Anand Natarajasundaram wrote:

> 	I  have a R5000 Compact PCI board. I intend to do a Linux port  on it.  
> I have downloaded Linux-2.1.36. 

Please don't use that kernel.  Below are instructions how to get current
sources (2.1.121) from CVS which will be a _much_ more satisfying experience.

> 	Most of the MIPS machine except DECstations use the ARC firmware.  I 
> have a  firmware running  on my  board.  I plan to use it to boot Linux.  
> 
> I have some queries :
> 
> 1)	How is the boot sequence from Power On to  'kernel_entry' happens on 
> a DECstation or Indy Box ?

What the firmware does is about

 - self test
 - hardware initialization
 - execute whatever boot default action is specified like for example
   loading Linux.

The general philosophy is to touch or rely on the firmware is little as
possible.  While there are nice firmware implementations out there like
Algorithmics' PMON, some ARC implementations have been found to be very
buggy; also the different firmware implementations are very different
from each other.

> 2)	It seems Linux uses the ARCS PROMBLOCK structure for ROM
> facilities. Is this the only info needed for interfacing the firmware
> with Linux ? What are the issues required to handle while interfacing  
> Linux with a firware.

There is no fundamental necessity for Linux to somehow be interfaces with a
firmware.  On an Indy we only use the firmware to detect the available
memory areas and the Ethernet hardware address.  You can as well implement
this by quering a non-ARC firmware, the hardware or by hardware as appropriate
for your platform.  As all this code is platform specific you can hide is
somewhere in arch/mips/<your-platform>/.

> 3) Is there a clear document describing these issues ?

The source is with you, Luke ...

>snip<
  4.2.  Anonymous CVS servers.

  For those who always want to stay on the bleeding edge and want to
  avoid having to download patch files or full tarballs we also have an
  anonymous CVS server.  Using CVS you can checkout the Linux/MIPS
  source tree with the following commands:


    cvs -d :pserver:cvs@linus.linux.sgi.com:/cvs login
    (Only needed the first time you use anonymous CVS, the password is "cvs")
    cvs -d :pserver:cvs@linus.linux.sgi.com:/cvs co <repository>


  where you insert linux, libc, or gdb for <repository>.
>snap<

  Ralf
