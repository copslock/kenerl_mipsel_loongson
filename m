Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA93232 for <linux-archive@neteng.engr.sgi.com>; Tue, 9 Mar 1999 15:09:11 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA97729
	for linux-list;
	Tue, 9 Mar 1999 15:08:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA56959
	for <linux@engr.sgi.com>;
	Tue, 9 Mar 1999 15:08:01 -0800 (PST)
	mail_from (griesbac@gamera.colorado.edu)
Received: from gamera.colorado.edu (gamera.Colorado.EDU [128.138.189.223]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07202
	for <linux@engr.sgi.com>; Tue, 9 Mar 1999 15:08:01 -0800 (PST)
	mail_from (griesbac@gamera.colorado.edu)
Received: from localhost by gamera.colorado.edu
	via sendmail with smtp
	id <m10KVDf-001FGFC@gamera.colorado.edu> (Debian Smail3.2.0.102)
	for <linux@engr.sgi.com>; Tue, 9 Mar 1999 15:43:23 -0700 (MST) 
Date: Tue, 9 Mar 1999 15:43:23 -0700 (MST)
From: Jake Griesbach <griesbac@gamera.colorado.edu>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Linux/Mips installation
In-Reply-To: <19990309231121.A3408@alpha.franken.de>
Message-ID: <Pine.LNX.3.96.990309152601.7439A-100000@gamera.colorado.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, 9 Mar 1999, Thomas Bogendoerfer wrote:
> please mail me the oops, so I could look up, where is happens.

Here it is:
                            Oops: 0000
$0 : 00000000 1000fc00 00001000 ffffffe0
$4 : 00000020 00000000 1000fc00 8df1fcc0
$8 : 00000010 880ff520 00000001 88152b28
$12: 00000001 00000001 00000001 fffffffc
$16: 00000000 00001000 a83b6000 883b3800
$20: 00000002 bfbc0003 00000000 bfb90000
$24: 1000fc01 80000000
$28: 8875e000 8875fb78 883b7e78 880f167c
epc   : 8801f3f8
Status: 1000fc02
Cause : 00000000
Process runinstall2 (pid: 7, stackpage=8875e000)
Stack: 03200801 00802421 808abd88 808abddd 883b3800 bfbc0003 880f167c 
88101b38
       8df1f4a0 00000074 883bc700 8875fc30 00000078 00000001 883b3800 
bfbc0003
       883b7e78 883b50e0 00000002 8875fcc0 00000000 00000000 00000005
880f1df4
       8df220a8 88086778 8df21074 8807e11c 00000000 880b3b60 883b3800
1000fc00
       883b7e78 880f1a6c 00000000 1000fc01 00000001 1000fc01 883b7e00
883b3800
       08000000 ...
Call Trace: [<880f167c>] [<88101b38>] [<880f1df4>] [<88086778>] (more ...)
Code: 00041823 02032824 00431024 <bcb50000> 14a2fffe  00a42821 40866000
00000000 00000000
install exited abnormally -- recieved signal 11
sending termination signals...done

This happens whether or not I use the disk partitioner via the Edit button
or not.  I'm choosing the third hard disk on my menu which corresponds to
the external drive I have after choosing the install button on the first
menu.

> 
> > Could this be a swapon problem?  I also have an internal floppy/floptical
> 
> maybe. Did you try to create swap ? AFAIK this doesn't work with HardHat.

I'm not using swapon explicitly.  I was just wondering if maybe the
installation program was trying to swapon the raw partition that IRIX
defines on a "root" type partition table (using fx).

Jake Griesbach
University of Colorado
