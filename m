Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 03:29:26 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:1059 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023745AbXIUC3R (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 03:29:17 +0100
Received: by mo.po.2iij.net (mo30) id l8L2TEeG030919; Fri, 21 Sep 2007 11:29:14 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l8L2TCDr009117
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Sep 2007 11:29:12 +0900
Message-Id: <200709210229.l8L2TCDr009117@po-mbox301.hop.2iij.net>
Date:	Fri, 21 Sep 2007 11:29:12 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, Richard Purdie <rpurdie@rpsys.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][2/6] led: add Cobalt Raq series LEDs support
In-Reply-To: <20070920160034.GC5522@linux-mips.org>
References: <20070920230204.0ad15513.yoichi_yuasa@tripeaks.co.jp>
	<20070920230322.6600dd83.yoichi_yuasa@tripeaks.co.jp>
	<20070920160034.GC5522@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Thu, 20 Sep 2007 17:00:34 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Thu, Sep 20, 2007 at 11:03:22PM +0900, Yoichi Yuasa wrote:
> 
> > diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/leds/leds-cobalt-raq.c mips/drivers/leds/leds-cobalt-raq.c
> > --- mips-orig/drivers/leds/leds-cobalt-raq.c	1970-01-01 09:00:00.000000000 +0900
> > +++ mips/drivers/leds/leds-cobalt-raq.c	2007-09-14 13:06:03.900173500 +0900
> > @@ -0,0 +1,135 @@
> > +/*
> > + *  LEDs driver for the Cobalt Raq series.
> > + *
> > + *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> 
> Do you really want to allow version 2 or newer?  (Just checking)

Yes I do.

Thank you for your comments.
I'll update soon.

Yoichi
