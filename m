Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2014 18:02:50 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:14807 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854777AbaEIQC16ndbW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2014 18:02:27 +0200
X-IronPort-AV: E=Sophos;i="4.97,1019,1389772800"; 
   d="scan'208";a="28926878"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw1-out.broadcom.com with ESMTP; 09 May 2014 10:18:12 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Fri, 9 May 2014 09:02:22 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Fri, 9 May 2014 09:02:22 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 E95835D81C;    Fri,  9 May 2014 09:02:20 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Ashok Kumar <ashoks@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 3/5] MIPS: Netlogic: Mapped kernel support
Date:   Fri, 9 May 2014 21:39:22 +0530
Message-ID: <1399651764-14202-3-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1399651764-14202-1-git-send-email-jchandra@broadcom.com>
References: <1399649304-25856-1-git-send-email-jchandra@broadcom.com>
 <1399651764-14202-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

From: Ashok Kumar <ashoks@broadcom.com>

Add support for loading kernel compiled for CKSEG2. This is done by
adding wired TLB entries for the CKSEG2 at boot up and slave CPU init.

In 64-bit we will map the whole physical memory to mapped area starting
at XKSEG and move the MAP_OFFSET higher to accomodate this.

Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
[jchandra@broadcom.com: Updated to add support 32-bit, and to add XLR
    support. Also made some code cleanups and style fixes.]
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/Kconfig                                  |    9 +-
 .../include/asm/mach-netlogic/kernel-entry-init.h  |   50 +++++++++
 arch/mips/include/asm/mach-netlogic/spaces.h       |   25 +++++
 arch/mips/include/asm/netlogic/common.h            |   14 +++
 arch/mips/include/asm/pgtable-64.h                 |    4 +
 arch/mips/mm/tlb-r4k.c                             |    2 +
 arch/mips/netlogic/Platform                        |    5 +
 arch/mips/netlogic/common/memory.c                 |  113 ++++++++++++++++++++
 arch/mips/netlogic/common/reset.S                  |   40 +++++++
 arch/mips/netlogic/common/smpboot.S                |   16 ++-
 arch/mips/netlogic/xlr/wakeup.c                    |    7 +-
 11 files changed, 277 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-netlogic/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-netlogic/spaces.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index acf85a8..e149850 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2095,12 +2095,11 @@ config SB1_PASS_2_1_WORKAROUNDS
 
 config MAPPED_KERNEL
 	bool "Mapped kernel support"
-	depends on SGI_IP27
+	depends on SGI_IP27 || CPU_XLP || CPU_XLR
 	help
-	  Change the way a Linux kernel is loaded into memory on a MIPS64
-	  machine.  This is required in order to support text replication on
-	  NUMA.  If you need to understand it, read the source code.
-
+	  Enable compiling and loading the Linux kernel compiled to
+	  run in the KSEG2/CKSEG2. Wired TLB entries are used to map
+	  the available DRAM into either XKSEG or KSEG2.
 
 config 64BIT_PHYS_ADDR
 	bool
diff --git a/arch/mips/include/asm/mach-netlogic/kernel-entry-init.h b/arch/mips/include/asm/mach-netlogic/kernel-entry-init.h
new file mode 100644
index 0000000..c1fd37a
--- /dev/null
+++ b/arch/mips/include/asm/mach-netlogic/kernel-entry-init.h
@@ -0,0 +1,50 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Broadcom Corporation
+ *
+ * Based on arch/mips/include/asm/mach-generic/kernel-entry-init.h:
+ *
+ * Copyright (C) 2005 Embedded Alley Solutions, Inc
+ * Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
+ */
+#ifndef __ASM_MACH_NETLOGIC_KERNEL_ENTRY_H
+#define __ASM_MACH_NETLOGIC_KERNEL_ENTRY_H
+
+#ifdef CONFIG_CPU_MIPSR2
+#define JRHB		jr.hb
+#else
+#define JRHB		jr
+#endif
+
+.macro	kernel_entry_setup
+#ifdef CONFIG_MAPPED_KERNEL
+	PTR_LA	t0, 91f
+	move	t3, t0
+	li	t1, 0x1fffffff		/* VA to PA mask for CKSEG */
+	or	t0, t1
+	xor	t0, t1			/* clear PA bits to get mapping */
+	dmtc0	t0, CP0_ENTRYHI
+	li	t1, 0x2f		/* CCA 5, dirty, valid, global */
+	dmtc0	t1, CP0_ENTRYLO0
+	li	t0, 0x1			/* not valid, global */
+	dmtc0	t0, CP0_ENTRYLO1
+	li	t1, PM_256M		/* 256 MB */
+	mtc0	t1, CP0_PAGEMASK
+	mtc0	zero, CP0_INDEX		/* index 0 in TLB */
+	tlbwi
+	li	t0, 1
+	mtc0	t0, CP0_WIRED
+	_ehb
+	JRHB	t3			/* jump to 'real' mapped address */
+	nop
+91:
+#endif
+.endm
+
+.macro	smp_slave_setup
+.endm
+
+#endif /* __ASM_MACH_NETLOGIC_KERNEL_ENTRY_H */
diff --git a/arch/mips/include/asm/mach-netlogic/spaces.h b/arch/mips/include/asm/mach-netlogic/spaces.h
new file mode 100644
index 0000000..6f32f07
--- /dev/null
+++ b/arch/mips/include/asm/mach-netlogic/spaces.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994 - 1999, 2000, 03, 04 Ralf Baechle
+ * Copyright (C) 2000, 2002  Maciej W. Rozycki
+ * Copyright (C) 1990, 1999, 2000 Silicon Graphics, Inc.
+ */
+#ifndef _ASM_NETLOGIC_SPACES_H
+#define _ASM_NETLOGIC_SPACES_H
+
+#if defined(CONFIG_MAPPED_KERNEL)
+#ifdef CONFIG_32BIT
+#define PAGE_OFFSET		CKSEG2
+#define MAP_BASE		CKSEG3
+#else
+#define PAGE_OFFSET		_AC(0xc000000000000000, UL)
+#define MAP_BASE		_AC(0xd000000000000000, UL)
+#endif
+#endif /* CONFIG_MAPPED_KERNEL */
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* __ASM_NETLOGIC_SPACES_H */
diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index c281f03..dde3a8d 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -47,6 +47,17 @@
 #define BOOT_NMI_LOCK		4
 #define BOOT_NMI_HANDLER	8
 
