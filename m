Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA3222353 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Apr 1998 15:56:45 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA17661536
	for linux-list;
	Wed, 29 Apr 1998 15:56:00 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA16885423
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Apr 1998 15:55:58 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA22194
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Apr 1998 15:55:56 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id AAA11562;
	Thu, 30 Apr 1998 00:55:53 +0200 (MEST)
Received: by thoma (SMI-8.6/KO-2.0)
	id AAA03612; Thu, 30 Apr 1998 00:55:49 +0200
Message-ID: <19980430005548.01183@uni-koblenz.de>
Date: Thu, 30 Apr 1998 00:55:48 +0200
From: ralf@uni-koblenz.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: adevries@engsoc.carleton.ca, linux@cthulhu.engr.sgi.com
Subject: Re: Rex and the Newport.
References: <19980430003404.02686@uni-koblenz.de> <m0yUfUg-000aNhC@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <m0yUfUg-000aNhC@the-village.bc.nu>; from Alan Cox on Wed, Apr 29, 1998 at 11:38:25PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Apr 29, 1998 at 11:38:25PM +0100, Alan Cox wrote:

> > Btw, whe really should switch all MIPS machines to fbcon or will never
> > have a kernel with reasonable fast console and support for multiple
> > GFX types in kernel binary.
> 
> fbcon assumes direct memory access to the display. abscon is probably
> what you want.

Sorry, yes.  I had the G364 based video card for Magnum 4000 /
Olivetti M700-10 in mind which in fact is just a dumb fb.

  Ralf
