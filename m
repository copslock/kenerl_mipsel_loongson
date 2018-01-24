Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 02:50:17 +0100 (CET)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:33441
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993004AbeAXBr4l0xIZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 02:47:56 +0100
Received: by mail-qt0-x242.google.com with SMTP id d8so6636728qtm.0;
        Tue, 23 Jan 2018 17:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICsCgEcDt8tjlteN8C6JSxkSX44pAkjb4q7ArvYpt5M=;
        b=Aj3diXS9vKzKN2F1tnOPlmIHWkhQUDEpG0jNkIkKQzXJIc4VQVDT2UBGJXBV19oZh8
         rXaa+hzPD2iGk8KvFn1WS64qPSvZANgBqGAIkzfPQVXF5Fcnc9gm8jbIdubX5g97uiMY
         olR3ZoWKN+hMvKCN+4PNED0LeaeGcyhUrrebWJ8ebuYoDY/gbUioSS7ZkcAne+xwjZYK
         CoJLHN9HJfs4YIEXbX4LPDuUatxLeTTIXV+D6dQbLKpETLfNqayRb1pE0oVmKlE072q7
         QShMY7Fyk/Bf2zuNPr2Cm/dBiYUCDJe68cWrZrwV0H0jUcYmE5HFQZ4ghq6G5Mf6f+qk
         J8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICsCgEcDt8tjlteN8C6JSxkSX44pAkjb4q7ArvYpt5M=;
        b=NlnMOWbP8xVI7uvLm6EGcbSIqF3Jc35Q87MkALG5wmegWsa9bbXLmTAwNmjhDz0U+u
         Z0GGJf6SouSkpUK/Pyhyi2J4f8TGzoGA34oS0wl4AU5muogXGy8rmPVFrFTS0k8Ml12A
         IOETtzFMp2SE1Gf5abo7psYBVSCnjDlyCwDB5GJPiPyA0qCaks1bFgILg2PMPTsfAba/
         9nquBKnKrIyow2j1kx54kFW8DnZ9G5v6UVx/wZgXOTpEEsP1K1oDcAbLHh7rZwvDxtga
         vyDtzYQTuf94OXv80e4q0DP3ZjV2mxDvHTmgtmImyPqUfCdyiY8+o5pFGoe9QUQMsPsY
         vbWg==
X-Gm-Message-State: AKwxytdU72P4jBRVJoqQGFrmuNVQaAYTPpEPzMnGCQ0WzBVjhUgYaNBg
        eYrkn4J8SmNxkHdLQi+n6/UCRE7T
X-Google-Smtp-Source: AH8x226OFf406h1hC+kbclfYCgZqW/UlLY+eUqO4SIWij+nqQJtuNZ+QqciLeMNY6nqmDXuMvmAHRw==
X-Received: by 10.200.49.231 with SMTP id i36mr6527110qte.116.1516758470223;
        Tue, 23 Jan 2018 17:47:50 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x7sm1465605qtx.51.2018.01.23.17.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jan 2018 17:47:49 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 6/6] MIPS: BMIPS: Add support for eXtended KSEG0/1 (XKS01)
Date:   Tue, 23 Jan 2018 17:47:06 -0800
Message-Id: <1516758426-8127-7-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com>
References: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Florian Fainelli <florian.fainelli@broadcom.com>

We need to implement a few things in order for XKS01 to work:

- a coherent allocator is needed for some portions of the memory space,
  this is loosely inspired from an old ARM implementation
- we need to obtain how much DRAM we have on our first memory controller
  (MEMC0) which is what govers how big the extended region can be
- a bunch of ioremap and dma-coherent functions need to be re-defined to
  take our special ranges into account

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/mips/Kconfig                                  |   2 +
 arch/mips/bmips/Makefile                           |   2 +-
 arch/mips/bmips/memory.c                           | 427 +++++++++++++++++++++
 arch/mips/bmips/setup.c                            |  35 ++
 arch/mips/include/asm/addrspace.h                  |   8 +
 arch/mips/include/asm/mach-bmips/dma-coherence.h   |   6 +
 arch/mips/include/asm/mach-bmips/ioremap.h         |  26 +-
 .../include/asm/mach-bmips/kernel-entry-init.h     |  18 +
 arch/mips/include/asm/mach-bmips/spaces.h          | 102 +++++
 9 files changed, 603 insertions(+), 23 deletions(-)
 create mode 100644 arch/mips/bmips/memory.c
 create mode 100644 arch/mips/include/asm/mach-bmips/kernel-entry-init.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 659e0079487f..b7c0306c9051 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -234,6 +234,7 @@ config BMIPS_GENERIC
 	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
 	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select HARDIRQS_SW_RESEND
