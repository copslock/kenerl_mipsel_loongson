Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Aug 2013 22:34:08 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47040 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816493Ab3HTUeFxw9Hj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Aug 2013 22:34:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=bjVc4yo6BM6uMHNygd7YGYJLqhO4nH/xUeh7+7UXT88=;
        b=bnou8vjBeM/UZwyvd577zM+gWbltMJesJ3+tM72kQvu1eL7jAxKs/ZPYV/VnqNNOP/LjybvNukr9ubbRVtIH/IidV7oX9+ucWKeG4AOOSpr+3yQCUt+Px4+fW1lsYFNHwTHTYqwssT0QQdbKIrJqeUGXpYDFaGQsrwdXnuLrBew=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:58582)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1VBsZZ-0004Ov-Ma; Tue, 20 Aug 2013 21:30:37 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1VBsZX-0000rN-JT; Tue, 20 Aug 2013 21:30:35 +0100
Date:   Tue, 20 Aug 2013 21:30:34 +0100
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
Subject: Re: [PATCH v2 1/4] clk: add common __clk_get(), __clk_put()
        implementations
Message-ID: <20130820203034.GC17845@n2100.arm.linux.org.uk>
References: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com> <1377020063-30213-2-git-send-email-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1377020063-30213-2-git-send-email-s.nawrocki@samsung.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37600
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

On Tue, Aug 20, 2013 at 07:34:20PM +0200, Sylwester Nawrocki wrote:
> +int __clk_get(struct clk *clk)
> +{
> +	if (WARN_ON((!clk)))
> +		return 0;

This changes the behaviour of clk_get()

> +
> +	if (!try_module_get(clk->owner))
> +		return 0;

If you want this to be safe against NULL pointers, just do this:

	if (clk && !try_module_get(clk->owner))
		return 0;

> +
> +	return 1;
> +}
> +EXPORT_SYMBOL(__clk_get);
> +
> +void __clk_put(struct clk *clk)
> +{
> +	if (!clk || IS_ERR(clk))
> +		return;
> +
> +	module_put(clk->owner);

Calling clk_put() with an error-pointer should be a Bad Thing and something
that shouldn't be encouraged, so trapping it is probably unwise.  So, just
do here:

	if (clk)
		module_put(clk->owner);

If we do have some callers of this with ERR pointers, then we could add:

	if (WARN_ON_ONCE(IS_ERR(clk)))
		return;

and remove it after a full kernel cycle or so.
