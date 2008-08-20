Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2008 21:20:26 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:64390 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S28585492AbYHTUUU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Aug 2008 21:20:20 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48ac7c7d0000>; Wed, 20 Aug 2008 16:20:13 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 Aug 2008 13:20:12 -0700
Received: from localhost.localdomain ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 Aug 2008 13:20:12 -0700
From:	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 1/2] OCTEON: Add processor-specific constants and detection of CPU variants
Date:	Wed, 20 Aug 2008 13:20:05 -0700
Message-Id: <1219263605-21396-1-git-send-email-tpaoletti@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <48A9E6DA.8030208@caviumnetworks.com>
References: <48A9E6DA.8030208@caviumnetworks.com>
X-OriginalArrivalTime: 20 Aug 2008 20:20:12.0226 (UTC) FILETIME=[262FE220:01C90302]
Return-Path: <Tomaso.Paoletti@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tpaoletti@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Add constants for machine type, processor ID and MODULE_PROC_FAMILY for Octeon.
Add detection of all Cavium-specific ID strings for each processor variant.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
---
 arch/mips/kernel/cpu-probe.c |   35 +++++++++++++++++++++++++++++++++++
 include/asm-mips/bootinfo.h  |    5 +++++
 include/asm-mips/cpu.h       |   14 ++++++++++++++
 include/asm-mips/module.h    |    2 ++
 4 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 335a6ae..3e104db 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -160,6 +160,7 @@ static inline void check_wait(void)
 	case CPU_25KF:
 	case CPU_PR4450:
 	case CPU_BCM3302:
+	case CPU_CAVIUM_OCTEON:
 		cpu_wait = r4k_wait;
 		break;
 
@@ -821,6 +822,35 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c)
 	}
 }
 
+static inline void cpu_probe_cavium(struct cpuinfo_mips *c)
+{
+	switch (c->processor_id & 0xff00) {
+	case PRID_IMP_CAVIUM_CN38XX:
+	case PRID_IMP_CAVIUM_CN31XX:
+	case PRID_IMP_CAVIUM_CN30XX:
+	case PRID_IMP_CAVIUM_CN58XX:
+	case PRID_IMP_CAVIUM_CN56XX:
+	case PRID_IMP_CAVIUM_CN50XX:
+	case PRID_IMP_CAVIUM_CN52XX:
+		c->cputype = CPU_CAVIUM_OCTEON;
+		break;
+	default:
+		printk(KERN_INFO "Unknown Octeon chip!\n");
+		c->cputype = CPU_UNKNOWN;
+		break;
+	}
+
+	c->isa_level = MIPS_CPU_ISA_M64R2;
+	c->options = MIPS_CPU_TLB |     /* CPU has TLB */
+		     MIPS_CPU_4KEX |    /* "R4K" exception model */
+		     MIPS_CPU_COUNTER | /* Cycle count/compare */
+		     MIPS_CPU_WATCH |   /* watchpoint registers */
+		     MIPS_CPU_DIVEC |   /* dedicated int vector */
+		     MIPS_CPU_EJTAG |   /* EJTAG exception */
+		     MIPS_CPU_LLSC;     /* CPU has ll/sc instructions */
+	decode_config1(c);
+}
+
 const char *__cpu_name[NR_CPUS];
 
 /*
@@ -902,6 +932,8 @@ static __cpuinit const char *cpu_to_name(struct cpuinfo_mips *c)
 	case CPU_BCM4710:	name = "Broadcom BCM4710"; break;
 	case CPU_PR4450:	name = "Philips PR4450"; break;
 	case CPU_LOONGSON2:	name = "ICT Loongson-2"; break;
+	case CPU_CAVIUM_OCTEON:	name = "Cavium Octeon"; break;
+
 	default:
 		BUG();
 	}
@@ -941,6 +973,9 @@ __cpuinit void cpu_probe(void)
 	case PRID_COMP_NXP:
 		cpu_probe_nxp(c);
 		break;
+	case PRID_COMP_CAVIUM:
+		cpu_probe_cavium(c);
+		break;
 	default:
 		c->cputype = CPU_UNKNOWN;
 	}
diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
index 610fe3a..ac34028 100644
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -57,6 +57,11 @@
 #define	MACH_MIKROTIK_RB532	0	/* Mikrotik RouterBoard 532 	*/
 #define MACH_MIKROTIK_RB532A	1	/* Mikrotik RouterBoard 532A 	*/
 
+/*
+ * Valid machtype for group CAVIUM
+ */
+#define  MACH_CAVIUM_OCTEON	1	/* Cavium Octeon */
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 extern char *system_type;
diff --git a/include/asm-mips/cpu.h b/include/asm-mips/cpu.h
index 229a786..c018727 100644
--- a/include/asm-mips/cpu.h
+++ b/include/asm-mips/cpu.h
@@ -33,6 +33,7 @@
 #define PRID_COMP_TOSHIBA	0x070000
 #define PRID_COMP_LSI		0x080000
 #define PRID_COMP_LEXRA		0x0b0000
+#define PRID_COMP_CAVIUM	0x0d0000
 
 
 /*
@@ -114,6 +115,18 @@
 #define PRID_IMP_BCM3302	0x9000
 
 /*
+ * These are the PRID's for when 23:16 == PRID_COMP_CAVIUM
+ */
+
+#define PRID_IMP_CAVIUM_CN38XX 0x0000
+#define PRID_IMP_CAVIUM_CN31XX 0x0100
+#define PRID_IMP_CAVIUM_CN30XX 0x0200
+#define PRID_IMP_CAVIUM_CN58XX 0x0300
+#define PRID_IMP_CAVIUM_CN56XX 0x0400
+#define PRID_IMP_CAVIUM_CN50XX 0x0600
+#define PRID_IMP_CAVIUM_CN52XX 0x0700
+
+/*
  * Definitions for 7:0 on legacy processors
  */
 
@@ -203,6 +216,7 @@ enum cpu_type_enum {
 	 * MIPS64 class processors
 	 */
 	CPU_5KC, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
+	CPU_CAVIUM_OCTEON,
 
 	CPU_LAST
 };
diff --git a/include/asm-mips/module.h b/include/asm-mips/module.h
index de6d09e..7b24183 100644
--- a/include/asm-mips/module.h
+++ b/include/asm-mips/module.h
@@ -114,6 +114,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "SB1 "
 #elif defined CONFIG_CPU_LOONGSON2
 #define MODULE_PROC_FAMILY "LOONGSON2 "
+#elif defined CONFIG_CPU_CAVIUM_OCTEON
+#define MODULE_PROC_FAMILY "OCTEON "
 #else
 #error MODULE_PROC_FAMILY undefined for your processor configuration
 #endif
-- 
1.5.3.2
