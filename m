Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2007 16:42:42 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:11226 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023157AbXFWPmk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 23 Jun 2007 16:42:40 +0100
Received: from localhost (p2146-ipad201funabasi.chiba.ocn.ne.jp [222.146.65.146])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3E386AE34; Sun, 24 Jun 2007 00:41:18 +0900 (JST)
Date:	Sun, 24 Jun 2007 00:41:59 +0900 (JST)
Message-Id: <20070624.004159.07644824.anemo@mba.ocn.ne.jp>
To:	david-b@pacbell.net
Cc:	spi-devel-general@lists.sourceforge.net, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, ralf@linux-mips.org,
	mlachwani@mvista.com
Subject: Re: [spi-devel-general] [PATCH] TXx9 SPI controller driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200706221151.24959.david-b@pacbell.net>
References: <20070622.232111.36926005.anemo@mba.ocn.ne.jp>
	<200706221103.19761.david-b@pacbell.net>
	<200706221151.24959.david-b@pacbell.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 22 Jun 2007 11:51:24 -0700, David Brownell <david-b@pacbell.net> wrote:
> > > This is a driver for SPI controller built into TXx9 MIPS SoCs.
> > 
> > Looks mostly pretty good.  I made a few minor changes/cleanups
> > in the appended version, notably:
> >  - checking for spi->mode bits this code doesn't understand;
> >  - updating to match latest patches;
> > 
> > Note that if gpio_set_value() needs an mmiowb(), that seems like
> > a bug in this platform's  GPIO code; other platforms don't require
> > I/O barriers after GPIO calls.  Comments?
> > 
> > Also:
> > 
> 
> ... yeah, -ENOPATCH, sorry.  And the minor whitespace fixes.
> 
> One more comment:  surely platform_driver_probe() would be
> appropriate here?

Thank you for excellent review!  I'll look at each comments surely
will update the driver but it may take a few days.

For now, I'm quite sure your patch is OK for me except for one thing:

> + * spi_tx99.c - TXx9 SPI controller driver.

Name it spi_txx9.c, please ;)

And for mmiowb() issue, I put it just only I was not sure whether
gpio_set_value() guarantee I/O barrier.  Now I see i2c-gpio.c, etc. do
not have such barriers.  I will remove these barriers and fix platform
gpio codes.

---
Atsushi Nemoto
