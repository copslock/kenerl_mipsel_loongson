Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 17:19:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48491 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824782Ab3FZPS4nWBZB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 17:18:56 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5QFIsMf010658;
        Wed, 26 Jun 2013 17:18:54 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5QFIsEo010657;
        Wed, 26 Jun 2013 17:18:54 +0200
Date:   Wed, 26 Jun 2013 17:18:54 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Tony Wu <tung7970@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add missing cpu_has_mips_1 guardian
Message-ID: <20130626151854.GC7171@linux-mips.org>
References: <20130621110301.GA23195@hades.local>
 <20130626143115.GA7171@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130626143115.GA7171@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37135
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

On Wed, Jun 26, 2013 at 04:31:16PM +0200, Ralf Baechle wrote:

> cpu_has_mips_1 will always evaluate as MIPS I because later ISA revisions
> always contain MIPS I as a subset.  So maybe we should rather remove
> cpu_has_mips_1 and MIPS_CPU_ISA_I entirely.  The sole user of cpu_has_mips_1,
> proc.c could easily be cleaned up, the sole test for MIPS_CPU_ISA_I in
> traps.c is slightly more work to clean up because it really is a test for
> the cp0 architecture.

So I propose below patch instead.

  Ralf

MIPS: Get rid of MIPS I flag and test macros.

MIPS I is the ancestor of all MIPS ISA and architecture variants.  Anything
ever build in the MIPS empire is either MIPS I or at least contains MIPS I.
If it's running Linus, that is.

So there is little point in having cpu_has_mips_1 because it will always
evaluate as true - though usually only at runtime.  Thus there is no
point in having the MIPS_CPU_ISA_I ISA flag, so get rid of it.

Little complication: traps.c: was using a test for a pure MIPS I ISA as
a test for an R3000-style cp0.  To deal with that, use a check for
cpu_has_3kex or cpu_has_4kex instead.

cpu_has_3kex is a new macro.  At the moment its default implementation is
!cpu_has_4kex but this may eventually change if Linux is ever going to
support the oddball MIPS processors R6000 and R8000 so users of either
of these macros should not make any assumptions.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/include/asm/cpu-features.h | 11 ++++++++++-
 arch/mips/include/asm/cpu.h          | 23 +++++++++++------------
 arch/mips/kernel/cpu-probe.c         |  8 +-------
 arch/mips/kernel/proc.c              |  4 +---
 arch/mips/kernel/traps.c             |  4 ++--
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index e5ec8fc..9609812 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -24,6 +24,16 @@
 #ifndef cpu_has_tlb
 #define cpu_has_tlb		(cpu_data[0].options & MIPS_CPU_TLB)
 #endif
+
+/*
+ * For the moment we don't consider R6000 and R8000 so we can assume that
+ * anything that doesn't support R4000-style exceptions and interrupts is
+ * R3000-like.  Users should still treat these two macro definitions as
+ * opaque.
+ */
+#ifndef cpu_has_3kex
+#define cpu_has_3kex		(!cpu_has_4kex)
+#endif
 #ifndef cpu_has_4kex
 #define cpu_has_4kex		(cpu_data[0].options & MIPS_CPU_4KEX)
 #endif
@@ -136,7 +146,6 @@
 #endif
 #endif
 
-# define cpu_has_mips_1		(cpu_data[0].isa_level & MIPS_CPU_ISA_I)
 #ifndef cpu_has_mips_2
 # define cpu_has_mips_2		(cpu_data[0].isa_level & MIPS_CPU_ISA_II)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index dd86ab2..632bbe5 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -282,18 +282,17 @@ enum cpu_type_enum {
  * ISA Level encodings
  *
  */