+	select FW_CFE
 	help
 	  Build a generic DT-based kernel image that boots on select
 	  BCM33xx cable modem chips, BCM63xx DSL chips, and BCM7xxx set-top
@@ -1690,6 +1691,7 @@ config CPU_BMIPS
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_CPUFREQ
 	select MIPS_EXTERNAL_TIMER
+	select XKS01
 	help
 	  Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
 
diff --git a/arch/mips/bmips/Makefile b/arch/mips/bmips/Makefile
index a393955cba08..990dc814b7d8 100644
--- a/arch/mips/bmips/Makefile
+++ b/arch/mips/bmips/Makefile
@@ -1 +1 @@
-obj-y		+= setup.o irq.o dma.o
+obj-y		+= setup.o irq.o dma.o memory.o
diff --git a/arch/mips/bmips/memory.c b/arch/mips/bmips/memory.c
new file mode 100644
index 000000000000..847954b8686e
--- /dev/null
+++ b/arch/mips/bmips/memory.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bootmem.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/ioport.h>
+#include <linux/list.h>
+#include <linux/vmalloc.h>
+#include <linux/compiler.h>
+#include <linux/atomic.h>
+#include <linux/printk.h>
+#include <linux/module.h>
+#include <linux/init_task.h>
+
+#include <asm/page.h>
+#include <asm/pgtable-32.h>
+#include <asm/pgtable-bits.h>
+#include <asm/addrspace.h>
+#include <asm/tlbflush.h>
+#include <asm/r4kcache.h>
+
+#include <spaces.h>
+
+/*
+ * Override default behavior to allow cached access to all valid DRAM ranges
+ */
+int __uncached_access(struct file *file, unsigned long addr)
+{
+	if (file->f_flags & O_SYNC)
+		return 1;
+	if (addr >= 0x10000000 && addr < UPPERMEM_START)
+		return 1;
+	if (addr >= 0xa0000000)
+		return 1;
+	return 0;
+}
+
+/***********************************************************************
+ * Wired TLB mappings for upper memory support
+ ***********************************************************************/
+
+#define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
+
+/* (PFN << 6) | GLOBAL | VALID | DIRTY | cacheability */
+#define ENTRYLO_CACHED(paddr)	(((paddr) >> 6) | (0x07) | (0x03 << 3))
+#define ENTRYLO_UNCACHED(paddr)	(((paddr) >> 6) | (0x07) | (0x02 << 3))
+
+/* GLOBAL | !VALID */
+#define ENTRYLO_INVALID()	(0x01)
+
+struct tlb_entry {
+	unsigned long entrylo0;
+	unsigned long entrylo1;
+	unsigned long entryhi;
+	unsigned long pagemask;
+};
+
+static struct tlb_entry __maybe_unused uppermem_mappings[] = {
+{
+	.entrylo0		= ENTRYLO_CACHED(TLB_UPPERMEM_PA),
+	.entrylo1		= ENTRYLO_INVALID(),
+	.entryhi		= TLB_UPPERMEM_VA,
+	.pagemask		= PM_256M,
+},
+};
+
+static inline void brcm_write_tlb_entry(int idx, unsigned long entrylo0,
+					unsigned long entrylo1,
+					unsigned long entryhi,
+					unsigned long pagemask)
+{
+	write_c0_entrylo0(entrylo0);
+	write_c0_entrylo1(entrylo1);
+	write_c0_entryhi(entryhi);
+	write_c0_pagemask(pagemask);
+	write_c0_index(idx);
+	mtc0_tlbw_hazard();
+	tlb_write_indexed();
+	tlbw_use_hazard();
+}
+
+/*
+ * This function is used instead of add_wired_entry(), because it does not
+ * have any external dependencies and is not marked __init
+ */
+static inline void brcm_add_wired_entry(unsigned long entrylo0,
+					unsigned long entrylo1,
+					unsigned long entryhi,
+					unsigned long pagemask)
+{
+	int i = read_c0_wired();
+	write_c0_wired(i + 1);
+	brcm_write_tlb_entry(i, entrylo0, entrylo1, entryhi, pagemask);
+}
+
+extern void build_tlb_refill_handler(void);
+extern void tlb_init(void);
+
+void bmips_tlb_init(void)
+{
+	if (!cpu_has_xks01) {
+		tlb_init();
+		return;
+	}
+
+	if (smp_processor_id() == 0) {
+		int i;
+		struct tlb_entry *e = uppermem_mappings;
+
+		tlb_init();
+		for (i = 0; i < ARRAY_SIZE(uppermem_mappings); i++, e++)
+			brcm_add_wired_entry(e->entrylo0, e->entrylo1,
+				e->entryhi, e->pagemask);
+		write_c0_pagemask(PM_DEFAULT_MASK);
+	} else {
+		/* bypass tlb_init() / probe_tlb() for secondary CPU */
+		cpu_data[smp_processor_id()].tlbsize = cpu_data[0].tlbsize;
+		build_tlb_refill_handler();
+	}
+}
+
+/*
+ * Initialize upper memory TLB entries
+ *
+ * On TP1 this must happen before we set up $sp/$gp .  It is always
+ * possible for stacks, task_structs, thread_info's, and other
+ * important structures to be allocated out of upper memory so
+ * this happens early on.
+ */
+asmlinkage void plat_wired_tlb_setup(void)
+{
+	int __maybe_unused i, tlbsz;
+
+	if (!cpu_has_xks01)
+		return;
+
+	/* Flush TLB.  local_flush_tlb_all() is not available yet. */
+	write_c0_entrylo0(0);
+	write_c0_entrylo1(0);
+	write_c0_pagemask(PM_DEFAULT_MASK);
+	write_c0_wired(0);
+
+	tlbsz = (read_c0_config1() >> 25) & 0x3f;
+	for (i = 0; i <= tlbsz; i++) {
+		write_c0_entryhi(UNIQUE_ENTRYHI(i));
+		write_c0_index(i);
+		mtc0_tlbw_hazard();
+		tlb_write_indexed();
+		tlbw_use_hazard();
+	}
+
+	write_c0_wired(0);
+	mtc0_tlbw_hazard();
+
+	for (i = 0; i < ARRAY_SIZE(uppermem_mappings); i++) {
+		struct tlb_entry *e = &uppermem_mappings[i];
+		brcm_add_wired_entry(e->entrylo0, e->entrylo1, e->entryhi,
+			e->pagemask);
+	}
+
+	write_c0_pagemask(PM_DEFAULT_MASK);
+}
+
+/***********************************************************************
+ * Special allocator for coherent (uncached) memory
+ * (Required for >256MB upper memory)
+ ***********************************************************************/
+
+#define CONSISTENT_DMA_SIZE	(CONSISTENT_END - CONSISTENT_BASE)
+#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> \
+	PAGE_SHIFT)
+#define CONSISTENT_PTE_INDEX(x) (((unsigned long)(x) - CONSISTENT_BASE) >> \
+	PGDIR_SHIFT)
+#define NUM_CONSISTENT_PTES	(CONSISTENT_DMA_SIZE >> PGDIR_SHIFT)
+
+/*
+ * These are the page tables (4MB each) covering uncached, DMA consistent
+ * allocations
+ */
+static pte_t *consistent_pte[NUM_CONSISTENT_PTES];
+static DEFINE_SPINLOCK(consistent_lock);
+
+struct bmips_vm_region {
+	struct list_head	vm_list;
+	unsigned long		vm_start;
+	unsigned long		vm_end;
+	void			*vm_cac_va;
+	int			vm_active;
+};
+
+static struct bmips_vm_region consistent_head = {
+	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
+	.vm_start	= CONSISTENT_BASE,
+	.vm_end		= CONSISTENT_END,
+};
+
+static struct bmips_vm_region *
+bmips_vm_region_alloc(struct bmips_vm_region *head, size_t size, gfp_t gfp)
+{
+	unsigned long addr = head->vm_start, end = head->vm_end - size;
+	unsigned long flags;
+	struct bmips_vm_region *c, *new;
+
+	new = kmalloc(sizeof(struct bmips_vm_region), gfp);
+	if (!new)
+		goto out;
+
+	spin_lock_irqsave(&consistent_lock, flags);
+
+	list_for_each_entry(c, &head->vm_list, vm_list) {
+		if ((addr + size) < addr)
+			goto nospc;
+		if ((addr + size) <= c->vm_start)
+			goto found;
+		addr = c->vm_end;
+		if (addr > end)
+			goto nospc;
+	}
+
+found:
+	/*
+	 * Insert this entry _before_ the one we found.
+	 */
+	list_add_tail(&new->vm_list, &c->vm_list);
+	new->vm_start = addr;
+	new->vm_end = addr + size;
+	new->vm_active = 1;
+
+	spin_unlock_irqrestore(&consistent_lock, flags);
+	return new;
+
+nospc:
+	spin_unlock_irqrestore(&consistent_lock, flags);
+	kfree(new);
+out:
+	return NULL;
+}
+
+static struct bmips_vm_region *bmips_vm_region_find(struct bmips_vm_region *head,
+	unsigned long addr)
+{
+	struct bmips_vm_region *c;
+
+	list_for_each_entry(c, &head->vm_list, vm_list) {
+		if (c->vm_active && c->vm_start == addr)
+			goto out;
+	}
+	c = NULL;
+out:
+	return c;
+}
+
+static int __init consistent_init(void)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	int ret = 0, i = 0;
+	u32 base = CONSISTENT_BASE;
+
+	do {
+		pgd = pgd_offset(&init_mm, base);
+		pud = pud_alloc(&init_mm, pgd, base);
+		if (!pud) {
+			pr_err("%s: no pud tables\n", __func__);
+			ret = -ENOMEM;
+			break;
+		}
+		pmd = pmd_alloc(&init_mm, pud, base);
+		if (!pmd) {
+			pr_err("%s: no pmd tables\n", __func__);
+			ret = -ENOMEM;
+			break;
+		}
+
+		pte = pte_alloc_kernel(pmd, base);
+		if (!pte) {
+			pr_err("%s: no pte tables\n", __func__);
+			ret = -ENOMEM;
+			break;
+		}
+
+		consistent_pte[i++] = pte;
+		base += (1 << PGDIR_SHIFT);
+	} while (base < CONSISTENT_END);
+
+	return ret;
+}
+
+core_initcall(consistent_init);
+
+int plat_map_coherent(dma_addr_t dma_handle, void *cac_va, size_t size,
+		      void **uncac_va, gfp_t gfp)
+{
+	struct bmips_vm_region *c;
+	struct page *page;
+	pte_t *pte;
+	int idx;
+	u32 off;
+
+	c = bmips_vm_region_alloc(&consistent_head, size, gfp);
+	if (!c)
+		return -EINVAL;
+
+	c->vm_cac_va = cac_va;
+
+	page = virt_to_page(cac_va);
+	idx = CONSISTENT_PTE_INDEX(c->vm_start);
+	off = CONSISTENT_OFFSET(c->vm_start) & (PTRS_PER_PTE-1);
+	pte = consistent_pte[idx] + off;
+
+	pr_debug("map addr %08lx idx %x off %x pte %p\n",
+		c->vm_start, idx, off, pte);
+
+	do {
+		if (off >= PTRS_PER_PTE) {
+			off = 0;
+			BUG_ON(idx >= NUM_CONSISTENT_PTES - 1);
+			pte = consistent_pte[++idx];
+		}
+
+		BUG_ON(!pte_none(*pte));
+		set_pte(pte, mk_pte(page, PAGE_KERNEL_UNCACHED));
+		page++;
+		pte++;
+		off++;
+	} while (size -= PAGE_SIZE);
+
+	*uncac_va = (void *)c->vm_start;
+	return 0;
+}
+
+void *plat_unmap_coherent(void *vaddr)
+{
+	struct bmips_vm_region *c;
+	unsigned long flags, addr;
+	void *ret = NULL;
+	pte_t *pte;
+	int idx;
+	u32 off;
+
+	spin_lock_irqsave(&consistent_lock, flags);
+	c = bmips_vm_region_find(&consistent_head, (unsigned long)vaddr);
+	if (!c) {
+		spin_unlock_irqrestore(&consistent_lock, flags);
+		pr_err("%s: invalid VA %p\n", __func__, vaddr);
+		return NULL;
+	}
+	c->vm_active = 0;
+	spin_unlock_irqrestore(&consistent_lock, flags);
+
+	ret = c->vm_cac_va;
+	addr = c->vm_start;
+
+	idx = CONSISTENT_PTE_INDEX(addr);
+	off = CONSISTENT_OFFSET(addr) & (PTRS_PER_PTE-1);
+	pte = consistent_pte[idx] + off;
+
+	pr_debug("unmap addr %08lx idx %x off %x pte %p\n",
+		addr, idx, off, pte);
+
+	do {
+		if (off >= PTRS_PER_PTE) {
+			off = 0;
+			BUG_ON(idx >= NUM_CONSISTENT_PTES - 1);
+			pte = consistent_pte[++idx];
+		}
+
+		pte_clear(&init_mm, addr, pte);
+		pte++;
+		off++;
+		addr += PAGE_SIZE;
+	} while (addr < c->vm_end);
+	flush_tlb_kernel_range(c->vm_start, c->vm_end);
+
+	spin_lock_irqsave(&consistent_lock, flags);
+	list_del(&c->vm_list);
+	spin_unlock_irqrestore(&consistent_lock, flags);
+
+	kfree(c);
+
+	return ret;
+}
+
+void __iomem *plat_ioremap(phys_addr_t offset, unsigned long size,
+	unsigned long flags)
+{
+	/* sanity check */
+	if ((offset + size - 1) < offset ||
+	    !size ||
+	    offset > max(KSEG0_SIZE, KSEG1_SIZE))
+		return NULL;
+
+	/* !XKS01, XKS01: uncached access to EBI/registers @ PA 1000_0000 */
+	if (offset >= 0x10000000 &&
+	    (offset + size) <= 0x20000000 &&
+	    flags == _CACHE_UNCACHED)
+		return (void *)(KSEG1 + offset);
+
+	/* !XKS01, XKS01: easy cached access to some DRAM */
+	if ((offset + size) <= KSEG0_SIZE &&
+	    flags == _CACHE_CACHABLE_NONCOHERENT)
+		return (void *)(KSEG0 + offset);
+
+	/* !XKS01 only: easy uncached access to some DRAM */
+	if ((offset + size) <= KSEG1_SIZE &&
+	    flags == _CACHE_UNCACHED)
+		return (void *)(KSEG1 + offset);
+
+	/* anything else gets mapped using page tables */
+	return NULL;
+}
+EXPORT_SYMBOL(plat_ioremap);
+
+int plat_iounmap(const volatile void __iomem *addr)
+{
+	phys_addr_t va = (unsigned long)addr;
+
+	if (va >= KSEG0 && va < (KSEG0 + KSEG0_SIZE))
+		return 1;
+	if (va >= KSEG1 && va < (KSEG1 + KSEG1_SIZE))
+		return 1;
+	return 0;
+}
+EXPORT_SYMBOL(plat_iounmap);
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index d1b7b8b82ae1..4f565f2df977 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -134,6 +134,39 @@ static unsigned long dram0_size_mb;
 
 extern void bmips_tlb_init(void);
 
