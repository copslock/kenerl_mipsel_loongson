Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2017 13:35:52 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:55118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993876AbdATMfot9QSL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jan 2017 13:35:44 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E03FFAC3D;
        Fri, 20 Jan 2017 12:35:42 +0000 (UTC)
Subject: Re: [PATCH 1/3] mm: alloc_contig_range: allow to specify GFP mask
To:     Lucas Stach <l.stach@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20170119170707.31741-1-l.stach@pengutronix.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alexander Graf <agraf@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <81849c0d-b7aa-faf2-484c-66b0ea0a7e95@suse.cz>
Date:   Fri, 20 Jan 2017 13:35:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170119170707.31741-1-l.stach@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <vbabka@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbabka@suse.cz
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

On 01/19/2017 06:07 PM, Lucas Stach wrote:
> Currently alloc_contig_range assumes that the compaction should
> be done with the default GFP_KERNEL flags. This is probably
> right for all current uses of this interface, but may change as
> CMA is used in more use-cases (including being the default DMA
> memory allocator on some platforms).
> 
> Change the function prototype, to allow for passing through the
> GFP mask set by upper layers. No functional change in this patch,
> just making the assumptions a bit more obvious.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

[...]

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eced9fee582b..6d392d8dee36 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7230,6 +7230,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
>   *			in range must have the same migratetype and it must
>   *			be either of the two.
> + * @gfp_mask:	GFP mask to use during compaction
>   *
>   * The PFN range does not have to be pageblock or MAX_ORDER_NR_PAGES
>   * aligned, however it's the caller's responsibility to guarantee that
> @@ -7243,7 +7244,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   * need to be freed with free_contig_range().
>   */
>  int alloc_contig_range(unsigned long start, unsigned long end,
> -		       unsigned migratetype)
> +		       unsigned migratetype, gfp_t gfp_mask)
>  {
>  	unsigned long outer_start, outer_end;
>  	unsigned int order;
> @@ -7255,7 +7256,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  		.zone = page_zone(pfn_to_page(start)),
>  		.mode = MIGRATE_SYNC,
>  		.ignore_skip_hint = true,
> -		.gfp_mask = GFP_KERNEL,
> +		.gfp_mask = gfp_mask,

I think you should apply memalloc_noio_flags() here (and Michal should
then convert it to the new name in his scoped gfp_nofs series). Note
that then it's technically a functional change, but it's needed.
Otherwise looks good.

>  	};
>  	INIT_LIST_HEAD(&cc.migratepages);
>  
> 
