Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2013 17:14:12 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:1075 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6853541Ab3KNQM5u0FVs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Nov 2013 17:12:57 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2 04/12] MIPS: features: Add initial support for Segmentation Control registers
Date:   Thu, 14 Nov 2013 16:12:24 +0000
Message-ID: <1384445552-30573-5-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
References: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_14_16_12_54
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38524
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

MIPS32R3 introduced a new set of Segmentation Control registers which
increase the flexibility of the segmented-based memory scheme.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h |  4 ++++
 arch/mips/include/asm/cpu.h          |  1 +
 arch/mips/include/asm/mipsregs.h     | 29 +++++++++++++++++++++++++++++
 arch/mips/kernel/cpu-probe.c         |  2 ++
 4 files changed, 36 insertions(+)

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
index fd3bc43..7974be9 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -349,6 +349,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_RIXI		0x00800000 /* CPU has TLB Read/eXec Inhibit */
 #define MIPS_CPU_MICROMIPS	0x01000000 /* CPU has microMIPS capability */
 #define MIPS_CPU_TLBINV		0x02000000 /* CPU supports TLBINV/F */
+#define MIPS_CPU_SEGMENTS	0x04000000 /* CPU supports Segmentation Control registers */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 412fe99..0558f9b 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -664,6 +664,26 @@
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
@@ -1138,6 +1158,15 @@ do {									\
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
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 5dac95a..b534d33 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -272,6 +272,8 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->options |= MIPS_CPU_MICROMIPS;
 	if (config3 & MIPS_CONF3_VZ)
 		c->ases |= MIPS_ASE_VZ;
+	if (config3 & MIPS_CONF3_SC)
+		c->options |= MIPS_CPU_SEGMENTS;
 
 	return config3 & MIPS_CONF_M;
 }
-- 
1.8.4.3