+static void bmips_add_memory_regions(void)
+{
+	board_tlb_init = bmips_tlb_init;
+
+	do {
+		unsigned long dram0_mb = dram0_size_mb, mb;
+
+		mb = min(dram0_mb, BRCM_MAX_LOWER_MB);
+		dram0_mb -= mb;
+
+		add_memory_region(0, mb << 20, BOOT_MEM_RAM);
+		if (!dram0_mb)
+			break;
+
+		if (cpu_has_xks01) {
+			mb = min(dram0_mb, BRCM_MAX_UPPER_MB);
+			dram0_mb -= mb;
+
+			plat_wired_tlb_setup();
+			add_memory_region(UPPERMEM_START, mb << 20, BOOT_MEM_RAM);
+			if (!dram0_mb)
+				break;
+		}
+
+#ifdef CONFIG_HIGHMEM
+		add_memory_region(HIGHMEM_START, dram0_mb << 20, BOOT_MEM_RAM);
+		break;
+#endif
+		/* Linux memory */
+		mb = dram0_size_mb - dram0_mb;
+	} while (0);
+}
+
 static char __initdata cfe_buf[COMMAND_LINE_SIZE];
 
 static inline int __init parse_ulong(const char *buf, unsigned long *val)
@@ -230,6 +263,8 @@ void __init plat_mem_setup(void)
 			q->quirk_fn();
 		}
 	}
