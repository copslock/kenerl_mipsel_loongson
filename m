Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 21:29:49 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:28825 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013458AbcBYU3qqNWWk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 21:29:46 +0100
Received: from [10.14.4.125] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Thu, 25 Feb 2016
 13:29:39 -0700
Subject: Re: [PATCH] clk: Get rid of HAVE_MACH_CLKDEV
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>
References: <1453933020-8577-1-git-send-email-sboyd@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56CF6461.9040308@microchip.com>
Date:   Thu, 25 Feb 2016 13:30:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1453933020-8577-1-git-send-email-sboyd@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

On 01/27/2016 03:17 PM, Stephen Boyd wrote:
> This config was used for the ARM port so that it could use a
> machine specific clkdev.h include, but those are all gone now.
> The MIPS architecture is the last user, and from what I can tell
> it doesn't actually use it anyway, so let's remove the config all
> together.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: <linux-mips@linux-mips.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Reviewed-by: Joshua Henderson <joshua.henderson@microchip.com>

Thanks,
Josh

> ---
> 
> I don't see a problem if this goes through the MIPS tree or the clk tree.
> Let me know and I can take it through clk.
> 
>  arch/mips/Kconfig       | 2 --
>  arch/mips/pic32/Kconfig | 1 -
>  drivers/clk/Kconfig     | 3 ---
>  3 files changed, 6 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 56f57816613e..8e1be2889af3 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -328,7 +328,6 @@ config LANTIQ
>  	select ARCH_REQUIRE_GPIOLIB
>  	select SWAP_IO_SPACE
>  	select BOOT_RAW
> -	select HAVE_MACH_CLKDEV
>  	select CLKDEV_LOOKUP
>  	select USE_OF
>  	select PINCTRL
> @@ -590,7 +589,6 @@ config RALINK
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  	select SYS_SUPPORTS_MIPS16
>  	select SYS_HAS_EARLY_PRINTK
> -	select HAVE_MACH_CLKDEV
>  	select CLKDEV_LOOKUP
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select RESET_CONTROLLER
> diff --git a/arch/mips/pic32/Kconfig b/arch/mips/pic32/Kconfig
> index fde56a8b85ca..1985971b9890 100644
> --- a/arch/mips/pic32/Kconfig
> +++ b/arch/mips/pic32/Kconfig
> @@ -15,7 +15,6 @@ config PIC32MZDA
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  	select ARCH_REQUIRE_GPIOLIB
> -	select HAVE_MACH_CLKDEV
>  	select COMMON_CLK
>  	select CLKDEV_LOOKUP
>  	select LIBFDT
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index eca8e019e005..35cbde8449a0 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -6,9 +6,6 @@ config CLKDEV_LOOKUP
>  config HAVE_CLK_PREPARE
>  	bool
>  
> -config HAVE_MACH_CLKDEV
> -	bool
> -
>  config COMMON_CLK
>  	bool
>  	select HAVE_CLK_PREPARE
> 
