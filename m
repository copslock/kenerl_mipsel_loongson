Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2010 18:40:34 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:57443 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491143Ab0LYRk1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Dec 2010 18:40:27 +0100
Received: by pzk30 with SMTP id 30so1939180pzk.36
        for <multiple recipients>; Sat, 25 Dec 2010 09:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=7fhv/faPfgGKQnyUi3csjFWpHvAEStvE8QsFfJCL0AY=;
        b=BD37ZFrnwRf/5TXU4G30LoSH5To0iBwa4egwschU5Zy+vY4Wzw0v3xos1tkxgWyC+j
         vqJ3unwar4w8zv/XBMO+qysv4xzr8nwxN3sw2ZKvRWV1GnAyaGogoPTjq81ArrynJmMK
         Dj1HC323LBcnfPZXCLWX6uEM1YC8NBkJMCbI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nUmzsb7LTmRASs1BYuuwPdNDTynXiWA9ar40eWGQ3i/ewWZ/27InqxEjlmOGVDvd7z
         x1w9FOp1mKKRrCO8y8umaqPEDIe8WpXgZApahpKrmzzjeCX3GrMO46fPzJyQ3mz7mMrm
         MuCxguXn8NuREnfKRp3MuT5FJYFWaM/zCzdFU=
Received: by 10.142.134.13 with SMTP id h13mr8365601wfd.315.1293298819550;
        Sat, 25 Dec 2010 09:40:19 -0800 (PST)
Received: from localhost.localdomain ([61.48.57.245])
        by mx.google.com with ESMTPS id v19sm14415197wfh.0.2010.12.25.09.40.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Dec 2010 09:40:17 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [v2 PATCH] MIPS: Add current_cpu_prid() to optimize the code generation
Date:   Sun, 26 Dec 2010 01:40:02 +0800
Message-Id: <1293298802-12727-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

current_cpu_prid(), cpu_prid_comp(), cpu_prid_imp() and cpu_prid_rev()
are added to simplify/beautify the processord_id related code.

And if current_cpu_prid() is pre-encoded for the specific processor in
cpu-feature-overrides.h, the code generation will be optimized.

cpu_prid_encode() and cpu_prid_encode_copt() are added to encode the
current_cpu_prid(), the former one can be used by most of the processors
whose 'Company Options' part of the prid register is 0 or is not used by
any of the existing codes. Or current_cpu_prid() can be simply assigned
as the value of read_c0_prid(), which can be printed by the
show_cpuinfo() defined in arch/mips/kernel/proc.c.

The size of compressed kernel image(vmlinuz) can be reduced about 0.1M
if current_cpu_prid() is pre-defined as a fixed value in
cpu-feature-overrides.h.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/alchemy/common/pci.c                     |    5 +-
 arch/mips/alchemy/common/setup.c                   |    2 +-
 arch/mips/alchemy/devboards/pb1000/board_setup.c   |    5 +-
 arch/mips/bcm63xx/cpu.c                            |    2 +-
 arch/mips/cavium-octeon/setup.c                    |    2 +-
 arch/mips/include/asm/cpu-features.h               |    6 ++-
 arch/mips/include/asm/cpu.h                        |   17 ++++++
 arch/mips/include/asm/mach-au1x00/au1000.h         |    6 +-
 .../asm/mach-loongson/cpu-feature-overrides.h      |   14 +++++
 arch/mips/kernel/cpu-probe.c                       |   56 ++++++++++----------
 arch/mips/kernel/time.c                            |    2 +-
 arch/mips/kernel/traps.c                           |    2 +-
 arch/mips/loongson/common/env.c                    |    4 +-
 arch/mips/loongson/common/platform.c               |    4 +-
 arch/mips/mipssim/sim_time.c                       |    2 +-
 arch/mips/mm/c-r4k.c                               |   19 +++----
 arch/mips/mm/cerr-sb1.c                            |    2 +-
 arch/mips/mm/page.c                                |    5 +--
 arch/mips/mm/tlbex.c                               |    2 +-
 arch/mips/mti-malta/malta-time.c                   |    2 +-
 arch/mips/oprofile/op_model_mipsxx.c               |    2 +-
 arch/mips/pci/pci-vr41xx.c                         |    2 +-
 arch/mips/sgi-ip27/ip27-nmi.c                      |    2 +-
 arch/mips/sibyte/bcm1480/setup.c                   |    2 +-
 arch/mips/sibyte/sb1250/setup.c                    |    2 +-
 arch/mips/sni/setup.c                              |    2 +-
 arch/mips/vr41xx/common/init.c                     |    4 +-
 27 files changed, 99 insertions(+), 76 deletions(-)

