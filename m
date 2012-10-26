Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2012 18:45:33 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:37266 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823119Ab2JZQpcuz0h- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Oct 2012 18:45:32 +0200
Received: by mail-pb0-f49.google.com with SMTP id xa7so2666956pbc.36
        for <multiple recipients>; Fri, 26 Oct 2012 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8i8hVYcUX+rwHIFnyWLD94epR5+UVt0OL1fvi52rhg8=;
        b=AogWKKRj86ZZZzAgeCNGXWVv1LV38OjWhEqZnIjX9Rc8TXKd6ZO9hUiym6YhKs7ZXl
         iB2VMZ8e+sFiFQh7yB8PYpGNwYDge5uq2x9ClxqaI6pFFq/MEgb0CI94727E6lRA6PeM
         juPh5UsJAEOOyvGhzJOsVCY9fEHIrgSGcxb3xDfyZdV1gIBW2FsTXN5piy0qMbCfQqMC
         N7uVBcMx+paijq8fCmko3oiQnesA+M3J7kZfHe7KHpdV+CgAZwR8RCl+prnWMHOglm6d
         YpavKLCFl/LsHTkcnz7Kfdj733i9j+iY35zEpLYb0kbVDk9OyHursOxDwJLdgNM7eVfI
         mZcg==
Received: by 10.68.212.6 with SMTP id ng6mr70392800pbc.57.1351269925966;
        Fri, 26 Oct 2012 09:45:25 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id wo9sm1408358pbc.53.2012.10.26.09.45.18
        (version=SSLv3 cipher=OTHER);
        Fri, 26 Oct 2012 09:45:22 -0700 (PDT)
Message-ID: <508ABE1D.5010106@gmail.com>
Date:   Fri, 26 Oct 2012 09:45:17 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
MIME-Version: 1.0
To:     shuah.khan@hp.com
CC:     ralf@linux-mips.org, kyungmin.park@samsung.com, arnd@arndb.de,
        andrzej.p@samsung.com, m.szyprowski@samsung.com,
        linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        shuahkhan@gmail.com
Subject: Re: [PATCH RFT RESEND linux-next] mips: dma-mapping: support debug_dma_mapping_error
References: <1351208193.6851.17.camel@lorien2> <1351267298.4013.12.camel@lorien2>
In-Reply-To: <1351267298.4013.12.camel@lorien2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 10/26/2012 09:01 AM, Shuah Khan wrote:
> Add support for debug_dma_mapping_error() call to avoid warning from
> debug_dma_unmap() interface when it checks for mapping error checked
> status. Without this patch, device driver failed to check map error
> warning is generated.
>
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> ---
>   arch/mips/include/asm/dma-mapping.h |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
> index be39a12..006b43e 100644
> --- a/arch/mips/include/asm/dma-mapping.h
> +++ b/arch/mips/include/asm/dma-mapping.h
> @@ -40,6 +40,8 @@ static inline int dma_supported(struct device *dev, u64 mask)
>   static inline int dma_mapping_error(struct device *dev, u64 mask)
>   {
>   	struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	debug_dma_mapping_error(dev, mask);
>   	return ops->mapping_error(dev, mask);
>   }
>
>

Although this is a start, I don't think it is sufficient.

As far as I can tell, there are many missing calls to debug_dma_*() in 
the various MIPS commone and sub-architecture DMA code.

Really you (or someone) needs to look at *all* the functions in 
arch/mips/asm/dma-mapping.h, and arch/mips/mm/dma-default.c and find 
places missing a debug_dma_*().

Thanks,
David Daney
