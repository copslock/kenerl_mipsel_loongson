Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 10:03:19 +0100 (BST)
Received: from harold.telenet-ops.be ([195.130.133.65]:31940 "EHLO
	harold.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20023547AbYHGJDK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Aug 2008 10:03:10 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by harold.telenet-ops.be (Postfix) with SMTP id 0512B30062;
	Thu,  7 Aug 2008 11:03:09 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by harold.telenet-ops.be (Postfix) with ESMTP id CC3463003B;
	Thu,  7 Aug 2008 11:03:08 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id m77938cG024062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 7 Aug 2008 11:03:08 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m77938F8024059;
	Thu, 7 Aug 2008 11:03:08 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Thu, 7 Aug 2008 11:03:07 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Alessandro Zummo <alessandro.zummo@towertech.it>
cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] DS1286: new RTC driver
In-Reply-To: <20080807105249.50d6e777@i1501.lan.towertech.it>
Message-ID: <Pine.LNX.4.64.0808071102420.23641@anakin>
References: <20080803174137.AF8071DA6F4@solo.franken.de>
 <20080807105249.50d6e777@i1501.lan.towertech.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 7 Aug 2008, Alessandro Zummo wrote:
> On Sun,  3 Aug 2008 19:41:37 +0200 (CEST)
> Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> > +static int __devinit ds1286_probe(struct platform_device *pdev)
> > +{
> > +	struct rtc_device *rtc;
> > +	struct resource *res;
> > +	struct ds1286_priv *priv;
> > +	int ret = 0;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res)
> > +		return -ENODEV;
> > +	priv = kzalloc(sizeof *priv, GFP_KERNEL);
> 
>  sizeof(struct ds1286_priv) is a little bit cleaner.

What if the type of priv changes?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
