Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 13:53:29 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:34731 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021836AbXITMxT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 13:53:19 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 8FCDC400EB;
	Thu, 20 Sep 2007 14:52:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id oIYHAPqlUgzj; Thu, 20 Sep 2007 14:52:40 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id C9CE040090;
	Thu, 20 Sep 2007 14:52:40 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8KCqhJC002796;
	Thu, 20 Sep 2007 14:52:43 +0200
Date:	Thu, 20 Sep 2007 13:52:39 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	Antonino Daplas <adaplas@pol.net>,
	linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/video/pmag-ba-fb.c: Improve diagnostics
In-Reply-To: <20070919172412.725508d0.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64N.0709201342160.30788@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709171736580.17606@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.64N.0709181314300.9650@blysk.ds.pg.gda.pl>
 <20070919172412.725508d0.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4349/Thu Sep 20 00:46:46 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 19 Sep 2007, Andrew Morton wrote:

> > patch-mips-2.6.23-rc5-20070904-pmag-ba-err-2
> > diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/video/pmag-ba-fb.c linux-mips-2.6.23-rc5-20070904/drivers/video/pmag-ba-fb.c
> > --- linux-mips-2.6.23-rc5-20070904.macro/drivers/video/pmag-ba-fb.c	2007-02-21 05:56:47.000000000 +0000
> > +++ linux-mips-2.6.23-rc5-20070904/drivers/video/pmag-ba-fb.c	2007-09-18 10:56:51.000000000 +0000
> > @@ -147,16 +147,23 @@ static int __init pmagbafb_probe(struct 
> >  	resource_size_t start, len;
> >  	struct fb_info *info;
> >  	struct pmagbafb_par *par;
> > +	int err = 0;
> 
> This initialisation to zero is not good.
> 
> Because if some error-path code forgot to do `err = -EFOO' then probe()
> will return zero and the driver will leave things in half-initialised state
> and will then proceed as if things had succeeded.  It will crash.

 GCC used to complain: "`foo' might be used uninitialized..." and this is 
the usual cure; let me see if this not the case anymore (I have 4.1.2).

> So it's better to leave this local uninitialised, because we really want to
> get that compiler warning if someone forgot to set the return value.

 Yes of course, barring the issue mentioned.  Note the message above is 
not the same as: "`foo' is used uninitialized..." that would be reported 
in the case which you are concerned of.

> I made that change, but am too stupid to be able to work out how to create
> a config which will let me compile this thing.
> 
> akpm:/usr/src/25> grep PMAG arch/arm/configs/*
> akpm:/usr/src/25> 

 TURBOchannel is currently MIPS only:

$ grep PMAG arch/mips/configs/*
arch/mips/configs/decstation_defconfig:# CONFIG_FB_PMAG_AA is not set
arch/mips/configs/decstation_defconfig:CONFIG_FB_PMAG_BA=y
arch/mips/configs/decstation_defconfig:CONFIG_FB_PMAGB_B=y
$

 Thanks for your review.

  Maciej
