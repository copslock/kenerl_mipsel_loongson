Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA2976284 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Apr 1998 16:22:16 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA15883113
	for linux-list;
	Wed, 29 Apr 1998 16:21:31 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA17800360
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Apr 1998 16:21:30 -0700 (PDT)
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id QAA02388
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Apr 1998 16:21:28 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id AAA30149; Thu, 30 Apr 1998 00:21:24 +0100
Received: by the-village.bc.nu (Smail3.1.29.1 #2)
	id m0yUg1F-000aNhC; Thu, 30 Apr 98 00:12 BST
Message-Id: <m0yUg1F-000aNhC@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Rex and the Newport.
To: galibert@pobox.com (Olivier Galibert)
Date: Thu, 30 Apr 1998 00:12:04 +0100 (BST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <19980430011402.A16267@loria.fr> from "Olivier Galibert" at Apr 30, 98 01:14:02 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > As of about now KGI provides accelerator and mode switching modules to
> > fbcon/abscon. Whatever the peanut gallery may be doing the KGI heads
> > _are_ clueful
> 
> I do  think so   too  actually.  They  just  have  a  "let's  reinvent
> everything" tendancy that plays against them. And very very bad PR.

Not the  clueful bits - the noisy bits yes

> The only problem I have seen with GGI (reading thier documentation) is
> that  non-framebuffer    devices   does   not seem   to     be  really
> supported... if  I'm wrong it may  be easier to  use KGI/GGI for video

They are not well supported.

> support on sgi instead of filling the gaps in XFree86.

Its easier to make XAA work on mips and go from there.

> This would have the additional side effect to allow the use of SVGAlib
> programs and maybe open the way to a nice Mesa integration.

Svgalib apps will run under X with the svgalib/ggi on ggi/xshm on X ..
