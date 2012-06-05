Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 11:57:51 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:38714 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903703Ab2FEJ5r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 11:57:47 +0200
Received: by eekd17 with SMTP id d17so2500809eek.36
        for <multiple recipients>; Tue, 05 Jun 2012 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=7B1oJytCIBqJiDjZAVKybQ58dY7YTtqzU5yfDDT1OsA=;
        b=Sa55akxv/WAvigo+l3ik6yf95xcKhceetxw4GsBNIErGpTPwv/AdhlzuiWFIJ/mmMU
         bVvwlEUWFgphTa5L4hAw8nQgsbeDqpXK9zt88a5mYTu3f2uAL3Z7qwsHyzl+hyblwaFn
         wAwH2XbJ7KIj4yXlhTjqvk/QMhJCGPufgPB9d10XPs2nkEs5M2eEF54U51XyjJ4PVM/P
         P27yB19H+bDnK5WhkeoNOFSicBn+qqqOc1eySFwH9wbnUUMmDQhJX84NfiaLIravFwTW
         W/E+6ZuAcIs/r5B2ShQXA5GO1gF2w6vRR0LEHXwwLpdVOe5fN5fv253lAD8cciTlIFc1
         H7BA==
Received: by 10.14.96.8 with SMTP id q8mr6188823eef.203.1338890261416;
        Tue, 05 Jun 2012 02:57:41 -0700 (PDT)
