Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA97204 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Mar 1999 09:46:11 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA42028
	for linux-list;
	Thu, 11 Mar 1999 09:44:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA50677
	for <linux@engr.sgi.com>;
	Thu, 11 Mar 1999 09:44:27 -0800 (PST)
	mail_from (griesbac@gamera.colorado.edu)
Received: from gamera.colorado.edu (gamera.Colorado.EDU [128.138.189.223]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA04718
	for <linux@engr.sgi.com>; Thu, 11 Mar 1999 09:44:11 -0800 (PST)
	mail_from (griesbac@gamera.colorado.edu)
Received: from localhost by gamera.colorado.edu
	via sendmail with smtp
	id <m10L9VI-001FGFC@gamera.colorado.edu> (Debian Smail3.2.0.102)
	for <linux@engr.sgi.com>; Thu, 11 Mar 1999 10:44:16 -0700 (MST) 
Date: Thu, 11 Mar 1999 10:44:15 -0700 (MST)
From: Jake Griesbach <griesbac@gamera.colorado.edu>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux@cthulhu.engr.sgi.com, ralf@uni-koblenz.de
Subject: Re: Linux/Mips installation
In-Reply-To: <19990311010022.A1006@alpha.franken.de>
Message-ID: <Pine.LNX.3.96.990311103856.28421A-100000@gamera.colorado.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thanks, that helped.  I didn't have the kernel installed correctly.  Now
the system boots by itself and runs linux!

I've noticed that the web pages haven't been updated for a while.  Is X
available?  I get the following errors when I try to run X (with startx):

_X11TransSocketUNIXConnect: Can't connect: errno = 146

This repeats until I kill startx.  Also, I'm not familiar with the Red-Hat
linux flavor.  How do I start the package manager to get the latest set of
packages?

Thanks!

Jake Griesbach
University of Colorado




On Thu, 11 Mar 1999, Thomas Bogendoerfer wrote:

> On Wed, Mar 10, 1999 at 04:02:08PM -0700, Jake Griesbach wrote:
> > That was it!  I removed the CDROM and internal floptical drive, and the
> > installation proceeded.  However, now I get the prom error when rebooting
> > that is caused by elf kernels on old proms:
> > 
> > Cannot load bootp()/vmlinux
> > Illegal f_magic number 0x7f45, expected MIPSELMAGIC or MIPSEBMAGIC.
> 
> The kernel worked before the installation and doesn't afterwards ? Strange.
> 
> > I tried downloading the ecoff kernel you posted in the test directory, but
> > I still get the error.  Maybe I haven't installed it correctly, or maybe I
> > am not typing the correct boot command.
> 
> Really the same error ? The 0x7f45 is part of the elf magic, which the
> ECOFF doesnt contain for sure (at least not at the beginning of the file).
> 
> > I have unzipped the ecoff kernel and placed it in the installation (remote
> > computer's) root directory.  (It does boot over NFS into the installation
> 
> If you boot via tftp, you need to put new kernel in your /tftp directory 
> (like you did it with the other kernel).
> 
> > script.)  I have verified the kernel installed on the local drive after
> > installation is the same size.  (I simply copied it over to the local
> > drive.)  Do I have to run something equivalent to lilo??
> 
> Right now, you have two choices for booting the kernel. Either use
> bootp/tftp or put it on your Irix root partition and boot with 
> "boot vmlinux root=/dev/sdc1" (or the approriate /dev/sdxx).
> 
> Thomas.
> 
> -- 
>    This device has completely bogus header. Compaq scores again :-|
> It's a host bridge, but it should be called ghost bridge instead ;^)
>                                         [Martin `MJ' Mares on linux-kernel]
> 