+/* TLB entry save area for mapped kernel */
+#define BOOT_NTLBS		64
+#define BOOT_TLBS_START		72
+#define BOOT_TLB_SIZE		32
+
+/* four u64 entries per TLB */
+#define BOOT_TLB_ENTRYHI	0
+#define BOOT_TLB_ENTRYLO0	1
+#define BOOT_TLB_ENTRYLO1	2
+#define BOOT_TLB_PAGEMASK	3
+
 /* CPU ready flags for each CPU */
 #define BOOT_CPU_READY		2048
 
@@ -90,6 +101,9 @@ extern char nlm_reset_entry[], nlm_reset_entry_end[];
 /* SWIOTLB */
 extern struct dma_map_ops nlm_swiotlb_dma_ops;
 
+/* mapped kernel */
+void nlm_setup_wired_tlbs(void);
+
 extern unsigned int nlm_threads_per_core;
 extern cpumask_t nlm_cpumask;
 
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index e1c49a9..21a204f 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -135,7 +135,11 @@
 #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
 	VMALLOC_START != CKSSEG
 /* Load modules into 32bit-compatible segment. */
+#ifdef CONFIG_MAPPED_KERNEL
+#define MODULE_START	CKSEG3	/* don't overlap with mapped kernel */
+#else
 #define MODULE_START	CKSSEG
+#endif
 #define MODULE_END	(FIXADDR_START-2*PAGE_SIZE)
 #endif
 
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index eeaf50f..81c4859 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -431,7 +431,9 @@ void tlb_init(void)
 	 *     be set to fixed-size pages.
 	 */
 	write_c0_pagemask(PM_DEFAULT_MASK);
+#ifndef CONFIG_MAPPED_KERNEL
 	write_c0_wired(0);
+#endif
 	if (current_cpu_type() == CPU_R10000 ||
 	    current_cpu_type() == CPU_R12000 ||
 	    current_cpu_type() == CPU_R14000)
diff --git a/arch/mips/netlogic/Platform b/arch/mips/netlogic/Platform
index fb8eb4c..3124510 100644
--- a/arch/mips/netlogic/Platform
+++ b/arch/mips/netlogic/Platform
@@ -14,4 +14,9 @@ cflags-$(CONFIG_CPU_XLP)	+= $(call cc-option,-march=xlp,-march=mips64r2)
 # NETLOGIC processor support
 #
 platform-$(CONFIG_NLM_COMMON)	+= netlogic/
+
+ifdef CONFIG_MAPPED_KERNEL
+load-$(CONFIG_NLM_COMMON)	+= 0xffffffffc0100000
+else
 load-$(CONFIG_NLM_COMMON)	+= 0xffffffff80100000
+endif
diff --git a/arch/mips/netlogic/common/memory.c b/arch/mips/netlogic/common/memory.c
index 980c102..6d967ce 100644
--- a/arch/mips/netlogic/common/memory.c
+++ b/arch/mips/netlogic/common/memory.c
@@ -36,14 +36,127 @@
 #include <linux/types.h>
 
 #include <asm/bootinfo.h>
+#include <asm/pgtable.h>
 #include <asm/types.h>
