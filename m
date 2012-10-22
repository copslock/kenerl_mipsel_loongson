Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2012 15:27:20 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52184 "EHLO
        opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824843Ab2JVN1T0j0c6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Oct 2012 15:27:19 +0200
Received: from finisterre.wolfsonmicro.main (unknown [87.246.78.26])
        by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 87AF6110A02;
        Mon, 22 Oct 2012 14:27:13 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.80)
        (envelope-from <broonie@opensource.wolfsonmicro.com>)
        id 1TQI2B-0002WN-Tc; Mon, 22 Oct 2012 14:27:11 +0100
Date:   Mon, 22 Oct 2012 14:27:11 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Mike Turquette <mturquette@linaro.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: Make the generic clock API available by default
Message-ID: <20121022132711.GE4477@opensource.wolfsonmicro.com>
References: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121022130556.GM21164@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121022130556.GM21164@n2100.arm.linux.org.uk>
X-Cookie: Just to have it is enough.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Oct 22, 2012 at 02:05:57PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 22, 2012 at 02:02:50PM +0100, Mark Brown wrote:
> > @@ -327,6 +328,7 @@ config ARCH_AT91
> >  	select ARCH_REQUIRE_GPIOLIB
> >  	select CLKDEV_LOOKUP
> >  	select HAVE_CLK
> > +	select HAVE_CUSTOM_CLK

> This is silly.  If you select "HAVE_CUSTOM_CLK" then isn't it true that
> "HAVE_CLK" should also be selected?  If so, why not have "HAVE_CUSTOM_CLK"
> do that selection and remove it from all these entries?

If we're worrying about that there's the larger point that the effect of
this patch is to make HAVE_CLK meaningless as there will be no platform
for which it's not true.  I was just leaving HAVE_CLK alone for now
ready to circle around on it if we ever manage to get the enabling bit
sorted.
