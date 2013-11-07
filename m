Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 18:12:23 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43747 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823073Ab3KGRJ6cvg0W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 18:09:58 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 6/6] MIPS: Add debugfs file to print the segmentation control registers
Date:   Thu, 7 Nov 2013 17:08:40 +0000
Message-ID: <1383844120-29601-7-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com>
References: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_07_17_09_54
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Add a new mips/segments debugfs file to print the 6 segmentation
control registers for supported cores. A sample from a proAptiv core
is given below:

Segment   Virtual    Size   Access Mode   Physical   Caching   EU
-------   -------    ----   -----------   --------   -------   --
   0      e0000000   512M      MK           UND         U       0
   1      c0000000   512M      MSK          UND         U       0
   2      a0000000   512M      UK           000         2       0
   3      80000000   512M      UK           000         3       0
   4      40000000    1G       MUSK         UND         U       1
   5      00000000    1G       MUSK         UND         U       1

Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h |   4 ++
 arch/mips/include/asm/cpu.h          |   1 +
 arch/mips/include/asm/mipsregs.h     |  29 +++++++++
 arch/mips/kernel/Makefile            |   1 +
 arch/mips/kernel/cpu-probe.c         |   2 +
 arch/mips/kernel/segment.c           | 110 +++++++++++++++++++++++++++++++++++
 6 files changed, 147 insertions(+)
 create mode 100644 arch/mips/kernel/segment.c

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 296606b..6e70b03 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -23,6 +23,10 @@
 #ifndef cpu_has_tlbinv
 #define cpu_has_tlbinv		(cpu_data[0].options & MIPS_CPU_TLBINV)
 #endif
+#ifndef cpu_has_segments
+#define cpu_has_segments	(cpu_data[0].options & MIPS_CPU_SEGMENTS)
+#endif
+
 
 /*
  * For the moment we don't consider R6000 and R8000 so we can assume that
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index ca5827c..9bb2abe 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -351,6 +351,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_RIXI		0x00800000 /* CPU has TLB Read/eXec Inhibit */
 #define MIPS_CPU_MICROMIPS	0x01000000 /* CPU has microMIPS capability */
 #define MIPS_CPU_TLBINV		0x02000000 /* CPU supports TLBINV/F */
+#define MIPS_CPU_SEGMENTS	0x04000000 /* CPU supports Segmentation Control registers */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 303bb46..cb57e07 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -666,6 +666,26 @@
 #define MIPS_FPIR_L		(_ULCAST_(1) << 21)
 #define MIPS_FPIR_F64		(_ULCAST_(1) << 22)
 
+/*
+ * Bits in the MIPS32 Memory Segmentation registers.
+ */
+#define MIPS_SEGCFG_PA_SHIFT	9
+#define MIPS_SEGCFG_PA		(_ULCAST_(127) << MIPS_SEGCFG_PA_SHIFT)
+#define MIPS_SEGCFG_AM_SHIFT	4
+#define MIPS_SEGCFG_AM		(_ULCAST_(7) << MIPS_SEGCFG_AM_SHIFT)
+#define MIPS_SEGCFG_EU_SHIFT	3
+#define MIPS_SEGCFG_EU		(_ULCAST_(1) << MIPS_SEGCFG_EU_SHIFT)
+#define MIPS_SEGCFG_C_SHIFT	0
+#define MIPS_SEGCFG_C		(_ULCAST_(7) << MIPS_SEGCFG_C_SHIFT)
+
+#define MIPS_SEGCFG_UUSK	_ULCAST_(7)
+#define MIPS_SEGCFG_USK		_ULCAST_(5)
+#define MIPS_SEGCFG_MUSUK	_ULCAST_(4)
+#define MIPS_SEGCFG_MUSK	_ULCAST_(3)
+#define MIPS_SEGCFG_MSK		_ULCAST_(2)
+#define MIPS_SEGCFG_MK		_ULCAST_(1)
+#define MIPS_SEGCFG_UK		_ULCAST_(0)
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -1153,6 +1173,15 @@ do {									\
 #define read_c0_ebase()		__read_32bit_c0_register($15, 1)
 #define write_c0_ebase(val)	__write_32bit_c0_register($15, 1, val)
 
+/* MIPSR3 */
+#define read_c0_segctl0()	__read_32bit_c0_register($5, 2)
+#define write_c0_segctl0(val)	__write_32bit_c0_register($5, 2, val)
+
+#define read_c0_segctl1()	__read_32bit_c0_register($5, 3)
+#define write_c0_segctl1(val)	__write_32bit_c0_register($5, 3, val)
+
+#define read_c0_segctl2()	__read_32bit_c0_register($5, 4)
+#define write_c0_segctl2(val)	__write_32bit_c0_register($5, 4, val)
 
 /* Cavium OCTEON (cnMIPS) */
 #define read_c0_cvmcount()	__read_ulong_c0_register($9, 6)
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 1c1b717..b95eb741 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_CSRC_R4K)		+= csrc-r4k.o
 obj-$(CONFIG_CSRC_SB1250)	+= csrc-sb1250.o
 obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
 
