Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2015 12:22:47 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:50791 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007457AbbFFKWpK4T6P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 6 Jun 2015 12:22:45 +0200
Received: from [IPv6:2003:62:460e:f000:bd37:7c96:2aca:18a9] (p20030062460EF000BD377C962ACA18A9.dip0.t-ipconnect.de [IPv6:2003:62:460e:f000:bd37:7c96:2aca:18a9])
        by hauke-m.de (Postfix) with ESMTPSA id 8B5BC2016F;
        Sat,  6 Jun 2015 12:22:44 +0200 (CEST)
Message-ID: <5572C9F3.1010509@hauke-m.de>
Date:   Sat, 06 Jun 2015 12:22:43 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:     Arend van Spriel <arend@broadcom.com>,
        Hante Meuleman <meuleman@broadcom.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Add helper variable for storing NVRAM
 length
References: <1433585387-30548-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1433585387-30548-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47893
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

On 06/06/2015 12:09 PM, Rafał Miłecki wrote:
> This simplifies code just a bit (also maybe makes it a bit more
> intuitive?) and will allow us to stop storing header which holds some
> data we never use.

Can you please make it clear that nvram_buf still holds the header and
that you want to remove it in a later step.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
>  arch/mips/bcm47xx/nvram.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
> index 2ed762e..9ccdce8 100644
> --- a/arch/mips/bcm47xx/nvram.c
> +++ b/arch/mips/bcm47xx/nvram.c
> @@ -35,6 +35,7 @@ struct nvram_header {
>  };
>  
>  static char nvram_buf[NVRAM_SPACE];
> +static size_t nvram_len;
>  static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
>  
>  static u32 find_nvram_size(void __iomem *end)
> @@ -60,7 +61,7 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
>  	u32 *src, *dst;
>  	u32 size;
>  
> -	if (nvram_buf[0]) {
> +	if (nvram_len) {
>  		pr_warn("nvram already initialized\n");
>  		return -EEXIST;
>  	}
> @@ -99,17 +100,18 @@ found:
>  	for (i = 0; i < sizeof(struct nvram_header); i += 4)
>  		*dst++ = __raw_readl(src++);
>  	header = (struct nvram_header *)nvram_buf;
> -	if (header->len > size) {
> +	nvram_len = header->len;
> +	if (nvram_len > size) {
>  		pr_err("The nvram size according to the header seems to be bigger than the partition on flash\n");
> -		header->len = size;
> +		nvram_len = size;
>  	}
> -	if (header->len >= NVRAM_SPACE) {
> +	if (nvram_len >= NVRAM_SPACE) {
>  		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
>  		       header->len, NVRAM_SPACE - 1);
> -		header->len = NVRAM_SPACE - 1;
> +		nvram_len = NVRAM_SPACE - 1;
>  	}
>  	/* proceed reading data after header */
> -	for (; i < header->len; i += 4)
> +	for (; i < nvram_len; i += 4)
>  		*dst++ = readl(src++);
>  	nvram_buf[NVRAM_SPACE - 1] = '\0';
>  
> @@ -144,7 +146,6 @@ static int nvram_init(void)
>  #ifdef CONFIG_MTD
>  	struct mtd_info *mtd;
>  	struct nvram_header header;
> -	struct nvram_header *pheader;
>  	size_t bytes_read;
>  	int err;
>  
> @@ -155,20 +156,16 @@ static int nvram_init(void)
>  	err = mtd_read(mtd, 0, sizeof(header), &bytes_read, (uint8_t *)&header);
>  	if (!err && header.magic == NVRAM_MAGIC &&
>  	    header.len > sizeof(header)) {
> -		if (header.len >= NVRAM_SPACE) {
> +		nvram_len = header.len;
> +		if (nvram_len >= NVRAM_SPACE) {
>  			pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
>  				header.len, NVRAM_SPACE);
> -			header.len = NVRAM_SPACE - 1;
> +			nvram_len = NVRAM_SPACE - 1;
>  		}
>  
> -		err = mtd_read(mtd, 0, header.len, &bytes_read,
> +		err = mtd_read(mtd, 0, nvram_len, &nvram_len,
>  			       (u8 *)nvram_buf);
> -		if (err)
> -			return err;
> -
> -		pheader = (struct nvram_header *)nvram_buf;
> -		pheader->len = header.len;
> -		return 0;
> +		return err;
>  	}
>  #endif
>  
> @@ -183,7 +180,7 @@ int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
>  	if (!name)
>  		return -EINVAL;
>  
> -	if (!nvram_buf[0]) {
> +	if (!nvram_len) {
>  		err = nvram_init();
>  		if (err)
>  			return err;
> @@ -231,16 +228,14 @@ char *bcm47xx_nvram_get_contents(size_t *nvram_size)
>  {
>  	int err;
>  	char *nvram;
> -	struct nvram_header *header;
>  
> -	if (!nvram_buf[0]) {
> +	if (!nvram_len) {
>  		err = nvram_init();
>  		if (err)
>  			return NULL;
>  	}
>  
> -	header = (struct nvram_header *)nvram_buf;
> -	*nvram_size = header->len - sizeof(struct nvram_header);
> +	*nvram_size = nvram_len - sizeof(struct nvram_header);
>  	nvram = vmalloc(*nvram_size);
>  	if (!nvram)
>  		return NULL;
> 
