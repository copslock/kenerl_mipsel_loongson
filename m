Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA2670363 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Apr 1998 10:48:26 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id KAA6925605
	for linux-list;
	Thu, 2 Apr 1998 10:48:15 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA6995222
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Apr 1998 10:48:14 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id KAA08343
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 10:48:10 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id UAA00299
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Apr 1998 20:48:04 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id UAA01342;
	Thu, 2 Apr 1998 20:47:39 +0200
Message-ID: <19980402204738.29605@uni-koblenz.de>
Date: Thu, 2 Apr 1998 20:47:38 +0200
To: Dong Liu <dliu@npiww.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: kernel panic
References: <199804021731.TAA00404@calypso.saturn> <199804021855.NAA08562@pluto.npiww.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199804021855.NAA08562@pluto.npiww.com>; from Dong Liu on Thu, Apr 02, 1998 at 01:55:41PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Apr 02, 1998 at 01:55:41PM -0500, Dong Liu wrote:

> Ulf Carlsson writes:
>  > Hello again... we're updating the internet connection to my mail server so
>  > I can't read what you've written today. But I've downloaded patch-3 of the
>  > sgi-kernel. I get further, but it still doesn't work.. well, I think it's
>  > almost fixed now. Here's the output:
>  > 
>  > IP-Config: Got BOOTP answer from 192.168.0.1, my address is 192.168.0.3
>  > Partition check:
>  >  sda: sda1 sda2 sda3 sda4
>  >  sdb: sdb1 sdb2 sdb3
>  > VFS: Mounted root (ext2 filesystem) readonly.
>  > Warning: unable to open an initial console.
>  > Got vced at 8801a2a4.
>  > Kernel panic: Caught VCE exception - should not happen
>  > 
> 
> Same here, only difference is I'm using nfsroot.
> 
> Good work! Now only I can find a serial cable for this damn Indy:=).

Surprise, the support for the serial console does not compile :-)

  Ralf
