Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2014 22:08:35 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:36056 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008048AbaICUIeJBN44 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Sep 2014 22:08:34 +0200
Received: from [IPv6:2001:470:7259:0:59c1:1a8e:a91d:7de2] (unknown [IPv6:2001:470:7259:0:59c1:1a8e:a91d:7de2])
        by hauke-m.de (Postfix) with ESMTPSA id C1B09200F3;
        Wed,  3 Sep 2014 22:08:33 +0200 (CEST)
Message-ID: <54077541.3090006@hauke-m.de>
Date:   Wed, 03 Sep 2014 22:08:33 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V2] MIPS: BCM47XX: Make ssb init NVRAM instead of bcm47xx
 polling it
References: <1409743926-23957-1-git-send-email-zajec5@gmail.com> <1409744065-24334-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1409744065-24334-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42381
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

On 09/03/2014 01:34 PM, Rafał Miłecki wrote:
> This makes NVRAM code less bcm47xx/ssb specific allowing it to become a
> standalone driver in the future. A similar patch for bcma will follow
> when it's ready.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
> This patch depends on
> [PATCH] MIPS: BCM47XX: Get rid of calls to KSEG1ADDR in nvram
> 
> V2: Typo in commit message s/bcma/ssb/
> ---
>  arch/mips/bcm47xx/nvram.c     | 30 +++++++++---------------------
>  drivers/ssb/driver_mipscore.c | 18 +++++++++++++++++-
>  2 files changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
> index 2f0a646..8ea2116 100644
> --- a/arch/mips/bcm47xx/nvram.c
> +++ b/arch/mips/bcm47xx/nvram.c
> @@ -98,7 +98,14 @@ found:
>  	return 0;
>  }
>  
> -static int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
> +/*
> + * On bcm47xx we need access to the NVRAM very early, so we can't use mtd
> + * subsystem to access flash. We can't even use platform device / driver to
> + * store memory offset.
> + * To handle this we provide following symbol. It's supposed to be called as
> + * soon as we get info about flash device, before any NVRAM entry is needed.
> + */
> +int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
>  {
>  	void __iomem *iobase;
>  
> @@ -109,25 +116,6 @@ static int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
>  	return nvram_find_and_copy(iobase, lim);
>  }
>  
> -#ifdef CONFIG_BCM47XX_SSB
> -static int nvram_init_ssb(void)
> -{
> -	struct ssb_mipscore *mcore = &bcm47xx_bus.ssb.mipscore;
> -	u32 base;
> -	u32 lim;
> -
> -	if (mcore->pflash.present) {
> -		base = mcore->pflash.window;
> -		lim = mcore->pflash.window_size;
> -	} else {
> -		pr_err("Couldn't find supported flash memory\n");
> -		return -ENXIO;
> -	}
> -
> -	return bcm47xx_nvram_init_from_mem(base, lim);
> -}
> -#endif
> -
>  #ifdef CONFIG_BCM47XX_BCMA
>  static int nvram_init_bcma(void)
>  {
> @@ -163,7 +151,7 @@ static int nvram_init(void)
>  	switch (bcm47xx_bus_type) {
>  #ifdef CONFIG_BCM47XX_SSB
>  	case BCM47XX_BUS_TYPE_SSB:
> -		return nvram_init_ssb();
> +		break;
>  #endif
>  #ifdef CONFIG_BCM47XX_BCMA
>  	case BCM47XX_BUS_TYPE_BCMA:
> diff --git a/drivers/ssb/driver_mipscore.c b/drivers/ssb/driver_mipscore.c
> index 0907706..c51802f 100644
> --- a/drivers/ssb/driver_mipscore.c
> +++ b/drivers/ssb/driver_mipscore.c
> @@ -207,9 +207,17 @@ static void ssb_mips_serial_init(struct ssb_mipscore *mcore)
>  		mcore->nr_serial_ports = 0;
>  }
>  
> +/* bcm47xx_nvram isn't a separated driver yet and doesn't have its own header.
> + * Once we make it a standalone driver, remove following extern!
> + */
> +#ifdef CONFIG_BCM47XX
> +extern int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
> +#endif
> +

I do not like forward declarations, could you add this to the nvram
header file and make this file include it. When we move the nvram header
file to /include/linux/... we can provide an empty implementation and
get rid of all these ugly ifdef.

>  static void ssb_mips_flash_detect(struct ssb_mipscore *mcore)
>  {
>  	struct ssb_bus *bus = mcore->dev->bus;
> +	struct ssb_sflash *sflash = &mcore->sflash;
>  	struct ssb_pflash *pflash = &mcore->pflash;
>  
>  	/* When there is no chipcommon on the bus there is 4MB flash */
> @@ -242,7 +250,15 @@ static void ssb_mips_flash_detect(struct ssb_mipscore *mcore)
>  	}
>  
>  ssb_pflash:
> -	if (pflash->present) {
> +	if (sflash->present) {
> +#ifdef CONFIG_BCM47XX
> +		bcm47xx_nvram_init_from_mem(sflash->window, sflash->size);
> +#endif
> +	} else if (pflash->present) {
> +#ifdef CONFIG_BCM47XX
> +		bcm47xx_nvram_init_from_mem(pflash->window, pflash->window_size);
> +#endif
> +
>  		ssb_pflash_data.width = pflash->buswidth;
>  		ssb_pflash_resource.start = pflash->window;
>  		ssb_pflash_resource.end = pflash->window + pflash->window_size;
> 
