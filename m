Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2017 23:33:24 +0200 (CEST)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:39560
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993928AbdDYVdPRMmyF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Apr 2017 23:33:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=lGj+AGrYnrUwKPOP3UToRYz6h5LJje102CzEqC8i/Ck=;
        b=V2wHb5v5EDYX58xa10Jm2URdyYgjAmwA/d8INH4Qy5SvOYohiLS8+RSI0Fu1pnF4kdrpHFqxQ+qX3apQl3inqa8U8bKu2Clxojf/6M806x1DjgzlW2nqd6EwKKAUFaH3tmlcKEFIaD4/bnzkknVHPZieAfB2o7AVMk49FOkA1WM=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:57909)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@armlinux.org.uk>)
        id 1d385A-0002PT-Dn; Tue, 25 Apr 2017 22:33:12 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1d3853-00071V-8q; Tue, 25 Apr 2017 22:33:05 +0100
Date:   Tue, 25 Apr 2017 22:33:03 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Tom Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix returns of some CLK API calls, if !CONFIG_HAVE_CLOCK
Message-ID: <20170425213303.GU17774@n2100.armlinux.org.uk>
References: <20170425125547.865FB508DA7@solo.franken.de>
 <20170425163137.GR17774@n2100.armlinux.org.uk>
 <20170425205435.GA13744@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425205435.GA13744@alpha.franken.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@armlinux.org.uk
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, Apr 25, 2017 at 10:54:35PM +0200, Tom Bogendoerfer wrote:
> On Tue, Apr 25, 2017 at 05:31:37PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Apr 25, 2017 at 02:30:07PM +0200, Thomas Bogendoerfer wrote:
> > > If CONFIG_HAVE_CLOCK is not set, return values of clk_get(),
> > > devm_clk_get(), devm_get_clk_from_child(), clk_get_parent()
> > > and clk_get_sys() are wrong. According to spec these functions
> > > should either return a pointer to a struct clk or a valid IS_ERR
> > > condition. NULL is neither, so returning ERR_PTR(-ENODEV) makes
> > > more sense.
> > 
> > That's wrong.  When the clk API is disabled, the expected behaviour is
> > that drivers will not fail.  Returning ERR_PTR(-ENODEV) will cause them
> > to fail, so will break platforms.
> >
> > NAK.
> > 
> 
> then we have to go through all drivers, which could work with and
> without HAVE_CLK and replace the IS_ERR() checks with something
> like IS_ERR_OR_NULL().  Easy for the part I'm interested in the
> first place.

What you describe is exactly what you're proposing to happen if your
patch gets merged - we go from a situation where drivers that do this
today:

	clk = devm_clk_get();
	if (IS_ERR(clk))
		return PTR_ERR(clk);

start failing to probe, whereas the current situation is that they
work.

It's well established that the NULL clk means that there is no clock
available (eg, because the architecture doesn't support the clk API)
and this allows drivers to work across different architectures today.
provided they aren't reliant on obtaining the current clock rate.

> > > Without this change serial console on SNI RM400 machines (MIPS arch)
> > > is broken, because sccnxp driver doesn't get a valid clock rate.
> > 
> > So the driver needs to depeond on HAVE_CLOCK.
> 
> the driver worked without HAVE_CLOCK before just fine, and while it
> got invaded by CLK API it got broken.
> 
> No problem to fix that, but just looking at include/linux/clk.h:
> 
> /**
>  * devm_clk_get - lookup and obtain a managed reference to a clock producer.
>  * @dev: device for clock "consumer"
>  * @id: clock consumer ID
>  *
>  * Returns a struct clk corresponding to the clock producer, or
>  * valid IS_ERR() condition containing errno.  The implementation
> 
> I would expect either no replacement for that, if !HAVE_CLOCK
> or simple a sane result code... and NULL isn't sane at least
> with the description above...

As far as drivers are concerned, any value returned that IS_ERR()
tests false must not be assumed to be a failure.

However, looking at commit 90efa75f7ab0, there's one point that's
definitely wrong, and another that can be improved to avoid your
problem.

1. clk_get_rate() on a disabled clock:

 * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
 *                This is only valid once the clock source has been enabled.

   The clock is expected to be enabled before clk_get_rate() is called,
   and the driver is not doing that.

2. if uartclk is zero after enabling, then there's clearly no clock
   rate available, and the driver really ought to fallback to using
   the old method.

So, I'd suggest that the driver should be coded:

	clk = devm_clk_get(&pdev->dev, NULL);
	if (IS_ERR(clk)) {
		ret = PTR_ERR(clk);
		if (ret == -EPROBE_DEFER)
			goto err_out;
		uartclk = 0;
	} else {
		uartclk = clk_get_rate(clk);
	}

	if (!uartclk) {
		dev_notice(&pdev->dev, "Using default clock frequency\n");
		uartclk = s->freq_std;
	}

	/* Check input frequency */
	...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
