Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 18:12:03 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43747 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823043Ab3KGRJ6W1wCE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 18:09:58 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 5/6] MIPS: Add support for FTLBs
Date:   Thu, 7 Nov 2013 17:08:39 +0000
Message-ID: <1383844120-29601-6-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com>
References: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_07_17_09_52
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38483
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

The Fixed Page Size TLB (FTLB) is a set-associative dual entry TLB. Its
purpose is to reduce the number of TLB misses by increasing the effective
TLB size and keep the implementation complexity to minimum levels.
A supported core can have both VTLB and FTLB.

Reviewed-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-info.h |  3 ++
 arch/mips/include/asm/mipsregs.h |  2 +
 arch/mips/include/asm/page.h     | 25 ++++++++++++
 arch/mips/kernel/cpu-probe.c     | 86 ++++++++++++++++++++++++++++++++++++----
 arch/mips/kernel/genex.S         |  1 +
 arch/mips/kernel/traps.c         | 30 ++++++++++++++
 arch/mips/mm/tlb-r4k.c           | 29 ++++++++++----
 7 files changed, 162 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 21c8e29..8f7adf0 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -52,6 +52,9 @@ struct cpuinfo_mips {
 	unsigned int		cputype;
 	int			isa_level;
 	int			tlbsize;
+	int			tlbsizevtlb;
+	int			tlbsizeftlbsets;
+	int			tlbsizeftlbways;
 	struct cache_desc	icache; /* Primary I-cache */
 	struct cache_desc	dcache; /* Primary D or combined I/D cache */
 	struct cache_desc	scache; /* Secondary cache */
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 9cd0e13..303bb46 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -645,6 +645,8 @@
 #define MIPS_CONF5_K		(_ULCAST_(1) << 30)
 
 #define MIPS_CONF6_SYND		(_ULCAST_(1) << 13)
+/* proAptiv FTLB on/off bit */
+#define MIPS_CONF6_FTLBEN	(_ULCAST_(1) << 15)
 
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index f6be474..5e08bcc 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -11,6 +11,8 @@
 
 #include <spaces.h>
 #include <linux/const.h>
+#include <linux/kernel.h>
+#include <asm/mipsregs.h>
 
 /*
  * PAGE_SHIFT determines the page size
@@ -33,6 +35,29 @@
 #define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
 
+/*
+ * This is used for calculating the real page sizes
+ * for FTLB or VTLB + FTLB confugrations.
+ */
+static inline unsigned int page_size_ftlb(unsigned int mmuextdef)
+{
+	switch (mmuextdef) {
+	case MIPS_CONF4_MMUEXTDEF_FTLBSIZEEXT:
+		if (PAGE_SIZE == (1 << 30))
+			return 5;
+		if (PAGE_SIZE == (1llu << 32))
+			return 6;
+		if (PAGE_SIZE > (256 << 10))
+			return 7; /* reserved */
+			/* fall through */
+	case MIPS_CONF4_MMUEXTDEF_VTLBSIZEEXT:
+		return (PAGE_SHIFT - 10) / 2;
+	default:
+		panic("Invalid FTLB configuration with Conf4_mmuextdef=%d value\n",
+		      mmuextdef >> 14);
+	}
+}
+
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 #define HPAGE_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
 #define HPAGE_SIZE	(_AC(1,UL) << HPAGE_SHIFT)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 8168e29..de364ac 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -163,6 +163,26 @@ static void set_isa(struct cpuinfo_mips *c, unsigned int isa)
 static char unknown_isa[] = KERN_ERR \
 	"Unsupported ISA type, c0.config0: %d.";
 
+static void set_ftlb_enable(struct cpuinfo_mips *c, int enable)
+{
+	unsigned int config6;
+	/*
+	 * Config6 is implementation dependent and it's currently only
+	 * used by proAptiv
+	 */
+	if (c->cputype == CPU_PROAPTIV) {
+		config6 = read_c0_config6();
+		if (enable) {
+			pr_info("Enabling FTLB support\n");
+			write_c0_config6(config6 | MIPS_CONF6_FTLBEN);
+		} else {
+			pr_info("Switching FTLB OFF\n");
+			write_c0_config6(config6 &  ~MIPS_CONF6_FTLBEN);
+		}
+		back_to_back_c0_hazard();
+	}
+}
+
 static inline unsigned int decode_config0(struct cpuinfo_mips *c)
 {
 	unsigned int config0;
@@ -170,8 +190,13 @@ static inline unsigned int decode_config0(struct cpuinfo_mips *c)
 
 	config0 = read_c0_config();
 
-	if (((config0 & MIPS_CONF_MT) >> 7) == 1)
+	/*
+	 * Look for Standard TLB or Dual VTLB and FTLB
+	 */
+	if ((((config0 & MIPS_CONF_MT) >> 7) == 1) ||
+	    (((config0 & MIPS_CONF_MT) >> 7) == 4))
 		c->options |= MIPS_CPU_TLB;
+
 	isa = (config0 & MIPS_CONF_AT) >> 13;
 	switch (isa) {
 	case 0:
@@ -226,8 +251,11 @@ static inline unsigned int decode_config1(struct cpuinfo_mips *c)
 		c->options |= MIPS_CPU_FPU;
 		c->options |= MIPS_CPU_32FPR;
 	}
-	if (cpu_has_tlb)
+	if (cpu_has_tlb) {
 		c->tlbsize = ((config1 & MIPS_CONF1_TLBS) >> 25) + 1;
+		c->tlbsizevtlb = c->tlbsize;
+		c->tlbsizeftlbsets = 0;
+	}
 
 	return config1 & MIPS_CONF_M;
 }
@@ -279,18 +307,58 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 static inline unsigned int decode_config4(struct cpuinfo_mips *c)
 {
 	unsigned int config4;
+	unsigned int newcf4;
+	unsigned int mmuextdef;
+	unsigned int ftlb_page = MIPS_CONF4_FTLBPAGESIZE;
 
 	config4 = read_c0_config4();
 
-	if ((config4 & MIPS_CONF4_MMUEXTDEF) == MIPS_CONF4_MMUEXTDEF_MMUSIZEEXT
-	    && cpu_has_tlb)
-		c->tlbsize += (config4 & MIPS_CONF4_MMUSIZEEXT) * 0x40;
-
 	if (cpu_has_tlb) {
 		if (((config4 & MIPS_CONF4_IE) >> 29) == 2) {
 			c->options |= MIPS_CPU_TLBINV;
 			pr_info("TLBINV/F supported, config4=0x%0x\n", config4);
 		}
+		mmuextdef = config4 & MIPS_CONF4_MMUEXTDEF;
+		switch (mmuextdef) {
+		case MIPS_CONF4_MMUEXTDEF_MMUSIZEEXT:
+			c->tlbsize += (config4 & MIPS_CONF4_MMUSIZEEXT) * 0x40;
+			c->tlbsizevtlb = c->tlbsize;
+			pr_info("MMUSizeExt found, total TLB=%d\n", c->tlbsize);
+			break;
+		case MIPS_CONF4_MMUEXTDEF_VTLBSIZEEXT:
+			c->tlbsizevtlb +=
+				((config4 & MIPS_CONF4_VTLBSIZEEXT) >>
+				  MIPS_CONF4_VTLBSIZEEXT_SHIFT) * 0x40;
+			c->tlbsize = c->tlbsizevtlb;
+			ftlb_page = MIPS_CONF4_VFTLBPAGESIZE;
+			/* fall through */
+		case MIPS_CONF4_MMUEXTDEF_FTLBSIZEEXT:
+			newcf4 = (config4 & ~ftlb_page) |
+				(page_size_ftlb(mmuextdef) <<
+				 MIPS_CONF4_FTLBPAGESIZE_SHIFT);
+			write_c0_config4(newcf4);
+			back_to_back_c0_hazard();
+			config4 = read_c0_config4();
+			if (config4 != newcf4) {
+				pr_err("PAGE_SIZE 0x%lx is not supported by FTLB (config4=0x%x)\n",
+				       PAGE_SIZE, config4);
+				/* Switch FTLB off */
+				set_ftlb_enable(c, 0);
+				pr_info("Total TLB(VTLB) in use: %d\n",
+					c->tlbsizevtlb);
+				break;
+			}
+			c->tlbsizeftlbsets = 1 <<
+				((config4 & MIPS_CONF4_FTLBSETS) >>
+				 MIPS_CONF4_FTLBSETS_SHIFT);
+			c->tlbsizeftlbways = ((config4 & MIPS_CONF4_FTLBWAYS) >>
+					      MIPS_CONF4_FTLBWAYS_SHIFT) + 2;
+			c->tlbsize += c->tlbsizeftlbways * c->tlbsizeftlbsets;
+			pr_info("V/FTLB found: VTLB=%d, FTLB sets=%d, ways=%d total TLB=%d\n",
+				c->tlbsizevtlb, c->tlbsizeftlbsets,
+				c->tlbsizeftlbways, c->tlbsize);
+			break;
+		}
 	}
 
 	c->kscratch_mask = (config4 >> 16) & 0xff;
@@ -319,6 +387,9 @@ static void decode_configs(struct cpuinfo_mips *c)
 
 	c->scache.flags = MIPS_CACHE_NOT_PRESENT;
 
+	/* Enable FTLB if present */
+	set_ftlb_enable(c, 1);
+
 	ok = decode_config0(c);			/* Read Config registers.  */
 	BUG_ON(!ok);				/* Arch spec violation!	 */
 	if (ok)
@@ -682,7 +753,6 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 
 static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 {
-	decode_configs(c);
 	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_4KC:
 		c->cputype = CPU_4KC;
@@ -756,6 +826,8 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		break;
 	}
 
+	decode_configs(c);
+
 	spram_config();
 }
 
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 72853aa..bf56ae1 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -476,6 +476,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER ov ov sti silent			/* #12 */
 	BUILD_HANDLER tr tr sti silent			/* #13 */
 	BUILD_HANDLER fpe fpe fpe silent		/* #15 */
+	BUILD_HANDLER ftlb ftlb none silent		/* #16 */
 	BUILD_HANDLER mdmx mdmx sti silent		/* #22 */
 #ifdef	CONFIG_HARDWARE_WATCHPOINTS
 	/*
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cc20415..7541855 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -78,6 +78,7 @@ extern asmlinkage void handle_cpu(void);
 extern asmlinkage void handle_ov(void);
 extern asmlinkage void handle_tr(void);
 extern asmlinkage void handle_fpe(void);
+extern asmlinkage void handle_ftlb(void);
 extern asmlinkage void handle_mdmx(void);
 extern asmlinkage void handle_watch(void);
 extern asmlinkage void handle_mt(void);
@@ -1447,6 +1448,34 @@ asmlinkage void cache_parity_error(void)
 	panic("Can't handle the cache error!");
 }
 
+asmlinkage void do_ftlb(void)
+{
+	const int field = 2 * sizeof(unsigned long);
+	unsigned int reg_val;
+
+	/* For the moment, report the problem and hang. */
+	if (cpu_has_mips_r2 &&
+	    ((current_cpu_data.processor_id && 0xff0000) == PRID_COMP_MIPS)) {
+		pr_err("FTLB error exception, cp0_ecc=0x%08x:\n",
+		       read_c0_ecc());
+		pr_err("cp0_errorepc == %0*lx\n", field, read_c0_errorepc());
+		reg_val = read_c0_cacheerr();
+		pr_err("c0_cacheerr == %08x\n", reg_val);
+
+		if ((reg_val & 0xc0000000) == 0xc0000000) {
+			pr_err("Decoded c0_cacheerr: FTLB parity error\n");
+		} else {
+			pr_err("Decoded c0_cacheerr: %s cache fault in %s reference.\n",
+			       reg_val & (1<<30) ? "secondary" : "primary",
+			       reg_val & (1<<31) ? "data" : "insn");
+		}
+	} else {
+		pr_err("FTLB error exception\n");
+	}
+	/* Just print the cacheerr bits for now */
+	cache_parity_error();
+}
+
 /*
  * SDBBP EJTAG debug exception handler.
  * We skip the instruction and return to the next instruction.
@@ -1996,6 +2025,7 @@ void __init trap_init(void)
 	if (cpu_has_fpu && !cpu_has_nofpuex)
 		set_except_vector(15, handle_fpe);
 
+	set_except_vector(16, handle_ftlb);
 	set_except_vector(22, handle_mdmx);
 
 	if (cpu_has_mcheck)
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 427dcac..11f149c 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -72,7 +72,7 @@ void local_flush_tlb_all(void)
 {
 	unsigned long flags;
 	unsigned long old_ctx;
-	int entry;
+	int entry, ftlbhighset;
 
 	ENTER_CRITICAL(flags);
 	/* Save old context and create impossible VPN2 value */
