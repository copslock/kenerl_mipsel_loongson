Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2012 15:50:58 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34927 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824843Ab2JVNu5aD4eh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Oct 2012 15:50:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=8VADQ95mEzo7ITE9Njwf70rMMocBtWW/WzXcgOqRH9c=;
        b=WM3Fct1nSuBpFVSKL+PhsBQbtYzq/p3IMV69Z/aYusY12eFzsYjAozKI37hEUeVKN+PNX4uCaZLAxSOXlXABnNDX1tZOpXFAshivttjOqi9vroVV8LrkXC1HBIZiKJZ5n62+GZrAcv2k9EOU0aJQFVZ+cj/bZJXq32Wh3bPo3zM=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:44400)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1TQIOg-0005VZ-21; Mon, 22 Oct 2012 14:50:26 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1TQIOf-00014V-2F; Mon, 22 Oct 2012 14:50:25 +0100
Date:   Mon, 22 Oct 2012 14:50:24 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     Mike Turquette <mturquette@linaro.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: Make the generic clock API available by default
Message-ID: <20121022135024.GN21164@n2100.arm.linux.org.uk>
References: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20121022130556.GM21164@n2100.arm.linux.org.uk> <20121022132711.GE4477@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121022132711.GE4477@opensource.wolfsonmicro.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-archive-position: 34733
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Oct 22, 2012 at 02:27:11PM +0100, Mark Brown wrote:
> On Mon, Oct 22, 2012 at 02:05:57PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 22, 2012 at 02:02:50PM +0100, Mark Brown wrote:
> > > @@ -327,6 +328,7 @@ config ARCH_AT91
> > >  	select ARCH_REQUIRE_GPIOLIB
> > >  	select CLKDEV_LOOKUP
> > >  	select HAVE_CLK
> > > +	select HAVE_CUSTOM_CLK
> 
> > This is silly.  If you select "HAVE_CUSTOM_CLK" then isn't it true that
> > "HAVE_CLK" should also be selected?  If so, why not have "HAVE_CUSTOM_CLK"
> > do that selection and remove it from all these entries?
> 
> If we're worrying about that there's the larger point that the effect of
> this patch is to make HAVE_CLK meaningless as there will be no platform
> for which it's not true.  I was just leaving HAVE_CLK alone for now
> ready to circle around on it if we ever manage to get the enabling bit
> sorted.

Are you sure that all architectures are fine with having that permanently
enabled?  What about nommu architectures?
