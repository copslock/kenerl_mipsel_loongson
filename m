Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 11:16:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51803 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860090AbaGNJOxWGf2l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 11:14:53 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 01D3E8175507
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 10:14:43 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 14 Jul
 2014 10:14:45 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 10:14:45 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 10:14:44 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 5/5] MIPS: mm: Use the HardWare Page Table Walker if the core supports it
Date:   Mon, 14 Jul 2014 10:14:06 +0100
Message-ID: <1405329246-21643-6-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405329246-21643-1-git-send-email-markos.chandras@imgtec.com>
References: <1405329246-21643-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The Hardware Page Table Walker aims to speed up TLB refill exceptions
by handling them in the hardware level instead of having a software
TLB refill handler. However, a TLB refill exception can still be thrown
in certain cases such as, synchronus exceptions, or address translation
or memory errors during the HWTW operation. As a result of which,
HWTW must not be considered a complete replacement for the TLB refill
software handler, but rather a fast-path for it.
For HWTW to work, the PWBase register must contain the task's page
global directory address so the HWTW will kick in on TLB refill
exceptions.

Due to HWTW being a separate engine embedded deep in the CPU pipeline,
we need to restart the HWTW everytime a PTE changes to avoid HWTW fetching
a old entry from the page tables. It's also necessary to restart the HWTW
on context switches to prevent it from fetching a page from the previous
process. Finally, since HWTW is using the entryhi register to write
the translations to the TLB, it's necessary to stop the HWTW whenever
the entryhi changes (eg for tlb probe operations) and enable it back
afterwards.

== Performance ==

The following trivial test was used to measure the performance of
the HWTW. Using the same root filesystem, the following
command was used to measure the number of tlb refill handler executions
with and without (using 'nohwtw' kernel parameter) HWTW support.
The kernel was modified to use a scratch register as a counter for
the TLB refill exceptions.

find /usr -type f -exec ls -lh {} \;

HWTW Enabled:
TLB refill exceptions: 12306

HWTW Disabled:
TLB refill exceptions: 17805

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/mmu_context.h | 10 ++++
 arch/mips/include/asm/pgtable.h     | 27 +++++++++++
 arch/mips/mm/tlb-r4k.c              | 13 +++++-
 arch/mips/mm/tlbex.c                | 91 +++++++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 2e373da5f8e9..be778125b81d 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -20,10 +20,20 @@
 #include <asm/tlbflush.h>
 #include <asm-generic/mm_hooks.h>
 
+#define hwtw_set_pwbase(pgd)						\
+do {									\
+	if (cpu_has_hwtw) {						\
+		write_c0_pwbase(pgd);					\
+		back_to_back_c0_hazard();				\
+		hwtw_reset();						\
+	}								\
+} while (0)
+
 #define TLBMISS_HANDLER_SETUP_PGD(pgd)					\
 do {									\
 	extern void tlbmiss_handler_setup_pgd(unsigned long);		\
 	tlbmiss_handler_setup_pgd((unsigned long)(pgd));		\
+	hwtw_set_pwbase((unsigned long)pgd);				\
 } while (0)
 
 #ifdef CONFIG_MIPS_PGD_C0_CONTEXT
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 539ddd148bbb..d3844c09e7e4 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -97,6 +97,31 @@ extern void paging_init(void);
 
 #define pmd_page_vaddr(pmd)	pmd_val(pmd)
 
+#define hwtw_stop()							\
+do {									\
+	if (cpu_has_hwtw)						\
+		write_c0_pwctl(read_c0_pwctl() &			\
+			       ~(1 << MIPS_PWCTL_PWEN_SHIFT));		\
+} while(0)
+
+#define hwtw_start()							\
+do {									\
+	if (cpu_has_hwtw)						\
+		write_c0_pwctl(read_c0_pwctl() |			\
+			       (1 << MIPS_PWCTL_PWEN_SHIFT));		\
+} while(0)
+
+
+#define hwtw_reset()							\
+do {									\
+	if (cpu_has_hwtw) {						\
+		hwtw_stop();						\
+		back_to_back_c0_hazard();				\
+		hwtw_start();						\
+		back_to_back_c0_hazard();				\
+	}								\
+} while(0)
+
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 
 #define pte_none(pte)		(!(((pte).pte_low | (pte).pte_high) & ~_PAGE_GLOBAL))
@@ -131,6 +156,7 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 		null.pte_low = null.pte_high = _PAGE_GLOBAL;
 
 	set_pte_at(mm, addr, ptep, null);
+	hwtw_reset();
 }
 #else
 
@@ -168,6 +194,7 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 	else
 #endif
 		set_pte_at(mm, addr, ptep, __pte(0));