@@ -83,10 +83,21 @@ void local_flush_tlb_all(void)
 	entry = read_c0_wired();
 
 	/* Blast 'em all away. */
-	if (cpu_has_tlbinv && current_cpu_data.tlbsize) {
-		write_c0_index(0);
-		mtc0_tlbw_hazard();
-		tlbinvf();  /* invalidate VTLB */
+	if (cpu_has_tlbinv) {
+		if (current_cpu_data.tlbsizevtlb) {
+			write_c0_index(0);
+			mtc0_tlbw_hazard();
+			tlbinvf();  /* invalidate VTLB */
+		}
+		ftlbhighset = current_cpu_data.tlbsizevtlb +
+			current_cpu_data.tlbsizeftlbsets;
+		for (entry = current_cpu_data.tlbsizevtlb;
+		     entry < ftlbhighset;
+		     entry++) {
+			write_c0_index(entry);
+			mtc0_tlbw_hazard();
+			tlbinvf();  /* invalide one FTLB set */
+		}
 	} else {
 		while (entry < current_cpu_data.tlbsize) {
 			/* Make sure all entries differ. */
@@ -134,7 +145,9 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		start = round_down(start, PAGE_SIZE << 1);
 		end = round_up(end, PAGE_SIZE << 1);
 		size = (end - start) >> (PAGE_SHIFT + 1);
-		if (size <= current_cpu_data.tlbsize/2) {
+		if (size <= (current_cpu_data.tlbsizeftlbsets ?
+			     current_cpu_data.tlbsize / 8 :
+			     current_cpu_data.tlbsize / 2)) {
 			int oldpid = read_c0_entryhi();
 			int newpid = cpu_asid(cpu, mm);
 
@@ -173,7 +186,9 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	ENTER_CRITICAL(flags);
 	size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
 	size = (size + 1) >> 1;
-	if (size <= current_cpu_data.tlbsize / 2) {
+	if (size <= (current_cpu_data.tlbsizeftlbsets ?
+		     current_cpu_data.tlbsize / 8 :
+		     current_cpu_data.tlbsize / 2)) {
 		int pid = read_c0_entryhi();
 
 		start &= (PAGE_MASK << 1);
-- 
1.8.4