+#include <asm/tlb.h>
+
+#include <asm/netlogic/common.h>
+
+#define TLBSZ		(256 * 1024 * 1024)
+#define PM_TLBSZ	PM_256M
+#define PTE_MAPKERN(pa)	(((pa >> 12) << 6) | 0x2f)
+#define TLB_MAXWIRED	28
 
 static const int prefetch_backup = 512;
 
+#if defined(CONFIG_MAPPED_KERNEL) && defined(CONFIG_64BIT)
+static void nlm_tlb_align(struct boot_mem_map_entry *map)
+{
+	phys_t astart, aend, start, end;
+
+	start = map->addr;
+	end = start + map->size;
+
+	/* fudge first entry for now  */
+	if (start < 0x10000000) {
+		start = 0;
+		end = 0x10000000;
+	}
+	astart = round_up(start, TLBSZ);
+	aend = round_down(end, TLBSZ);
+	if (aend <= astart) {
+		pr_info("Boot mem map: discard seg %lx-%lx\n",
+				(unsigned long)start, (unsigned long)end);
+		map->size = 0;
+		return;
+	}
+	if (astart != start || aend != end) {
+		if (start != 0) {
+			map->addr = astart;
+			map->size = aend - astart;
+		}
+		pr_info("Boot mem map: %lx - %lx -> %lx-%lx\n",
+			(unsigned long)start, (unsigned long)end,
+			(unsigned long)astart, (unsigned long)aend);
+	} else
+		pr_info("Boot mem map: added %lx - %lx\n",
+			(unsigned long)astart, (unsigned long)aend);
+}
+
+static void nlm_calc_wired_tlbs(void)
+{
+	u64 *tlbarr;
+	u32 *tlbcount;
+	u64 lo0, lo1, vaddr;
+	phys_addr_t astart, aend, p;
+	unsigned long bootdata = CKSEG1ADDR(RESET_DATA_PHYS);
+	int i, pos;
+
+	tlbarr = (u64 *)(bootdata + BOOT_TLBS_START);
+	tlbcount = (u32 *)(bootdata + BOOT_NTLBS);
+
+	pos = 0;
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			continue;
+		astart = boot_mem_map.map[i].addr;
+		aend =	astart + boot_mem_map.map[i].size;
+
+		/* fudge first entry for now  */
+		if (astart < 0x10000000) {
+			astart = 0;
+			aend = 0x10000000;
+		}
+		for (p = round_down(astart, 2 * TLBSZ);
+			p < round_up(aend, 2 * TLBSZ);) {
+				vaddr = PAGE_OFFSET + p;
+				lo0 = (p >= astart) ? PTE_MAPKERN(p) : 1;
+				p += TLBSZ;
+				lo1 = (p < aend) ? PTE_MAPKERN(p) : 1;
+				p += TLBSZ;
+
+				tlbarr[BOOT_TLB_ENTRYHI] = vaddr;
+				tlbarr[BOOT_TLB_ENTRYLO0] = lo0;
+				tlbarr[BOOT_TLB_ENTRYLO1] = lo1;
+				tlbarr[BOOT_TLB_PAGEMASK] = PM_TLBSZ;
+				tlbarr += (BOOT_TLB_SIZE / sizeof(tlbarr[0]));
+
+				if (++pos >= TLB_MAXWIRED) {
+					pr_err("Ran out of TLBs at %llx, ",
+							(unsigned long long)p);
+					pr_err("Discarding rest of memory!\n");
+					boot_mem_map.nr_map = i + 1;
+					boot_mem_map.map[i].size = p -
+						boot_mem_map.map[i].addr;
+					goto out;
+				}
+		}
+	}
+out:
+	*tlbcount = pos;
+	pr_info("%d TLB entires used for mapped kernel.\n", pos);
+}
+#endif
+
 void __init plat_mem_fixup(void)
 {
 	int i;
 
+#if defined(CONFIG_MAPPED_KERNEL) && defined(CONFIG_64BIT)
+	/* trim memory regions to PM_TLBSZ boundaries */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			continue;
+		nlm_tlb_align(&boot_mem_map.map[i]);
+	}
+
+	/* calculate and save wired TLB entries */
+	nlm_calc_wired_tlbs();
+
+	/* set them up for boot cpu */
+	nlm_setup_wired_tlbs();
+#endif
+
 	/* fixup entries for prefetch */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
index 701c4bc..1f57c59 100644
--- a/arch/mips/netlogic/common/reset.S
+++ b/arch/mips/netlogic/common/reset.S
@@ -43,6 +43,7 @@
 #include <asm/asmmacro.h>
 #include <asm/addrspace.h>
 
+#include <kernel-entry-init.h>
 #include <asm/netlogic/common.h>
 
 #include <asm/netlogic/xlp-hal/iomap.h>
