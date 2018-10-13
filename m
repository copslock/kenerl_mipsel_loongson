Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 03:32:50 +0200 (CEST)
Received: from mail-pg1-x542.google.com ([IPv6:2607:f8b0:4864:20::542]:33943
        "EHLO mail-pg1-x542.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994586AbeJMBc3ZaMuy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 03:32:29 +0200
Received: by mail-pg1-x542.google.com with SMTP id g12-v6so6609652pgs.1
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 18:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TuTZZG6t7Vpxk6hICMjuKsRejg5EuhIlnOB0TcQ6zaw=;
        b=lwmRep2sGNPNtJhgB9RsOPKTOOSB/krJ8anCRbmRRsLRPZ/Xgg8wtftrtImybZPJ9o
         ta6TKRrl0gc5jms/MCsxSVJ+O1Hrax3boWXjxUDfy0mAOjOPdatt+VtwlcaiJ8EZAXsz
         W1Bl/HdY1fIvlWc7La4wrjjn5Dnmh5o9mNT2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TuTZZG6t7Vpxk6hICMjuKsRejg5EuhIlnOB0TcQ6zaw=;
        b=jLU3H6mZ5tOtH73or7Sh27tqd1iS+ysd2rULVunHiBdNIgfHXTt+v67F3C5wxnp42O
         xr6d2L9+XNmiVYcjMOfBN7rmKtaVGeFSpBZsMFj+ENeMyNfJwbUjxO0Esu4aFKqb32dk
         xJ+ftXQOmhctzLM4V5Ao1PDvGMs49Nzs790kV5LcKHhTKMADkleDMB/lSP0mD8zUlf0M
         nk6KI6mDxBqG46s5SFIl7n/OTc313caut3x3EscKY3ECClcEKAtgrhhEBueYSBSpRE4M
         A+A5SE+AZrrZYALRsTRGsu/ywbNYH7JWOna4wrN0f8kpOS6Bq6JecOnJTqH/mzB+heRE
         pXZQ==
X-Gm-Message-State: ABuFfohnMFwkxEsI1IFJq02ejVw63ZZoZDqrOoARzm2YuGCtTLyT3tak
        Vg9Q1GkoEscpk9yOcefznPa1WA==
X-Google-Smtp-Source: ACcGV61+9EmPtOdQGzTHjVGwLpiqYsmqyZ1bXa4NAgT6WNqQkE33CkAc0nRdLLEL017wJ1a4KyTnew==
X-Received: by 2002:a63:b08:: with SMTP id 8-v6mr7584652pgl.130.1539394343099;
        Fri, 12 Oct 2018 18:32:23 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q7-v6sm6507828pfd.164.2018.10.12.18.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 18:32:21 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        minchan@kernel.org, pantin@google.com, hughd@google.com,
        lokeshgidra@google.com, dancol@google.com, mhocko@kernel.org,
        kirill@shutemov.name, akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        anton.ivanov@kot-begemot.co.uk, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        elfring@users.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
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
        linux-xtensa@linux-xtensa.org, Max Filippov <jcmvbkbc@gmail.com>,
        nios2-dev@lists.rocketboards.org,
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
Subject: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Date:   Fri, 12 Oct 2018 18:31:58 -0700
Message-Id: <20181013013200.206928-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181013013200.206928-1-joel@joelfernandes.org>
References: <20181013013200.206928-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66805
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

Incase THP is enabled, the optimization is skipped. I also flush the
tlb every time we do this optimization since I couldn't find a way to
determine if the low-level PTEs are dirty. It is seen that the cost of
doing so is not much compared the improvement, on both x86-64 and arm64.

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
 mm/mremap.c  | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

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
index 9e68a02a52b1..2fd163cff406 100644
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
@@ -239,7 +287,24 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
 				continue;
+		} else if (extent == PMD_SIZE && IS_ENABLED(CONFIG_HAVE_MOVE_PMD)) {
+			/*
+			 * If the extent is PMD-sized, try to speed the move by
+			 * moving at the PMD level if possible.
+			 */
+			bool moved;
+
+			if (need_rmap_locks)
+				take_rmap_locks(vma);
+			moved = move_normal_pmd(vma, old_addr, new_addr,
+					old_end, old_pmd, new_pmd,
+					&need_flush);
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
2.19.0.605.g01d371f741-goog
