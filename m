Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 22:26:33 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:23854 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23754595AbYKRWYF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 22:24:05 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4923406f0000>; Tue, 18 Nov 2008 17:23:43 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:41 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:40 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mAIMNZe0004839;
	Tue, 18 Nov 2008 14:23:35 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mAIMNZke004838;
	Tue, 18 Nov 2008 14:23:35 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 08/26] MIPS: Add Cavium OCTEON processor constants and CPU probe.
Date:	Tue, 18 Nov 2008 14:23:23 -0800
Message-Id: <1227047013-4785-8-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <49233FDE.3010404@caviumnetworks.com>
References: <49233FDE.3010404@caviumnetworks.com>
X-OriginalArrivalTime: 18 Nov 2008 22:23:40.0456 (UTC) FILETIME=[4F039280:01C949CC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Add OCTEON constants to asm/cpu.h and asm/module.h.

Add probe function for Cavium OCTEON CPUs and hook it up.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/cpu.h    |   14 ++++++++++++++
 arch/mips/include/asm/module.h |    2 ++
 arch/mips/kernel/cpu-probe.c   |   25 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 229a786..c018727 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
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
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index e2e09b2..d94085a 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -116,6 +116,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "SB1 "
 #elif defined CONFIG_CPU_LOONGSON2
 #define MODULE_PROC_FAMILY "LOONGSON2 "
+#elif defined CONFIG_CPU_CAVIUM_OCTEON
+#define MODULE_PROC_FAMILY "OCTEON "
 #else
 #error MODULE_PROC_FAMILY undefined for your processor configuration
 #endif
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c9207b5..6b3c63d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -154,6 +154,7 @@ void __init check_wait(void)
 	case CPU_25KF:
 	case CPU_PR4450:
 	case CPU_BCM3302:
+	case CPU_CAVIUM_OCTEON:
 		cpu_wait = r4k_wait;
 		break;
 
@@ -875,6 +876,27 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 	}
 }
 
+static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
+{
+	decode_configs(c);
+	switch (c->processor_id & 0xff00) {
+	case PRID_IMP_CAVIUM_CN38XX:
+	case PRID_IMP_CAVIUM_CN31XX:
+	case PRID_IMP_CAVIUM_CN30XX:
+	case PRID_IMP_CAVIUM_CN58XX:
+	case PRID_IMP_CAVIUM_CN56XX:
+	case PRID_IMP_CAVIUM_CN50XX:
+	case PRID_IMP_CAVIUM_CN52XX:
+		c->cputype = CPU_CAVIUM_OCTEON;
+		__cpu_name[cpu] = "Cavium Octeon";
+		break;
+	default:
+		printk(KERN_INFO "Unknown Octeon chip!\n");
+		c->cputype = CPU_UNKNOWN;
+		break;
+	}
+}
+
 const char *__cpu_name[NR_CPUS];
 
 __cpuinit void cpu_probe(void)
@@ -909,6 +931,9 @@ __cpuinit void cpu_probe(void)
 	case PRID_COMP_NXP:
 		cpu_probe_nxp(c, cpu);
 		break;
+	case PRID_COMP_CAVIUM:
+		cpu_probe_cavium(c, cpu);
+		break;
 	}
 
 	BUG_ON(!__cpu_name[cpu]);
-- 
1.5.6.5
