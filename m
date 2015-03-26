Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 19:19:00 +0100 (CET)
Received: from mail-la0-f46.google.com ([209.85.215.46]:33340 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009040AbbCZSS5v3rKm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 19:18:57 +0100
Received: by labto5 with SMTP id to5so52620820lab.0
        for <linux-mips@linux-mips.org>; Thu, 26 Mar 2015 11:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=meAunzWtUX4dW9R7B6xdRpjXwjgZTiWV0jMskF9WXAM=;
        b=WuuHnGHyoUY09YXLPjz9182ZQnxidg71b2fypZU0JJWVjU/bBrBF5ks1WaAD0UjxXm
         Ylr3mM3j9inQrnzHYJHoDt3XNz9tRTXF08y4aHeoN6FdEUA9knAKFuBApMD6Qv58alDK
         HKTYzhd5kB+vyVlPcY+S+rcsJ/qCrRR/egYMzLfhX8sK6S9PYi3PBh6n3a22jPRG4eXz
         ZKpj4nZ0TpgaroH85pdYAo0XTLdzmMyrI+O+Vxg2Nm2e26ByXFCGg+0R6ZhkFTrNzweK
         qT4Bc/opidWvT8i0wa/w3IXKFad8yvNG91oaTj7pS/xkZCfGNpr7zcadt7Fxl8bxWGDW
         y37Q==
X-Gm-Message-State: ALoCoQkIARU4LcdtO0RqS/h0IF5DHfPkjzUklWKbyugkgWcADSNJAc+S8zyM9DSoClK7ZFkKW+66
X-Received: by 10.112.63.165 with SMTP id h5mr14277576lbs.16.1427393933296;
        Thu, 26 Mar 2015 11:18:53 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp85-141-198-103.pppoe.mtu-net.ru. [85.141.198.103])
        by mx.google.com with ESMTPSA id y2sm1406784lay.30.2015.03.26.11.18.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2015 11:18:52 -0700 (PDT)
Message-ID: <55144D8A.8050004@cogentembedded.com>
Date:   Thu, 26 Mar 2015 21:18:50 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: dma-default: Fix 32-bit fall back to GFP_DMA
References: <1427388993-17697-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1427388993-17697-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 03/26/2015 07:56 PM, James Hogan wrote:

> If there is a DMA zone (usually 24bit = 16MB I believe), but no DMA32
> zone, as is the case for some 32-bit kernels, then massage_gfp_flags()
> will cause DMA memory allocated for devices with a 32..63-bit
> coherent_dma_mask to fall back to using __GFP_DMA, even though there may
> only be 32-bits of physical address available anyway.

> Correct that case to compare against a mask the size of phys_addr_t
> instead of always using a 64-bit mask.

> Fixes: a2e715a86c6d ("MIPS: DMA: Fix computation of DMA flags from device's coherent_dma_mask.")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 2.6.36+
> ---
> This works around problems encountered on Malta with ethernet and IDE
> drivers being unable to allocate any coherent memory when the entire
> 16MB DMA zone is taken up with static kernel data (a separate problem),
> even though their coherent_dma_masks are 32-bit. This can happen when
> PROVE_RCU and PROVE_LOCKING are set, especially since commit
> 1413c0389333 ("lockdep: Increase static allocations") was applied in
> v3.16.
> ---
>   arch/mips/mm/dma-default.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index af5f046e627e..501557026768 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -100,7 +100,7 @@ static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
>   	else
>   #endif
>   #if defined(CONFIG_ZONE_DMA) && !defined(CONFIG_ZONE_DMA32)
> -	     if (dev->coherent_dma_mask < DMA_BIT_MASK(64))
> +	     if (dev->coherent_dma_mask < DMA_BIT_MASK(sizeof(phys_addr_t)*8))

    Cold you add spaces around *, just to be consisted with the other binary 
operators? This seems a preferred kernel style anyway.

WBR, Sergei
