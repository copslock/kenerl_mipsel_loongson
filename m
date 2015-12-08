Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 23:19:48 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39839 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013471AbbLHWTqhzewZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 23:19:46 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D6249A92;
        Tue,  8 Dec 2015 22:19:39 +0000 (UTC)
Date:   Tue, 8 Dec 2015 14:19:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     <linux-mips@linux-mips.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <mgorman@techsingularity.net>
Subject: Re: [PATCH] MIPS: Fix DMA contiguous allocation
Message-Id: <20151208141939.d0edbb72b3c15844c5ac25ea@linux-foundation.org>
In-Reply-To: <1449569930-2118-1-git-send-email-qais.yousef@imgtec.com>
References: <1449569930-2118-1-git-send-email-qais.yousef@imgtec.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Tue, 8 Dec 2015 10:18:50 +0000 Qais Yousef <qais.yousef@imgtec.com> wrote:

> Recent changes to how GFP_ATOMIC is defined seems to have broken the condition
> to use mips_alloc_from_contiguous() in mips_dma_alloc_coherent().
> 
> I couldn't bottom out the exact change but I think it's this one
> 
> d0164adc89f6 (mm, page_alloc: distinguish between being unable to sleep,
> unwilling to sleep and avoiding waking kswapd)
> 
> >From what I see GFP_ATOMIC has multiple bits set and the check for !(gfp
> & GFP_ATOMIC) isn't enough. To verify if the flag is atomic we need to make
> sure that (gfp & GFP_ATOMIC) == GFP_ATOMIC to verify that all bits rquired to
> satisfy GFP_ATOMIC condition are set.
> 
> ...
>
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -145,7 +145,7 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
>  
>  	gfp = massage_gfp_flags(dev, gfp);
>  
> -	if (IS_ENABLED(CONFIG_DMA_CMA) && !(gfp & GFP_ATOMIC))
> +	if (IS_ENABLED(CONFIG_DMA_CMA) && ((gfp & GFP_ATOMIC) != GFP_ATOMIC))
>  		page = dma_alloc_from_contiguous(dev,
>  					count, get_order(size));
>  	if (!page)

hm.  It seems that the code is asking "can I do a potentially-sleeping
memory allocation"?

The way to do that under the new regime is

	if (IS_ENABLED(CONFIG_DMA_CMA) && gfpflags_allow_blocking(gfp))

Mel, can you please confirm?
