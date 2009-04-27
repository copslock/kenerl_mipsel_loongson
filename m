Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 14:09:58 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51124 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20023112AbZD0NJz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Apr 2009 14:09:55 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3RD9qrH030938;
	Mon, 27 Apr 2009 15:09:53 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3RD9q5a030936;
	Mon, 27 Apr 2009 15:09:52 +0200
Date:	Mon, 27 Apr 2009 15:09:52 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
Message-ID: <20090427130952.GA30817@linux-mips.org>
References: <E1LyQQX-00047N-6E@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1LyQQX-00047N-6E@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 27, 2009 at 06:59:17AM -0600, Shane McDonald wrote:

> There have been a number of compile problems with the msp71xx
> configuration ever since it was included in the linux-mips.org
> repository.  This patch resolves these problems:
>  - proper files are included when using a squashfs rootfs
>  - resetting the board no longer uses non-existent GPIO routines
>  - create the required plat_timer_setup function
> 
> This patch has been compile-tested against the current HEAD.
> 
> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
> ---
>  arch/mips/pmc-sierra/msp71xx/msp_prom.c  |    3 ++-
>  arch/mips/pmc-sierra/msp71xx/msp_setup.c |    8 ++------
>  arch/mips/pmc-sierra/msp71xx/msp_time.c  |    7 ++-----
>  3 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
> index e5bd548..1e2d984 100644
> --- a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
> @@ -44,7 +44,8 @@
>  #include <linux/cramfs_fs.h>
>  #endif
>  #ifdef CONFIG_SQUASHFS
> -#include <linux/squashfs_fs.h>
> +#include <linux/magic.h>
> +#include "../../../../fs/squashfs/squashfs_fs.h"

No way.  You're reaching deep into the internals of squashfs for no good
reason.  The only use of anything from squashfs_fs.h is a cast and casting
to void * would work just as well.

>  #endif
>  
>  #include <asm/addrspace.h>
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
> index c936756..a54e85b 100644
> --- a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
> @@ -21,7 +21,6 @@
>  
>  #if defined(CONFIG_PMC_MSP7120_GW)
>  #include <msp_regops.h>
> -#include <msp_gpio.h>
>  #define MSP_BOARD_RESET_GPIO	9
>  #endif
>  
> @@ -88,11 +87,8 @@ void msp7120_reset(void)
>  	 * as GPIO char driver may not be enabled and it would look up
>  	 * data inRAM!
>  	 */
> -	set_value_reg32(GPIO_CFG3_REG,
> -			basic_mode_mask(MSP_BOARD_RESET_GPIO),
> -			basic_mode(MSP_GPIO_OUTPUT, MSP_BOARD_RESET_GPIO));
> -	set_reg32(GPIO_DATA3_REG,
> -			basic_data_mask(MSP_BOARD_RESET_GPIO));
> +	set_value_reg32(GPIO_CFG3_REG, 0xf000, 0x8000);
> +	set_reg32(GPIO_DATA3_REG, 8);
>  
>  	/*
>  	 * In case GPIO9 doesn't reset the board (jumper configurable!)
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra/msp71xx/msp_time.c
> index 7cfeda5..cca64e1 100644
> --- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
> @@ -81,10 +81,7 @@ void __init plat_time_init(void)
>  	mips_hpt_frequency = cpu_rate/2;
>  }
>  
> -void __init plat_timer_setup(struct irqaction *irq)
> +unsigned int __init get_c0_compare_int(void)
>  {
> -#ifdef CONFIG_IRQ_MSP_CIC
> -	/* we are using the vpe0 counter for timer interrupts */
> -	setup_irq(MSP_INT_VPE0_TIMER, irq);
> -#endif
> +	return MSP_INT_VPE0_TIMER;
>  }

The rest seems ok.  Can you fix the issue above and send a new patch?

Thanks!

  Ralf
