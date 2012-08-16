Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 18:43:35 +0200 (CEST)
Received: from shutemov.name ([176.9.204.213]:56834 "EHLO shutemov.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903435Ab2HPQnb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 18:43:31 +0200
Received: by shutemov.name (Postfix, from userid 1000)
        id C39902F0BF; Thu, 16 Aug 2012 19:43:56 +0300 (EEST)
Date:   Thu, 16 Aug 2012 19:43:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alex Shi <alex.shu@intel.com>,
        Jan Beulich <jbeulich@novell.com>,
        Robert Richter <robert.richter@amd.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 6/7] mm: make clear_huge_page cache clear only around
 the fault address
Message-ID: <20120816164356.GA30106@shutemov.name>
References: <1345130154-9602-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1345130154-9602-7-git-send-email-kirill.shutemov@linux.intel.com>
 <20120816161647.GM11188@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120816161647.GM11188@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill@shutemov.name
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

On Thu, Aug 16, 2012 at 06:16:47PM +0200, Andrea Arcangeli wrote:
> Hi Kirill,
> 
> On Thu, Aug 16, 2012 at 06:15:53PM +0300, Kirill A. Shutemov wrote:
> >  	for (i = 0; i < pages_per_huge_page;
> >  	     i++, p = mem_map_next(p, page, i)) {
> 
> It may be more optimal to avoid a multiplication/shiftleft before the
> add, and to do:
> 
>   	for (i = 0, vaddr = haddr; i < pages_per_huge_page;
>   	     i++, p = mem_map_next(p, page, i), vaddr += PAGE_SIZE) {
> 

Makes sense. I'll update it.

> >  		cond_resched();
> > -		clear_user_highpage(p, addr + i * PAGE_SIZE);
> > +		vaddr = haddr + i*PAGE_SIZE;
> 
> Not sure if gcc can optimize it away because of the external calls.
> 
> > +		if (!ARCH_HAS_USER_NOCACHE || i == target)
> > +			clear_user_highpage(page + i, vaddr);
> > +		else
> > +			clear_user_highpage_nocache(page + i, vaddr);
> >  	}
> 
> 
> My only worry overall is if there can be some workload where this may
> actually slow down userland if the CPU cache is very large and
> userland would access most of the faulted in memory after the first
> fault.
> 
> So I wouldn't mind to add one more check in addition of
> !ARCH_HAS_USER_NOCACHE above to check a runtime sysctl variable. It'll
> waste a cacheline yes but I doubt it's measurable compared to the time
> it takes to do a >=2M hugepage copy.

Hm.. I think with static_key we can avoid cache overhead here. I'll try.
 
> Furthermore it would allow people to benchmark its effect without
> having to rebuild the kernel themself.
> 
> All other patches looks fine to me.

Thanks, for review. Could you take a look at huge zero page patchset? ;)

-- 
 Kirill A. Shutemov
