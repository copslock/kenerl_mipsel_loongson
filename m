Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA2445583 for <linux-archive@neteng.engr.sgi.com>; Tue, 31 Mar 1998 06:50:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id GAA5693110
	for linux-list;
	Tue, 31 Mar 1998 06:50:23 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA5976320
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 31 Mar 1998 06:50:21 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id GAA08109
	for <linux@cthulhu.engr.sgi.com>; Tue, 31 Mar 1998 06:50:16 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (dali.uni-koblenz.de [141.26.5.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id QAA16821
	for <linux@cthulhu.engr.sgi.com>; Tue, 31 Mar 1998 16:50:13 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id QAA05236;
	Tue, 31 Mar 1998 16:49:50 +0200
Message-ID: <19980331164948.39802@uni-koblenz.de>
Date: Tue, 31 Mar 1998 16:49:48 +0200
To: Oliver Frommel <oliver@aec.at>
Cc: Ulf Carlsson <grimsy@zigzegv.ml.org>, linux@cthulhu.engr.sgi.com
Subject: Re: compile problem with kernel
References: <19980331091452.41730@uni-koblenz.de> <Pine.LNX.3.96.980331092404.8445B-100000@web.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.96.980331092404.8445B-100000@web.aec.at>; from Oliver Frommel on Tue, Mar 31, 1998 at 09:32:33AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Mar 31, 1998 at 09:32:33AM +0200, Oliver Frommel wrote:

> I am currently trying to rebuild recent binutils and gcc with host=x86 and
> target=mips-linux. So far I've built binutils-2.8.1 with the patch from sgi.com
> applied but I have some problems building gcc. I have two questions regarding 
> the setup of the crosscompilation environment:
> 
> 1. is gas supposed to be part of the binutils package,

Yes.

> of the gcc package or
>  is it a package on its own? I've built gas from the binutils dist and put it
>  into the binutils.rpm now while I found it in gcc-xcompile...2.7.2-3.rpm
>  on sgi.com ..

> 2. which compiler source & patches am i supposed to use?

Binutils 2.7-4 and newer are ok for kernels; userland needs 2.8.1-1 or
newer or building certain shared libs will fail.

GCC 2.7.2-7 is ok.  Btw, you only need to apply one of these patches;
none of my binutils or gcc patches was meant to be applied incrementally.

>  gcc-2.7.2 with patches 2.7.2-6 and 2.7.2-7 from sgi.com applied, but I am not
>  sure if those are meant to be used with a native mips-linux host & target.
>  Anyway I am getting this error when I try to compile gcc now:

You can build both native and crosscompilers from the same source.  That's
the beauty of GCC.

  Ralf
