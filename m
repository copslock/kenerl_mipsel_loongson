Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Aug 2013 01:20:31 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41254 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827311Ab3HWXUYEpQFW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Aug 2013 01:20:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=9jGuYhhxqr0gIq8bvJtq9Yv6nE2qBR399z3OhypT7e8=;
        b=mH3anHHvsjF/o+nQ9zMM1UtfJR1blrqiNKxMjdTeL2eiz76FKuF1JhK+OsK3g7JnvDP1VXfD7iEutxW8qlMOAGbDJaUzAO+c12CDCQfjjqfgbTajPy3gwdyzgBnGG100NFTKasGKHXMS9af2z+1SxY0uWEOhsNvzRK4EeymYsiQ=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:34018)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1VD0Xd-0001NA-8o; Sat, 24 Aug 2013 00:13:17 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1VD0Xb-0001Ln-HI; Sat, 24 Aug 2013 00:13:15 +0100
Date:   Sat, 24 Aug 2013 00:13:15 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, mturquette@linaro.org,
        jiada_wang@mentor.com, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, shawn.guo@linaro.org,
        sebastian.hesselbarth@gmail.com, LW@KARO-electronics.de,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v3 3/5] clk: Add common __clk_get(), __clk_put()
        implementations
Message-ID: <20130823231314.GR6617@n2100.arm.linux.org.uk>
References: <1377270227-1030-1-git-send-email-s.nawrocki@samsung.com> <1377270227-1030-4-git-send-email-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1377270227-1030-4-git-send-email-s.nawrocki@samsung.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37672
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

On Fri, Aug 23, 2013 at 05:03:45PM +0200, Sylwester Nawrocki wrote:
> This patch adds common __clk_get(), __clk_put() clkdev helpers which
> replace their platform specific counterparts when the common clock
> API is enabled.
> 
> The owner module pointer field is added to struct clk so a reference
> to the clock supplier module can be taken by the clock consumers.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

I'm mostly happy with this now.

> +int __clk_get(struct clk *clk)
> +{
> +	if (clk && !try_module_get(clk->owner))
> +		return 0;
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL(__clk_get);
> +
> +void __clk_put(struct clk *clk)
> +{
> +	if (WARN_ON_ONCE(IS_ERR(clk)))
> +		return;
> +
> +	if (clk)
> +		module_put(clk->owner);
> +}
> +EXPORT_SYMBOL(__clk_put);

Why are these exported?  clkdev can only be built into the kernel, as can
the common clk framework - they can't be modular.  So why would a module
wish to access these directly?