+	hwtw_reset();
 }
 #endif
 
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 3914e27456f2..36dabb8e331a 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -57,6 +57,7 @@ void local_flush_tlb_all(void)
 	local_irq_save(flags);
 	/* Save old context and create impossible VPN2 value */
 	old_ctx = read_c0_entryhi();
+	hwtw_stop();
 	write_c0_entrylo0(0);
 	write_c0_entrylo1(0);
 
@@ -90,6 +91,7 @@ void local_flush_tlb_all(void)
 	}
 	tlbw_use_hazard();
 	write_c0_entryhi(old_ctx);
+	hwtw_start();
 	flush_itlb();
 	local_irq_restore(flags);
 }
@@ -131,6 +133,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			int oldpid = read_c0_entryhi();
 			int newpid = cpu_asid(cpu, mm);
 
+			hwtw_stop();
 			while (start < end) {
 				int idx;
 
@@ -151,6 +154,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			}
 			tlbw_use_hazard();
 			write_c0_entryhi(oldpid);
+			hwtw_start();
 		} else {
 			drop_mmu_context(mm, cpu);
 		}
@@ -174,7 +178,7 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		start &= (PAGE_MASK << 1);
 		end += ((PAGE_SIZE << 1) - 1);
 		end &= (PAGE_MASK << 1);
-
+		hwtw_stop();
 		while (start < end) {
 			int idx;
 
@@ -195,6 +199,7 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		}
 		tlbw_use_hazard();
 		write_c0_entryhi(pid);
+		hwtw_start();
 	} else {
 		local_flush_tlb_all();
 	}
@@ -214,6 +219,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 		page &= (PAGE_MASK << 1);
 		local_irq_save(flags);
 		oldpid = read_c0_entryhi();
+		hwtw_stop();
 		write_c0_entryhi(page | newpid);
 		mtc0_tlbw_hazard();
 		tlb_probe();
@@ -231,6 +237,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 
 	finish:
 		write_c0_entryhi(oldpid);
+		hwtw_start();
 		flush_itlb_vm(vma);
 		local_irq_restore(flags);
 	}
@@ -247,6 +254,7 @@ void local_flush_tlb_one(unsigned long page)
 
 	local_irq_save(flags);
 	oldpid = read_c0_entryhi();
+	hwtw_stop();
 	page &= (PAGE_MASK << 1);
 	write_c0_entryhi(page);
 	mtc0_tlbw_hazard();
@@ -263,6 +271,7 @@ void local_flush_tlb_one(unsigned long page)
 		tlbw_use_hazard();
 	}
 	write_c0_entryhi(oldpid);
+	hwtw_start();
 	flush_itlb();
 	local_irq_restore(flags);
 }
@@ -351,6 +360,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 	local_irq_save(flags);
 	/* Save old context and create impossible VPN2 value */
 	old_ctx = read_c0_entryhi();
+	hwtw_stop();
 	old_pagemask = read_c0_pagemask();
 	wired = read_c0_wired();
 	write_c0_wired(wired + 1);
@@ -366,6 +376,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 
 	write_c0_entryhi(old_ctx);
 	tlbw_use_hazard();	/* What is the hazard here? */
+	hwtw_start();
 	write_c0_pagemask(old_pagemask);
 	local_flush_tlb_all();
 	local_irq_restore(flags);
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e80e10bafc83..a497db82a247 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2194,6 +2194,94 @@ static void flush_tlb_handlers(void)
 			   (unsigned long)tlbmiss_handler_setup_pgd_end);
 }
 
