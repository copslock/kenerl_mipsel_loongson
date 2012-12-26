Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 11:51:29 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:51730 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817387Ab2LZKv1hLUkj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Dec 2012 11:51:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 7BC058F60;
        Wed, 26 Dec 2012 11:51:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6BM9PJa175g3; Wed, 26 Dec 2012 11:51:20 +0100 (CET)
Received: from [192.168.178.21] (dyndsl-085-016-167-010.ewe-ip-backbone.de [85.16.167.10])
        by hauke-m.de (Postfix) with ESMTPSA id 914278E1C;
        Wed, 26 Dec 2012 11:51:20 +0100 (CET)
Message-ID: <50DAD6A7.6040304@hauke-m.de>
Date:   Wed, 26 Dec 2012 11:51:19 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: bcm47xx: separate functions finding flash window
 addr
References: <1356514157-7547-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1356514157-7547-1-git-send-email-zajec5@gmail.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 12/26/2012 10:29 AM, Rafał Miłecki wrote:
> Also check if parallel flash is present at all before accessing it and
> add support for serial flash on BCMA bus.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

I came up with a similar patch [0], but I will rebase mine and send it
in some days.

[0):
https://dev.openwrt.org/browser/trunk/target/linux/brcm47xx/patches-3.6/080-MIPS-BCM47XX-rewrite-nvram-probing.patch
> ---
>  arch/mips/bcm47xx/nvram.c |   87 +++++++++++++++++++++++++++++++--------------
>  1 files changed, 60 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
> index 48a4c70..6461367 100644
> --- a/arch/mips/bcm47xx/nvram.c
> +++ b/arch/mips/bcm47xx/nvram.c
> @@ -23,39 +23,13 @@
>  
>  static char nvram_buf[NVRAM_SPACE];
>  
> -/* Probe for NVRAM header */
> -static void early_nvram_init(void)
> +static void nvram_find_and_copy(u32 base, u32 lim)
>  {
> -#ifdef CONFIG_BCM47XX_SSB
> -	struct ssb_mipscore *mcore_ssb;
> -#endif
> -#ifdef CONFIG_BCM47XX_BCMA
> -	struct bcma_drv_cc *bcma_cc;
> -#endif
>  	struct nvram_header *header;
>  	int i;
> -	u32 base = 0;
> -	u32 lim = 0;
>  	u32 off;
>  	u32 *src, *dst;
>  
> -	switch (bcm47xx_bus_type) {
> -#ifdef CONFIG_BCM47XX_SSB
> -	case BCM47XX_BUS_TYPE_SSB:
> -		mcore_ssb = &bcm47xx_bus.ssb.mipscore;
> -		base = mcore_ssb->pflash.window;
> -		lim = mcore_ssb->pflash.window_size;
> -		break;
> -#endif
> -#ifdef CONFIG_BCM47XX_BCMA
> -	case BCM47XX_BUS_TYPE_BCMA:
> -		bcma_cc = &bcm47xx_bus.bcma.bus.drv_cc;
> -		base = bcma_cc->pflash.window;
> -		lim = bcma_cc->pflash.window_size;
> -		break;
> -#endif
> -	}
> -
>  	off = FLASH_MIN;
>  	while (off <= lim) {
>  		/* Windowed flash access */
> @@ -86,6 +60,65 @@ found:
>  		*dst++ = le32_to_cpu(*src++);
>  }
>  
> +#ifdef CONFIG_BCM47XX_SSB
> +static void nvram_init_ssb(void)
> +{
> +	struct ssb_mipscore *mcore = &bcm47xx_bus.ssb.mipscore;
> +	u32 base;
> +	u32 lim;
> +
> +	if (mcore->pflash.present) {
> +		base = mcore->pflash.window;
> +		lim = mcore->pflash.window_size;
> +	} else {
> +		pr_err("Couldn't find supported flash memory\n");
> +		return;
> +	}
> +
> +	nvram_find_and_copy(base, lim);
> +}
> +#endif
> +
> +#ifdef CONFIG_BCM47XX_BCMA
> +static void nvram_init_bcma(void)
> +{
> +	struct bcma_drv_cc *cc = &bcm47xx_bus.bcma.bus.drv_cc;
> +	u32 base;
> +	u32 lim;
> +
> +	if (cc->pflash.present) {
> +		base = cc->pflash.window;
> +		lim = cc->pflash.window_size;
> +#ifdef CONFIG_BCMA_SFLASH
> +	} else if (cc->sflash.present) {
> +		base = cc->sflash.window;
> +		lim = cc->sflash.size;
> +#endif
> +	} else {
> +		pr_err("Couldn't find supported flash memory\n");
> +		return;
> +	}
> +
> +	nvram_find_and_copy(base, lim);
> +}
> +#endif
> +
> +static void early_nvram_init(void)
> +{
> +	switch (bcm47xx_bus_type) {
> +#ifdef CONFIG_BCM47XX_SSB
> +	case BCM47XX_BUS_TYPE_SSB:
> +		nvram_init_ssb();
> +		break;
> +#endif
> +#ifdef CONFIG_BCM47XX_BCMA
> +	case BCM47XX_BUS_TYPE_BCMA:
> +		nvram_init_bcma();
> +		break;
> +#endif
> +	}
> +}
> +
>  int nvram_getenv(char *name, char *val, size_t val_len)
>  {
>  	char *var, *value, *end, *eq;
> 
