Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 08:30:00 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:34380 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903548Ab2EKG3y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 08:29:54 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SSjMK-0001vr-Bu; Fri, 11 May 2012 01:29:48 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: [PATCH v2] Add MIPS64R2 core support.
Date:   Fri, 11 May 2012 01:29:44 -0500
Message-Id: <1336717784-853-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Leonid Yegoshin <yegoshin@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kconfig            |    7 +++++++
 arch/mips/include/asm/cpu.h  |    2 +-
 arch/mips/kernel/cpu-probe.c |    4 ++++
 arch/mips/kernel/traps.c     |    1 +
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d0570f4..862a9c3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -282,6 +282,7 @@ config MIPS_MALTA
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_HAS_CPU_MIPS64_R1
+	select SYS_HAS_CPU_MIPS64_R2
 	select SYS_HAS_CPU_NEVADA
 	select SYS_HAS_CPU_RM7000
 	select SYS_HAS_EARLY_PRINTK
@@ -2488,6 +2489,7 @@ config TRAD_SIGNALS
 config MIPS32_COMPAT
 	bool "Kernel support for Linux/MIPS 32-bit binary compatibility"
 	depends on 64BIT
+	default y if CPU_SUPPORTS_32BIT_KERNEL && SYS_SUPPORTS_32BIT_KERNEL
 	help
 	  Select this option if you want Linux/MIPS 32-bit binary
 	  compatibility. Since all software available for Linux/MIPS is
@@ -2507,6 +2509,7 @@ config SYSVIPC_COMPAT
 config MIPS32_O32
 	bool "Kernel support for o32 binaries"
 	depends on MIPS32_COMPAT
+	default y if CPU_SUPPORTS_32BIT_KERNEL && SYS_SUPPORTS_32BIT_KERNEL
 	help
 	  Select this option if you want to run o32 binaries.  These are pure
 	  32-bit binaries as used by the 32-bit Linux/MIPS port.  Most of
@@ -2525,6 +2528,10 @@ config MIPS32_N32
 
 	  If unsure, say N.
 
+comment "64bit kernel, but support of 32bit applications is disabled!"
+	depends on 64BIT && !MIPS32_O32 && !MIPS32_N32
+	depends on CPU_SUPPORTS_32BIT_KERNEL && SYS_SUPPORTS_32BIT_KERNEL
+
 config BINFMT_ELF32
 	bool
 	default y if MIPS32_O32 || MIPS32_N32
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 0a619f8..559bd12 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -268,7 +268,7 @@ enum cpu_type_enum {
 	/*
 	 * MIPS64 class processors
 	 */
-	CPU_5KC, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
+	CPU_5KC, CPU_5KE, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
 	CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS, CPU_CAVIUM_OCTEON2,
 	CPU_XLR, CPU_XLP,
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index e5f0b27..fe76d60 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -817,6 +817,10 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_5KC;
 		__cpu_name[cpu] = "MIPS 5Kc";
 		break;
+	case PRID_IMP_5KE:
+		c->cputype = CPU_5KE;
+		__cpu_name[cpu] = "MIPS 5KE";
+		break;
 	case PRID_IMP_20KC:
 		c->cputype = CPU_20KC;
 		__cpu_name[cpu] = "MIPS 20Kc";
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7bec6f8..a69edbe 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1349,6 +1349,7 @@ static inline void parity_protection_init(void)
 		break;
 
 	case CPU_5KC:
+	case CPU_5KE:
 		write_c0_ecc(0x80000000);
 		back_to_back_c0_hazard();
 		/* Set the PE bit (bit 31) in the c0_errctl register. */
-- 
1.7.10