+static void print_hwtw_config(void)
+{
+	unsigned long config;
+	unsigned int pwctl;
+	const int field = 2 * sizeof(unsigned long);
+
+	config = read_c0_pwfield();
+	pr_debug("PWField (0x%0*lx): GDI: 0x%02lx  UDI: 0x%02lx  MDI: 0x%02lx  PTI: 0x%02lx  PTEI: 0x%02lx\n",
+		field, config,
+		(config & MIPS_PWFIELD_GDI_MASK) >> MIPS_PWFIELD_GDI_SHIFT,
+		(config & MIPS_PWFIELD_UDI_MASK) >> MIPS_PWFIELD_UDI_SHIFT,
+		(config & MIPS_PWFIELD_MDI_MASK) >> MIPS_PWFIELD_MDI_SHIFT,
+		(config & MIPS_PWFIELD_PTI_MASK) >> MIPS_PWFIELD_PTI_SHIFT,
+		(config & MIPS_PWFIELD_PTEI_MASK) >> MIPS_PWFIELD_PTEI_SHIFT);
+
+	config = read_c0_pwsize();
+	pr_debug("PWSize  (0x%0*lx): GDW: 0x%02lx  UDW: 0x%02lx  MDW: 0x%02lx  PTW: 0x%02lx  PTEW: 0x%02lx\n",
+		field, config,
+		(config & MIPS_PWSIZE_GDW_MASK) >> MIPS_PWSIZE_GDW_SHIFT,
+		(config & MIPS_PWSIZE_UDW_MASK) >> MIPS_PWSIZE_UDW_SHIFT,
+		(config & MIPS_PWSIZE_MDW_MASK) >> MIPS_PWSIZE_MDW_SHIFT,
+		(config & MIPS_PWSIZE_PTW_MASK) >> MIPS_PWSIZE_PTW_SHIFT,
+		(config & MIPS_PWSIZE_PTEW_MASK) >> MIPS_PWSIZE_PTEW_SHIFT);
+
+	pwctl = read_c0_pwctl();
+	pr_debug("PWCtl   (0x%x): PWEn: 0x%x  DPH: 0x%x  HugePg: 0x%x  Psn: 0x%x\n",
+		pwctl,
+		(pwctl & MIPS_PWCTL_PWEN_MASK) >> MIPS_PWCTL_PWEN_SHIFT,
+		(pwctl & MIPS_PWCTL_DPH_MASK) >> MIPS_PWCTL_DPH_SHIFT,
+		(pwctl & MIPS_PWCTL_HUGEPG_MASK) >> MIPS_PWCTL_HUGEPG_SHIFT,
+		(pwctl & MIPS_PWCTL_PSN_MASK) >> MIPS_PWCTL_PSN_SHIFT);
+}
+
+static void config_hwtw_params(void)
+{
+	unsigned long pwfield, pwsize, ptei;
+	unsigned int config;
+
+	/*
+	 * We are using 2-level page tables, so we only need to
+	 * setup GDW and PTW appropriately. UDW and MDW will remain 0.
+	 * The default value of GDI/UDI/MDI/PTI is 0xc. It is illegal to
+	 * write values less than 0xc in these fields because the entire
+	 * write will be dropped. As a result of which, we must preserve
+	 * the original reset values and overwrite only what we really want.
+	 */
+
+	pwfield = read_c0_pwfield();
+	/* re-initialize the GDI field */
+	pwfield &= ~MIPS_PWFIELD_GDI_MASK;
+	pwfield |= PGDIR_SHIFT << MIPS_PWFIELD_GDI_SHIFT;
+	/* re-initialize the PTI field including the even/odd bit */
+	pwfield &= ~MIPS_PWFIELD_PTI_MASK;
+	pwfield |= PAGE_SHIFT << MIPS_PWFIELD_PTI_SHIFT;
+	/* Set the PTEI right shift */
+	ptei = _PAGE_GLOBAL_SHIFT << MIPS_PWFIELD_PTEI_SHIFT;
+	pwfield |= ptei;
+	write_c0_pwfield(pwfield);
+	/* Check whether the PTEI value is supported */
+	back_to_back_c0_hazard();
+	pwfield = read_c0_pwfield();
+	if (((pwfield & MIPS_PWFIELD_PTEI_MASK) << MIPS_PWFIELD_PTEI_SHIFT)
+		!= ptei) {
+		pr_warn("Unsupported PTEI field value: 0x%lx. HWTW will not be enabled",
+			ptei);
+		/*
+		 * Drop option to avoid HWTW being enabled via another path
+		 * (eg hwtw_reset())
+		 */
+		current_cpu_data.options &= ~MIPS_CPU_HWTW;
+		return;
+	}
+
+	pwsize = ilog2(PTRS_PER_PGD) << MIPS_PWSIZE_GDW_SHIFT;
+	pwsize |= ilog2(PTRS_PER_PTE) << MIPS_PWSIZE_PTW_SHIFT;
+	write_c0_pwsize(pwsize);
+
+	/* Make sure everything is set before we enable the HWTW */
+	back_to_back_c0_hazard();
+
+	/* Enable HWTW and disable the rest of the pwctl fields */
+	config = 1 << MIPS_PWCTL_PWEN_SHIFT;
+	write_c0_pwctl(config);
+	pr_info("Hardware Page Table Walker enabled\n");
+
+	print_hwtw_config();
+}
+
 void build_tlb_refill_handler(void)
 {
 	/*
@@ -2258,5 +2346,8 @@ void build_tlb_refill_handler(void)
 		}
 		if (cpu_has_local_ebase)
 			build_r4000_tlb_refill_handler();
+		if (cpu_has_hwtw)
+			config_hwtw_params();
+
 	}
 }
-- 
2.0.0