Received: from flexo.localnet ([2a01:e34:ec0d:4090:daa:5a0b:38c8:54be])
        by mx.google.com with ESMTPS id p41sm4140997eef.5.2012.06.05.02.57.37
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Jun 2012 02:57:37 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: BCM63XX: be consistent in clock bits enable naming
Date:   Tue, 05 Jun 2012 11:55:26 +0200
Message-ID: <1470070.RaZQ4a8ogE@flexo>
User-Agent: KMail/4.8.3 (Linux/3.2.0-24-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <1328018888-5533-3-git-send-email-florian@openwrt.org>
References: <1328018888-5533-1-git-send-email-florian@openwrt.org> <1328018888-5533-3-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-archive-position: 33511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Hi Ralf,

On Tuesday 31 January 2012 15:08:08 Florian Fainelli wrote:
> Remove the _CLK suffix from the BCM6368 clock bits definitions to be
> consistent with what is already present.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

This patch is a prerequisite for BCM63xx's SPI support, and should be applied 
to your master tree in order to fix the following build failure, the patch 
applies cleanly to your master tree.

arch/mips/bcm63xx/clk.c: In function 'spi_set':
arch/mips/bcm63xx/clk.c:188:10: error: 'CKCTL_6368_SPI_EN' undeclared (first 
use in this function)
arch/mips/bcm63xx/clk.c:188:10: note: each undeclared identifier is reported 
only once for each function it appears in
make[2]: *** [arch/mips/bcm63xx/clk.o] Error 1

Thanks!


> ---
>  arch/mips/bcm63xx/clk.c                           |    6 ++--
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   36 
++++++++++----------
>  2 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
> index 9d57c71..8d2ea22 100644
> --- a/arch/mips/bcm63xx/clk.c
> +++ b/arch/mips/bcm63xx/clk.c
> @@ -120,7 +120,7 @@ static void enetsw_set(struct clk *clk, int enable)
>  {
>  	if (!BCMCPU_IS_6368())
>  		return;
> -	bcm_hwclock_set(CKCTL_6368_ROBOSW_CLK_EN |
> +	bcm_hwclock_set(CKCTL_6368_ROBOSW_EN |
>  			CKCTL_6368_SWPKT_USB_EN |
>  			CKCTL_6368_SWPKT_SAR_EN, enable);
>  	if (enable) {
> @@ -163,7 +163,7 @@ static void usbh_set(struct clk *clk, int enable)
>  	if (BCMCPU_IS_6348())
>  		bcm_hwclock_set(CKCTL_6348_USBH_EN, enable);
>  	else if (BCMCPU_IS_6368())
> -		bcm_hwclock_set(CKCTL_6368_USBH_CLK_EN, enable);
> +		bcm_hwclock_set(CKCTL_6368_USBH_EN, enable);
>  }
>  
>  static struct clk clk_usbh = {
> @@ -199,7 +199,7 @@ static void xtm_set(struct clk *clk, int enable)
>  	if (!BCMCPU_IS_6368())
>  		return;
>  
> -	bcm_hwclock_set(CKCTL_6368_SAR_CLK_EN |
> +	bcm_hwclock_set(CKCTL_6368_SAR_EN |
>  			CKCTL_6368_SWPKT_SAR_EN, enable);
>  
>  	if (enable) {
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h 
b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> index 94d4faa..6ddd081 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> @@ -90,29 +90,29 @@
>  #define CKCTL_6368_PHYMIPS_EN		(1 << 6)
>  #define CKCTL_6368_SWPKT_USB_EN		(1 << 7)
>  #define CKCTL_6368_SWPKT_SAR_EN		(1 << 8)
> -#define CKCTL_6368_SPI_CLK_EN		(1 << 9)
> -#define CKCTL_6368_USBD_CLK_EN		(1 << 10)
> -#define CKCTL_6368_SAR_CLK_EN		(1 << 11)
> -#define CKCTL_6368_ROBOSW_CLK_EN	(1 << 12)
> -#define CKCTL_6368_UTOPIA_CLK_EN	(1 << 13)
> -#define CKCTL_6368_PCM_CLK_EN		(1 << 14)
> -#define CKCTL_6368_USBH_CLK_EN		(1 << 15)
> +#define CKCTL_6368_SPI_EN		(1 << 9)
> +#define CKCTL_6368_USBD_EN		(1 << 10)
> +#define CKCTL_6368_SAR_EN		(1 << 11)
> +#define CKCTL_6368_ROBOSW_EN		(1 << 12)
> +#define CKCTL_6368_UTOPIA_EN		(1 << 13)
> +#define CKCTL_6368_PCM_EN		(1 << 14)
> +#define CKCTL_6368_USBH_EN		(1 << 15)
>  #define CKCTL_6368_DISABLE_GLESS_EN	(1 << 16)
> -#define CKCTL_6368_NAND_CLK_EN		(1 << 17)
> -#define CKCTL_6368_IPSEC_CLK_EN		(1 << 17)
> +#define CKCTL_6368_NAND_EN		(1 << 17)
> +#define CKCTL_6368_IPSEC_EN		(1 << 17)
>  
>  #define CKCTL_6368_ALL_SAFE_EN		(CKCTL_6368_SWPKT_USB_EN |	\
>  					CKCTL_6368_SWPKT_SAR_EN |	\
> -					CKCTL_6368_SPI_CLK_EN |		\
> -					CKCTL_6368_USBD_CLK_EN |	\
> -					CKCTL_6368_SAR_CLK_EN |		\
> -					CKCTL_6368_ROBOSW_CLK_EN |	\
> -					CKCTL_6368_UTOPIA_CLK_EN |	\
> -					CKCTL_6368_PCM_CLK_EN |		\
> -					CKCTL_6368_USBH_CLK_EN |	\
> +					CKCTL_6368_SPI_EN |		\
> +					CKCTL_6368_USBD_EN |		\
> +					CKCTL_6368_SAR_EN |		\
> +					CKCTL_6368_ROBOSW_EN |		\
> +					CKCTL_6368_UTOPIA_EN |		\
> +					CKCTL_6368_PCM_EN |		\
> +					CKCTL_6368_USBH_EN |		\
>  					CKCTL_6368_DISABLE_GLESS_EN |	\
> -					CKCTL_6368_NAND_CLK_EN |	\
> -					CKCTL_6368_IPSEC_CLK_EN)
> +					CKCTL_6368_NAND_EN |		\
> +					CKCTL_6368_IPSEC_EN)
>  
>  /* System PLL Control register  */
>  #define PERF_SYS_PLL_CTL_REG		0x8
> -- 
> 1.7.5.4
> 
