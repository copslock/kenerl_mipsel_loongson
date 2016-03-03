Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2016 02:48:51 +0100 (CET)
Received: from smtpproxy19.qq.com ([184.105.206.84]:53594 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007622AbcCCBspfVecl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Mar 2016 02:48:45 +0100
X-QQ-mid: bizesmtp1t1456969695t104t167
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 03 Mar 2016 09:47:20 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK70B00A0000000
X-QQ-FEAT: EmmLG+1XAgor/tU8tUI2/RpalxvE2TJZwwtpAEPmaCtbPSxL4gEcroD5IqW1g
        a+ikUerUJuMx30p66r+iQmR0qlGn3dlRZJWAD32kvHJeGSxTuytECDVL1Lhtgvwdwh1Lb+1
        GbeOM9+TnAi0luTMYPoAqUI6977rZjBmNf5nm0JK7JooRP37f1JgpIEb94S59Lg94qh0ZB3
        43hqB8YDvJCn0io+B567b6o8WoAH0zlIy8Dp0gAiTZyChwcovovjfZkBOOJZLrQgQSC81uu
        pXvG7rGbhyqJC8kjzdN1sj0DI=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V6 4/5] MIPS: Loongson-3: Fast TLB refill handler
Date:   Thu,  3 Mar 2016 09:45:12 +0800
Message-Id: <1456969513-1683-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456969513-1683-1-git-send-email-chenhc@lemote.com>
References: <1456969513-1683-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Loongson-3A R2 has pwbase/pwfield/pwsize/pwctl registers in CP0 (this
is very similar to HTW) and lwdir/lwpte/lddir/ldpte instructions which
can be used for fast TLB refill.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu-features.h |   3 +
 arch/mips/include/asm/cpu.h          |   1 +
 arch/mips/include/asm/mipsregs.h     |   6 ++
 arch/mips/include/asm/uasm.h         |   3 +-
 arch/mips/include/uapi/asm/inst.h    |  10 +++
 arch/mips/kernel/cpu-probe.c         |   2 +-
 arch/mips/mm/tlbex.c                 | 124 ++++++++++++++++++++++++++++++++++-
 arch/mips/mm/uasm-mips.c             |   2 +
 arch/mips/mm/uasm.c                  |   3 +
 9 files changed, 149 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index eeec8c8..e0ba50a 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -35,6 +35,9 @@
 #ifndef cpu_has_htw
 #define cpu_has_htw		(cpu_data[0].options & MIPS_CPU_HTW)
 #endif
+#ifndef cpu_has_ldpte
+#define cpu_has_ldpte		(cpu_data[0].options & MIPS_CPU_LDPTE)
+#endif
 #ifndef cpu_has_rixiex
 #define cpu_has_rixiex		(cpu_data[0].options & MIPS_CPU_RIXIEX)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 68807b8..67bbff5 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -392,6 +392,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_FTLB		0x20000000000ull /* CPU has Fixed-page-size TLB */
 #define MIPS_CPU_NAN_LEGACY	0x40000000000ull /* Legacy NaN implemented */
 #define MIPS_CPU_NAN_2008	0x80000000000ull /* 2008 NaN implemented */
+#define MIPS_CPU_LDPTE		0x100000000000ull /* CPU has ldpte/lddir instructions */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index e41e9d9..35f9eaa 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1453,6 +1453,12 @@ do {									\
 #define read_c0_pwctl()		__read_32bit_c0_register($6, 6)
 #define write_c0_pwctl(val)	__write_32bit_c0_register($6, 6, val)
 
+#define read_c0_pgd()		__read_64bit_c0_register($9, 7)
+#define write_c0_pgd(val)	__write_64bit_c0_register($9, 7, val)
+
+#define read_c0_kpgd()		__read_64bit_c0_register($31, 7)
+#define write_c0_kpgd(val)	__write_64bit_c0_register($31, 7, val)
+
 /* Cavium OCTEON (cnMIPS) */
 #define read_c0_cvmcount()	__read_ulong_c0_register($9, 6)
 #define write_c0_cvmcount(val)	__write_ulong_c0_register($9, 6, val)
diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index fc1cdd2..b6ecfee 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -171,7 +171,8 @@ Ip_u2u1(_wsbh);
 Ip_u3u1u2(_xor);
 Ip_u2u1u3(_xori);
 Ip_u2u1(_yield);
