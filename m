Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2013 01:22:23 +0100 (CET)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35064 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823051Ab3J3AWVazl2n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Oct 2013 01:22:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=CsHao1vUnf8TSMiZSkBybdaOYsZv8W54GiHHDuxyok4=;
        b=aotF7+5hcEAZyOC88xav3kBAZsSBVePzXPZMuhChZP/cufgaCHiBkAiipN2zce5J/hnO1do5ze+nAqPqX3U6xr+4j67nFKBr4FBvHqoNzao9h441+L71ZAoFKo2mfjQxHlZ+8HpmpfpFWEI3r0tXaqnAX08xxz/oMXVqs9pMhcQ=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:53301)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1VbJVP-0004YL-70; Wed, 30 Oct 2013 00:19:27 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1VbJVN-0003Or-Ml; Wed, 30 Oct 2013 00:19:25 +0000
Date:   Wed, 30 Oct 2013 00:19:25 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, mturquette@linaro.org,
        jiada_wang@mentor.com, kyungmin.park@samsung.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v7 4/5] clk: Add common __clk_get(), __clk_put()
        implementations
Message-ID: <20131030001924.GX16735@n2100.arm.linux.org.uk>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com> <1383076268-8984-5-git-send-email-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1383076268-8984-5-git-send-email-s.nawrocki@samsung.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38412
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

On Tue, Oct 29, 2013 at 08:51:07PM +0100, Sylwester Nawrocki wrote:
> This patch adds common __clk_get(), __clk_put() clkdev helpers that
> replace their platform specific counterparts when the common clock
> API is used.
> 
> The owner module pointer field is added to struct clk so a reference
> to the clock supplier module can be taken by the clock consumers.
> 
> The owner module is assigned while the clock is being registered,
> in functions _clk_register() and __clk_register().
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
