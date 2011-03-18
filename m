Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2011 14:27:48 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:4554 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491819Ab1CRN1o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2011 14:27:44 +0100
X-TM-IMSS-Message-ID: <2f3161520001a99d@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 2f3161520001a99d ; Fri, 18 Mar 2011 06:27:33 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 18 Mar 2011 06:22:45 -0700
Date:   Fri, 18 Mar 2011 18:58:02 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 1/7] Netlogic XLR/XLS processor IDs.
Message-ID: <82409e0e9e91d1589afa1d6fb1375da89b8854b3.1300452150.git.jayachandranc@netlogicmicro.com>
References: <cover.1300452150.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1300452150.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 18 Mar 2011 13:22:46.0035 (UTC) FILETIME=[91CB6E30:01CBE56F]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

Add Netlogic Microsystems company ID and processor IDs for XLR
and XLS processors for CPU probe. Add CPU_XLR to cpu_type_enum.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/cpu.h  |   27 ++++++++++++++++++++
 arch/mips/kernel/cpu-probe.c |   55 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 8687753..34c0d3c 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -33,6 +33,7 @@
 #define PRID_COMP_TOSHIBA	0x070000
 #define PRID_COMP_LSI		0x080000
 #define PRID_COMP_LEXRA		0x0b0000
+#define PRID_COMP_NETLOGIC	0x0c0000
 #define PRID_COMP_CAVIUM	0x0d0000
 #define PRID_COMP_INGENIC	0xd00000
 
@@ -142,6 +143,31 @@
 #define PRID_IMP_JZRISC        0x0200
 
 /*
+ * These are the PRID's for when 23:16 == PRID_COMP_NETLOGIC
+ */
+#define PRID_IMP_NETLOGIC_XLR732	0x0000
+#define PRID_IMP_NETLOGIC_XLR716	0x0200
+#define PRID_IMP_NETLOGIC_XLR532	0x0900
+#define PRID_IMP_NETLOGIC_XLR308	0x0600
+#define PRID_IMP_NETLOGIC_XLR532C	0x0800
+#define PRID_IMP_NETLOGIC_XLR516C	0x0a00
+#define PRID_IMP_NETLOGIC_XLR508C	0x0b00
+#define PRID_IMP_NETLOGIC_XLR308C	0x0f00
+#define PRID_IMP_NETLOGIC_XLS608	0x8000
+#define PRID_IMP_NETLOGIC_XLS408	0x8800
+#define PRID_IMP_NETLOGIC_XLS404	0x8c00
+#define PRID_IMP_NETLOGIC_XLS208	0x8e00
+#define PRID_IMP_NETLOGIC_XLS204	0x8f00
+#define PRID_IMP_NETLOGIC_XLS108	0xce00
+#define PRID_IMP_NETLOGIC_XLS104	0xcf00
+#define PRID_IMP_NETLOGIC_XLS616B	0x4000
+#define PRID_IMP_NETLOGIC_XLS608B	0x4a00
+#define PRID_IMP_NETLOGIC_XLS416B	0x4400
+#define PRID_IMP_NETLOGIC_XLS412B	0x4c00
+#define PRID_IMP_NETLOGIC_XLS408B	0x4e00
+#define PRID_IMP_NETLOGIC_XLS404B	0x4f00
+
+/*
  * Definitions for 7:0 on legacy processors
  */
 
@@ -234,6 +260,7 @@ enum cpu_type_enum {
 	 */
 	CPU_5KC, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
 	CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS, CPU_CAVIUM_OCTEON2,
+	CPU_XLR,
 
 	CPU_LAST
 };
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index f65d4c8..a995d56 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -988,6 +988,59 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 	}
 }
 
+static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
+{
+	decode_configs(c);
+
+	c->options = (MIPS_CPU_TLB     |
+			MIPS_CPU_4KEX    |
+			MIPS_CPU_COUNTER |
+			MIPS_CPU_DIVEC   |
+			MIPS_CPU_WATCH   |
+			MIPS_CPU_EJTAG   |
+			MIPS_CPU_LLSC);
+
+	switch (c->processor_id & 0xff00) {
+	case PRID_IMP_NETLOGIC_XLR732:
+	case PRID_IMP_NETLOGIC_XLR716:
+	case PRID_IMP_NETLOGIC_XLR532:
+	case PRID_IMP_NETLOGIC_XLR308:
+	case PRID_IMP_NETLOGIC_XLR532C:
+	case PRID_IMP_NETLOGIC_XLR516C:
+	case PRID_IMP_NETLOGIC_XLR508C:
+	case PRID_IMP_NETLOGIC_XLR308C:
+		c->cputype = CPU_XLR;
+		__cpu_name[cpu] = "Netlogic XLR";
+		break;
+
+	case PRID_IMP_NETLOGIC_XLS608:
+	case PRID_IMP_NETLOGIC_XLS408:
+	case PRID_IMP_NETLOGIC_XLS404:
+	case PRID_IMP_NETLOGIC_XLS208:
+	case PRID_IMP_NETLOGIC_XLS204:
+	case PRID_IMP_NETLOGIC_XLS108:
+	case PRID_IMP_NETLOGIC_XLS104:
+	case PRID_IMP_NETLOGIC_XLS616B:
+	case PRID_IMP_NETLOGIC_XLS608B:
+	case PRID_IMP_NETLOGIC_XLS416B:
+	case PRID_IMP_NETLOGIC_XLS412B:
+	case PRID_IMP_NETLOGIC_XLS408B:
+	case PRID_IMP_NETLOGIC_XLS404B:
+		c->cputype = CPU_XLR;
+		__cpu_name[cpu] = "Netlogic XLS";
+		break;
+
+	default:
+		printk(KERN_INFO "Unknown Netlogic chip id [%02x]!\n",
+		       c->processor_id);
+		c->cputype = CPU_XLR;
+		break;
+	}
+
+	c->isa_level = MIPS_CPU_ISA_M64R1;
+	c->tlbsize = ((read_c0_config1() >> 25) & 0x3f) + 1;
+}
+
 #ifdef CONFIG_64BIT
 /* For use by uaccess.h */
 u64 __ua_limit;
@@ -1034,6 +1087,8 @@ __cpuinit void cpu_probe(void)
 		break;
 	case PRID_COMP_INGENIC:
 		cpu_probe_ingenic(c, cpu);
+	case PRID_COMP_NETLOGIC:
+		cpu_probe_netlogic(c, cpu);
 		break;
 	}
 
-- 
1.7.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