-
+Ip_u1u2(_ldpte);
+Ip_u2u1u3(_lddir);
 
 /* Handle labels. */
 struct uasm_label {
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index ddea53e..3bb8cd9 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -204,6 +204,16 @@ enum mad_func {
 };
 
 /*
+ * func field for page table walker (Loongson-3).
+ */
+enum ptw_func {
+	lwdir_op = 0x00,
+	lwpte_op = 0x01,
+	lddir_op = 0x02,
+	ldpte_op = 0x03,
+};
+
+/*
  * func field for special3 lx opcodes (Cavium Octeon).
  */
 enum lx_func {
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 1c41f10..51ca958 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1522,7 +1522,7 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		}
 
 		decode_configs(c);
-		c->options |= MIPS_CPU_TLBINV;
+		c->options |= MIPS_CPU_TLBINV | MIPS_CPU_LDPTE;
 		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		break;
 	default:
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index b1a712f..7bc8978 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -284,7 +284,12 @@ static inline void dump_handler(const char *symbol, const u32 *handler, int coun
 #define C0_ENTRYLO1	3, 0
 #define C0_CONTEXT	4, 0
 #define C0_PAGEMASK	5, 0
+#define C0_PWBASE	5, 5
+#define C0_PWFIELD	5, 6
+#define C0_PWSIZE	5, 7
+#define C0_PWCTL	6, 6
 #define C0_BADVADDR	8, 0
+#define C0_PGD		9, 7
 #define C0_ENTRYHI	10, 0
 #define C0_EPC		14, 0
 #define C0_XCONTEXT	20, 0
@@ -808,7 +813,10 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 
 	if (pgd_reg != -1) {
 		/* pgd is in pgd_reg */
-		UASM_i_MFC0(p, ptr, c0_kscratch(), pgd_reg);
+		if (cpu_has_ldpte)
+			UASM_i_MFC0(p, ptr, C0_PWBASE);
+		else
+			UASM_i_MFC0(p, ptr, c0_kscratch(), pgd_reg);
 	} else {
 #if defined(CONFIG_MIPS_PGD_C0_CONTEXT)
 		/*
@@ -1421,6 +1429,108 @@ static void build_r4000_tlb_refill_handler(void)
 	dump_handler("r4000_tlb_refill", (u32 *)ebase, 64);
 }
 
+static void setup_pw(void)
+{
+	unsigned long pgd_i, pgd_w;
+#ifndef __PAGETABLE_PMD_FOLDED
+	unsigned long pmd_i, pmd_w;
+#endif
+	unsigned long pt_i, pt_w;
+	unsigned long pte_i, pte_w;
+#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
+	unsigned long psn;
+
+	psn = ilog2(_PAGE_HUGE);     /* bit used to indicate huge page */
+#endif
+	pgd_i = PGDIR_SHIFT;  /* 1st level PGD */
+#ifndef __PAGETABLE_PMD_FOLDED
+	pgd_w = PGDIR_SHIFT - PMD_SHIFT + PGD_ORDER;
+
+	pmd_i = PMD_SHIFT;    /* 2nd level PMD */
+	pmd_w = PMD_SHIFT - PAGE_SHIFT;
+#else
+	pgd_w = PGDIR_SHIFT - PAGE_SHIFT + PGD_ORDER;
+#endif
+
+	pt_i  = PAGE_SHIFT;    /* 3rd level PTE */
+	pt_w  = PAGE_SHIFT - 3;
+
+	pte_i = ilog2(_PAGE_GLOBAL);
+	pte_w = 0;
+
+#ifndef __PAGETABLE_PMD_FOLDED
+	write_c0_pwfield(pgd_i << 24 | pmd_i << 12 | pt_i << 6 | pte_i);
+	write_c0_pwsize(1 << 30 | pgd_w << 24 | pmd_w << 12 | pt_w << 6 | pte_w);
+#else
+	write_c0_pwfield(pgd_i << 24 | pt_i << 6 | pte_i);
+	write_c0_pwsize(1 << 30 | pgd_w << 24 | pt_w << 6 | pte_w);
+#endif
+
+#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
+	write_c0_pwctl(1 << 6 | psn);
+#endif
+	write_c0_kpgd(swapper_pg_dir);
+	kscratch_used_mask |= (1 << 7); /* KScratch6 is used for KPGD */
+}
+
+static void build_loongson3_tlb_refill_handler(void)
+{
+	u32 *p = tlb_handler;
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
+
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+	memset(tlb_handler, 0, sizeof(tlb_handler));
+
+	if (check_for_high_segbits) {
+		uasm_i_dmfc0(&p, K0, C0_BADVADDR);
+		uasm_i_dsrl_safe(&p, K1, K0, PGDIR_SHIFT + PGD_ORDER + PAGE_SHIFT - 3);
+		uasm_il_beqz(&p, &r, K1, label_vmalloc);
+		uasm_i_nop(&p);
+
+		uasm_il_bgez(&p, &r, K0, label_large_segbits_fault);
+		uasm_i_nop(&p);
+		uasm_l_vmalloc(&l, p);
+	}
+
+	uasm_i_dmfc0(&p, K1, C0_PGD);
+
+	uasm_i_lddir(&p, K0, K1, 3);  /* global page dir */
+#ifndef __PAGETABLE_PMD_FOLDED
+	uasm_i_lddir(&p, K1, K0, 1);  /* middle page dir */
+#endif
+	uasm_i_ldpte(&p, K1, 0);      /* even */
+	uasm_i_ldpte(&p, K1, 1);      /* odd */
+	uasm_i_tlbwr(&p);
+
+	/* restore page mask */
+	if (PM_DEFAULT_MASK >> 16) {
+		uasm_i_lui(&p, K0, PM_DEFAULT_MASK >> 16);
+		uasm_i_ori(&p, K0, K0, PM_DEFAULT_MASK & 0xffff);
+		uasm_i_mtc0(&p, K0, C0_PAGEMASK);
+	} else if (PM_DEFAULT_MASK) {
+		uasm_i_ori(&p, K0, 0, PM_DEFAULT_MASK);
+		uasm_i_mtc0(&p, K0, C0_PAGEMASK);
+	} else {
+		uasm_i_mtc0(&p, 0, C0_PAGEMASK);
+	}
+
+	uasm_i_eret(&p);
+
+	if (check_for_high_segbits) {
+		uasm_l_large_segbits_fault(&l, p);
+		UASM_i_LA(&p, K1, (unsigned long)tlb_do_page_fault_0);
+		uasm_i_jr(&p, K1);
+		uasm_i_nop(&p);
+	}
+
+	uasm_resolve_relocs(relocs, labels);
+	memcpy((void *)(ebase + 0x80), tlb_handler, 0x80);
+	local_flush_icache_range(ebase + 0x80, ebase + 0x100);
+	dump_handler("loongson3_tlb_refill", (u32 *)(ebase + 0x80), 32);
+}
+
 extern u32 handle_tlbl[], handle_tlbl_end[];
 extern u32 handle_tlbs[], handle_tlbs_end[];
 extern u32 handle_tlbm[], handle_tlbm_end[];
@@ -1468,7 +1578,10 @@ static void build_setup_pgd(void)
 	} else {
 		/* PGD in c0_KScratch */
 		uasm_i_jr(&p, 31);
-		UASM_i_MTC0(&p, a0, c0_kscratch(), pgd_reg);
+		if (cpu_has_ldpte)
+			UASM_i_MTC0(&p, a0, C0_PWBASE);
+		else
+			UASM_i_MTC0(&p, a0, c0_kscratch(), pgd_reg);
 	}
 #else
 #ifdef CONFIG_SMP
@@ -2437,13 +2550,18 @@ void build_tlb_refill_handler(void)
 		break;
 
 	default:
+		if (cpu_has_ldpte)
+			setup_pw();
+
 		if (!run_once) {
 			scratch_reg = allocate_kscratch();
 			build_setup_pgd();
 			build_r4000_tlb_load_handler();
 			build_r4000_tlb_store_handler();
 			build_r4000_tlb_modify_handler();
-			if (!cpu_has_local_ebase)
+			if (cpu_has_ldpte)
+				build_loongson3_tlb_refill_handler();
+			else if (!cpu_has_local_ebase)
 				build_r4000_tlb_refill_handler();
 			flush_tlb_handlers();
 			run_once++;
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index b4a83789..9c2220a 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -153,6 +153,8 @@ static struct insn insn_table[] = {
 	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
 	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
 	{ insn_yield, M(spec3_op, 0, 0, 0, 0, yield_op), RS | RD },
+	{ insn_ldpte, M(lwc2_op, 0, 0, 0, ldpte_op, mult_op), RS | RD },
+	{ insn_lddir, M(lwc2_op, 0, 0, 0, lddir_op, mult_op), RS | RT | RD },
 	{ insn_invalid, 0, 0 }
 };
 
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 319051c..ad718de 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -60,6 +60,7 @@ enum opcode {
 	insn_sltiu, insn_sltu, insn_sra, insn_srl, insn_srlv, insn_subu,
 	insn_sw, insn_sync, insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi,
 	insn_tlbwr, insn_wait, insn_wsbh, insn_xor, insn_xori, insn_yield,
+	insn_lddir, insn_ldpte,
 };
 
 struct insn {
@@ -335,6 +336,8 @@ I_u1u2s3(_bbit0);
 I_u1u2s3(_bbit1);
 I_u3u1u2(_lwx)
 I_u3u1u2(_ldx)
+I_u1u2(_ldpte)
+I_u2u1u3(_lddir)
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #include <asm/octeon/octeon.h>
-- 
2.7.0
