Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 12:36:48 +0100 (CET)
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:36487 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008626AbbLILgquByle (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 12:36:46 +0100
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 18BE61C1CD7
        for <linux-mips@linux-mips.org>; Wed,  9 Dec 2015 11:36:41 +0000 (GMT)
Received: (qmail 16676 invoked from network); 9 Dec 2015 11:36:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.246.231])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 9 Dec 2015 11:36:40 -0000
Date:   Wed, 9 Dec 2015 11:36:35 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qais Yousef <qais.yousef@imgtec.com>, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix DMA contiguous allocation
Message-ID: <20151209113635.GA15910@techsingularity.net>
References: <1449569930-2118-1-git-send-email-qais.yousef@imgtec.com>
 <20151208141939.d0edbb72b3c15844c5ac25ea@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20151208141939.d0edbb72b3c15844c5ac25ea@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mgorman@techsingularity.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mgorman@techsingularity.net
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

On Tue, Dec 08, 2015 at 02:19:39PM -0800, Andrew Morton wrote:
> On Tue, 8 Dec 2015 10:18:50 +0000 Qais Yousef <qais.yousef@imgtec.com> wrote:
> 
> > Recent changes to how GFP_ATOMIC is defined seems to have broken the condition
> > to use mips_alloc_from_contiguous() in mips_dma_alloc_coherent().
> > 
> > I couldn't bottom out the exact change but I think it's this one
> > 
> > d0164adc89f6 (mm, page_alloc: distinguish between being unable to sleep,
> > unwilling to sleep and avoiding waking kswapd)
> > 
> > >From what I see GFP_ATOMIC has multiple bits set and the check for !(gfp
> > & GFP_ATOMIC) isn't enough. To verify if the flag is atomic we need to make
> > sure that (gfp & GFP_ATOMIC) == GFP_ATOMIC to verify that all bits rquired to
> > satisfy GFP_ATOMIC condition are set.
> > 
> > ...
> >
> > --- a/arch/mips/mm/dma-default.c
> > +++ b/arch/mips/mm/dma-default.c
> > @@ -145,7 +145,7 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
> >  
> >  	gfp = massage_gfp_flags(dev, gfp);
> >  
> > -	if (IS_ENABLED(CONFIG_DMA_CMA) && !(gfp & GFP_ATOMIC))
> > +	if (IS_ENABLED(CONFIG_DMA_CMA) && ((gfp & GFP_ATOMIC) != GFP_ATOMIC))
> >  		page = dma_alloc_from_contiguous(dev,
> >  					count, get_order(size));
> >  	if (!page)
> 
> hm.  It seems that the code is asking "can I do a potentially-sleeping
> memory allocation"?
> 
> The way to do that under the new regime is
> 
> 	if (IS_ENABLED(CONFIG_DMA_CMA) && gfpflags_allow_blocking(gfp))
> 
> Mel, can you please confirm?

Yes, this is the correct way it should be checked. The full flags cover
watermark and kswapd treatment which potentially could be altered by
the caller.

-- 
Mel Gorman
SUSE Labs
