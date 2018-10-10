Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2018 09:58:57 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:47920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994575AbeJJH6xrZPxg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Oct 2018 09:58:53 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC818AC68;
        Wed, 10 Oct 2018 07:58:47 +0000 (UTC)
Date:   Wed, 10 Oct 2018 09:58:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH] memblock: stop using implicit alignement to
 SMP_CACHE_BYTES
Message-ID: <20181010075844.GA5873@dhcp22.suse.cz>
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66740
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

On Fri 05-10-18 00:07:04, Mike Rapoport wrote:
> When a memblock allocation APIs are called with align = 0, the alignment is
> implicitly set to SMP_CACHE_BYTES.

I would add something like
"
Implicit alignment is done deep in the memblock allocator and it can
come as a surprise. Not that such an alignment would be wrong even when
used incorrectly but it is better to be explicit for the sake of clarity
and the prinicple of the least surprise.
"

> Replace all such uses of memblock APIs with the 'align' parameter explicitly
> set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
> memblock internal allocation functions.
> 
> For the case when memblock APIs are used via helper functions, e.g. like
> iommu_arena_new_node() in Alpha, the helper functions were detected with
> Coccinelle's help and then manually examined and updated where appropriate.
> 
> The direct memblock APIs users were updated using the semantic patch below:
> 
> @@
> expression size, min_addr, max_addr, nid;
> @@
> (
> |
> - memblock_alloc_try_nid_raw(size, 0, min_addr, max_addr, nid)
> + memblock_alloc_try_nid_raw(size, SMP_CACHE_BYTES, min_addr, max_addr,
> nid)
> |
> - memblock_alloc_try_nid_nopanic(size, 0, min_addr, max_addr, nid)
> + memblock_alloc_try_nid_nopanic(size, SMP_CACHE_BYTES, min_addr, max_addr,
> nid)
> |
> - memblock_alloc_try_nid(size, 0, min_addr, max_addr, nid)
> + memblock_alloc_try_nid(size, SMP_CACHE_BYTES, min_addr, max_addr, nid)
> |
> - memblock_alloc(size, 0)
> + memblock_alloc(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_raw(size, 0)
> + memblock_alloc_raw(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_from(size, 0, min_addr)
> + memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr)
> |
> - memblock_alloc_nopanic(size, 0)
> + memblock_alloc_nopanic(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_low(size, 0)
> + memblock_alloc_low(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_low_nopanic(size, 0)
> + memblock_alloc_low_nopanic(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_from_nopanic(size, 0, min_addr)
> + memblock_alloc_from_nopanic(size, SMP_CACHE_BYTES, min_addr)
> |
> - memblock_alloc_node(size, 0, nid)
> + memblock_alloc_node(size, SMP_CACHE_BYTES, nid)
> )
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

I do agree that this is an improvement. I would also add WARN_ON_ONCE on
0 alignment to catch some left overs. If we ever grown a user which
would explicitly require the zero alignment (I would be surprised) then
we can remove the warning.

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