+
+	bmips_add_memory_regions();
 }
 
 void __init device_tree_init(void)
diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
index 4856adc8906e..f66e2f90c604 100644
--- a/arch/mips/include/asm/addrspace.h
+++ b/arch/mips/include/asm/addrspace.h
@@ -96,13 +96,21 @@
  */
 #define KUSEG			0x00000000
 #define KSEG0			0x80000000
+#ifdef CONFIG_XKS01
+#define KSEG1			plat_kseg1()
+#else
 #define KSEG1			0xa0000000
+#endif
 #define KSEG2			0xc0000000
 #define KSEG3			0xe0000000
 
 #define CKUSEG			0x00000000
 #define CKSEG0			0x80000000
+#ifdef CONFIG_XKS01
+#define CKSEG1			plat_kseg1()
+#else
 #define CKSEG1			0xa0000000
+#endif
 #define CKSEG2			0xc0000000
 #define CKSEG3			0xe0000000
 
diff --git a/arch/mips/include/asm/mach-bmips/dma-coherence.h b/arch/mips/include/asm/mach-bmips/dma-coherence.h
index b56380066573..9fbb6355fd8d 100644
--- a/arch/mips/include/asm/mach-bmips/dma-coherence.h
+++ b/arch/mips/include/asm/mach-bmips/dma-coherence.h
@@ -37,6 +37,12 @@ static inline int plat_device_is_coherent(struct device *dev)
 
 #define plat_post_dma_flush	bmips_post_dma_flush
 
