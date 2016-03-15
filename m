Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2016 23:42:16 +0100 (CET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:51448 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014041AbcCOWmOwhVlJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Mar 2016 23:42:14 +0100
Received: from raspberrypi.musicnaut.iki.fi (85-76-14-12-nat.elisa-mobile.fi [85.76.14.12])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 075599006D;
        Wed, 16 Mar 2016 00:42:13 +0200 (EET)
Date:   Wed, 16 Mar 2016 00:42:13 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/firmware/broadcom/bcm47xx_nvram.c: fix incorrect
 __ioread32_copy
Message-ID: <20160315224213.GC10851@raspberrypi.musicnaut.iki.fi>
References: <1458078386-30254-1-git-send-email-aaro.koskinen@iki.fi>
 <20160315221324.GI25972@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160315221324.GI25972@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Tue, Mar 15, 2016 at 03:13:24PM -0700, Stephen Boyd wrote:
> Ah sorry. That was a stupid mistake. But it might be bad to
> access header->len now because that's still some device memory
> and not the copy of the memory into ram anymore. How about
> this patch instead? Commit text and authorship can be the same as
> the original patch.
> 
> ---8<----
> diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
> index 0c2f0a61b0ea..0b631e5b5b84 100644
> --- a/drivers/firmware/broadcom/bcm47xx_nvram.c
> +++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
> @@ -94,15 +94,14 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
>  
>  found:
>  	__ioread32_copy(nvram_buf, header, sizeof(*header) / 4);
> -	header = (struct nvram_header *)nvram_buf;
> -	nvram_len = header->len;
> +	nvram_len = ((struct nvram_header *)(nvram_buf))->len;
>  	if (nvram_len > size) {
>  		pr_err("The nvram size according to the header seems to be bigger than the partition on flash\n");
>  		nvram_len = size;
>  	}
>  	if (nvram_len >= NVRAM_SPACE) {
>  		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
> -		       header->len, NVRAM_SPACE - 1);
> +		       nvram_len, NVRAM_SPACE - 1);

I'm OK with this as well; I'll test this on my router (just to be sure :))
and send a v2.

Thanks,

A.
