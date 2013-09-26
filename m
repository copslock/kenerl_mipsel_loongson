Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 12:32:33 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:3156 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817315Ab3IZKc3N45FT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Sep 2013 12:32:29 +0200
Received: from [10.9.208.55] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Thu, 26 Sep 2013 03:28:10 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Thu, 26 Sep 2013 03:32:08 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Thu, 26 Sep 2013 03:32:09 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 62801246A3; Thu, 26
 Sep 2013 03:32:08 -0700 (PDT)
Date:   Thu, 26 Sep 2013 16:06:52 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: mm: Move some checks out of 'for' loop in DMA
 operations
Message-ID: <20130926103651.GL24359@jayachandranc.netlogicmicro.com>
References: <1380114065-9761-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1380114065-9761-1-git-send-email-jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7E5AD3B00UO11247868-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

On Wed, Sep 25, 2013 at 06:31:05PM +0530, Jayachandran C wrote:

The patch was missing the required Signed-off-by, added below.

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

Signed-off-by: Jayachandran C <jchandra@broadcom.com>

> ---
>  arch/mips/mm/dma-default.c |   12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index e45e4b0..2e94185 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -307,12 +307,10 @@ static void mips_dma_sync_sg_for_cpu(struct device *dev,
>  {
>  	int i;
>  
> -	/* Make sure that gcc doesn't leave the empty loop body.  */
> -	for (i = 0; i < nelems; i++, sg++) {
> -		if (cpu_needs_post_dma_flush(dev))
> +	if (cpu_needs_post_dma_flush(dev))
> +		for (i = 0; i < nelems; i++, sg++)
>  			__dma_sync(sg_page(sg), sg->offset, sg->length,
>  				   direction);
> -	}
>  }
>  
>  static void mips_dma_sync_sg_for_device(struct device *dev,
> @@ -320,12 +318,10 @@ static void mips_dma_sync_sg_for_device(struct device *dev,
>  {
>  	int i;
>  
> -	/* Make sure that gcc doesn't leave the empty loop body.  */
> -	for (i = 0; i < nelems; i++, sg++) {
> -		if (!plat_device_is_coherent(dev))
> +	if (!plat_device_is_coherent(dev))
> +		for (i = 0; i < nelems; i++, sg++)
>  			__dma_sync(sg_page(sg), sg->offset, sg->length,
>  				   direction);
> -	}
>  }
>  
>  int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)

JC.
