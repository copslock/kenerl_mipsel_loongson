Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2012 15:06:43 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34887 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824845Ab2JVNGmPQ1Eu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Oct 2012 15:06:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=pQdoz2C5yt4asGmWaXHoCghvA9ipxoMdBc8bC+ZEuDA=;
        b=NXK+CwMWsBsAApZRP7Hwc7dzzXfi4u7XPGTs4GwBNt8XIsTPbtSs4dxA2TVsyOsUas17hdkbu/pYPI1fNuR3N0IAn4WuQYTIiqJZGeoGeISj87WOSec66ivFF+PiJEmZGkB/Hmctrt6TrJtPJzBuhvfkw5/lx4M/9T8Qajq5ox4=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:51395)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1TQHhe-0005TI-HM; Mon, 22 Oct 2012 14:05:58 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1TQHhd-0000jd-EU; Mon, 22 Oct 2012 14:05:57 +0100
Date:   Mon, 22 Oct 2012 14:05:57 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     Mike Turquette <mturquette@linaro.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: Make the generic clock API available by default
Message-ID: <20121022130556.GM21164@n2100.arm.linux.org.uk>
References: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-archive-position: 34731
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

On Mon, Oct 22, 2012 at 02:02:50PM +0100, Mark Brown wrote:
> @@ -327,6 +328,7 @@ config ARCH_AT91
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CLKDEV_LOOKUP
>  	select HAVE_CLK
> +	select HAVE_CUSTOM_CLK

This is silly.  If you select "HAVE_CUSTOM_CLK" then isn't it true that
"HAVE_CLK" should also be selected?  If so, why not have "HAVE_CUSTOM_CLK"
do that selection and remove it from all these entries?
