Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 18:17:29 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:4089 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903438Ab2HPQRU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 18:17:20 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7GGGo4X014551
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 16 Aug 2012 12:16:50 -0400
Received: from random.random (ovpn-116-31.ams2.redhat.com [10.36.116.31])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7GGGmIP000683;
        Thu, 16 Aug 2012 12:16:48 -0400
Date:   Thu, 16 Aug 2012 18:16:47 +0200
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20120816161647.GM11188@redhat.com>
References: <1345130154-9602-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1345130154-9602-7-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1345130154-9602-7-git-send-email-kirill.shutemov@linux.intel.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-archive-position: 34220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aarcange@redhat.com
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

Hi Kirill,

On Thu, Aug 16, 2012 at 06:15:53PM +0300, Kirill A. Shutemov wrote:
>  	for (i = 0; i < pages_per_huge_page;
>  	     i++, p = mem_map_next(p, page, i)) {

It may be more optimal to avoid a multiplication/shiftleft before the
add, and to do:

  	for (i = 0, vaddr = haddr; i < pages_per_huge_page;
  	     i++, p = mem_map_next(p, page, i), vaddr += PAGE_SIZE) {

>  		cond_resched();
> -		clear_user_highpage(p, addr + i * PAGE_SIZE);
> +		vaddr = haddr + i*PAGE_SIZE;

Not sure if gcc can optimize it away because of the external calls.

> +		if (!ARCH_HAS_USER_NOCACHE || i == target)
> +			clear_user_highpage(page + i, vaddr);
> +		else
> +			clear_user_highpage_nocache(page + i, vaddr);
>  	}


My only worry overall is if there can be some workload where this may
actually slow down userland if the CPU cache is very large and
userland would access most of the faulted in memory after the first
fault.

So I wouldn't mind to add one more check in addition of
!ARCH_HAS_USER_NOCACHE above to check a runtime sysctl variable. It'll
waste a cacheline yes but I doubt it's measurable compared to the time
it takes to do a >=2M hugepage copy.

Furthermore it would allow people to benchmark its effect without
having to rebuild the kernel themself.

All other patches looks fine to me.

Thanks!
Andrea
