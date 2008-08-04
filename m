Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2008 08:49:35 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:19349 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20025364AbYHDHt2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 Aug 2008 08:49:28 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KPuoo-0002S9-00; Mon, 04 Aug 2008 09:49:26 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id B1FF4C2EA8; Mon,  4 Aug 2008 09:49:09 +0200 (CEST)
Date:	Mon, 4 Aug 2008 09:49:09 +0200
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	a.zummo@towertech.it, ralf@linux-mips.org
Subject: Re: [PATCH] M48T35: new RTC driver
Message-ID: <20080804074909.GA5760@alpha.franken.de>
References: <20080803174140.797B51DA6F4@solo.franken.de> <20080804.105151.213759441.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080804.105151.213759441.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Aug 04, 2008 at 10:51:51AM +0900, Atsushi Nemoto wrote:
> On Sun,  3 Aug 2008 19:41:40 +0200 (CEST), Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> > This driver replaces the broken ip27-rtc driver in drivers/char and
> > gives back RTC support for SGI IP27 machines.
> ...
> > +config RTC_DRV_M48T35
> > +	tristate "ST M48T35"
> > +	depends on SGI_IP27
> 
> Is this driver really IP27 specific?  Let's make drivers generic as
> possible.

ok, will change that.

> > +	if ((hrs >= 24) || (min >= 60) || (sec >= 60))
> > +		return -EINVAL;
> 
> rtc_valid_tm() can be used?

good idea.

> > +	priv->baseaddr = res->start;
> > +	priv->reg = (struct m48t35_rtc __iomem *)res->start;
> 
> It seems priv->baseaddr is a physical address and priv->reg is a
> virtual address.  ioremap() is not needed?

I've misued res->start to pass the pointer, which was used by the old
rtc driver. I'll switch over to pass a physical address and add ioremap
code.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