@@ -254,6 +255,10 @@ EXPORT(nlm_boot_siblings)
 	PTR_ADDU t1, v1
 	li	t2, 1
 	sw	t2, 0(t1)
+
+	/* mapped first wired TLB for mapped kernel */
+	kernel_entry_setup
+
 	/* Wait until NMI hits */
 3:	wait
 	b	3b
@@ -278,3 +283,38 @@ LEAF(nlm_init_boot_cpu)
 	jr	ra
 	nop
 END(nlm_init_boot_cpu)
+
+LEAF(nlm_setup_wired_tlbs)
+#ifdef CONFIG_MAPPED_KERNEL
+	li	t0, CKSEG1ADDR(RESET_DATA_PHYS)
+	lw	t3, BOOT_NTLBS(t0)
+	ADDIU	t0, t0, BOOT_TLBS_START
+	li	t1, 1		/* entry 0 is wired at boot, start at 1 */
+	addiu	t3, 1		/* final number of wired entries */
+
+1:	sltu	v1, t1, t3
+	beqz	v1, 2f
+	nop
+	ld	a0, (8 * BOOT_TLB_ENTRYLO0)(t0)
+	dmtc0	a0, CP0_ENTRYLO0
+	ld	a1, (8 * BOOT_TLB_ENTRYLO1)(t0)
+	dmtc0	a1, CP0_ENTRYLO1
+	ld	a2, (8 * BOOT_TLB_ENTRYHI)(t0)
+	dmtc0	a2, CP0_ENTRYHI
+	ld	a2, (8 * BOOT_TLB_PAGEMASK)(t0)
+	dmtc0	a2, CP0_PAGEMASK
+	mtc0	t1, CP0_INDEX
+	_ehb
+	tlbwi
+	ADDIU	t0, BOOT_TLB_SIZE
+	addiu	t1, 1
+	b	1b
+	nop
+2:
+	mtc0	t3, CP0_WIRED
+	JRHB	ra
+#else
+	jr	ra
+#endif
+	nop
+END(nlm_setup_wired_tlbs)
diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
index 805355b..c720492 100644
--- a/arch/mips/netlogic/common/smpboot.S
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -41,6 +41,7 @@
 #include <asm/asmmacro.h>
 #include <asm/addrspace.h>
 
+#include <kernel-entry-init.h>
 #include <asm/netlogic/common.h>
 
 #include <asm/netlogic/xlp-hal/iomap.h>
@@ -80,6 +81,13 @@ NESTED(nlm_boot_secondary_cpus, 16, sp)
 	ori	t1, ST0_KX
 #endif
 	mtc0	t1, CP0_STATUS
+
+#ifdef CONFIG_64BIT
+	/* set the full wired TLBs needed for mapped kernel */
+	jal	nlm_setup_wired_tlbs
+	nop
+#endif
+
 	PTR_LA	t1, nlm_next_sp
 	PTR_L	sp, 0(t1)
 	PTR_LA	t1, nlm_next_gp
@@ -136,8 +144,12 @@ NESTED(nlm_rmiboot_preboot, 16, sp)
 	or	t1, t2, v1	/* put in new value */
 	mtcr	t1, t0		/* update core control */
 
+1:
+	/* mapped first wired TLB for mapped kernel */
+	kernel_entry_setup
+
 	/* wait for NMI to hit */
-1:	wait
-	b	1b
+2:	wait
+	b	2b
 	nop
 END(nlm_rmiboot_preboot)
diff --git a/arch/mips/netlogic/xlr/wakeup.c b/arch/mips/netlogic/xlr/wakeup.c
index d61cba1..4ed5204 100644
--- a/arch/mips/netlogic/xlr/wakeup.c
+++ b/arch/mips/netlogic/xlr/wakeup.c
@@ -53,6 +53,7 @@ int xlr_wakeup_secondary_cpus(void)
 	struct nlm_soc_info *nodep;
 	unsigned int i, j, boot_cpu;
 	volatile u32 *cpu_ready = nlm_get_boot_data(BOOT_CPU_READY);
+	void *handler;
 
 	/*
 	 *  In case of RMI boot, hit with NMI to get the cores
@@ -60,7 +61,11 @@ int xlr_wakeup_secondary_cpus(void)
 	 */
 	nodep = nlm_get_node(0);
 	boot_cpu = hard_smp_processor_id();
-	nlm_set_nmi_handler(nlm_rmiboot_preboot);
+	handler = nlm_rmiboot_preboot;
+#ifdef CONFIG_MAPPED_KERNEL
+	handler = (void *)CKSEG0ADDR((long)handler);
+#endif
+	nlm_set_nmi_handler(handler);
 	for (i = 0; i < NR_CPUS; i++) {
 		if (i == boot_cpu || !cpumask_test_cpu(i, &nlm_cpumask))
 			continue;
-- 
1.7.9.5
