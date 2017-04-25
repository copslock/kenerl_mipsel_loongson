Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2017 22:54:54 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:56112 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993928AbdDYUyrlz5kx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Apr 2017 22:54:47 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1d37U0-0001y5-00; Tue, 25 Apr 2017 22:54:48 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 02119508DC0; Tue, 25 Apr 2017 22:54:35 +0200 (CEST)
Date:   Tue, 25 Apr 2017 22:54:35 +0200
From:   Tom Bogendoerfer <tsbogend@alpha.franken.de>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix returns of some CLK API calls, if !CONFIG_HAVE_CLOCK
Message-ID: <20170425205435.GA13744@alpha.franken.de>
References: <20170425125547.865FB508DA7@solo.franken.de>
 <20170425163137.GR17774@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425163137.GR17774@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

On Tue, Apr 25, 2017 at 05:31:37PM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 25, 2017 at 02:30:07PM +0200, Thomas Bogendoerfer wrote:
> > If CONFIG_HAVE_CLOCK is not set, return values of clk_get(),
> > devm_clk_get(), devm_get_clk_from_child(), clk_get_parent()
> > and clk_get_sys() are wrong. According to spec these functions
> > should either return a pointer to a struct clk or a valid IS_ERR
> > condition. NULL is neither, so returning ERR_PTR(-ENODEV) makes
> > more sense.
> 
> That's wrong.  When the clk API is disabled, the expected behaviour is
> that drivers will not fail.  Returning ERR_PTR(-ENODEV) will cause them
> to fail, so will break platforms.
>
> NAK.
> 

then we have to go through all drivers, which could work with and
without HAVE_CLK and replace the IS_ERR() checks with something
like IS_ERR_OR_NULL().  Easy for the part I'm interested in the first place.

> > Without this change serial console on SNI RM400 machines (MIPS arch)
> > is broken, because sccnxp driver doesn't get a valid clock rate.
> 
> So the driver needs to depeond on HAVE_CLOCK.

the driver worked without HAVE_CLOCK before just fine, and while it
got invaded by CLK API it got broken.

No problem to fix that, but just looking at include/linux/clk.h:

/**
 * devm_clk_get - lookup and obtain a managed reference to a clock producer.
 * @dev: device for clock "consumer"
 * @id: clock consumer ID
 *
 * Returns a struct clk corresponding to the clock producer, or
 * valid IS_ERR() condition containing errno.  The implementation

I would expect either no replacement for that, if !HAVE_CLOCK
or simple a sane result code... and NULL isn't sane at least
with the description above...

But still it's your call.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
