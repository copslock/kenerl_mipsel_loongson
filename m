Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2014 11:07:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46294 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6826484AbaCUKHbgC0sl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Mar 2014 11:07:31 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2LA7SZS014376;
        Fri, 21 Mar 2014 11:07:28 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2LA7RiB014375;
        Fri, 21 Mar 2014 11:07:27 +0100
Date:   Fri, 21 Mar 2014 11:07:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@codesourcery.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: copy_to_user_page: Avoid ptrace(2) I-cache
 incoherency
Message-ID: <20140321100727.GJ4365@linux-mips.org>
References: <alpine.DEB.1.10.1311071758410.21686@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1311071758410.21686@tp.orcam.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Nov 07, 2013 at 06:35:54PM +0000, Maciej W. Rozycki wrote:

> We currently support no MIPS processor that has its I-cache coherent with 
> the D-cache, no such processor may even exist.  We apparently have two 
> configurations that have fully coherent D-caches and therefore set 
> cpu_has_ic_fills_f_dc, and these are the Alchemy and NetLogic processor 
> families.  I have checked relevant CPU documentation I was able to track 
> down and in both cases the respective documents[1][2] clearly state that 
> the I-cache provides no hardware coherency and whenever instructions in 
> memory are modified then the I-cache has to be synchronized by software 
> even though the D-caches are fully coherent.

No, cpu_has_ic_fills_f_dc doesn't mean the D-cache is coherent but rather
that the I-cache is refilled from the D-cache if there was a hit.  This
means there is no need to write back the D-cache to S-cache or even memory
which is saving some time.

> Therefore we cannot ever avoid the call to flush_cache_page in 
> copy_to_user_page and here is a change that reflects this observation.  
> The implementation of flush_cache_page may then choose freely whether it 
> needs to perform a full cache synchronization with D-cache writeback and 
> invalidation requests or whether a lone I-cache invalidation will suffice.  
> The c-r4k.c implementation already respects the setting of 
> cpu_has_ic_fills_f_dc and avoids touching the D-cache unless necessary.
> 
> The lack of I-cache synchronization is typically seen in debugging 
> sessions e.g. with GDB where software breakpoints are used.  When such a 
> breakpoint is hit and subsequently replaced using a ptrace(2) call with 
> the original instruction, the BREAK instruction previously executed 
> sometimes remains in the I-cache and causes the breakpoint just removed to 
> hit again regardless, resulting in a spurious SIGTRAP signal delivery that 
> debuggers typically complain about (e.g. "Program received signal SIGTRAP, 
> Trace/breakpoint trap" in the case of GDB).  Of course the I-cache line 
> containing the BREAK instruction may have since been randomly replaced, in 
> which case no problem occurs.
> 
> [1] "AMD Alchemy Au1200 Processor Data Book", AMD Alchemy, January, 2005, 
>     Publication ID: 32798A
> 
> [2] "XLP Processor Family Programming Reference Manual", NetLogic 
>     Microsystems, Revision Level 1.10, February, 2011, Document Number 
>     10724V110PM-CR (regrettably not publicly available)
> 
> Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
> ---
> Ralf,
> 
>  Please apply.  I've seen these SIGTRAPs in some NetLogic GDB testing and 
> the removal of this cpu_has_ic_fills_f_dc condition from copy_to_user_page 
> is really necessary; also the Au1200 document is very explicit about the 
> requirement of I-cache invalidation in software (see Section 2.3.7.3 
> "Instruction Cache Coherency").

You found a bug and yes, the fix you sent improves things a bit.  But
there is also the cache on a cache coherent system where a page might
be marked for a delayed cache flush with SetPageDcacheDirty(), then
flushed by flush_cache_page() before eventually the delayed cacheflush
flushes it once more for a good meassure.

What do you think about below patch to also deal with the duplicate flushing?

  Ralf

 arch/mips/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 6b59617..80072ef 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -227,13 +227,13 @@ void copy_to_user_page(struct vm_area_struct *vma,
 		void *vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
 		memcpy(vto, src, len);
 		kunmap_coherent();
+		if (vma->vm_flags & VM_EXEC)
+			flush_cache_page(vma, vaddr, page_to_pfn(page));
 	} else {
 		memcpy(dst, src, len);
 		if (cpu_has_dc_aliases)
 			SetPageDcacheDirty(page);
 	}
-	if ((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc)
-		flush_cache_page(vma, vaddr, page_to_pfn(page));
 }
 
 void copy_from_user_page(struct vm_area_struct *vma,
