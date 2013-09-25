Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 15:19:29 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:54183 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816233Ab3IYNTKN5-h4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Sep 2013 15:19:10 +0200
Message-ID: <5242E2CF.8030709@imgtec.com>
Date:   Wed, 25 Sep 2013 14:19:11 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>
CC:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: mm: Move some checks out of 'for' loop in DMA operations
References: <1380114065-9761-1-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1380114065-9761-1-git-send-email-jchandra@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_09_25_14_19_04
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 09/25/13 14:01, Jayachandran C wrote:
> The check cpu_needs_post_dma_flush() in mips_dma_sync_sg_for_cpu() and
> the check !plat_device_is_coherent() in mips_dma_sync_sg_for_device()
> can be moved outside the for loop.
>
> As a side effect, this also avoids a GCC bug that caused kernel compile
> to fail with the error:
>
> arch/mips/mm/dma-default.c: In function 'mips_dma_sync_sg_for_cpu':
> arch/mips/mm/dma-default.c:316:1: internal compiler error: in add_insn_before, at emit-rtl.c:3852
>
> This gcc failure is seen in Code Sourcery toolchains [e.g. gcc version
> 4.7.2 (Sourcery CodeBench Lite 2012.09-99)] after commit "MIPS: Optimize
> current_cpu_type() for better code."
> ---
>   arch/mips/mm/dma-default.c |   12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index e45e4b0..2e94185 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -307,12 +307,10 @@ static void mips_dma_sync_sg_for_cpu(struct device *dev,
>   {
>   	int i;
>
> -	/* Make sure that gcc doesn't leave the empty loop body.  */
> -	for (i = 0; i < nelems; i++, sg++) {
> -		if (cpu_needs_post_dma_flush(dev))
> +	if (cpu_needs_post_dma_flush(dev))
> +		for (i = 0; i < nelems; i++, sg++)
>   			__dma_sync(sg_page(sg), sg->offset, sg->length,
>   				   direction);
> -	}
>   }
>
>   static void mips_dma_sync_sg_for_device(struct device *dev,
> @@ -320,12 +318,10 @@ static void mips_dma_sync_sg_for_device(struct device *dev,
>   {
>   	int i;
>
> -	/* Make sure that gcc doesn't leave the empty loop body.  */
> -	for (i = 0; i < nelems; i++, sg++) {
> -		if (!plat_device_is_coherent(dev))
> +	if (!plat_device_is_coherent(dev))
> +		for (i = 0; i < nelems; i++, sg++)
>   			__dma_sync(sg_page(sg), sg->offset, sg->length,
>   				   direction);
> -	}
>   }
>
>   int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>

Hi,

The patch looks good to me and it fixes the gcc problem indeed (the bug 
is also present in gcc-4.7.3  from the 2013.05 release)

Reviewed-by/Tested-by: Markos Chandras <markos.chandras@imgtec.com>