+#define plat_map_coherent	plat_map_coherent
+extern int plat_map_coherent(dma_addr_t handle, void *cac_va, size_t size,
+			     void **uncac_va, gfp_t gfp);
+#define plat_unmap_coherent	plat_unmap_coherent
+extern void *plat_unmap_coherent(void *addr);
+
 #include <asm/mach-generic/dma-coherence.h>
 
 #endif /* __ASM_MACH_BMIPS_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-bmips/ioremap.h b/arch/mips/include/asm/mach-bmips/ioremap.h
index 52632ebc705f..e3333d1e52c6 100644
--- a/arch/mips/include/asm/mach-bmips/ioremap.h
+++ b/arch/mips/include/asm/mach-bmips/ioremap.h
@@ -9,26 +9,8 @@ static inline phys_addr_t fixup_bigphys_addr(phys_addr_t phys_addr, phys_addr_t
 	return phys_addr;
 }
 
-static inline int is_bmips_internal_registers(phys_addr_t offset)
-{
-	if (offset >= 0xfff80000)
-		return 1;
-
-	return 0;
-}
-
-static inline void __iomem *plat_ioremap(phys_addr_t offset, unsigned long size,
-					 unsigned long flags)
-{
-	if (is_bmips_internal_registers(offset))
-		return (void __iomem *)offset;
-
-	return NULL;
-}
-
-static inline int plat_iounmap(const volatile void __iomem *addr)
-{
-	return is_bmips_internal_registers((unsigned long)addr);
-}
+extern void __iomem *plat_ioremap(phys_addr_t offset, unsigned long size,
+		        unsigned long flags);
+extern int plat_iounmap(const volatile void __iomem *addr);
 
