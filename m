Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2014 22:13:40 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:36063 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008048AbaICUNi5P1lP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Sep 2014 22:13:38 +0200
Received: from [IPv6:2001:470:7259:0:59c1:1a8e:a91d:7de2] (unknown [IPv6:2001:470:7259:0:59c1:1a8e:a91d:7de2])
        by hauke-m.de (Postfix) with ESMTPSA id 95FA8200F3;
        Wed,  3 Sep 2014 22:13:38 +0200 (CEST)
Message-ID: <54077671.7000204@hauke-m.de>
Date:   Wed, 03 Sep 2014 22:13:37 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH][RFC] MIPS: BCM47XX: Use mtd as an alternative way/API
 to get NVRAM content
References: <1409764481-20997-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1409764481-20997-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42382
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

On 09/03/2014 07:14 PM, Rafał Miłecki wrote:
> NVRAM can be read using magic memory offset, but after all it's just a
> flash partition. On platforms where NVRAM isn't needed early we can get
> it using mtd subsystem.

Where would this work?

Do you plan the following initialization order in bcma on arm and mips?

1. bcma SoC version
2. bcma bus scan
3. flash driver registration
4. nvram read
5. sprom generation from nvram and attaching to bcma
6. registration of the other bcam cores (wifi, ...)

The nvram is memory mapped on every SoC, just on devices with nand flash
booting we would need something to check for bad blocks.

> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
>  arch/mips/bcm47xx/nvram.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
> index 8ea2116..9ab74db 100644
> --- a/arch/mips/bcm47xx/nvram.c
> +++ b/arch/mips/bcm47xx/nvram.c
> @@ -16,6 +16,7 @@
>  #include <linux/ssb/ssb.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> +#include <linux/mtd/mtd.h>
>  #include <asm/addrspace.h>
>  #include <bcm47xx_nvram.h>
>  #include <asm/mach-bcm47xx/bcm47xx.h>
> @@ -148,6 +149,13 @@ static int nvram_init_bcma(void)
>  
>  static int nvram_init(void)
>  {
> +#ifdef CONFIG_MTD
> +	struct mtd_info *mtd;
> +	struct nvram_header header;
> +	size_t bytes_read;
> +	int i;
> +#endif
> +
>  	switch (bcm47xx_bus_type) {
>  #ifdef CONFIG_BCM47XX_SSB
>  	case BCM47XX_BUS_TYPE_SSB:
> @@ -158,6 +166,38 @@ static int nvram_init(void)
>  		return nvram_init_bcma();
>  #endif
>  	}
> +
> +#ifdef CONFIG_MTD
> +	mtd = get_mtd_device_nm("nvram");
> +	if (IS_ERR(mtd))
> +		return -ENODEV;
> +
> +	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
> +		loff_t from = mtd->size - nvram_sizes[i];
> +
> +		if (from < 0)
> +			continue;
> +
> +		if (mtd_read(mtd, from, sizeof(header), &bytes_read,
> +			     (uint8_t *)&header) < 0)
> +			continue;
> +		if (header.magic == NVRAM_HEADER) {
> +			u8 *dst = (uint8_t *)nvram_buf;
> +			size_t len = header.len;
> +
> +			if (header.len > NVRAM_SPACE) {
> +				pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
> +				       header.len, NVRAM_SPACE);
> +				len = NVRAM_SPACE;
> +			}
> +
> +			if (mtd_read(mtd, from, len, &bytes_read, dst) < 0)
> +				continue;
> +			memset(dst + bytes_read, 0x0, NVRAM_SPACE - bytes_read);
> +		}
> +	}
> +#endif
> +
>  	return -ENXIO;
>  }
>  
> 
