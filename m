Message-Id:
 <96a6fe21ee649e119f4d6b8053e0c1cd781c27a8.1304712046.git.jayachandranc@netlogicmicro.com>
In-Reply-To: <cover.1304712046.git.jayachandranc@netlogicmicro.com>
References: <cover.1304712046.git.jayachandranc@netlogicmicro.com>
From: Jayachandran C <jayachandranc@netlogicmicro.com>
Date: Fri, 22 Apr 2011 02:58:37 +0530
Subject: [PATCH 1/8] Netlogic XLR/XLS processor IDs.
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Message-ID: <20110421212837.HnTQD0DvzkV4UR5ETJuV3czOQq7goM2Ag4bNzKVPS5I@z>

Add Netlogic Microsystems company ID and processor IDs for XLR
and XLS processors for CPU probe. Add CPU_XLR to cpu_type_enum.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/cpu.h  |   27 ++++++++++++++++++++
 arch/mips/kernel/cpu-probe.c |   56 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 0 deletions(-)

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
index f65d4c8..c7b7eb2 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -988,6 +988,59 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 	}
 }
 
+static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
+{
+	decode_configs(c);
+
+	c->options = (MIPS_CPU_TLB       |
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
@@ -1035,6 +1088,9 @@ __cpuinit void cpu_probe(void)
 	case PRID_COMP_INGENIC:
 		cpu_probe_ingenic(c, cpu);
 		break;
+	case PRID_COMP_NETLOGIC:
+		cpu_probe_netlogic(c, cpu);
+		break;
 	}
 
 	BUG_ON(!__cpu_name[cpu]);
-- 
1.7.1