-#endif /* __ASM_MACH_BMIPS_IOREMAP_H */
+#endif /* __ASM_MACH_BMIPS_GENERIC_IOREMAP_H */
diff --git a/arch/mips/include/asm/mach-bmips/kernel-entry-init.h b/arch/mips/include/asm/mach-bmips/kernel-entry-init.h
new file mode 100644
index 000000000000..48a6768cd664
--- /dev/null
+++ b/arch/mips/include/asm/mach-bmips/kernel-entry-init.h
@@ -0,0 +1,18 @@
+#ifndef __ASM_MACH_BMIPS_GENERIC_KERNEL_ENTRY_H
+#define __ASM_MACH_BMIPS_GENERIC_KERNEL_ENTRY_H
+
+	.macro kernel_entry_setup
+
+	# save arguments for CFE callback
+	sw      a0, cfe_handle
+	sw      a2, cfe_entry
+	sw      a3, cfe_seal
+
+	jal     bmips_enable_xks01
+
+	.endm
+
+	.macro  smp_slave_setup
+	.endm
+
+#endif /* __ASM_MACH_BMIPS_GENERIC_KERNEL_ENTRY_H */
diff --git a/arch/mips/include/asm/mach-bmips/spaces.h b/arch/mips/include/asm/mach-bmips/spaces.h
index c59b28fd9e1d..439e05a80ac9 100644
--- a/arch/mips/include/asm/mach-bmips/spaces.h
+++ b/arch/mips/include/asm/mach-bmips/spaces.h
@@ -13,6 +13,108 @@
 /* Avoid collisions with system base register (SBR) region on BMIPS3300 */
 #include <asm/bmips-spaces.h>
 
