Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA49564 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Mar 1999 15:03:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA70556
	for linux-list;
	Wed, 10 Mar 1999 15:02:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA55952
	for <linux@engr.sgi.com>;
	Wed, 10 Mar 1999 15:02:27 -0800 (PST)
	mail_from (griesbac@gamera.colorado.edu)
Received: from gamera.colorado.edu (gamera.Colorado.EDU [128.138.189.223]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA06393
	for <linux@engr.sgi.com>; Wed, 10 Mar 1999 15:02:25 -0800 (PST)
	mail_from (griesbac@gamera.colorado.edu)
Received: from localhost by gamera.colorado.edu
	via sendmail with smtp
	id <m10KrzM-001FGFC@gamera.colorado.edu> (Debian Smail3.2.0.102)
	for <linux@engr.sgi.com>; Wed, 10 Mar 1999 16:02:08 -0700 (MST) 
Date: Wed, 10 Mar 1999 16:02:08 -0700 (MST)
From: Jake Griesbach <griesbac@gamera.colorado.edu>
Reply-To: Jake Griesbach <griesbac@gamera.colorado.edu>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux@cthulhu.engr.sgi.com, ralf@uni-koblenz.de
Subject: Re: Linux/Mips installation
In-Reply-To: <19990310002217.A6143@alpha.franken.de>
Message-ID: <Pine.LNX.3.96.990310155606.22494A-100000@gamera.colorado.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

That was it!  I removed the CDROM and internal floptical drive, and the
installation proceeded.  However, now I get the prom error when rebooting
that is caused by elf kernels on old proms:

Cannot load bootp()/vmlinux
Illegal f_magic number 0x7f45, expected MIPSELMAGIC or MIPSEBMAGIC.

I tried downloading the ecoff kernel you posted in the test directory, but
I still get the error.  Maybe I haven't installed it correctly, or maybe I
am not typing the correct boot command.

I have unzipped the ecoff kernel and placed it in the installation (remote
computer's) root directory.  (It does boot over NFS into the installation
script.)  I have verified the kernel installed on the local drive after
installation is the same size.  (I simply copied it over to the local
drive.)  Do I have to run something equivalent to lilo??

When rebooting I'm typing:  boot dksc(0,3)

3 is the SCSI id for the local installed drive.

Thanks!!

Jake Griesbach


On Wed, 10 Mar 1999, Thomas Bogendoerfer wrote:

> On Tue, Mar 09, 1999 at 03:43:23PM -0700, Jake Griesbach wrote:
> > On Tue, 9 Mar 1999, Thomas Bogendoerfer wrote:
> > > please mail me the oops, so I could look up, where is happens.
> > 
> > Here it is:
> 
> thanks. The oops is caused by something going wrong in the SCSI driver.
> 
> I saw in your hinv, that there are different devices on your scsi bus.
> Could you please try to remove as much as possible from the bus and
> try it again ? What devices do have on the bus ?
> 
> Thomas.
> 
> -- 
>    This device has completely bogus header. Compaq scores again :-|
> It's a host bridge, but it should be called ghost bridge instead ;^)
>                                         [Martin `MJ' Mares on linux-kernel]
> 
