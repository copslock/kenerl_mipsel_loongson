Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 17:58:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46946 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824764Ab3IQP6Kjj5NK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Sep 2013 17:58:10 +0200
Date:   Tue, 17 Sep 2013 16:58:10 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [MIPS] CP0 PRId and CP1 FPIR register access masks
Message-ID: <alpine.LFD.2.03.1309171641260.5967@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Replace hardcoded CP0 PRId and CP1 FPIR register access masks throughout.  
The change does not touch places that use shifted or partial masks.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 Please apply.  I think the places ignored by this change should be 
further reviewed, especially the shifted masks that can likely remove the 
shifts and rely on compiler optimisation instead.  I decided to make this 
change as straightforward as possible to avoid accidental breakage in code 
I have no way to test.  Also partial masks are probably better handled 
with macros rather than hardcoded constants scattered throughout.  I can 
see steps have been taken towards this already (PRID_REV_ENCODE_*).

  Maciej

linux-mips-prid-masks.patch
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/alchemy/common/usb.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/alchemy/common/usb.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/alchemy/common/usb.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
+#include <asm/cpu.h>
 #include <asm/mach-au1x00/au1000.h>
 
 /* control register offsets */
@@ -358,7 +359,7 @@ static inline int au1200_coherency_bug(v
 {
 #if defined(CONFIG_DMA_COHERENT)
 	/* Au1200 AB USB does not support coherent memory */
-	if (!(read_c0_prid() & 0xff)) {
+	if (!(read_c0_prid() & PRID_REV_MASK)) {
 		printk(KERN_INFO "Au1200 USB: this is chip revision AB !!\n");
 		printk(KERN_INFO "Au1200 USB: update your board or re-configure"
 				 " the kernel\n");
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/bcm63xx/cpu.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/bcm63xx/cpu.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/bcm63xx/cpu.c
@@ -306,14 +306,14 @@ void __init bcm63xx_cpu_init(void)
 
 	switch (c->cputype) {
 	case CPU_BMIPS3300:
-		if ((read_c0_prid() & 0xff00) != PRID_IMP_BMIPS3300_ALT)
+		if ((read_c0_prid() & PRID_IMP_MASK) != PRID_IMP_BMIPS3300_ALT)
 			__cpu_name[cpu] = "Broadcom BCM6338";
 		/* fall-through */
 	case CPU_BMIPS32:
 		chipid_reg = BCM_6345_PERF_BASE;
 		break;
 	case CPU_BMIPS4350:
-		switch ((read_c0_prid() & 0xff)) {
+		switch ((read_c0_prid() & PRID_REV_MASK)) {
 		case 0x04:
 			chipid_reg = BCM_3368_PERF_BASE;
 			break;
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/include/asm/cpu.h
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/include/asm/cpu.h
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/include/asm/cpu.h
@@ -3,15 +3,14 @@
  *	  various MIPS cpu types.
  *
  * Copyright (C) 1996 David S. Miller (davem@davemloft.net)
- * Copyright (C) 2004  Maciej W. Rozycki
+ * Copyright (C) 2004, 2013  Maciej W. Rozycki
  */
 #ifndef _ASM_CPU_H
 #define _ASM_CPU_H
 
-/* Assigned Company values for bits 23:16 of the PRId Register
-   (CP0 register 15, select 0).	 As of the MIPS32 and MIPS64 specs from
-   MTI, the PRId register is defined in this (backwards compatible)
-   way:
+/*
+   As of the MIPS32 and MIPS64 specs from MTI, the PRId register (CP0
+   register 15, select 0) is defined in this (backwards compatible) way:
 
   +----------------+----------------+----------------+----------------+
   | Company Options| Company ID	    | Processor ID   | Revision	      |
@@ -23,6 +22,14 @@
    spec.
 */
 
+#define PRID_OPT_MASK		0xff000000
+
+/*
+ * Assigned Company values for bits 23:16 of the PRId register.
+ */
+
+#define PRID_COMP_MASK		0xff0000
+
 #define PRID_COMP_LEGACY	0x000000
 #define PRID_COMP_MIPS		0x010000
 #define PRID_COMP_BROADCOM	0x020000
@@ -38,10 +45,17 @@
 #define PRID_COMP_INGENIC	0xd00000
 
 /*
- * Assigned values for the product ID register.	 In order to detect a
- * certain CPU type exactly eventually additional registers may need to
- * be examined.	 These are valid when 23:16 == PRID_COMP_LEGACY
+ * Assigned Processor ID (implementation) values for bits 15:8 of the PRId
+ * register.  In order to detect a certain CPU type exactly eventually
+ * additional registers may need to be examined.
+ */
+
+#define PRID_IMP_MASK		0xff00
+
+/*
+ * These are valid when 23:16 == PRID_COMP_LEGACY
  */
+
 #define PRID_IMP_R2000		0x0100
 #define PRID_IMP_AU1_REV1	0x0100
 #define PRID_IMP_AU1_REV2	0x0200
@@ -182,11 +196,15 @@
 #define PRID_IMP_NETLOGIC_XLP2XX	0x1200
 
 /*
- * Definitions for 7:0 on legacy processors
+ * Particular Revision values for bits 7:0 of the PRId register.
  */
 
 #define PRID_REV_MASK		0x00ff
 
+/*
+ * Definitions for 7:0 on legacy processors
+ */
+
 #define PRID_REV_TX4927		0x0022
 #define PRID_REV_TX4937		0x0030
 #define PRID_REV_R4400		0x0040
@@ -227,6 +245,8 @@
  *  31				   16 15	     8 7	      0
  */
 
+#define FPIR_IMP_MASK		0xff00
+
 #define FPIR_IMP_NONE		0x0000
 
 enum cpu_type_enum {
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/include/asm/mach-au1x00/au1000.h
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/include/asm/mach-au1x00/au1000.h
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -43,6 +43,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 
+#include <asm/cpu.h>
+
 /* cpu pipeline flush */
 void static inline au_sync(void)
 {
@@ -140,7 +142,7 @@ static inline int au1xxx_cpu_needs_confi
 
 static inline int alchemy_get_cputype(void)
 {
-	switch (read_c0_prid() & 0xffff0000) {
+	switch (read_c0_prid() & (PRID_OPT_MASK | PRID_COMP_MASK)) {
 	case 0x00030000:
 		return ALCHEMY_CPU_AU1000;
 		break;
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/kernel/cpu-probe.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/kernel/cpu-probe.c
@@ -122,7 +122,7 @@ static inline unsigned long cpu_get_fpu_
  */
 static inline int __cpu_has_fpu(void)
 {
-	return ((cpu_get_fpu_id() & 0xff00) != FPIR_IMP_NONE);
+	return ((cpu_get_fpu_id() & FPIR_IMP_MASK) != FPIR_IMP_NONE);
 }
 
 static inline void cpu_probe_vmbits(struct cpuinfo_mips *c)
@@ -322,7 +322,7 @@ static void decode_configs(struct cpuinf
 
 static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 {
-	switch (c->processor_id & 0xff00) {
+	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_R2000:
 		c->cputype = CPU_R2000;
 		__cpu_name[cpu] = "R2000";
@@ -333,7 +333,7 @@ static inline void cpu_probe_legacy(stru
 		c->tlbsize = 64;
 		break;
 	case PRID_IMP_R3000:
-		if ((c->processor_id & 0xff) == PRID_REV_R3000A) {
+		if ((c->processor_id & PRID_REV_MASK) == PRID_REV_R3000A) {
 			if (cpu_has_confreg()) {
 				c->cputype = CPU_R3081E;
 				__cpu_name[cpu] = "R3081";
@@ -353,7 +353,8 @@ static inline void cpu_probe_legacy(stru
 		break;
 	case PRID_IMP_R4000:
 		if (read_c0_config() & CONF_SC) {
-			if ((c->processor_id & 0xff) >= PRID_REV_R4400) {
+			if ((c->processor_id & PRID_REV_MASK) >=
+			    PRID_REV_R4400) {
 				c->cputype = CPU_R4400PC;
 				__cpu_name[cpu] = "R4400PC";
 			} else {
@@ -361,7 +362,8 @@ static inline void cpu_probe_legacy(stru
 				__cpu_name[cpu] = "R4000PC";
 			}
 		} else {
-			if ((c->processor_id & 0xff) >= PRID_REV_R4400) {
+			if ((c->processor_id & PRID_REV_MASK) >=
+			    PRID_REV_R4400) {
 				c->cputype = CPU_R4400SC;
 				__cpu_name[cpu] = "R4400SC";
 			} else {
@@ -454,7 +456,7 @@ static inline void cpu_probe_legacy(stru
 			__cpu_name[cpu] = "TX3927";
 			c->tlbsize = 64;
 		} else {
-			switch (c->processor_id & 0xff) {
+			switch (c->processor_id & PRID_REV_MASK) {
 			case PRID_REV_TX3912:
 				c->cputype = CPU_TX3912;
 				__cpu_name[cpu] = "TX3912";
@@ -640,7 +642,7 @@ static inline void cpu_probe_legacy(stru
 static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_4KC:
 		c->cputype = CPU_4KC;
 		__cpu_name[cpu] = "MIPS 4Kc";
@@ -711,7 +713,7 @@ static inline void cpu_probe_mips(struct
 static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_AU1_REV1:
 	case PRID_IMP_AU1_REV2:
 		c->cputype = CPU_ALCHEMY;
@@ -730,7 +732,7 @@ static inline void cpu_probe_alchemy(str
 			break;
 		case 4:
 			__cpu_name[cpu] = "Au1200";
-			if ((c->processor_id & 0xff) == 2)
+			if ((c->processor_id & PRID_REV_MASK) == 2)
 				__cpu_name[cpu] = "Au1250";
 			break;
 		case 5:
@@ -748,12 +750,12 @@ static inline void cpu_probe_sibyte(stru
 {
 	decode_configs(c);
 
-	switch (c->processor_id & 0xff00) {
+	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_SB1:
 		c->cputype = CPU_SB1;
 		__cpu_name[cpu] = "SiByte SB1";
 		/* FPU in pass1 is known to have issues. */
-		if ((c->processor_id & 0xff) < 0x02)
+		if ((c->processor_id & PRID_REV_MASK) < 0x02)
 			c->options &= ~(MIPS_CPU_FPU | MIPS_CPU_32FPR);
 		break;
 	case PRID_IMP_SB1A:
@@ -766,7 +768,7 @@ static inline void cpu_probe_sibyte(stru
 static inline void cpu_probe_sandcraft(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_SR71000:
 		c->cputype = CPU_SR71000;
 		__cpu_name[cpu] = "Sandcraft SR71000";
@@ -779,7 +781,7 @@ static inline void cpu_probe_sandcraft(s
 static inline void cpu_probe_nxp(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_PR4450:
 		c->cputype = CPU_PR4450;
 		__cpu_name[cpu] = "Philips PR4450";
@@ -791,7 +793,7 @@ static inline void cpu_probe_nxp(struct 
 static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_BMIPS32_REV4:
 	case PRID_IMP_BMIPS32_REV8:
 		c->cputype = CPU_BMIPS32;
@@ -806,7 +808,7 @@ static inline void cpu_probe_broadcom(st
 		set_elf_platform(cpu, "bmips3300");
 		break;
 	case PRID_IMP_BMIPS43XX: {
-		int rev = c->processor_id & 0xff;
+		int rev = c->processor_id & PRID_REV_MASK;
 
 		if (rev >= PRID_REV_BMIPS4380_LO &&
 				rev <= PRID_REV_BMIPS4380_HI) {
@@ -832,7 +834,7 @@ static inline void cpu_probe_broadcom(st
 static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_CAVIUM_CN38XX:
 	case PRID_IMP_CAVIUM_CN31XX:
 	case PRID_IMP_CAVIUM_CN30XX:
@@ -875,7 +877,7 @@ static inline void cpu_probe_ingenic(str
 	decode_configs(c);
 	/* JZRISC does not implement the CP0 counter. */
 	c->options &= ~MIPS_CPU_COUNTER;
-	switch (c->processor_id & 0xff00) {
+	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_JZRISC:
 		c->cputype = CPU_JZRISC;
 		__cpu_name[cpu] = "Ingenic JZRISC";
@@ -890,7 +892,7 @@ static inline void cpu_probe_netlogic(st
 {
 	decode_configs(c);
 
-	if ((c->processor_id & 0xff00) == PRID_IMP_NETLOGIC_AU13XX) {
+	if ((c->processor_id & PRID_IMP_MASK) == PRID_IMP_NETLOGIC_AU13XX) {
 		c->cputype = CPU_ALCHEMY;
 		__cpu_name[cpu] = "Au1300";
 		/* following stuff is not for Alchemy */
@@ -905,7 +907,7 @@ static inline void cpu_probe_netlogic(st
 			MIPS_CPU_EJTAG	 |
 			MIPS_CPU_LLSC);
 
-	switch (c->processor_id & 0xff00) {
+	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_NETLOGIC_XLP2XX:
 		c->cputype = CPU_XLP;
 		__cpu_name[cpu] = "Broadcom XLPII";
@@ -984,7 +986,7 @@ void cpu_probe(void)
 	c->cputype	= CPU_UNKNOWN;
 
 	c->processor_id = read_c0_prid();
-	switch (c->processor_id & 0xff0000) {
+	switch (c->processor_id & PRID_COMP_MASK) {
 	case PRID_COMP_LEGACY:
 		cpu_probe_legacy(c, cpu);
 		break;
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/mm/c-r4k.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/mm/c-r4k.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/mm/c-r4k.c
@@ -786,12 +786,12 @@ static inline void alias_74k_erratum(str
 	 * aliases. In this case it is better to treat the cache as always
 	 * having aliases.
 	 */
-	if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
+	if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_ENCODE_332(2, 4, 0))
 		c->dcache.flags |= MIPS_CACHE_VTAG;
-	if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
+	if ((c->processor_id & PRID_REV_MASK) == PRID_REV_ENCODE_332(2, 4, 0))
 		write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
-	if (((c->processor_id & 0xff00) == PRID_IMP_1074K) &&
-	    ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0))) {
+	if ((c->processor_id & PRID_IMP_MASK) == PRID_IMP_1074K &&
+	    (c->processor_id & PRID_REV_MASK) <= PRID_REV_ENCODE_332(1, 1, 0)) {
 		c->dcache.flags |= MIPS_CACHE_VTAG;
 		write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
 	}
@@ -1025,7 +1025,8 @@ static void probe_pcache(void)
 	 * presumably no vendor is shipping his hardware in the "bad"
 	 * configuration.
 	 */
-	if ((prid & 0xff00) == PRID_IMP_R4000 && (prid & 0xff) < 0x40 &&
+	if ((prid & PRID_IMP_MASK) == PRID_IMP_R4000 &&
+	    (prid & PRID_REV_MASK) < PRID_REV_R4400 &&
 	    !(config & CONF_SC) && c->icache.linesz != 16 &&
 	    PAGE_SIZE <= 0x8000)
 		panic("Improper R4000SC processor configuration detected");
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/mti-malta/malta-time.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/mti-malta/malta-time.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/mti-malta/malta-time.c
@@ -27,6 +27,7 @@
 #include <linux/timex.h>
 #include <linux/mc146818rtc.h>
 
+#include <asm/cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/hardirq.h>
@@ -76,7 +77,7 @@ static void __init estimate_frequencies(
 #endif
 
 #if defined (CONFIG_KVM_GUEST) && defined (CONFIG_KVM_HOST_FREQ)
-	unsigned int prid = read_c0_prid() & 0xffff00;
+	unsigned int prid = read_c0_prid() & (PRID_COMP_MASK | PRID_IMP_MASK);
 
 	/*
 	 * XXXKYMA: hardwire the CPU frequency to Host Freq/4
@@ -169,7 +170,7 @@ unsigned int get_c0_compare_int(void)
 
 void __init plat_time_init(void)
 {
-	unsigned int prid = read_c0_prid() & 0xffff00;
+	unsigned int prid = read_c0_prid() & (PRID_COMP_MASK | PRID_IMP_MASK);
 	unsigned int freq;
 
 	estimate_frequencies();
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/mti-sead3/sead3-time.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/mti-sead3/sead3-time.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/mti-sead3/sead3-time.c
@@ -7,6 +7,7 @@
  */
 #include <linux/init.h>
 
+#include <asm/cpu.h>
 #include <asm/setup.h>
 #include <asm/time.h>
 #include <asm/irq.h>
@@ -34,7 +35,7 @@ static void __iomem *status_reg = (void 
  */
 static unsigned int __init estimate_cpu_frequency(void)
 {
-	unsigned int prid = read_c0_prid() & 0xffff00;
+	unsigned int prid = read_c0_prid() & (PRID_COMP_MASK | PRID_IMP_MASK);
 	unsigned int tick = 0;
 	unsigned int freq;
 	unsigned int orig;
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/netlogic/xlr/fmn-config.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/netlogic/xlr/fmn-config.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/netlogic/xlr/fmn-config.c
@@ -36,6 +36,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 
+#include <asm/cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/netlogic/xlr/fmn.h>
 #include <asm/netlogic/xlr/xlr.h>
@@ -187,7 +188,7 @@ void xlr_board_info_setup(void)
 	int processor_id, num_core;
 
 	num_core = hweight32(nlm_current_node()->coremask);
-	processor_id = read_c0_prid() & 0xff00;
+	processor_id = read_c0_prid() & PRID_IMP_MASK;
 
 	setup_cpu_fmninfo(cpu, num_core);
 	switch (processor_id) {
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/sibyte/bcm1480/setup.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/sibyte/bcm1480/setup.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/sibyte/bcm1480/setup.c
@@ -22,6 +22,7 @@
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
+#include <asm/cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/io.h>
 #include <asm/sibyte/sb1250.h>
@@ -119,7 +120,7 @@ void __init bcm1480_setup(void)
 	uint64_t sys_rev;
 	int plldiv;
 
-	sb1_pass = read_c0_prid() & 0xff;
+	sb1_pass = read_c0_prid() & PRID_REV_MASK;
 	sys_rev = __raw_readq(IOADDR(A_SCD_SYSTEM_REVISION));
 	soc_type = SYS_SOC_TYPE(sys_rev);
 	part_type = G_SYS_PART(sys_rev);
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/sibyte/sb1250/setup.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/sibyte/sb1250/setup.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/sibyte/sb1250/setup.c
@@ -22,6 +22,7 @@
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
+#include <asm/cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/io.h>
 #include <asm/sibyte/sb1250.h>
@@ -182,7 +183,7 @@ void __init sb1250_setup(void)
 	int plldiv;
 	int bad_config = 0;
 
-	sb1_pass = read_c0_prid() & 0xff;
+	sb1_pass = read_c0_prid() & PRID_REV_MASK;
 	sys_rev = __raw_readq(IOADDR(A_SCD_SYSTEM_REVISION));
 	soc_type = SYS_SOC_TYPE(sys_rev);
 	soc_pass = G_SYS_REVISION(sys_rev);
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/sni/setup.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/sni/setup.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/sni/setup.c
@@ -25,6 +25,7 @@
 #endif
 
 #include <asm/bootinfo.h>
+#include <asm/cpu.h>
 #include <asm/io.h>
 #include <asm/reboot.h>
 #include <asm/sni.h>
@@ -173,7 +174,7 @@ void __init plat_mem_setup(void)
 		system_type = "RM300-Cxx";
 		break;
 	case SNI_BRD_PCI_DESKTOP:
-		switch (read_c0_prid() & 0xff00) {
+		switch (read_c0_prid() & PRID_IMP_MASK) {
 		case PRID_IMP_R4600:
 		case PRID_IMP_R4700:
 			system_type = "RM200-C20";