+#include <linux/const.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/cpu.h>
+
+/*
+ * 1024MB Broadcom 256+768 virtual address map
+ *
+ * 8000_0000 - 8fff_ffff: 256MB RAM @ 0000_0000, cached
+ * 9000_0000 - 9fff_ffff: 256MB EBI/Registers @ 1000_0000, uncached
+ * a000_0000 - cfff_ffff: 768MB RAM @ 2000_0000, cached
+ * d000_0000 - dfff_ffff: TBD
+ * e000_0000 - ff1f_7fff: vmalloc region
+ * ff1f_8000 - ff1f_ffff: FIXMAP
+ * ff40_0000 - ff7f_ffff: CONSISTENT region
+ *
+ * PA 5000_0000 and above are accessed through HIGHMEM (BMIPS5000 only).
+ */
+#define TLB_UPPERMEM_VA         _AC(0xc0000000, UL)
+#define TLB_UPPERMEM_PA         _AC(0x40000000, UL)
+
+#ifndef __ASSEMBLY__
+static inline unsigned long kseg0_size(void)
+{
+	switch (read_c0_prid() & PRID_IMP_MASK) {
+	case PRID_IMP_BMIPS5000:
+	case PRID_IMP_BMIPS5200:
+		return _AC(0x40000000, UL);
+	default:
+		return _AC(0x20000000, UL);
+	}
+}
+
+static inline unsigned long kseg1_size(void)
+{
+	switch (read_c0_prid() & PRID_IMP_MASK) {
+	case PRID_IMP_BMIPS5000:
+	case PRID_IMP_BMIPS5200:
+		return _AC(0x0, UL);
+	default:
+		return _AC(0x20000000, UL);
+	}
+}
+
+static inline unsigned long map_base(void)
+{
+	switch (read_c0_prid() & PRID_IMP_MASK) {
+	case PRID_IMP_BMIPS5000:
+	case PRID_IMP_BMIPS5200:
+		return _AC(0xe0000000, UL);
+	default:
+		return _AC(0xc0000000, UL);
+	}
+}
+
+static inline unsigned long brcm_max_upper_mb(void)
+{
+	switch (read_c0_prid() & PRID_IMP_MASK) {
+	case PRID_IMP_BMIPS5000:
+	case PRID_IMP_BMIPS5200:
+		return _AC(768, UL);
+	default:
+		return _AC(0, UL);
+	}
+}
+
+static inline unsigned long plat_kseg1(void)
+{
+	switch (read_c0_prid() & PRID_IMP_MASK) {
+	case PRID_IMP_BMIPS5000:
+	case PRID_IMP_BMIPS5200:
+		return 0x80000000;
+	default:
+		return 0xa0000000;
+	}
+}
+
+#define KSEG0_SIZE              kseg0_size()
+#define KSEG1_SIZE		kseg1_size()
+#define MAP_BASE		map_base()
+/* BASE and END must be 4MB-aligned (PGDIR_SIZE) */
+#define CONSISTENT_BASE         _AC(0xff400000, UL)
+#define CONSISTENT_END          _AC(0xff800000, UL)
+#define BRCM_MAX_UPPER_MB       brcm_max_upper_mb()
+#else
+
+#define TLB_UPPERMEM_VA         _AC(0xc0000000, UL)
+#define TLB_UPPERMEM_PA         _AC(0x40000000, UL)
+#define KSEG0_SIZE              _AC(0x40000000, UL)
+#define KSEG1_SIZE              _AC(0x00000000, UL)
+#define MAP_BASE                _AC(0xe0000000, UL)
+/* BASE and END must be 4MB-aligned (PGDIR_SIZE) */
+#define CONSISTENT_BASE         _AC(0xff400000, UL)
+#define CONSISTENT_END          _AC(0xff800000, UL)
+#define BRCM_MAX_UPPER_MB       _AC(768, UL)
+#endif
+
+#define BRCM_MAX_LOWER_MB	_AC(256, UL)
+
+#define UPPERMEM_START		_AC(0x20000000, UL)
+#define HIGHMEM_START		(UPPERMEM_START + (BRCM_MAX_UPPER_MB << 20))
+
 #include <asm/mach-generic/spaces.h>
 
 #endif /* __ASM_BMIPS_SPACES_H */
-- 
2.7.4