diff --git a/arch/mips/alchemy/common/pci.c b/arch/mips/alchemy/common/pci.c
index 7866cf5..e086300 100644
--- a/arch/mips/alchemy/common/pci.c
+++ b/arch/mips/alchemy/common/pci.c
@@ -82,9 +82,8 @@ static int __init au1x_pci_setup(void)
 		/*
 		 *  Set the NC bit in controller for Au1500 pre-AC silicon
 		 */
-		u32 prid = read_c0_prid();
-
-		if ((prid & 0xFF000000) == 0x01000000 && prid < 0x01030202) {
+		if (cpu_prid_copt() == 0x01000000 &&
+		    current_cpu_prid() < 0x01030202) {
 			au_writel((1 << 16) | au_readl(Au1500_PCI_CFG),
 				  Au1500_PCI_CFG);
 			printk(KERN_INFO "Non-coherent PCI accesses enabled\n");
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 561e5da..451a9ea 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -46,7 +46,7 @@ void __init plat_mem_setup(void)
 	est_freq = au1xxx_calc_clock();
 	est_freq += 5000;    /* round */
 	est_freq -= est_freq % 10000;
-	printk(KERN_INFO "(PRId %08x) @ %lu.%02lu MHz\n", read_c0_prid(),
+	pr_info("(PRId %08x) @ %lu.%02lu MHz\n", current_cpu_prid(),
 	       est_freq / 1000000, ((est_freq % 1000000) * 100) / 1000000);
 
 	/* this is faster than wasting cycles trying to approximate it */
diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index f6540ec..8c7f375 100644
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -58,7 +58,6 @@ void __init board_setup(void)
 {
 	u32 pin_func, static_cfg0;
 	u32 sys_freqctrl, sys_clksrc;
-	u32 prid = read_c0_prid();
 
 	sys_freqctrl = 0;
 	sys_clksrc = 0;
@@ -87,7 +86,7 @@ void __init board_setup(void)
 	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
 		        SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
 
-	switch (prid & 0x000000FF) {
+	switch (cpu_prid_rev()) {
 	case 0x00: /* DA */
 	case 0x01: /* HA */
 	case 0x02: /* HB */
@@ -176,7 +175,7 @@ void __init board_setup(void)
 	 * Enable Au1000 BCLK switching - note: sed1356 must not use
 	 * its BCLK (Au1000 LCLK) for any timings
 	 */
-	switch (prid & 0x000000FF) {
+	switch (cpu_prid_rev()) {
 	case 0x00: /* DA */
 	case 0x01: /* HA */
 	case 0x02: /* HB */
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 7c7e4d4..7bd5176 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -299,7 +299,7 @@ void __init bcm63xx_cpu_init(void)
 
 	switch (c->cputype) {
 	case CPU_BMIPS3300:
-		if ((read_c0_prid() & 0xff00) == PRID_IMP_BMIPS3300_ALT) {
+		if (cpu_prid_imp() == PRID_IMP_BMIPS3300_ALT) {
 			expected_cpu_id = BCM6348_CPU_ID;
 			bcm63xx_regs_base = bcm96348_regs_base;
 			bcm63xx_irqs = bcm96348_irqs;
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index b0c3686..3c7de6d 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -276,7 +276,7 @@ const char *octeon_board_type_string(void)
 	static char name[80];
 	sprintf(name, "%s (%s)",
 		cvmx_board_type_to_string(octeon_bootinfo->board_type),
-		octeon_model_get_string(read_c0_prid()));
+		octeon_model_get_string(current_cpu_prid()));
 	return name;
 }
 
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index ca400f7..c4e1834 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -13,8 +13,12 @@
 #include <asm/cpu-info.h>
 #include <cpu-feature-overrides.h>
 
+#ifndef current_cpu_prid
+#define current_cpu_prid()	current_cpu_data.processor_id
+#endif
+
 #ifndef current_cpu_type
-#define current_cpu_type()      current_cpu_data.cputype
+#define current_cpu_type()	current_cpu_data.cputype
 #endif
 
 /*
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 8687753..25d2eb4 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -22,6 +22,7 @@
    that bits 16-23 have been 0 for all MIPS processors before the MIPS32/64
    spec.
 */
+#define PRID_COPT_MASK		0xff000000
 
 #define PRID_COMP_LEGACY	0x000000
 #define PRID_COMP_MIPS		0x010000
@@ -36,6 +37,8 @@
 #define PRID_COMP_CAVIUM	0x0d0000
 #define PRID_COMP_INGENIC	0xd00000
 
+#define PRID_COMP_MASK		0xff0000
+
 /*
  * Assigned values for the product ID register.  In order to detect a
  * certain CPU type exactly eventually additional registers may need to
@@ -73,6 +76,7 @@
 #define PRID_IMP_LOONGSON2	0x6300
 
 #define PRID_IMP_UNKNOWN	0xff00
+#define PRID_IMP_MASK		0xff00
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_MIPS
@@ -166,6 +170,15 @@
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
 
+#define cpu_prid_copt()		(current_cpu_prid() & PRID_COPT_MASK)
+#define cpu_prid_comp()		(current_cpu_prid() & PRID_COMP_MASK)
+#define cpu_prid_imp()		(current_cpu_prid() & PRID_IMP_MASK)
+#define cpu_prid_rev()		(current_cpu_prid() & PRID_REV_MASK)
+
+#define cpu_prid_encode(comp, imp, rev)	((comp) | (imp) | (rev))
+#define cpu_prid_encode_copt(copt, comp, imp, rev) \
+	((copt) | cpu_prid_encode(comp, imp, rev))
+
 /*
  * Older processors used to encode processor version and revision in two
  * 4-bit bitfields, the 4K seems to simply count up and even newer MTI cores
@@ -294,5 +307,9 @@ enum cpu_type_enum {
 #define MIPS_ASE_DSP		0x00000010 /* Signal Processing ASE */
 #define MIPS_ASE_MIPSMT		0x00000020 /* CPU supports MIPS MT */
 
+#define cpu_is_r4600_v1_x()	\
+	((current_cpu_prid() & 0xfffffff0) == 0x00002010)
+#define cpu_is_r4600_v2_x()	\
+	((current_cpu_prid() & 0xfffffff0) == 0x00002020)
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index a697661..3de5493 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -94,7 +94,7 @@ static inline u32 au_readl(unsigned long reg)
 /* Early Au1000 have a write-only SYS_CPUPLL register. */
 static inline int au1xxx_cpu_has_pll_wo(void)
 {
-	switch (read_c0_prid()) {
+	switch (current_cpu_prid()) {
 	case 0x00030100:	/* Au1000 DA */
 	case 0x00030201:	/* Au1000 HA */
 	case 0x00030202:	/* Au1000 HB */
@@ -111,7 +111,7 @@ static inline int au1xxx_cpu_needs_config_od(void)
 	 * early revisions of Alchemy SOCs.  It disables the bus trans-
 	 * action overlapping and needs to be set to fix various errata.
 	 */
-	switch (read_c0_prid()) {
+	switch (current_cpu_prid()) {
 	case 0x00030100: /* Au1000 DA */
 	case 0x00030201: /* Au1000 HA */
 	case 0x00030202: /* Au1000 HB */
@@ -139,7 +139,7 @@ static inline int au1xxx_cpu_needs_config_od(void)
 
 static inline int alchemy_get_cputype(void)
 {
-	switch (read_c0_prid() & 0xffff0000) {
+	switch (cpu_prid_copt() | cpu_prid_comp()) {
 	case 0x00030000:
 		return ALCHEMY_CPU_AU1000;
 		break;
diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
index 675bd86..a941bcc 100644
--- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -16,6 +16,20 @@
 #ifndef __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H
 #define __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H
 
+#ifdef CONFIG_CPU_LOONGSON2
+#define cpu_prid_loongson2() \
+	cpu_prid_encode(PRID_COMP_LEGACY, PRID_IMP_LOONGSON2, 0)
+
+#ifdef CONFIG_CPU_LOONGSON2F
+#define current_cpu_prid() (cpu_prid_loongson2() | PRID_REV_LOONGSON2F)
+#endif
+
+#ifdef CONFIG_CPU_LOONGSON2E
+#define current_cpu_prid() (cpu_prid_loongson2() | PRID_REV_LOONGSON2E)
+#endif
+
+#endif /* CONFIG_CPU_LOONGSON2 */
+
 #define cpu_dcache_line_size()	32
 #define cpu_icache_line_size()	32
 #define cpu_scache_line_size()	32
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 68dae7b..34cb533 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -208,7 +208,7 @@ void __init check_wait(void)
 
 	case CPU_74K:
 		cpu_wait = r4k_wait;
-		if ((c->processor_id & 0xff) >= PRID_REV_ENCODE_332(2, 1, 0))
+		if (cpu_prid_rev() >= PRID_REV_ENCODE_332(2, 1, 0))
 			cpu_wait = r4k_wait_irqoff;
 		break;
 
@@ -224,7 +224,7 @@ void __init check_wait(void)
 		 * WAIT on Rev2.0 and Rev3.0 has E16.
 		 * Rev3.1 WAIT is nop, why bother
 		 */
-		if ((c->processor_id & 0xff) <= 0x64)
+		if (cpu_prid_rev() <= 0x64)
 			break;
 
 		/*
@@ -237,7 +237,7 @@ void __init check_wait(void)
 		 */
 		break;
 	case CPU_RM9000:
-		if ((c->processor_id & 0x00ff) >= 0x40)
+		if (cpu_prid_rev() >= 0x40)
 			cpu_wait = r4k_wait;
 		break;
 	default:
@@ -256,7 +256,7 @@ static inline void check_errata(void)
 		 * This code only handles VPE0, any SMP/SMTC/RTOS code
 		 * making use of VPE1 will be responsable for that VPE.
 		 */
-		if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_34K_V1_0_2)
+		if (cpu_prid_rev() <= PRID_REV_34K_V1_0_2)
 			write_c0_config7(read_c0_config7() | MIPS_CONF7_RPS);
 		break;
 	default:
@@ -327,7 +327,7 @@ static inline void cpu_probe_vmbits(struct cpuinfo_mips *c)
 
 static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 {
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_R2000:
 		c->cputype = CPU_R2000;
 		__cpu_name[cpu] = "R2000";
@@ -339,7 +339,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->tlbsize = 64;
 		break;
 	case PRID_IMP_R3000:
-		if ((c->processor_id & 0xff) == PRID_REV_R3000A) {
+		if (cpu_prid_rev() == PRID_REV_R3000A) {
 			if (cpu_has_confreg()) {
 				c->cputype = CPU_R3081E;
 				__cpu_name[cpu] = "R3081";
@@ -361,7 +361,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		break;
 	case PRID_IMP_R4000:
 		if (read_c0_config() & CONF_SC) {
-			if ((c->processor_id & 0xff) >= PRID_REV_R4400) {
+			if (cpu_prid_rev() >= PRID_REV_R4400) {
 				c->cputype = CPU_R4400PC;
 				__cpu_name[cpu] = "R4400PC";
 			} else {
@@ -369,7 +369,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 				__cpu_name[cpu] = "R4000PC";
 			}
 		} else {
-			if ((c->processor_id & 0xff) >= PRID_REV_R4400) {
+			if (cpu_prid_rev() >= PRID_REV_R4400) {
 				c->cputype = CPU_R4400SC;
 				__cpu_name[cpu] = "R4400SC";
 			} else {
@@ -385,7 +385,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_VR41XX:
-		switch (c->processor_id & 0xf0) {
+		switch (current_cpu_prid() & 0xf0) {
 		case PRID_REV_VR4111:
 			c->cputype = CPU_VR4111;
 			__cpu_name[cpu] = "NEC VR4111";
@@ -395,7 +395,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			__cpu_name[cpu] = "NEC VR4121";
 			break;
 		case PRID_REV_VR4122:
-			if ((c->processor_id & 0xf) < 0x3) {
+			if ((current_cpu_prid() & 0xf) < 0x3) {
 				c->cputype = CPU_VR4122;
 				__cpu_name[cpu] = "NEC VR4122";
 			} else {
@@ -404,7 +404,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			}
 			break;
 		case PRID_REV_VR4130:
-			if ((c->processor_id & 0xf) < 0x4) {
+			if ((current_cpu_prid() & 0xf) < 0x4) {
 				c->cputype = CPU_VR4131;
 				__cpu_name[cpu] = "NEC VR4131";
 			} else {
@@ -457,12 +457,12 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->isa_level = MIPS_CPU_ISA_I;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_TX39_CACHE;
 
-		if ((c->processor_id & 0xf0) == (PRID_REV_TX3927 & 0xf0)) {
+		if ((current_cpu_prid() & 0xf0) == (PRID_REV_TX3927 & 0xf0)) {
 			c->cputype = CPU_TX3927;
 			__cpu_name[cpu] = "TX3927";
 			c->tlbsize = 64;
 		} else {
-			switch (c->processor_id & 0xff) {
+			switch (cpu_prid_rev()) {
 			case PRID_REV_TX3912:
 				c->cputype = CPU_TX3912;
 				__cpu_name[cpu] = "TX3912";
@@ -489,7 +489,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R49XX";
 		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS | MIPS_CPU_LLSC;
-		if (!(c->processor_id & 0x08))
+		if (!(current_cpu_prid() & 0x08))
 			c->options |= MIPS_CPU_FPU | MIPS_CPU_32FPR;
 		c->tlbsize = 48;
 		break;
@@ -772,7 +772,7 @@ static void __cpuinit decode_configs(struct cpuinfo_mips *c)
 static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_4KC:
 		c->cputype = CPU_4KC;
 		__cpu_name[cpu] = "MIPS 4Kc";
@@ -824,11 +824,11 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_AU1_REV1:
 	case PRID_IMP_AU1_REV2:
 		c->cputype = CPU_ALCHEMY;
-		switch ((c->processor_id >> 24) & 0xff) {
+		switch ((current_cpu_prid() >> 24) & 0xff) {
 		case 0:
 			__cpu_name[cpu] = "Au1000";
 			break;
@@ -843,7 +843,7 @@ static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
 			break;
 		case 4:
 			__cpu_name[cpu] = "Au1200";
-			if ((c->processor_id & 0xff) == 2)
+			if (cpu_prid_rev() == 2)
 				__cpu_name[cpu] = "Au1250";
 			break;
 		case 5:
@@ -861,12 +861,12 @@ static inline void cpu_probe_sibyte(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
 
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_SB1:
 		c->cputype = CPU_SB1;
 		__cpu_name[cpu] = "SiByte SB1";
 		/* FPU in pass1 is known to have issues. */
-		if ((c->processor_id & 0xff) < 0x02)
+		if (cpu_prid_rev() < 0x02)
 			c->options &= ~(MIPS_CPU_FPU | MIPS_CPU_32FPR);
 		break;
 	case PRID_IMP_SB1A:
@@ -879,7 +879,7 @@ static inline void cpu_probe_sibyte(struct cpuinfo_mips *c, unsigned int cpu)
 static inline void cpu_probe_sandcraft(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_SR71000:
 		c->cputype = CPU_SR71000;
 		__cpu_name[cpu] = "Sandcraft SR71000";
@@ -892,7 +892,7 @@ static inline void cpu_probe_sandcraft(struct cpuinfo_mips *c, unsigned int cpu)
 static inline void cpu_probe_nxp(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_PR4450:
 		c->cputype = CPU_PR4450;
 		__cpu_name[cpu] = "Philips PR4450";
@@ -904,7 +904,7 @@ static inline void cpu_probe_nxp(struct cpuinfo_mips *c, unsigned int cpu)
 static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_BMIPS32_REV4:
 	case PRID_IMP_BMIPS32_REV8:
 		c->cputype = CPU_BMIPS32;
@@ -917,7 +917,7 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "Broadcom BMIPS3300";
 		break;
 	case PRID_IMP_BMIPS43XX: {
-		int rev = c->processor_id & 0xff;
+		int rev = cpu_prid_rev();
 
 		if (rev >= PRID_REV_BMIPS4380_LO &&
 				rev <= PRID_REV_BMIPS4380_HI) {
@@ -940,7 +940,7 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_CAVIUM_CN38XX:
 	case PRID_IMP_CAVIUM_CN31XX:
 	case PRID_IMP_CAVIUM_CN30XX:
@@ -975,7 +975,7 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 	decode_configs(c);
 	/* JZRISC does not implement the CP0 counter. */
 	c->options &= ~MIPS_CPU_COUNTER;
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_JZRISC:
 		c->cputype = CPU_JZRISC;
 		__cpu_name[cpu] = "Ingenic JZRISC";
@@ -1005,7 +1005,7 @@ __cpuinit void cpu_probe(void)
 	c->cputype	= CPU_UNKNOWN;
 
 	c->processor_id = read_c0_prid();
-	switch (c->processor_id & 0xff0000) {
+	switch (cpu_prid_comp()) {
 	case PRID_COMP_LEGACY:
 		cpu_probe_legacy(c, cpu);
 		break;
@@ -1081,7 +1081,7 @@ __cpuinit void cpu_report(void)
 	struct cpuinfo_mips *c = &current_cpu_data;
 
 	printk(KERN_INFO "CPU revision is: %08x (%s)\n",
-	       c->processor_id, cpu_name_string());
+	       current_cpu_prid(), cpu_name_string());
 	if (c->options & MIPS_CPU_FPU)
 		printk(KERN_INFO "FPU revision is: %08x\n", c->fpu_id);
 }
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index fb74974..9d08a95 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -105,7 +105,7 @@ static __init int cpu_has_mfc0_count_bug(void)
 		 * The published errata for the R4400 upto 3.0 say the CPU
 		 * has the mfc0 from count bug.
 		 */
-		if ((current_cpu_data.processor_id & 0xff) <= 0x30)
+		if (cpu_prid_rev() <= 0x30)
 			return 1;
 
 		/*
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e971043..38a7ccd 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -325,7 +325,7 @@ static void __show_regs(const struct pt_regs *regs)
 	if (1 <= cause && cause <= 5)
 		printk("BadVA : %0*lx\n", field, regs->cp0_badvaddr);
 
-	printk("PrId  : %08x (%s)\n", read_c0_prid(),
+	pr_info("PrId  : %08x (%s)\n", current_cpu_prid(),
 	       cpu_name_string());
 }
 
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
index 11b193f..7ad79b4 100644
--- a/arch/mips/loongson/common/env.c
+++ b/arch/mips/loongson/common/env.c
@@ -39,7 +39,6 @@ void __init prom_init_env(void)
 	/* pmon passes arguments in 32bit pointers */
 	int *_prom_envp;
 	unsigned long bus_clock;
-	unsigned int processor_id;
 	long l;
 
 	/* firmware arguments are initialized in head.S */
@@ -59,8 +58,7 @@ void __init prom_init_env(void)
 	if (bus_clock == 0)
 		bus_clock = 66000000;
 	if (cpu_clock_freq == 0) {
-		processor_id = (&current_cpu_data)->processor_id;
-		switch (processor_id & PRID_REV_MASK) {
+		switch (cpu_prid_rev()) {
 		case PRID_REV_LOONGSON2E:
 			cpu_clock_freq = 533080000;
 			break;
diff --git a/arch/mips/loongson/common/platform.c b/arch/mips/loongson/common/platform.c
index ed007a2..8c79906 100644
--- a/arch/mips/loongson/common/platform.c
+++ b/arch/mips/loongson/common/platform.c
@@ -18,10 +18,8 @@ static struct platform_device loongson2_cpufreq_device = {
 
 static int __init loongson2_cpufreq_init(void)
 {
-	struct cpuinfo_mips *c = &current_cpu_data;
-
 	/* Only 2F revision and it's successors support CPUFreq */
-	if ((c->processor_id & PRID_REV_MASK) >= PRID_REV_LOONGSON2F)
+	if (cpu_prid_rev() >= PRID_REV_LOONGSON2F)
 		return platform_device_register(&loongson2_cpufreq_device);
 
 	return -ENODEV;
diff --git a/arch/mips/mipssim/sim_time.c b/arch/mips/mipssim/sim_time.c
index 5492c42..b545f6f 100644
--- a/arch/mips/mipssim/sim_time.c
+++ b/arch/mips/mipssim/sim_time.c
@@ -28,7 +28,7 @@ unsigned long cpu_khz;
  */
 static unsigned int __init estimate_cpu_frequency(void)
 {
-	unsigned int prid = read_c0_prid() & 0xffff00;
+	unsigned int prid = cpu_prid_comp() | cpu_prid_imp();
 	unsigned int count;
 
 #if 1
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index b4923a7..4407dd0 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -82,9 +82,6 @@ static struct bcache_ops no_sc_ops = {
 
 struct bcache_ops *bcops = &no_sc_ops;
 
-#define cpu_is_r4600_v1_x()	((read_c0_prid() & 0xfffffff0) == 0x00002010)
-#define cpu_is_r4600_v2_x()	((read_c0_prid() & 0xfffffff0) == 0x00002020)
-
 #define R4600_HIT_CACHEOP_WAR_IMPL					\
 do {									\
 	if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())		\
@@ -758,7 +755,6 @@ static void __cpuinit probe_pcache(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int config = read_c0_config();
-	unsigned int prid = read_c0_prid();
 	unsigned long config1;
 	unsigned int lsize;
 
@@ -850,10 +846,11 @@ static void __cpuinit probe_pcache(void)
 		write_c0_config(config & ~VR41_CONF_P4K);
 	case CPU_VR4131:
 		/* Workaround for cache instruction bug of VR4131 */
-		if (c->processor_id == 0x0c80U || c->processor_id == 0x0c81U ||
-		    c->processor_id == 0x0c82U) {
+		if (current_cpu_prid() == 0x0c80U ||
+		    current_cpu_prid() == 0x0c81U ||
+		    current_cpu_prid() == 0x0c82U) {
 			config |= 0x00400000U;
-			if (c->processor_id == 0x0c80U)
+			if (current_cpu_prid() == 0x0c80U)
 				config |= VR41_CONF_BP;
 			write_c0_config(config);
 		} else
@@ -912,7 +909,7 @@ static void __cpuinit probe_pcache(void)
 	case CPU_LOONGSON2:
 		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
 		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
-		if (prid & 0x3)
+		if (current_cpu_prid() & 0x3)
 			c->icache.ways = 4;
 		else
 			c->icache.ways = 2;
@@ -920,7 +917,7 @@ static void __cpuinit probe_pcache(void)
 
 		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
 		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
-		if (prid & 0x3)
+		if (current_cpu_prid() & 0x3)
 			c->dcache.ways = 4;
 		else
 			c->dcache.ways = 2;
@@ -981,7 +978,7 @@ static void __cpuinit probe_pcache(void)
 	 * presumably no vendor is shipping his hardware in the "bad"
 	 * configuration.
 	 */
-	if ((prid & 0xff00) == PRID_IMP_R4000 && (prid & 0xff) < 0x40 &&
+	if (cpu_prid_imp() == PRID_IMP_R4000 && cpu_prid_rev() < 0x40 &&
 	    !(config & CONF_SC) && c->icache.linesz != 16 &&
 	    PAGE_SIZE <= 0x8000)
 		panic("Improper R4000SC processor configuration detected");
@@ -1242,7 +1239,7 @@ void au1x00_fixup_config_od(void)
 	 * on the early revisions of Alchemy SOCs.  It disables the bus
 	 * transaction overlapping and needs to be set to fix various errata.
 	 */
-	switch (read_c0_prid()) {
+	switch (current_cpu_prid()) {
 	case 0x00030100: /* Au1000 DA */
 	case 0x00030201: /* Au1000 HA */
 	case 0x00030202: /* Au1000 HB */
diff --git a/arch/mips/mm/cerr-sb1.c b/arch/mips/mm/cerr-sb1.c
index 3571090..5e696e8 100644
--- a/arch/mips/mm/cerr-sb1.c
+++ b/arch/mips/mm/cerr-sb1.c
@@ -191,7 +191,7 @@ asmlinkage void sb1_cache_error(void)
 #endif
 
 	printk("Cache error exception on CPU %x:\n",
-	       (read_c0_prid() >> 25) & 0x7);
+	       (current_cpu_prid() >> 25) & 0x7);
 
 	__asm__ __volatile__ (
 	"	.set	push\n\t"
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 36272f7..9c1f28a 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -69,9 +69,6 @@ UASM_L_LA(_copy_pref_store)
 static struct uasm_label __cpuinitdata labels[5];
 static struct uasm_reloc __cpuinitdata relocs[5];
 
-#define cpu_is_r4600_v1_x()	((read_c0_prid() & 0xfffffff0) == 0x00002010)
-#define cpu_is_r4600_v2_x()	((read_c0_prid() & 0xfffffff0) == 0x00002020)
-
 /*
  * Maximum sizes:
  *
@@ -212,7 +209,7 @@ static void __cpuinit set_prefetch_parameters(void)
 			 * hints are broken.
 			 */
 			if (current_cpu_type() == CPU_SB1 &&
-			    (current_cpu_data.processor_id & 0xff) < 0x02) {
+			    cpu_prid_rev() < 0x02) {
 				pref_src_mode = Pref_Load;
 				pref_dst_mode = Pref_Store;
 			} else {
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 93816f3..af08461 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -74,7 +74,7 @@ static inline int __maybe_unused r10000_llsc_war(void)
  */
 static int __cpuinit m4kc_tlbp_war(void)
 {
-	return (current_cpu_data.processor_id & 0xffff00) ==
+	return (cpu_prid_comp() | cpu_prid_imp()) ==
 	       (PRID_COMP_MIPS | PRID_IMP_4KC);
 }
 
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 3c6f190..c296443 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -65,7 +65,7 @@ static void mips_perf_dispatch(void)
  */
 static unsigned int __init estimate_cpu_frequency(void)
 {
-	unsigned int prid = read_c0_prid() & 0xffff00;
+	unsigned int prid = cpu_prid_comp() | cpu_prid_imp();
 	unsigned int count;
 
 	unsigned long flags;
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 54759f1..8e74878 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -349,7 +349,7 @@ static int __init mipsxx_init(void)
 		break;
 
 	case CPU_R10000:
-		if ((current_cpu_data.processor_id & 0xff) == 0x20)
+		if (cpu_prid_rev() == 0x20)
 			op_model_mipsxx_ops.cpu_type = "mips/r10000-v2.x";
 		else
 			op_model_mipsxx_ops.cpu_type = "mips/r10000";
diff --git a/arch/mips/pci/pci-vr41xx.c b/arch/mips/pci/pci-vr41xx.c
index 5652571..94056bb 100644
--- a/arch/mips/pci/pci-vr41xx.c
+++ b/arch/mips/pci/pci-vr41xx.c
@@ -147,7 +147,7 @@ static int __init vr41xx_pciu_init(void)
 		pciu_write(PCICLKSELREG, EQUAL_VTCLOCK);
 	else if ((vtclock / 2) < pci_clock_max)
 		pciu_write(PCICLKSELREG, HALF_VTCLOCK);
-	else if (current_cpu_data.processor_id >= PRID_VR4131_REV2_1 &&
+	else if (current_cpu_prid() >= PRID_VR4131_REV2_1 &&
 	         (vtclock / 3) < pci_clock_max)
 		pciu_write(PCICLKSELREG, ONE_THIRD_VTCLOCK);
 	else if ((vtclock / 4) < pci_clock_max)
diff --git a/arch/mips/sgi-ip27/ip27-nmi.c b/arch/mips/sgi-ip27/ip27-nmi.c
index bc4fa8d..b60758c 100644
--- a/arch/mips/sgi-ip27/ip27-nmi.c
+++ b/arch/mips/sgi-ip27/ip27-nmi.c
@@ -119,7 +119,7 @@ void nmi_cpu_eframe_save(nasid_t nasid, int slice)
 	printk("\n");
 
 	printk("Cause : %08lx\n", nr->cause);
-	printk("PrId  : %08x\n", read_c0_prid());
+	printk("PrId  : %08x\n", current_cpu_prid());
 	printk("BadVA : %016lx\n", nr->badva);
 	printk("CErr  : %016lx\n", nr->cache_err);
 	printk("NMI_SR: %016lx\n", nr->nmi_sr);
diff --git a/arch/mips/sibyte/bcm1480/setup.c b/arch/mips/sibyte/bcm1480/setup.c
index 05ed92c..1c174fa 100644
--- a/arch/mips/sibyte/bcm1480/setup.c
+++ b/arch/mips/sibyte/bcm1480/setup.c
@@ -119,7 +119,7 @@ void __init bcm1480_setup(void)
 	uint64_t sys_rev;
 	int plldiv;
 
-	sb1_pass = read_c0_prid() & 0xff;
+	sb1_pass = cpu_prid_rev();
 	sys_rev = __raw_readq(IOADDR(A_SCD_SYSTEM_REVISION));
 	soc_type = SYS_SOC_TYPE(sys_rev);
 	part_type = G_SYS_PART(sys_rev);
diff --git a/arch/mips/sibyte/sb1250/setup.c b/arch/mips/sibyte/sb1250/setup.c
index 92da315..66070d6 100644
--- a/arch/mips/sibyte/sb1250/setup.c
+++ b/arch/mips/sibyte/sb1250/setup.c
@@ -182,7 +182,7 @@ void __init sb1250_setup(void)
 	int plldiv;
 	int bad_config = 0;
 
-	sb1_pass = read_c0_prid() & 0xff;
+	sb1_pass = cpu_prid_rev();
 	sys_rev = __raw_readq(IOADDR(A_SCD_SYSTEM_REVISION));
 	soc_type = SYS_SOC_TYPE(sys_rev);
 	soc_pass = G_SYS_REVISION(sys_rev);
diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
index d16b462..e01f62e 100644
--- a/arch/mips/sni/setup.c
+++ b/arch/mips/sni/setup.c
@@ -172,7 +172,7 @@ void __init plat_mem_setup(void)
 		system_type = "RM300-Cxx";
 		break;
 	case SNI_BRD_PCI_DESKTOP:
-		switch (read_c0_prid() & 0xff00) {
+		switch (cpu_prid_imp()) {
 		case PRID_IMP_R4600:
 		case PRID_IMP_R4700:
 			system_type = "RM200-C20";
diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
index 2391632..aca5c76 100644
--- a/arch/mips/vr41xx/common/init.c
+++ b/arch/mips/vr41xx/common/init.c
@@ -43,8 +43,8 @@ void __init plat_time_init(void)
 	vr41xx_calculate_clock_frequency();
 
 	tclock = vr41xx_get_tclock_frequency();
-	if (current_cpu_data.processor_id == PRID_VR4131_REV2_0 ||
-	    current_cpu_data.processor_id == PRID_VR4131_REV2_1)
+	if (current_cpu_prid() == PRID_VR4131_REV2_0 ||
+	    current_cpu_prid() == PRID_VR4131_REV2_1)
 		mips_hpt_frequency = tclock / 2;
 	else
 		mips_hpt_frequency = tclock / 4;
-- 
1.7.1
