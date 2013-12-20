Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2013 09:42:48 +0100 (CET)
Received: from smtp-out-111.synserver.de ([212.40.185.111]:1126 "EHLO
        smtp-out-044.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6867247Ab3LTImoomxxW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Dec 2013 09:42:44 +0100
Received: (qmail 26150 invoked by uid 0); 20 Dec 2013 08:42:43 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 26073
Received: from ppp-83-171-154-177.dynamic.mnet-online.de (HELO ?192.168.178.41?) [83.171.154.177]
  by 217.119.54.81 with AES256-SHA encrypted SMTP; 20 Dec 2013 08:42:42 -0000
Message-ID: <52B3F531.3090107@metafoo.de>
Date:   Fri, 20 Dec 2013 08:43:45 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
MIME-Version: 1.0
To:     Apelete Seketeli <apelete@seketeli.net>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] arch: mips: update platform data for JZ4740 usb device
 controller
References: <1387487503-26161-1-git-send-email-apelete@seketeli.net> <1387487503-26161-2-git-send-email-apelete@seketeli.net>
In-Reply-To: <1387487503-26161-2-git-send-email-apelete@seketeli.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 12/19/2013 10:11 PM, Apelete Seketeli wrote:
> The platform data already available in tree for JZ4740 USB Device
> Controller was previously used by an out-of-tree USB gadget driver
> which was not relying on the musb driver and was written by Ingenic
> and the Qi-Hardware community.
> 
> Update platform data for JZ4740 USB device controller to be used with
> musb driver.
> 
> Signed-off-by: Apelete Seketeli <apelete@seketeli.net>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  arch/mips/include/asm/mach-jz4740/platform.h |    1 +
>  arch/mips/jz4740/board-qi_lb60.c             |    1 +
>  arch/mips/jz4740/platform.c                  |   40 +++++++++++++++-----------
>  3 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-jz4740/platform.h b/arch/mips/include/asm/mach-jz4740/platform.h
> index 05988c2..069b43a 100644
> --- a/arch/mips/include/asm/mach-jz4740/platform.h
> +++ b/arch/mips/include/asm/mach-jz4740/platform.h
> @@ -21,6 +21,7 @@
>  
>  extern struct platform_device jz4740_usb_ohci_device;
>  extern struct platform_device jz4740_udc_device;
> +extern struct platform_device jz4740_udc_xceiv_device;
>  extern struct platform_device jz4740_mmc_device;
>  extern struct platform_device jz4740_rtc_device;
>  extern struct platform_device jz4740_i2c_device;
> diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
> index 8a5ec0e..c01900e 100644
> --- a/arch/mips/jz4740/board-qi_lb60.c
> +++ b/arch/mips/jz4740/board-qi_lb60.c
> @@ -427,6 +427,7 @@ static struct platform_device qi_lb60_audio_device = {
>  
>  static struct platform_device *jz_platform_devices[] __initdata = {
>  	&jz4740_udc_device,
> +	&jz4740_udc_xceiv_device,
>  	&jz4740_mmc_device,
>  	&jz4740_nand_device,
>  	&qi_lb60_keypad,
> diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
> index df65677..1be41e2 100644
> --- a/arch/mips/jz4740/platform.c
> +++ b/arch/mips/jz4740/platform.c
> @@ -21,6 +21,8 @@
>  
>  #include <linux/dma-mapping.h>
>  
> +#include <linux/usb/musb.h>
> +
>  #include <asm/mach-jz4740/platform.h>
>  #include <asm/mach-jz4740/base.h>
>  #include <asm/mach-jz4740/irq.h>
> @@ -56,29 +58,35 @@ struct platform_device jz4740_usb_ohci_device = {
>  	.resource	= jz4740_usb_ohci_resources,
>  };
>  
> -/* UDC (USB gadget controller) */
> -static struct resource jz4740_usb_gdt_resources[] = {
> -	{
> -		.start	= JZ4740_UDC_BASE_ADDR,
> -		.end	= JZ4740_UDC_BASE_ADDR + 0x1000 - 1,
> -		.flags	= IORESOURCE_MEM,
> +/* USB Device Controller */
> +struct platform_device jz4740_udc_xceiv_device = {
> +	.name = "usb_phy_gen_xceiv",
> +	.id   = 0,
> +};
> +
> +static struct resource jz4740_udc_resources[] = {
> +	[0] = {
> +		.start = JZ4740_UDC_BASE_ADDR,
> +		.end   = JZ4740_UDC_BASE_ADDR + 0x10000 - 1,
> +		.flags = IORESOURCE_MEM,
>  	},
> -	{
> -		.start	= JZ4740_IRQ_UDC,
> -		.end	= JZ4740_IRQ_UDC,
> -		.flags	= IORESOURCE_IRQ,
> +	[1] = {
> +		.start = JZ4740_IRQ_UDC,
> +		.end   = JZ4740_IRQ_UDC,
> +		.flags = IORESOURCE_IRQ,
> +		.name  = "mc",
>  	},
>  };
>  
>  struct platform_device jz4740_udc_device = {
> -	.name		= "jz-udc",
> -	.id		= -1,
> -	.dev = {
> -		.dma_mask = &jz4740_udc_device.dev.coherent_dma_mask,
> +	.name = "musb-jz4740",
> +	.id   = -1,
> +	.dev  = {
> +		.dma_mask          = &jz4740_udc_device.dev.coherent_dma_mask,
>  		.coherent_dma_mask = DMA_BIT_MASK(32),
>  	},
> -	.num_resources	= ARRAY_SIZE(jz4740_usb_gdt_resources),
> -	.resource	= jz4740_usb_gdt_resources,
> +	.num_resources = ARRAY_SIZE(jz4740_udc_resources),
> +	.resource      = jz4740_udc_resources,
>  };
>  
>  /* MMC/SD controller */
> 
