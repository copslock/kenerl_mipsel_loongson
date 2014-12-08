Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Dec 2014 10:19:16 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:42560 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007654AbaLHJTBojEcY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Dec 2014 10:19:01 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 292A92E2D4;
        Mon,  8 Dec 2014 10:18:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id SDux87i7ay1j; Mon,  8 Dec 2014 10:18:51 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id B00432E2B3;
        Mon,  8 Dec 2014 10:18:49 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id A1C09108C;
        Mon,  8 Dec 2014 10:18:49 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id 9305B54A;
        Mon,  8 Dec 2014 10:18:49 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by seth.se.axis.com (Postfix) with ESMTP id 8E8DA3E3AC;
        Mon,  8 Dec 2014 10:18:49 +0100 (CET)
Received: from [10.88.41.1] (10.88.41.1) by xmail2.se.axis.com (10.0.5.74)
 with Microsoft SMTP Server (TLS) id 8.3.342.0; Mon, 8 Dec 2014 10:18:49 +0100
Message-ID: <1418030317.6459.8.camel@lnxlarper.se.axis.com>
Subject: Re: [PATCH] Revert "MIPS: Remove race window in page fault handling"
From:   Lars Persson <lars.persson@axis.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "paul.burton@imgtec.com" <paul.burton@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manuel.lauss@gmail.com" <manuel.lauss@gmail.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "blogic@openwrt.org" <blogic@openwrt.org>,
        "markos.chandras@imgtec.com" <markos.chandras@imgtec.com>
Date:   Mon, 8 Dec 2014 10:18:37 +0100
In-Reply-To: <54822685.8070504@imgtec.com>
References: <20141203032542.15388.17340.stgit@linux-yegoshin>
         <1417599104.10996.16.camel@lnxlarper.se.axis.com>
         <20141203134226.GC16063@linux-mips.org>
         <1417615394.10198.3.camel@lnxlarper.se.axis.com>
         <5481158D.1000409@imgtec.com>
         <1417771976.8400.8.camel@lnxlarper.se.axis.com>
         <54822685.8070504@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4-3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

Hi

I have reconstructed the stack trace on the 3.14 kernel where we caught
the problem.

The call path was __do_fault() -> set_pte_at(). In later kernels it
corresponds to the do_set_pte().

You are right that there are calls to flush_icache_page(). I did not dig
into the code enough to check if page_mapped() will return true at that
point. If it does, then your proposed patch for flush_icache_page is a
better fix.

- Lars

