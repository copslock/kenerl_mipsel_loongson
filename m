Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2017 15:23:29 +0200 (CEST)
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:37299 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993943AbdH0NXV0fSxG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Aug 2017 15:23:21 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 83B203F5E1
        for <linux-mips@linux-mips.org>; Sun, 27 Aug 2017 15:23:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4bLcS0kn4JY3 for <linux-mips@linux-mips.org>;
        Sun, 27 Aug 2017 15:23:12 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 9A6B63F53C
        for <linux-mips@linux-mips.org>; Sun, 27 Aug 2017 15:23:11 +0200 (CEST)
Date:   Sun, 27 Aug 2017 15:23:10 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Add basic R5900 support
Message-ID: <20170827132309.GA32166@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59814
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
 arch/mips/Kconfig                | 13 +++++++++++++
 arch/mips/include/asm/cpu-type.h |  4 ++++
 arch/mips/include/asm/cpu.h      |  6 ++++++
 arch/mips/include/asm/module.h   |  2 ++
 arch/mips/kernel/cpu-probe.c     | 10 ++++++++++
 5 files changed, 35 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..2a3592032861 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1708,6 +1708,16 @@ config CPU_BMIPS
 	help
 	  Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
 
+config CPU_R5900
+	bool "R5900"
+	depends on SYS_HAS_CPU_R5900
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select IRQ_MIPS_CPU
+	select CPU_HAS_WB
+	help
+	  MIPS Technologies R5900 processor (Emotion Engine in Sony Playstation 2).
+
 config CPU_XLR
 	bool "Netlogic XLR SoC"
 	depends on SYS_HAS_CPU_XLR
@@ -1938,6 +1948,9 @@ config SYS_HAS_CPU_R5432
 config SYS_HAS_CPU_R5500
 	bool
 
+config SYS_HAS_CPU_R5900
+	bool
+
 config SYS_HAS_CPU_R6000
 	bool
 
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
index 98f59307e6a3..f332aaa9e69b 100644
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
@@ -326,6 +327,11 @@ enum cpu_type_enum {
 
 	CPU_QEMU_GENERIC,
 
+	/*
+	 * Playstation 2 processors
+	 */
+	CPU_R5900,
+
 	CPU_LAST
 };
 
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
index 1aba27786bd5..b8bed9f26f8d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1518,6 +1518,16 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		}
 
 		break;
+	case PRID_IMP_R5900:
+		c->cputype = CPU_R5900;
+		__cpu_name[cpu] = "R5900";
+		c->isa_level = MIPS_CPU_ISA_III;
+		c->tlbsize = 48;
+		c->options = MIPS_CPU_TLB | MIPS_CPU_4K_CACHE |
+			     MIPS_CPU_4KEX | MIPS_CPU_DIVEC |
+			     MIPS_CPU_FPU | MIPS_CPU_32FPR |
+			     MIPS_CPU_COUNTER;
+		break;
 	}
 }
 
-- 
2.13.4
