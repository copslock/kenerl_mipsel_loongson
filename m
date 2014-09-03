Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2014 21:33:14 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:35968 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008056AbaICTdMUf9Fd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Sep 2014 21:33:12 +0200
Received: from [IPv6:2001:470:7259:0:59c1:1a8e:a91d:7de2] (unknown [IPv6:2001:470:7259:0:59c1:1a8e:a91d:7de2])
        by hauke-m.de (Postfix) with ESMTPSA id E306B200F3;
        Wed,  3 Sep 2014 21:33:11 +0200 (CEST)
Message-ID: <54076CF7.2080704@hauke-m.de>
Date:   Wed, 03 Sep 2014 21:33:11 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: BCM47XX: Get rid of calls to KSEG1ADDR in nvram
References: <1409587730-18849-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1409587730-18849-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42379
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

On 09/01/2014 06:08 PM, Rafał Miłecki wrote:
> We should be using ioremap_nocache helper which handles remaps in a
> smarter way.

This is a good idea.

I just checked this with sparse and it still finds some places where you
cast a var annotated with __iomem to a var without this annotation.

hauke@hauke-desktop:~/linux/linux-next$ ionice -c 3 nice -n 20 make
ARCH=mips CROSS_COMPILE=mipsel-openwrt-linux-uclibc- C=2 arch/mips/bcm47xx/
.....
  CHECK   arch/mips/bcm47xx/nvram.c
arch/mips/bcm47xx/nvram.c:32:27: warning: cast removes address space of
expression
arch/mips/bcm47xx/nvram.c:60:35: warning: cast removes address space of
expression
arch/mips/bcm47xx/nvram.c:67:19: warning: cast removes address space of
expression
arch/mips/bcm47xx/nvram.c:73:19: warning: cast removes address space of
expression
  CC      arch/mips/bcm47xx/nvram.o


> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
>  arch/mips/bcm47xx/nvram.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
> index 2bed73a..2f0a646 100644
> --- a/arch/mips/bcm47xx/nvram.c
> +++ b/arch/mips/bcm47xx/nvram.c
> @@ -23,13 +23,13 @@
>  static char nvram_buf[NVRAM_SPACE];
>  static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
>  
> -static u32 find_nvram_size(u32 end)
> +static u32 find_nvram_size(void __iomem *end)
>  {
>  	struct nvram_header *header;
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
> -		header = (struct nvram_header *)KSEG1ADDR(end - nvram_sizes[i]);
> +		header = (struct nvram_header *)(end - nvram_sizes[i]);
__iomem annotation gets lost
>  		if (header->magic == NVRAM_HEADER)
>  			return nvram_sizes[i];
>  	}
> @@ -38,7 +38,7 @@ static u32 find_nvram_size(u32 end)
>  }
>  
>  /* Probe for NVRAM header */
> -static int nvram_find_and_copy(u32 base, u32 lim)
> +static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
>  {
>  	struct nvram_header *header;
>  	int i;
> @@ -46,27 +46,31 @@ static int nvram_find_and_copy(u32 base, u32 lim)
>  	u32 *src, *dst;
>  	u32 size;
>  
> +	if (nvram_buf[0]) {
> +		pr_warn("nvram already initialized\n");
> +		return -EEXIST;
> +	}
> +
>  	/* TODO: when nvram is on nand flash check for bad blocks first. */
>  	off = FLASH_MIN;
>  	while (off <= lim) {
>  		/* Windowed flash access */
> -		size = find_nvram_size(base + off);
> +		size = find_nvram_size(iobase + off);
>  		if (size) {
> -			header = (struct nvram_header *)KSEG1ADDR(base + off -
> -								  size);
> +			header = (struct nvram_header *)(iobase + off - size);
__iomem annotation gets lost
>  			goto found;
>  		}
>  		off <<= 1;
>  	}
>  
>  	/* Try embedded NVRAM at 4 KB and 1 KB as last resorts */
> -	header = (struct nvram_header *) KSEG1ADDR(base + 4096);
> +	header = (struct nvram_header *)(iobase + 4096);
__iomem annotation gets lost
>  	if (header->magic == NVRAM_HEADER) {
>  		size = NVRAM_SPACE;
>  		goto found;
>  	}
>  
> -	header = (struct nvram_header *) KSEG1ADDR(base + 1024);
> +	header = (struct nvram_header *)(iobase + 1024);
__iomem annotation gets lost
>  	if (header->magic == NVRAM_HEADER) {
>  		size = NVRAM_SPACE;
>  		goto found;
> @@ -94,6 +98,17 @@ found:
>  	return 0;
>  }
>  
> +static int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
> +{
> +	void __iomem *iobase;
> +
> +	iobase = ioremap_nocache(base, lim);
> +	if (!iobase)
> +		return -ENOMEM;

You should iounmap this sometime later, because the data is copied to
nvram_buf and iobase is not accsses after is was passed to
nvram_find_and_copy().
> +
> +	return nvram_find_and_copy(iobase, lim);
> +}
> +
>  #ifdef CONFIG_BCM47XX_SSB
>  static int nvram_init_ssb(void)
>  {
> @@ -109,7 +124,7 @@ static int nvram_init_ssb(void)
>  		return -ENXIO;
>  	}
>  
> -	return nvram_find_and_copy(base, lim);
> +	return bcm47xx_nvram_init_from_mem(base, lim);
>  }
>  #endif
>  
> @@ -139,7 +154,7 @@ static int nvram_init_bcma(void)
>  		return -ENXIO;
>  	}
>  
> -	return nvram_find_and_copy(base, lim);
> +	return bcm47xx_nvram_init_from_mem(base, lim);
>  }
>  #endif
>  
> 
