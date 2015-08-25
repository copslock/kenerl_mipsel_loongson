Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Aug 2015 19:14:27 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:41702 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007467AbbHYROZPWT3w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Aug 2015 19:14:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=nOWh+T93YDAUph2CQWc2p0gwCdkg0iQG1Xf12JPNz10=;
        b=YGSM65b6qcB9E1DvHgVXGLHdour8z1t/g9fTfrPfSlEBjXORZ09kyxtAhW43bwL+zBW/R+CevVZlpr3rCVSosCugSn0MFfeejZMpuLmB3uol+0NwsF7Ou/iLPdHva/pnyS6vOTT9xclrhCHjWx889B7vpugVt4KxUOBz8tXunrQ=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:45235 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZUHnd-003Cpm-CM; Tue, 25 Aug 2015 17:14:17 +0000
Message-ID: <55DCA269.2000404@roeck-us.net>
Date:   Tue, 25 Aug 2015 10:14:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Jayachandran C <jchandra@broadcom.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>
Subject: Re: [PATCH -next] MIPS: Netlogic: Fix build error
References: <1440520150-2458-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1440520150-2458-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 08/25/2015 09:29 AM, Guenter Roeck wrote:
> dma_alloc_from_coherent is defined as (0) if HAVE_GENERIC_DMA_COHERENT
> is not configured. This results in the following build error, seen
> with nlm_xlp_defconfig.
>
> arch/mips/netlogic/common/nlm-dma.c: In function 'nlm_dma_alloc_coherent':
> arch/mips/netlogic/common/nlm-dma.c:50:8: error: unused variable 'ret'
>
> Add __maybe_unused to the variable declaration to fix the problem.
>
> Fixes: 79f8511c83f1 ("MIPS: Netlogic: SWIOTLB dma ops for 32-bit DMA")

Upon reflection, I think the problem may have been introduced by changes
in the definition of dma_alloc_from_coherent(), not by the above patch.
Not sure how to fix that properly.

Guenter

> Cc: Jayachandran C <jchandra@broadcom.com>
> Cc: Ganesan Ramalingam <ganesanr@broadcom.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   arch/mips/netlogic/common/nlm-dma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/netlogic/common/nlm-dma.c b/arch/mips/netlogic/common/nlm-dma.c
> index f3d4ae87abc7..4982d97d279f 100644
> --- a/arch/mips/netlogic/common/nlm-dma.c
> +++ b/arch/mips/netlogic/common/nlm-dma.c
> @@ -47,7 +47,7 @@ static char *nlm_swiotlb;
>   static void *nlm_dma_alloc_coherent(struct device *dev, size_t size,
>   	dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
>   {
> -	void *ret;
> +	void __maybe_unused *ret;
>
>   	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
>   		return ret;
>