On fre, 2014-12-05 at 22:41 +0100, Leonid Yegoshin wrote:
> Lars,
> 
> On 12/05/2014 01:32 AM, Lars Persson wrote:
> > Hi
> >
> > Our setup includes both a non-DMA block device and a compressing
> > file-system (UBIFS). A flush_dcache_page() is issued by UBIFS so your
> > patch fixes another problem that we do not hit.
> >
> > The stack trace is not available now. Do we need it for any further
> > analysis ? I think the mechanism of the race window is understood and it
> > depends on the __flush_dcache_page() deciding that the flush should be
> > postponed.
> 
> Unfortunately, the research of original case is still needed.
> I looked into all cases of update_mmu_cache() besides HUGE page support 
> and NUMA, and I see:
> 
> 1.  insert_pfn()
>      It is used to put a special page (read - VDSO) into memory map. No 
> cache flush is needed here because page is done and flushed during 
> system boot.
> 
> 2.  do_wp_page(), first occurrence
>      It has flush_cache_page() before it sets PTE in 
> ptep_set_access_flags(). This flush is unconditional and affects all caches.
> 
> 3.  do_wp_page(), second case
>      It is done after preparing a clear new page or after COW. COW has 
> an appropriate cache flush of destination in copy_user_highpage(). The 
> immediate use of cleared new page as instruction (you had SIGILL, 
> right?)... hm-m, something wrong in application in this case.
> 
> 4.  do_swap_page()
>      Well, it may be a case of flush_icache_page() is not used (see 
> below) and page is taken from non-DMA swap. But I also recommend to look 
> into
> 
>          http://patchwork.linux-mips.org/patch/7615/
> 
> there is a bug in swap entry number presentation and it may affect your 
> system.
> 
> 5.  do_anonymous_page()
>      The similar to case (3) - cleared new page, using of it as 
> instruction page may point to some app problem.
> 
> 6.  do_set_pte()
>      It also has flush_icache_page() which may have impact if not 
> implemented, see below.
> 
> 7.  handle_pte_fault()
>      Page is not touched and cache flush is NO-OP.
> 
> 8.  remove_migration_pte()
>      Well, it is a place for suspicion. But it should not run in 
> parallel with any running thread - dirtying page while other thread is 
> running is a way to disaster.
> 
> So, you see - if I understand it correctly, there is no place for 
> failure... besides application misbehaviour or potential kernel bug in 
> migration. Of course, I may miss something and that is a reason why 
> stack trace is desirable.
> 
> 
> > I think the mechanism of the race window is understood and it
> > depends on the __flush_dcache_page() deciding that the flush should be
> > postponed.
> 
> As I remember, you said you use HIGHMEM patch, right? It changes a 
> little __flush_dcache_page() and flush of any mapped page is not 
> postponed anymore. So, it has an immediate effect for application pages.
> 
> - Leonid.
> 
> >
> >
> > - Lars
> >
> > On Fri, 2014-12-05 at 03:16 +0100, Leonid Yegoshin wrote:
> >> (repeat mesg, first one went to wrong place)
> >>
> >> Lars,
> >>
> >> Do you have a stack trace or so then you found the second VPE between
> >> set_pte_at and update_mmu_cache?
> >> It would be interesting how it happens - generally, to get a consistent
> >> SIGILL in applications due to misbehaviour of memory subsystem, the bug
> >> in FS is not enough.
> >>
> >> Hold on - do you use non-DMA file system?
> >> If so, I advice you to try this simple patch:
> >>
> >>       Author: Leonid Yegoshin <yegoshin@mips.com>
> >>       Date:   Tue Apr 2 14:20:37 2013 -0700
> >>
> >>       MIPS: (opt) Fix of reading I-pages from non-DMA FS devices for ID
> >> cache separation
> >>
> >>       This optional fix provides a D-cache flush for instruction code
> >> pages on
> >>       page faults. In case of non-DMA block device a driver doesn't know
> >> that it
> >>       reads I-page and doesn't flush D-cache generally on systems without
> >>       cache aliasing. And that takes toll during page fault of
> >> instruction pages.
> >>
> >>       It is not a perfect fix, it should be considered as a temporary fix.
> >>       The permanent fix would track page origin in page cache and flushes
> >> D-cache
> >>       during reception of page from driver only but not at each page fault.
> >>       It is not done yet.
> >>
> >>       Change-Id: I43f5943d6ce0509729179615f6b81e77803a34ac
> >>       Author: Leonid Yegoshin <yegoshin@mips.com>
> >>       Signed-off-by: Leonid Yegoshin <yegoshin@mips.com>(imported from
> >> commit 6ebd22eb7a3d9873582ebe990a77094f971652ee)(imported from commit
> >> 0caf3b4a1eebb64572e81e4df6fdb3abf12c70
> >>
> >> arch/mips/include/asm/cacheflush.h:
> >>
> >>      @@ -61,6 +61,9 @@ static inline void flush_anon_page(struct
> >> vm_area_struct *vma,
> >>       static inline void flush_icache_page(struct vm_area_struct *vma,
> >>              struct page *page)
> >>       {
> >>      +       if (cpu_has_dc_aliases ||
> >>      +           ((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc))
> >>      +               __flush_dcache_page(page);
> >>       }
> >>
> >>       extern void (*flush_icache_range)(unsigned long start, unsigned
> >> long end);
> >>
> >>
> >> It fixed crash problems with non-DMA FS in a couple of our customers.
> >> Without it the non-DMA root FS crashes are catastrophic in aliasing
> >> systems but it is still a problem for I-cache too but much rare.
> >>
> >> Unfortunately, it is also a performance hit, however is less than run a
> >> page cache flush at each PTE setup. On 12/03/2014 06:03 AM, Lars Persson
> >> wrote:
> >>> It is the flush_dcache_page() that was called from the file-system
> >>> reading the page contents into memory.
> >>>
> >>> - Lars
> >>>
> >>>
> >
> >
> 