+obj-$(CONFIG_DEBUG_FS)		+= segment.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 obj-$(CONFIG_MODULES_USE_ELF_RELA) += module-rela.o
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index de364ac..beea299 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -300,6 +300,8 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->options |= MIPS_CPU_MICROMIPS;
 	if (config3 & MIPS_CONF3_VZ)
 		c->ases |= MIPS_ASE_VZ;
+	if (config3 & MIPS_CONF3_SC)
+		c->options |= MIPS_CPU_SEGMENTS;
 
 	return config3 & MIPS_CONF_M;
 }
diff --git a/arch/mips/kernel/segment.c b/arch/mips/kernel/segment.c
new file mode 100644
index 0000000..076ead2
--- /dev/null
+++ b/arch/mips/kernel/segment.c
@@ -0,0 +1,110 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Imagination Technologies Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <asm/cpu.h>
+#include <asm/mipsregs.h>
+
+static void build_segment_config(char *str, unsigned int cfg)
+{
+	unsigned int am;
+	static const char * const am_str[] = {
+		"UK", "MK", "MSK", "MUSK", "MUSUK", "USK",
+		"RSRVD", "UUSK"};
+
+	/* Segment access mode. */
+	am = (cfg & MIPS_SEGCFG_AM) >> MIPS_SEGCFG_AM_SHIFT;
+	str += sprintf(str, "%-5s", am_str[am]);
+
+	/*
+	 * Access modes MK, MSK and MUSK are mapped segments. Therefore
+	 * there is no direct physical address mapping.
+	 */
+	if ((am == 0) || (am > 3)) {
+		str += sprintf(str, "         %03lx",
+			((cfg & MIPS_SEGCFG_PA) >> MIPS_SEGCFG_PA_SHIFT));
+		str += sprintf(str, "         %01ld",
+			((cfg & MIPS_SEGCFG_C) >> MIPS_SEGCFG_C_SHIFT));
+	} else {
+		str += sprintf(str, "         UND");
+		str += sprintf(str, "         U");
+	}
+
+	/* Exception configuration. */
+	str += sprintf(str, "       %01ld\n",
+		((cfg & MIPS_SEGCFG_EU) >> MIPS_SEGCFG_EU_SHIFT));
+}
+
+static int show_segments(struct seq_file *m, void *v)
+{
+	unsigned int segcfg;
+	char str[42];
+
+	seq_puts(m, "Segment   Virtual    Size   Access Mode   Physical   Caching   EU\n");
+	seq_puts(m, "-------   -------    ----   -----------   --------   -------   --\n");
+
+	segcfg = read_c0_segctl0();
+	build_segment_config(str, segcfg);
+	seq_printf(m, "   0      e0000000   512M      %s", str);
+
+	segcfg >>= 16;
+	build_segment_config(str, segcfg);
+	seq_printf(m, "   1      c0000000   512M      %s", str);
+
+	segcfg = read_c0_segctl1();
+	build_segment_config(str, segcfg);
+	seq_printf(m, "   2      a0000000   512M      %s", str);
+
+	segcfg >>= 16;
+	build_segment_config(str, segcfg);
+	seq_printf(m, "   3      80000000   512M      %s", str);
+
+	segcfg = read_c0_segctl2();
+	build_segment_config(str, segcfg);
+	seq_printf(m, "   4      40000000    1G       %s", str);
+
+	segcfg >>= 16;
+	build_segment_config(str, segcfg);
+	seq_printf(m, "   5      00000000    1G       %s\n", str);
+
+	return 0;
+}
+
+static int segments_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, show_segments, NULL);
+}
+
+static const struct file_operations segments_fops = {
+	.open		= segments_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init segments_info(void)
+{
+	extern struct dentry *mips_debugfs_dir;
+	struct dentry *segments;
+
+	if (cpu_has_segments) {
+		if (!mips_debugfs_dir)
+			return -ENODEV;
+
+		segments = debugfs_create_file("segments", S_IRUGO,
+					       mips_debugfs_dir, NULL,
+					       &segments_fops);
+		if (!segments)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+device_initcall(segments_info);
-- 
1.8.4
