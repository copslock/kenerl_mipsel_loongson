Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 00:33:15 +0200 (CEST)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:36764
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990947AbeJOWdMsgZPc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2018 00:33:12 +0200
Received: by mail-pg1-x541.google.com with SMTP id f18-v6so9842421pgv.3
        for <linux-mips@linux-mips.org>; Mon, 15 Oct 2018 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=69Ih0AxspAb3LOagwndf0nAJ0Gw/4Xn5WVb76GM8Zl4=;
        b=Opn+78pFeiAm38S8tKZCcNEMSo2ZkRyw+dKYWyPLp4MS25Ip1WRenp/4a1CfYh9wfa
         4XPqhqN7ADAJGstLtOdjqCR4tWOgV4GcXi5K9jKNvI33afu9+9M5Q3xS+aYlDUZtEc9z
         8FWqxbD6KpEBe9aT75TdS03IJiQEVDKv111dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=69Ih0AxspAb3LOagwndf0nAJ0Gw/4Xn5WVb76GM8Zl4=;
        b=BlxHeMS1S4fFRGFqxxfTZviR9/EB+focvvS3BTOWTRDdNlzfzyNA0uAySeEYQU37lK
         znr2M5XlgbHw1+UaqLW2yN70bL/klZDlAALRBKN4PXHI2ntx2n3mk6FOj0SHzEjWKemT
         R3XQIq+wRMC/ouYisnZl5KelbmnNp9kPKMjGYTnMCmtPghbXhFMS2YuqXiAMMkzP2+y9
         ZAPdDlkZRzU5BmGA4a4mYOgJrCg0sJQDedJQPMCNBTy82K08/2cqrue3e1nCGiEnLZuh
         dCA35EepzBqnoojh5mD8UiiFZL1QJYfvZqHak/SSUtKxldm2Ov34LTlU8w/1r659nhcy
         JCZw==
X-Gm-Message-State: ABuFfoim2Qh8OhBymn4tT3pCv2xRiIb3Jw1FPFCCY6vr3HOJPtpDjMGu
        EYpyu5QyFQWABsMQGgRYPNTCtQ==
X-Google-Smtp-Source: ACcGV61mavqUGksovXZjObMwGIe/HqpZ9cOw5tT0zAj6BM5KqqYwfLYZFTGqOW0BIRGwp/CBZ9RJeA==
X-Received: by 2002:a63:b4b:: with SMTP id a11-v6mr16810826pgl.97.1539642785540;
        Mon, 15 Oct 2018 15:33:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id j14-v6sm15591781pgh.52.2018.10.15.15.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 15:33:04 -0700 (PDT)
Date:   Mon, 15 Oct 2018 15:33:03 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, mhocko@kernel.org,
        linux-mm@kvack.org, lokeshgidra@google.com,
        linux-riscv@lists.infradead.org, elfring@users.sourceforge.net,
        Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu,
        dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
        kasan-dev@googlegroups.com, anton.ivanov@kot-begemot.co.uk,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-snps-arc@lists.infradead.org, kernel-team@android.com,
        Sam Creasey <sammy@sammy.net>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-s390@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-m68k@lists.linux-m68k.org, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        nios2-dev@lists.rocketboards.org, kirill@shutemov.name,
        Stafford Horne <shorne@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>,
        Richard Weinberger <richard@nod.at>,
        linux-parisc@vger.kernel.org, pantin@google.com,
        Max Filippov <jcmvbkbc@gmail.com>, minchan@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181015223303.GA164293@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181015094209.GA31999@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015094209.GA31999@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joel@joelfernandes.org
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

On Mon, Oct 15, 2018 at 02:42:09AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> > Android needs to mremap large regions of memory during memory management
> > related operations.
> 
> Just curious: why?

In Android we have a requirement of moving a large (up to a GB now, but may
grow bigger in future) memory range from one location to another. This move
operation has to happen when the application threads are paused for this
operation. Therefore, an inefficient move like it is now (for example 250ms
on arm64) will cause response time issues for applications, which is not
acceptable. Huge pages cannot be used in such memory ranges to avoid this
inefficiency as (when the application threads are running) our fault handlers
are designed to process 4KB pages at a time, to keep response times low. So
using huge pages in this context can, again, cause response time issues.

Also, the mremap syscall waiting for quarter of a second for a large mremap
is quite weird and we ought to improve it where possible.

> > +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > +	    || old_end - old_addr < PMD_SIZE)
> 
> The || goes on the first line.

Ok, fixed.

