Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2010 16:28:29 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:59064 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491139Ab0LYP2U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Dec 2010 16:28:20 +0100
Received: by pzk30 with SMTP id 30so1927532pzk.36
        for <multiple recipients>; Sat, 25 Dec 2010 07:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ViCeubmsBbYQpPqahL4nCw5n6NxGkoeGK3FjmG3WztY=;
        b=syEKAMnZEnwaP3fjg3P2+mQ3ZnuHuE8GQVJnwDqzv80x3GsqZhn8n712zyhYyxZPFh
         elM+/+kEI1LUNiGMvQTP5rId9vY5PGLNPptFjqMHZwNw88cQ2llMhbepQHbeY/OoJ+cd
         +yzGp0QmkPBaHVrfK3A8dg7n+16gQPwJfiPps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=quRB23f0b1/r93jgudsanSH8pG+taJfMTrSg/+nkzGFaPiOBo3GlFfHU6a1H2SpdZ9
         RIWaJ6LacpUS3bA5kN5OK+W8DHHQ536vgPBPJ4y1mCIqocrQabLfuWpt5CPNpj+SdjZH
         aIz5CdFk7hc06T7SodwGK2rT9oPhYImLtcjhU=
Received: by 10.142.221.17 with SMTP id t17mr8367187wfg.138.1293290893580;
        Sat, 25 Dec 2010 07:28:13 -0800 (PST)
Received: from localhost.localdomain ([61.48.57.245])
        by mx.google.com with ESMTPS id x18sm14239920wfa.23.2010.12.25.07.28.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Dec 2010 07:28:12 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Add current_cpu_prid() to optimize the code generation
Date:   Sat, 25 Dec 2010 23:27:56 +0800
Message-Id: <1293290876-11731-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

current_cpu_prid(), cpu_prid_comp(), cpu_prid_imp() and cpu_prid_rev()
are added to simplify/beautify the c->processord_id related code, as a
result, the code generation will be optimized.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/cpu-features.h               |    6 ++-
 arch/mips/include/asm/cpu.h                        |   10 +++-
 .../asm/mach-loongson/cpu-feature-overrides.h      |   12 ++++
 arch/mips/kernel/cpu-probe.c                       |   60 +++++++++----------
 arch/mips/kernel/time.c                            |    2 +-
 arch/mips/loongson/common/env.c                    |    4 +-
 arch/mips/loongson/common/platform.c               |    4 +-
 arch/mips/mm/c-r4k.c                               |    7 +-
 arch/mips/mm/page.c                                |    2 +-
 arch/mips/mm/tlbex.c                               |    2 +-
 arch/mips/oprofile/op_model_mipsxx.c               |    2 +-
 arch/mips/pci/pci-vr41xx.c                         |    2 +-
 arch/mips/vr41xx/common/init.c                     |    4 +-
 13 files changed, 67 insertions(+), 50 deletions(-)

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
index 8687753..df8b008 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -36,6 +36,8 @@
 #define PRID_COMP_CAVIUM	0x0d0000
 #define PRID_COMP_INGENIC	0xd00000
 
+#define PRID_COMP_MASK		0xff0000
+
 /*
  * Assigned values for the product ID register.  In order to detect a
  * certain CPU type exactly eventually additional registers may need to
@@ -73,6 +75,7 @@
 #define PRID_IMP_LOONGSON2	0x6300
 
 #define PRID_IMP_UNKNOWN	0xff00
+#define PRID_IMP_MASK		0xff00
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_MIPS
@@ -166,6 +169,12 @@
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
 
+#define cpu_prid_comp()		(current_cpu_prid() & PRID_COMP_MASK)
+#define cpu_prid_imp()		(current_cpu_prid() & PRID_IMP_MASK)
+#define cpu_prid_rev()		(current_cpu_prid() & PRID_REV_MASK)
+
+#define cpu_prid_encode(comp, imp, rev)	((comp) | (imp) | (rev))
+
 /*
  * Older processors used to encode processor version and revision in two
  * 4-bit bitfields, the 4K seems to simply count up and even newer MTI cores
@@ -294,5 +303,4 @@ enum cpu_type_enum {
 #define MIPS_ASE_DSP		0x00000010 /* Signal Processing ASE */
 #define MIPS_ASE_MIPSMT		0x00000020 /* CPU supports MIPS MT */
 
-
 #endif /* _ASM_CPU_H */
diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
index 675bd86..0fcf5ed 100644
--- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -16,6 +16,18 @@
 #ifndef __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H
 #define __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H
 
