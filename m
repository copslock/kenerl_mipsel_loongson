Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 19:14:21 +0100 (CET)
Received: from mail-pf1-x441.google.com ([IPv6:2607:f8b0:4864:20::441]:36597
        "EHLO mail-pf1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991062AbeKHSMRp0qk8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 19:12:17 +0100
Received: by mail-pf1-x441.google.com with SMTP id d13-v6so2488980pfo.3
        for <linux-mips@linux-mips.org>; Thu, 08 Nov 2018 10:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRzIw96c42MBsppp+UtkS27cZw2ziHLGOZAWHCwUwkU=;
        b=VLb+fI0e5CupBhLX7SEpqp6aMYCEmrno2/+PWx1Fj5vgMnrhqgQj4nIpkri0wUpbG8
         F4GPWoT5NbHXAaJTdGVfn6zckMlMvaTWgcceAQNHhxzEznYU/sGs1Oziz5WMuk+Y2lPY
         nZdjL8GBrbofS49q8gzGHo1DibcI7hQLaT5lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRzIw96c42MBsppp+UtkS27cZw2ziHLGOZAWHCwUwkU=;
        b=RBC62q+1QEE4I78ERiGq9VBiOFjs+/spzZpgovHA5t0Cy3JWXSEyTqdPI1q0vwXVfS
         u/cVVUCUKlHYifh7aM+6D4hUCNS9eWjhvOxRvz1CeSF/4dd3/iW4H7bZPGsG9R0czDbh
         L+3mx8eiGywE111xyog+yzAMxyfNW1N6Vp5g4aZpALdR37xwnObeareNyEBzaqcMZYnK
         svmYe9UtwC8PyfR5qX03JO/D+gYmUbE227/BOtopGox9lrTqBNZ3vDF0t4QqR1u/zov4
         Q0u6dxgcKXaKtRO3KzXwY+jdtPBsfJ3NoluRTa5ZGrUoZ8cqDQFqOPwpcO25xVfxvnJK
         8wYQ==
X-Gm-Message-State: AGRZ1gI71LEFAUkOINRyMAKKxKb/6utCj1wIVuwk+iy/rJnGUAtpuwLq
        RR/k00RLzhkBBj787+P1eIGoxQ==
X-Google-Smtp-Source: AJdET5d03oyVAX8rvXz4lqxLxyGhZaxEcaDz6tsUNfJPuVe8tAAaxUTzs4svhnT0ivYmEFumZgA8Jg==
X-Received: by 2002:a63:2b01:: with SMTP id r1mr4588917pgr.432.1541700736301;
        Thu, 08 Nov 2018 10:12:16 -0800 (PST)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 64-v6sm10028533pfa.120.2018.11.08.10.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 10:12:15 -0800 (PST)
From:   Joel Fernandes <joel@joelfernandes.org>
X-Google-Original-From: Joel Fernandes <joelaf@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        William Kucharski <william.kucharski@oracle.com>,
        akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        anton.ivanov@kot-begemot.co.uk, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, dancol@google.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        hughd@google.com, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ley Foon Tan <lftan@altera.com>, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, lokeshgidra@google.com,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, minchan@kernel.org,
        nios2-dev@lists.rocketboards.org, pantin@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>,
        sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH -next-akpm 2/3] mm: speed up mremap by 20x on large regions (v5)
Date:   Thu,  8 Nov 2018 10:12:00 -0800
Message-Id: <20181108181201.88826-3-joelaf@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181108181201.88826-1-joelaf@google.com>
References: <20181108181201.88826-1-joelaf@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67174
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Android needs to mremap large regions of memory during memory management
related operations. The mremap system call can be really slow if THP is
not enabled. The bottleneck is move_page_tables, which is copying each
pte at a time, and can be really slow across a large map. Turning on THP
may not be a viable option, and is not for us. This patch speeds up the
performance for non-THP system by copying at the PMD level when possible.

The speed up is an order of magnitude on x86 (~20x). On a 1GB mremap,
the mremap completion times drops from 3.4-3.6 milliseconds to 144-160
microseconds.

Before:
Total mremap time for 1GB data: 3521942 nanoseconds.
Total mremap time for 1GB data: 3449229 nanoseconds.
Total mremap time for 1GB data: 3488230 nanoseconds.

After:
Total mremap time for 1GB data: 150279 nanoseconds.
Total mremap time for 1GB data: 144665 nanoseconds.
Total mremap time for 1GB data: 158708 nanoseconds.

Incase THP is enabled, the optimization is mostly skipped except in
certain situations.

Acked-by: Kirill A. Shutemov <kirill@shutemov.name>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---

Note that since the bug fix in [1], we now have to flush the TLB every
PMD move. The above numbers were obtained on x86 with a flush done every
move. For arm64, I previously encountered performance issues doing a
flush everytime we move, however Will Deacon says [2] the performance
should be better now with recent release. Until we can evaluate arm64, I
am dropping the HAVE_MOVE_PMD config enable patch for ARM64 for now. It
can be added back once we finish the performance evaluation. Also of
note is that the speed up on arm64 with this patch but without the TLB
flush every PMD move is around 500x.

[1] https://bugs.chromium.org/p/project-zero/issues/detail?id=1695
[2] https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg140837.html

 arch/Kconfig |  5 +++++
 mm/mremap.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index e1e540ffa979..b70c952ac838 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -535,6 +535,11 @@ config HAVE_IRQ_TIME_ACCOUNTING
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
index 7c9ab747f19d..2591e512373a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -191,6 +191,50 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		drop_rmap_locks(vma);
 }
 
+static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
+		  unsigned long new_addr, unsigned long old_end,
+		  pmd_t *old_pmd, pmd_t *new_pmd)
+{
+	spinlock_t *old_ptl, *new_ptl;
+	struct mm_struct *mm = vma->vm_mm;
+	pmd_t pmd;
+
+	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
+	    || old_end - old_addr < PMD_SIZE)
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
+	new_ptl = pmd_lockptr(mm, new_pmd);
+	if (new_ptl != old_ptl)
+		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+
+	/* Clear the pmd */
+	pmd = *old_pmd;
+	pmd_clear(old_pmd);
+
+	VM_BUG_ON(!pmd_none(*new_pmd));
+
+	/* Set the new pmd */
+	set_pmd_at(mm, new_addr, new_pmd, pmd);
+	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
+	if (new_ptl != old_ptl)
+		spin_unlock(new_ptl);
+	spin_unlock(old_ptl);
+
+	return true;
+}
+
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
@@ -237,7 +281,25 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
 				continue;
+		} else if (extent == PMD_SIZE) {
+#ifdef CONFIG_HAVE_MOVE_PMD
+			/*
+			 * If the extent is PMD-sized, try to speed the move by
+			 * moving at the PMD level if possible.
+			 */
+			bool moved;
+
+			if (need_rmap_locks)
+				take_rmap_locks(vma);
+			moved = move_normal_pmd(vma, old_addr, new_addr,
+					old_end, old_pmd, new_pmd);
+			if (need_rmap_locks)
+				drop_rmap_locks(vma);
+			if (moved)
+				continue;
+#endif
 		}
+
 		if (pte_alloc(new_vma->vm_mm, new_pmd))
 			break;
 		next = (new_addr + PMD_SIZE) & PMD_MASK;
-- 
2.19.1.930.g4563a0d9d0-goog
