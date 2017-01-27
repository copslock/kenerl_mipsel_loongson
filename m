Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2017 17:19:17 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:51424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992121AbdA0QTKIscSE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jan 2017 17:19:10 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42CA0AAA3;
        Fri, 27 Jan 2017 16:19:06 +0000 (UTC)
Date:   Fri, 27 Jan 2017 17:19:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alexander Graf <agraf@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: Re: [PATCH 1/3] mm: alloc_contig_range: allow to specify GFP mask
Message-ID: <20170127161904.GA6357@dhcp22.suse.cz>
References: <20170119170707.31741-1-l.stach@pengutronix.de>
 <81849c0d-b7aa-faf2-484c-66b0ea0a7e95@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81849c0d-b7aa-faf2-484c-66b0ea0a7e95@suse.cz>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@kernel.org
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

On Fri 20-01-17 13:35:40, Vlastimil Babka wrote:
> On 01/19/2017 06:07 PM, Lucas Stach wrote:
[...]
> > @@ -7255,7 +7256,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
> >  		.zone = page_zone(pfn_to_page(start)),
> >  		.mode = MIGRATE_SYNC,
> >  		.ignore_skip_hint = true,
> > -		.gfp_mask = GFP_KERNEL,
> > +		.gfp_mask = gfp_mask,
> 
> I think you should apply memalloc_noio_flags() here (and Michal should
> then convert it to the new name in his scoped gfp_nofs series). Note
> that then it's technically a functional change, but it's needed.
> Otherwise looks good.

yes, with that added, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> 
> >  	};
> >  	INIT_LIST_HEAD(&cc.migratepages);
> >  
> > 

-- 
Michal Hocko
SUSE Labs