> > +		} else if (extent == PMD_SIZE && IS_ENABLED(CONFIG_HAVE_MOVE_PMD)) {
> 
> Overly long line.

Ok, fixed. Preview of updated patch is below.

thanks,

 - Joel

------8<---
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v3)

Android needs to mremap large regions of memory during memory management
related operations. The mremap system call can be really slow if THP is
not enabled. The bottleneck is move_page_tables, which is copying each
pte at a time, and can be really slow across a large map. Turning on THP
may not be a viable option, and is not for us. This patch speeds up the
performance for non-THP system by copying at the PMD level when possible.

The speed up is three orders of magnitude. On a 1GB mremap, the mremap
completion times drops from 160-250 millesconds to 380-400 microseconds.

Before:
Total mremap time for 1GB data: 242321014 nanoseconds.
Total mremap time for 1GB data: 196842467 nanoseconds.
Total mremap time for 1GB data: 167051162 nanoseconds.

After:
Total mremap time for 1GB data: 385781 nanoseconds.
Total mremap time for 1GB data: 388959 nanoseconds.
Total mremap time for 1GB data: 402813 nanoseconds.

Incase THP is enabled, the optimization is mostly skipped except in
certain situations. I also flush the tlb every time we do this
optimization since I couldn't find a way to determine if the low-level
PTEs are dirty. It is seen that the cost of doing so is not much
compared the improvement, on both x86-64 and arm64.

Cc: minchan@kernel.org
Cc: pantin@google.com
Cc: hughd@google.com
Cc: lokeshgidra@google.com
Cc: dancol@google.com
Cc: mhocko@kernel.org
Cc: kirill@shutemov.name
Cc: akpm@linux-foundation.org
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/Kconfig |  5 ++++
 mm/mremap.c  | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6801123932a5..9724fe39884f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -518,6 +518,11 @@ config HAVE_IRQ_TIME_ACCOUNTING
 	  Archs need to ensure they use a high enough resolution clock to
 	  support irq time accounting and then call enable_sched_clock_irqtime().
 
+config HAVE_MOVE_PMD
+	bool
+	help
+	  Archs that select this are able to move page tables at the PMD level.
+
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	bool
 
diff --git a/mm/mremap.c b/mm/mremap.c
index 9e68a02a52b1..a8dd98a59975 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		drop_rmap_locks(vma);
 }
 
+static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
+		  unsigned long new_addr, unsigned long old_end,
+		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
+{
+	spinlock_t *old_ptl, *new_ptl;
+	struct mm_struct *mm = vma->vm_mm;
+
+	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK) ||
+	    old_end - old_addr < PMD_SIZE)
+		return false;
+
+	/*
+	 * The destination pmd shouldn't be established, free_pgtables()
+	 * should have release it.
+	 */
+	if (WARN_ON(!pmd_none(*new_pmd)))
+		return false;
+
+	/*
+	 * We don't have to worry about the ordering of src and dst
+	 * ptlocks because exclusive mmap_sem prevents deadlock.
+	 */
+	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
+	if (old_ptl) {
+		pmd_t pmd;
+
+		new_ptl = pmd_lockptr(mm, new_pmd);
+		if (new_ptl != old_ptl)
+			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+
+		/* Clear the pmd */
+		pmd = *old_pmd;
+		pmd_clear(old_pmd);
+
+		VM_BUG_ON(!pmd_none(*new_pmd));
+
+		/* Set the new pmd */
+		set_pmd_at(mm, new_addr, new_pmd, pmd);
+		if (new_ptl != old_ptl)
+			spin_unlock(new_ptl);
+		spin_unlock(old_ptl);
+
+		*need_flush = true;
+		return true;
+	}
+	return false;
+}
+
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
@@ -239,7 +287,25 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
 				continue;
+		} else if (extent == PMD_SIZE &&
+			   IS_ENABLED(CONFIG_HAVE_MOVE_PMD)) {
+			/*
+			 * If the extent is PMD-sized, try to speed the move by
+			 * moving at the PMD level if possible.
+			 */
+			bool moved;
+
+			if (need_rmap_locks)
+				take_rmap_locks(vma);
+			moved = move_normal_pmd(vma, old_addr, new_addr,
+						old_end, old_pmd, new_pmd,
+						&need_flush);
+			if (need_rmap_locks)
+				drop_rmap_locks(vma);
+			if (moved)
+				continue;
 		}
+
 		if (pte_alloc(new_vma->vm_mm, new_pmd))
 			break;
 		next = (new_addr + PMD_SIZE) & PMD_MASK;
-- 
2.19.1.331.ge82ca0e54c-goog
