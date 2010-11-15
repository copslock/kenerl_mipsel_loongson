Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Nov 2010 05:05:09 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:36907 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490969Ab0KOEFG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Nov 2010 05:05:06 +0100
Received: by gwb11 with SMTP id 11so923454gwb.36
        for <multiple recipients>; Sun, 14 Nov 2010 20:05:00 -0800 (PST)
Received: by 10.151.39.4 with SMTP id r4mr2498996ybj.135.1289793899718;
        Sun, 14 Nov 2010 20:04:59 -0800 (PST)
Received: from angua (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id n48sm4304477yha.7.2010.11.14.20.04.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 20:04:59 -0800 (PST)
Received: by angua (Postfix, from userid 1000)
        id 2F43B3C00E5; Sun, 14 Nov 2010 21:04:56 -0700 (MST)
Date:   Sun, 14 Nov 2010 21:04:56 -0700
From:   Grant Likely <grant.likely@secretlab.ca>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        David Brownell <dbrownell@users.sourceforge.net>,
        spi-devel-general@lists.sourceforge.net,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [RFC 11/18] spi: add SPI controller driver for the Atheros
 AR71XX/AR724X/AR913X SoCs
Message-ID: <20101115040456.GB19965@angua.secretlab.ca>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
 <1289598684-30624-12-git-send-email-juhosg@openwrt.org>
 <20101114082242.GA3137@angua.secretlab.ca>
 <4CE04EBC.4080701@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CE04EBC.4080701@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Sun, Nov 14, 2010 at 10:03:56PM +0100, Gabor Juhos wrote:
> >> +static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned reg)
> >> +{
> >> +	return __raw_readl(sp->base + reg);
> >> +}
> >> +
> >> +static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned reg, u32 val)
> >> +{
> >> +	__raw_writel(val, sp->base + reg);
> >> +}
> > 
> > This is suspect.  Why is __raw_{readl,writel} being used instead of
> > ioread32/iowrite32?  The __raw versions don't provide any kind of
> > ordering barriers.
> 
> Mainly because the resulting code is smaller, and the performance is a bit
> better with the use of the __raw versions. The controller is embedded into the
> SoC and the registers are memory mapped, so i think it is safe to access them
> with __raw_{readl,writel}. However I can change it if that is the preferred method.
> 

Smaller, yes, because it doesn't have any io barriers; but is it safe?
Do you know whether or not the CPU will reorder the instructions on
you?  Being embedded into the SoC doesn't really mean anything in this
regard.  Unless you really understand all the behaviour of the CPU and
bus, then the safe versions must be used.

If you *do* really understand all the behaviour and decide it is safe
to use the __raw versions, then the driver needs to be well documented
as to the reasons why the __raw versions are safe to use.

g.