-#define MIPS_CPU_ISA_I		0x00000001
-#define MIPS_CPU_ISA_II		0x00000002
-#define MIPS_CPU_ISA_III	0x00000004
-#define MIPS_CPU_ISA_IV		0x00000008
-#define MIPS_CPU_ISA_V		0x00000010
-#define MIPS_CPU_ISA_M32R1	0x00000020
-#define MIPS_CPU_ISA_M32R2	0x00000040
-#define MIPS_CPU_ISA_M64R1	0x00000080
-#define MIPS_CPU_ISA_M64R2	0x00000100
-
-#define MIPS_CPU_ISA_32BIT (MIPS_CPU_ISA_I | MIPS_CPU_ISA_II | \
-	MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M32R2)
+#define MIPS_CPU_ISA_II		0x00000001
+#define MIPS_CPU_ISA_III	0x00000002
+#define MIPS_CPU_ISA_IV		0x00000004
+#define MIPS_CPU_ISA_V		0x00000008
+#define MIPS_CPU_ISA_M32R1	0x00000010
+#define MIPS_CPU_ISA_M32R2	0x00000020
+#define MIPS_CPU_ISA_M64R1	0x00000040
+#define MIPS_CPU_ISA_M64R2	0x00000080
+
+#define MIPS_CPU_ISA_32BIT (MIPS_CPU_ISA_II | MIPS_CPU_ISA_M32R1 | \
+	MIPS_CPU_ISA_M32R2)
 #define MIPS_CPU_ISA_64BIT (MIPS_CPU_ISA_III | MIPS_CPU_ISA_IV | \
 	MIPS_CPU_ISA_V | MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2)
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c6568bf..04892ec 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -146,8 +146,7 @@ static void __cpuinit set_isa(struct cpuinfo_mips *c, unsigned int isa)
 	case MIPS_CPU_ISA_IV:
 		c->isa_level |= MIPS_CPU_ISA_IV;
 	case MIPS_CPU_ISA_III:
-		c->isa_level |= MIPS_CPU_ISA_I | MIPS_CPU_ISA_II |
-				MIPS_CPU_ISA_III;
+		c->isa_level |= MIPS_CPU_ISA_II | MIPS_CPU_ISA_III;
 		break;
 
 	case MIPS_CPU_ISA_M32R2:
@@ -156,8 +155,6 @@ static void __cpuinit set_isa(struct cpuinfo_mips *c, unsigned int isa)
 		c->isa_level |= MIPS_CPU_ISA_M32R1;
 	case MIPS_CPU_ISA_II:
 		c->isa_level |= MIPS_CPU_ISA_II;
-	case MIPS_CPU_ISA_I:
-		c->isa_level |= MIPS_CPU_ISA_I;
 		break;
 	}
 }
@@ -332,7 +329,6 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_R2000:
 		c->cputype = CPU_R2000;
 		__cpu_name[cpu] = "R2000";
-		set_isa(c, MIPS_CPU_ISA_I);
 		c->options = MIPS_CPU_TLB | MIPS_CPU_3K_CACHE |
 			     MIPS_CPU_NOFPUEX;
 		if (__cpu_has_fpu())
@@ -352,7 +348,6 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			c->cputype = CPU_R3000;
 			__cpu_name[cpu] = "R3000";
 		}
-		set_isa(c, MIPS_CPU_ISA_I);
 		c->options = MIPS_CPU_TLB | MIPS_CPU_3K_CACHE |
 			     MIPS_CPU_NOFPUEX;
 		if (__cpu_has_fpu())
@@ -455,7 +450,6 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		break;
 	#endif
 	case PRID_IMP_TX39:
-		set_isa(c, MIPS_CPU_ISA_I);
 		c->options = MIPS_CPU_TLB | MIPS_CPU_TX39_CACHE;
 
 		if ((c->processor_id & 0xf0) == (PRID_REV_TX3927 & 0xf0)) {
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index acb3437..8c58d8a 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -66,9 +66,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "]\n");
 	}
 	if (cpu_has_mips_r) {
-		seq_printf(m, "isa\t\t\t:");
-		if (cpu_has_mips_1)
-			seq_printf(m, "%s", " mips1");
+		seq_printf(m, "isa\t\t\t: mips1");
 		if (cpu_has_mips_2)
 			seq_printf(m, "%s", " mips2");
 		if (cpu_has_mips_3)
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index beba1e6..068d5ff 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -265,7 +265,7 @@ static void __show_regs(const struct pt_regs *regs)
 
 	printk("Status: %08x	", (uint32_t) regs->cp0_status);
 
-	if (current_cpu_data.isa_level == MIPS_CPU_ISA_I) {
+	if (cpu_has_3kex) {
 		if (regs->cp0_status & ST0_KUO)
 			printk("KUo ");
 		if (regs->cp0_status & ST0_IEO)
@@ -278,7 +278,7 @@ static void __show_regs(const struct pt_regs *regs)
 			printk("KUc ");
 		if (regs->cp0_status & ST0_IEC)
 			printk("IEc ");
-	} else {
+	} else if (cpu_has_4kex) {
 		if (regs->cp0_status & ST0_KX)
 			printk("KX ");
 		if (regs->cp0_status & ST0_SX)