+#ifdef CONFIG_CPU_LOONGSON2
+#define cpu_prid_loongson2() \
+	cpu_prid_encode(PRID_COMP_LEGACY, PRID_IMP_LOONGSON2, 0)
+
+#ifdef CONFIG_CPU_LOONGSON2F
+#define current_cpu_prid() (cpu_prid_loongson2() | PRID_REV_LOONGSON2F)
+#else /* CONFIG_CPU_LOONGSON2E */
+#define current_cpu_prid() (cpu_prid_loongson2() | PRID_REV_LOONGSON2E)
+#endif
+
+#endif /* CONFIG_CPU_LOONGSON2 */
+
 #define cpu_dcache_line_size()	32
 #define cpu_icache_line_size()	32
 #define cpu_scache_line_size()	32
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 877155f..cb14f1e 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -153,8 +153,6 @@ __setup("nodsp", dsp_disable);
 
 void __init check_wait(void)
 {
-	struct cpuinfo_mips *c = &current_cpu_data;
-
 	if (nowait) {
 		printk("Wait instruction disabled.\n");
 		return;
@@ -208,7 +206,7 @@ void __init check_wait(void)
 
 	case CPU_74K:
 		cpu_wait = r4k_wait;
-		if ((c->processor_id & 0xff) >= PRID_REV_ENCODE_332(2, 1, 0))
+		if (cpu_prid_rev() >= PRID_REV_ENCODE_332(2, 1, 0))
 			cpu_wait = r4k_wait_irqoff;
 		break;
 
@@ -224,7 +222,7 @@ void __init check_wait(void)
 		 * WAIT on Rev2.0 and Rev3.0 has E16.
 		 * Rev3.1 WAIT is nop, why bother
 		 */
-		if ((c->processor_id & 0xff) <= 0x64)
+		if (cpu_prid_rev() <= 0x64)
 			break;
 
 		/*
@@ -237,7 +235,7 @@ void __init check_wait(void)
 		 */
 		break;
 	case CPU_RM9000:
-		if ((c->processor_id & 0x00ff) >= 0x40)
+		if (cpu_prid_rev() >= 0x40)
 			cpu_wait = r4k_wait;
 		break;
 	default:
@@ -247,8 +245,6 @@ void __init check_wait(void)
 
 static inline void check_errata(void)
 {
-	struct cpuinfo_mips *c = &current_cpu_data;
-
 	switch (current_cpu_type()) {
 	case CPU_34K:
 		/*
@@ -256,7 +252,7 @@ static inline void check_errata(void)
 		 * This code only handles VPE0, any SMP/SMTC/RTOS code
 		 * making use of VPE1 will be responsable for that VPE.
 		 */
-		if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_34K_V1_0_2)
+		if (cpu_prid_rev() <= PRID_REV_34K_V1_0_2)
 			write_c0_config7(read_c0_config7() | MIPS_CONF7_RPS);
 		break;
 	default:
@@ -327,7 +323,7 @@ static inline void cpu_probe_vmbits(struct cpuinfo_mips *c)
 
 static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 {
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_R2000:
 		c->cputype = CPU_R2000;
 		__cpu_name[cpu] = "R2000";
@@ -339,7 +335,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->tlbsize = 64;
 		break;
 	case PRID_IMP_R3000:
-		if ((c->processor_id & 0xff) == PRID_REV_R3000A) {
+		if (cpu_prid_rev() == PRID_REV_R3000A) {
 			if (cpu_has_confreg()) {
 				c->cputype = CPU_R3081E;
 				__cpu_name[cpu] = "R3081";
@@ -361,7 +357,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		break;
 	case PRID_IMP_R4000:
 		if (read_c0_config() & CONF_SC) {
-			if ((c->processor_id & 0xff) >= PRID_REV_R4400) {
+			if (cpu_prid_rev() >= PRID_REV_R4400) {
 				c->cputype = CPU_R4400PC;
 				__cpu_name[cpu] = "R4400PC";
 			} else {
@@ -369,7 +365,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 				__cpu_name[cpu] = "R4000PC";
 			}
 		} else {
-			if ((c->processor_id & 0xff) >= PRID_REV_R4400) {
+			if (cpu_prid_rev() >= PRID_REV_R4400) {
 				c->cputype = CPU_R4400SC;
 				__cpu_name[cpu] = "R4400SC";
 			} else {
@@ -385,7 +381,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_VR41XX:
-		switch (c->processor_id & 0xf0) {
+		switch (current_cpu_prid() & 0xf0) {
 		case PRID_REV_VR4111:
 			c->cputype = CPU_VR4111;
 			__cpu_name[cpu] = "NEC VR4111";
@@ -395,7 +391,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			__cpu_name[cpu] = "NEC VR4121";
 			break;
 		case PRID_REV_VR4122:
-			if ((c->processor_id & 0xf) < 0x3) {
+			if ((current_cpu_prid() & 0xf) < 0x3) {
 				c->cputype = CPU_VR4122;
 				__cpu_name[cpu] = "NEC VR4122";
 			} else {
@@ -404,7 +400,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			}
 			break;
 		case PRID_REV_VR4130:
-			if ((c->processor_id & 0xf) < 0x4) {
+			if ((current_cpu_prid() & 0xf) < 0x4) {
 				c->cputype = CPU_VR4131;
 				__cpu_name[cpu] = "NEC VR4131";
 			} else {
@@ -457,12 +453,12 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
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
@@ -489,7 +485,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R49XX";
 		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS | MIPS_CPU_LLSC;
-		if (!(c->processor_id & 0x08))
+		if (!(current_cpu_prid() & 0x08))
 			c->options |= MIPS_CPU_FPU | MIPS_CPU_32FPR;
 		c->tlbsize = 48;
 		break;
@@ -772,7 +768,7 @@ static void __cpuinit decode_configs(struct cpuinfo_mips *c)
 static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_4KC:
 		c->cputype = CPU_4KC;
 		__cpu_name[cpu] = "MIPS 4Kc";
@@ -824,11 +820,11 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
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
@@ -843,7 +839,7 @@ static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
 			break;
 		case 4:
 			__cpu_name[cpu] = "Au1200";
-			if ((c->processor_id & 0xff) == 2)
+			if (cpu_prid_rev() == 2)
 				__cpu_name[cpu] = "Au1250";
 			break;
 		case 5:
@@ -861,12 +857,12 @@ static inline void cpu_probe_sibyte(struct cpuinfo_mips *c, unsigned int cpu)
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
@@ -879,7 +875,7 @@ static inline void cpu_probe_sibyte(struct cpuinfo_mips *c, unsigned int cpu)
 static inline void cpu_probe_sandcraft(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_SR71000:
 		c->cputype = CPU_SR71000;
 		__cpu_name[cpu] = "Sandcraft SR71000";
@@ -892,7 +888,7 @@ static inline void cpu_probe_sandcraft(struct cpuinfo_mips *c, unsigned int cpu)
 static inline void cpu_probe_nxp(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_PR4450:
 		c->cputype = CPU_PR4450;
 		__cpu_name[cpu] = "Philips PR4450";
@@ -904,7 +900,7 @@ static inline void cpu_probe_nxp(struct cpuinfo_mips *c, unsigned int cpu)
 static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_BMIPS32_REV4:
 	case PRID_IMP_BMIPS32_REV8:
 		c->cputype = CPU_BMIPS32;
@@ -917,7 +913,7 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "Broadcom BMIPS3300";
 		break;
 	case PRID_IMP_BMIPS43XX: {
-		int rev = c->processor_id & 0xff;
+		int rev = cpu_prid_rev();
 
 		if (rev >= PRID_REV_BMIPS4380_LO &&
 				rev <= PRID_REV_BMIPS4380_HI) {
@@ -940,7 +936,7 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_CAVIUM_CN38XX:
 	case PRID_IMP_CAVIUM_CN31XX:
 	case PRID_IMP_CAVIUM_CN30XX:
@@ -975,7 +971,7 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 	decode_configs(c);
 	/* JZRISC does not implement the CP0 counter. */
 	c->options &= ~MIPS_CPU_COUNTER;
-	switch (c->processor_id & 0xff00) {
+	switch (cpu_prid_imp()) {
 	case PRID_IMP_JZRISC:
 		c->cputype = CPU_JZRISC;
 		__cpu_name[cpu] = "Ingenic JZRISC";
@@ -1005,7 +1001,7 @@ __cpuinit void cpu_probe(void)
 	c->cputype	= CPU_UNKNOWN;
 
 	c->processor_id = read_c0_prid();
-	switch (c->processor_id & 0xff0000) {
+	switch (cpu_prid_comp()) {
 	case PRID_COMP_LEGACY:
 		cpu_probe_legacy(c, cpu);
 		break;
@@ -1081,7 +1077,7 @@ __cpuinit void cpu_report(void)
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
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e79fc25..d594c8a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -850,10 +850,11 @@ static void __cpuinit probe_pcache(void)
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
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 36272f7..24cdc98 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -212,7 +212,7 @@ static void __cpuinit set_prefetch_parameters(void)
 			 * hints are broken.
 			 */
 			if (current_cpu_type() == CPU_SB1 &&
-			    (current_cpu_data.processor_id & 0xff) < 0x02) {
+			    cpu_prid_rev() < 0x02) {
 				pref_src_mode = Pref_Load;
 				pref_dst_mode = Pref_Store;
 			} else {
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 48191a4..cb9d53b 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -74,7 +74,7 @@ static inline int __maybe_unused r10000_llsc_war(void)
  */
 static int __cpuinit m4kc_tlbp_war(void)
 {
-	return (current_cpu_data.processor_id & 0xffff00) ==
+	return (current_cpu_prid() & (PRID_COMP_MASK | PRID_IMP_MASK)) ==
 	       (PRID_COMP_MIPS | PRID_IMP_4KC);
 }
 
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
