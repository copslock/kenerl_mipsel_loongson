Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Aug 2013 23:54:39 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47099 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6828740Ab3HTVyhhrUMP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Aug 2013 23:54:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=IFrpuCr5G3S4u6Oit70LdvzHu9JeB9sM1Vtl963ZzWo=;
        b=AGiS7Smd8/9WxGNpbkkeAs/UaClS0/Y9PGqre94P/sd06nSovj4XLuVldg/ZEUoicZocCYLPI2Llc7236ypz5Lhw9N7CEPXIBjRNi23Hs9cozL4KFBgu7SIc3MMFzQF/R25xT7cI+mQD7DjoucqyI9Lm/DAzdZK9RZTQeTlwTo4=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:58668)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1VBtpk-0004SH-9O; Tue, 20 Aug 2013 22:51:24 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1VBtpi-0001hF-8e; Tue, 20 Aug 2013 22:51:22 +0100
Date:   Tue, 20 Aug 2013 22:51:21 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, mturquette@linaro.org,
        jiada_wang@mentor.com, robherring2@gmail.com,
        grant.likely@linaro.org, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, kyungmin.park@samsung.com,
        shawn.guo@linaro.org, sebastian.hesselbarth@gmail.com,
        LW@KARO-electronics.de, t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 3/4] clk: Provide not locked variant of
        of_clk_get_from_provider()
Message-ID: <20130820215121.GG17845@n2100.arm.linux.org.uk>
References: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com> <1377020063-30213-4-git-send-email-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1377020063-30213-4-git-send-email-s.nawrocki@samsung.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Tue, Aug 20, 2013 at 07:34:22PM +0200, Sylwester Nawrocki wrote:
> Add helper functions for the of_clk_providers list locking and
> an unlocked variant of of_clk_get_from_provider().
> These functions are intended to be used in the clkdev to avoid
> race condition in the device tree based clock look up in clk_get().
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changes since v1:
>  - moved the function declaractions to a local header.

Yes, this is a much better solution, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
