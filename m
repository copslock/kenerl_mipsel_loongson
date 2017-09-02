Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Sep 2017 16:10:47 +0200 (CEST)
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:44015 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991826AbdIBOKblPn2V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Sep 2017 16:10:31 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 4593B3F6DC;
        Sat,  2 Sep 2017 16:10:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JwdswVLs-G5N; Sat,  2 Sep 2017 16:10:19 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id ACEF83F689;
        Sat,  2 Sep 2017 16:10:14 +0200 (CEST)
Date:   Sat, 2 Sep 2017 16:10:13 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20170902141013.GB2602@localhost.localdomain>
References: <20170827132309.GA32166@localhost.localdomain>
 <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
Hi Maciej,

Here is revised patch. I've added arch/mips/mm/c-r4k.c and I'm unsure about

	c->options |= MIPS_CPU_CACHE_CDEX_P | MIPS_CPU_PREFETCH;

but similar architectures have MIPS_CPU_CACHE_CDEX_P and R5900 has a PREF
instruction. As indicated in the comment, it's not entirely clear why

	if (c->dcache.waysize > PAGE_SIZE)
		c->dcache.flags |= MIPS_CACHE_ALIASES;

is necessary. I've also added arch/mips/Makefile.

 arch/mips/Kconfig                | 12 ++++++++++++
 arch/mips/Makefile               |  2 ++
 arch/mips/include/asm/cpu-type.h |  4 ++++
 arch/mips/include/asm/cpu.h      |  3 ++-
 arch/mips/include/asm/module.h   |  2 ++
 arch/mips/kernel/cpu-probe.c     | 11 +++++++++++
 arch/mips/mm/c-r4k.c             | 25 +++++++++++++++++++++++++
 7 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..aec56966484b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1708,6 +1708,15 @@ config CPU_BMIPS
 	help
 	  Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
 
+config CPU_R5900
+	bool "R5900"
+	depends on SYS_HAS_CPU_R5900
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select IRQ_MIPS_CPU
+	help
+	  MIPS Technologies R5900 processor (Emotion Engine in Sony Playstation 2).
+
 config CPU_XLR
 	bool "Netlogic XLR SoC"
 	depends on SYS_HAS_CPU_XLR
@@ -1938,6 +1947,9 @@ config SYS_HAS_CPU_R5432
 config SYS_HAS_CPU_R5500
 	bool
 
+config SYS_HAS_CPU_R5900
+	bool
+
 config SYS_HAS_CPU_R6000
 	bool
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 02a1787c888c..e8e2805a05c4 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -171,6 +171,8 @@ cflags-$(CONFIG_CPU_R5432)	+= $(call cc-option,-march=r5400,-march=r5000) \
 			-Wa,--trap
 cflags-$(CONFIG_CPU_R5500)	+= $(call cc-option,-march=r5500,-march=r5000) \
 			-Wa,--trap
+cflags-$(CONFIG_CPU_R5900)	+= -march=r5900 -mtune=r5900 \
+			-Wa,--trap -mno-llsc
 cflags-$(CONFIG_CPU_NEVADA)	+= $(call cc-option,-march=rm5200,-march=r5000) \
 			-Wa,--trap
 cflags-$(CONFIG_CPU_RM7000)	+= $(call cc-option,-march=rm7000,-march=r5000) \
diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index bdd6dc18e65c..5613ae2a0fe0 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -150,6 +150,10 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_R5500:
 #endif
 
+#ifdef CONFIG_SYS_HAS_CPU_R5900
+	case CPU_R5900:
+#endif
+
 #ifdef CONFIG_SYS_HAS_CPU_R6000
 	case CPU_R6000:
 	case CPU_R6000A:
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 98f59307e6a3..19da9e4be440 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -80,6 +80,7 @@
 #define PRID_IMP_R4650		0x2200		/* Same as R4640 */
 #define PRID_IMP_R5000		0x2300
 #define PRID_IMP_TX49		0x2d00
+#define PRID_IMP_R5900		0x2e00		/* Playstation 2 */
 #define PRID_IMP_SONIC		0x2400
 #define PRID_IMP_MAGIC		0x2500
 #define PRID_IMP_RM7000		0x2700
@@ -296,7 +297,7 @@ enum cpu_type_enum {
 	CPU_R4700, CPU_R5000, CPU_R5500, CPU_NEVADA, CPU_R5432, CPU_R10000,
 	CPU_R12000, CPU_R14000, CPU_R16000, CPU_VR41XX, CPU_VR4111, CPU_VR4121,
 	CPU_VR4122, CPU_VR4131, CPU_VR4133, CPU_VR4181, CPU_VR4181A, CPU_RM7000,
-	CPU_SR71000, CPU_TX49XX,
+	CPU_SR71000, CPU_TX49XX, CPU_R5900,
 
 	/*
 	 * R8000 class processors
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index 702c273e67a9..5025b321604f 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -114,6 +114,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "R5432 "
 #elif defined CONFIG_CPU_R5500
 #define MODULE_PROC_FAMILY "R5500 "
+#elif defined CONFIG_CPU_R5900
+#define MODULE_PROC_FAMILY "R5900 "
 #elif defined CONFIG_CPU_R6000
 #define MODULE_PROC_FAMILY "R6000 "
 #elif defined CONFIG_CPU_NEVADA
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 1aba27786bd5..c9431900d11f 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1383,6 +1383,17 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			     MIPS_CPU_WATCH | MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
+	case PRID_IMP_R5900:
+		c->cputype = CPU_R5900;
+		__cpu_name[cpu] = "R5900";
+		c->isa_level = MIPS_CPU_ISA_III;
+		c->fpu_msk31 |= FPU_CSR_CONDX;
+		c->options = MIPS_CPU_TLB | MIPS_CPU_4K_CACHE |
+			     MIPS_CPU_4KEX | MIPS_CPU_DIVEC |
+			     MIPS_CPU_FPU | MIPS_CPU_32FPR |
+			     MIPS_CPU_COUNTER;
+		c->tlbsize = 48;
+		break;
 	case PRID_IMP_NEVADA:
 		c->cputype = CPU_NEVADA;
 		__cpu_name[cpu] = "Nevada";
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 3fe99cb271a9..0420ce8fb086 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1192,6 +1192,20 @@ static void probe_pcache(void)
 		c->options |= MIPS_CPU_CACHE_CDEX_P | MIPS_CPU_PREFETCH;
 		break;
 
+	case CPU_R5900:
+		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 64;
+		c->icache.ways = 2;
+		c->icache.waybit = 0;
+
+		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 64;
+		c->dcache.ways = 2;
+		c->dcache.waybit = 0;
+
+		c->options |= MIPS_CPU_CACHE_CDEX_P | MIPS_CPU_PREFETCH;
+		break;
+
 	case CPU_TX49XX:
 		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
 		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
@@ -1465,6 +1479,17 @@ static void probe_pcache(void)
 	case CPU_R16000:
 		break;
 
+	case CPU_R5900:
+		if (c->icache.waysize > PAGE_SIZE)
+			c->dcache.flags |= MIPS_CACHE_ALIASES;
+		/*
+		 * There seems to be a missing d-cache flush which is fixed
+		 * with MIPS_CACHE_ALIASES.
+		 */
+		if (c->dcache.waysize > PAGE_SIZE)
+			c->dcache.flags |= MIPS_CACHE_ALIASES;
+		break;
+
 	case CPU_74K:
 	case CPU_1074K:
 		has_74k_erratum = alias_74k_erratum(c);
-- 
2.13.4
