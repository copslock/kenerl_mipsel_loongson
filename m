Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA31701 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Feb 1999 08:08:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA14773
	for linux-list;
	Thu, 11 Feb 1999 08:07:16 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA15598
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 11 Feb 1999 08:07:13 -0800 (PST)
	mail_from (chipper@llamas.net)
Received: from chipsworld.llamas.net (chipsworld.llamas.net [206.98.157.232]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA00078
	for <linux@cthulhu.engr.sgi.com>; Thu, 11 Feb 1999 08:07:09 -0800 (PST)
	mail_from (chipper@llamas.net)
Received: from localhost (chipper@localhost)
	by chipsworld.llamas.net (8.9.1a/8.9.1) with ESMTP id LAA01413;
	Thu, 11 Feb 1999 11:05:24 -0500
Date: Thu, 11 Feb 1999 11:05:23 -0500 (EST)
From: Chris Chiapusio <chipper@llamas.net>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: Alex deVries <adevries@engsoc.carleton.ca>, linux@cthulhu.engr.sgi.com
Subject: Re: Challange S question..
In-Reply-To: <19990211002534.A3363@alpha.franken.de>
Message-ID: <Pine.LNX.4.05.9902111059380.683-100000@chipsworld.llamas.net>
X-Files: Resist or serve
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, 11 Feb 1999, Thomas Bogendoerfer wrote:

>On Wed, Feb 10, 1999 at 04:58:25PM -0500, Alex deVries wrote:
>> I really need to rebuild a kernel for installation that includes R4400
>> support and serial console.  I just wish I could find a serial console
>> cable somewhere.
>
>I've already done that last week (announced on this mailing list) and that 
>kernel boots fine on a Challenge S (tested on a real Challenge S, thanks to
>Richard Hartensveld).
>
>URL is:
>
>ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-990205.gz
>
>Thomas.
>

where can i find info on what the kernel is doing at each stage of the
boot process for a 'install' kernel like this so i can try to debug this
without buggin you guys for each problem?

in the mean time, this is with Thomas' kernel.. I got farther along

Red Hat install init version 1.1 starting
mounting /proc filesystem... done
opening /proc/cmdline... done
checking command line arguments... done
checking for NFS root filesystem...yes
mke2fs 1.10, 24-Apr-97 for EXT2 FS 0.5b, 95/08/09
/dev/ram: Operation not supported by device while setting up superblock
creating 100k of ramdisk space... done
mounting /tmp from ramdisk... failed.

I can't recover from this.


Chipper


------
                    Please encrypt anything important.
PGP Key: http://pgp.ai.mit.edu:11371/pks/lookup?op=get&search=0x6CFA486D
