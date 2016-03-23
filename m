Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2016 22:44:05 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:41044 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008998AbcCWVoDWNOJA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Mar 2016 22:44:03 +0100
Received: from [192.168.178.21] (dyndsl-037-138-076-162.ewe-ip-backbone.de [37.138.76.162])
        by hauke-m.de (Postfix) with ESMTPSA id 9EC8410029B;
        Wed, 23 Mar 2016 22:44:00 +0100 (CET)
Subject: Re: [PATCH v2] drivers/firmware/broadcom/bcm47xx_nvram.c: fix
 incorrect __ioread32_copy
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Stephen Boyd <sboyd@codeaurora.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1458083178-8207-1-git-send-email-aaro.koskinen@iki.fi>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
X-Enigmail-Draft-Status: N1110
Message-ID: <56F30E1F.5020108@hauke-m.de>
Date:   Wed, 23 Mar 2016 22:43:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
MIME-Version: 1.0
In-Reply-To: <1458083178-8207-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52689
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

On 03/16/2016 12:06 AM, Aaro Koskinen wrote:
> Commit 1f330c327900 ("drivers/firmware/broadcom/bcm47xx_nvram.c: use
> __ioread32_copy() instead of open-coding") switched to use a generic copy
> function, but failed to notice that the header pointer is updated between
> the two copies, resulting in bogus data being copied in the latter one.
> Fix by keeping the old header pointer.
> 
> The patch fixes totally broken networking on WRT54GL router (both LAN
> and WLAN interfaces fail to probe).
> 
> Fixes: 1f330c327900 ("drivers/firmware/broadcom/bcm47xx_nvram.c: use __ioread32_copy() instead of open-coding")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
> 
> 	v2: Avoid using the device memory after the first copy when
> 	    checking the nvram length, suggested by Stephen Boyd.
> 
> 	v1: http://marc.info/?t=145807850800003&r=1&w=2
> 
>  drivers/firmware/broadcom/bcm47xx_nvram.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
> index 0c2f0a6..0b631e5 100644
> --- a/drivers/firmware/broadcom/bcm47xx_nvram.c
> +++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
> @@ -94,15 +94,14 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
>  
>  found:
>  	__ioread32_copy(nvram_buf, header, sizeof(*header) / 4);
> -	header = (struct nvram_header *)nvram_buf;
> -	nvram_len = header->len;
> +	nvram_len = ((struct nvram_header *)(nvram_buf))->len;

I do not understand why this change is needed? Doesn't the old code do
exactly the same as the new one?

The old code updated the header pointer and then accesses a member, the
new one directly accesses this member without updating this pointer.

I assume, I am missing something. ;-)

>  	if (nvram_len > size) {
>  		pr_err("The nvram size according to the header seems to be bigger than the partition on flash\n");
>  		nvram_len = size;
>  	}
>  	if (nvram_len >= NVRAM_SPACE) {
>  		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
> -		       header->len, NVRAM_SPACE - 1);
> +		       nvram_len, NVRAM_SPACE - 1);
>  		nvram_len = NVRAM_SPACE - 1;
>  	}
>  	/* proceed reading data after header */
> 
