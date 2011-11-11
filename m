Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 07:42:54 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:46104 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903956Ab1KKGlN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 07:41:13 +0100
Received: (qmail 16053 invoked from network); 11 Nov 2011 06:41:02 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Nov 2011 06:41:02 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Thu, 10 Nov 2011 22:41:02 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH V2 5/8] MIPS: BMIPS: Introduce bmips.h
Date:   Thu, 10 Nov 2011 22:30:28 -0800
Message-Id: <82d0f7976bd482696b7dfefe4953859b@localhost>
In-Reply-To: <5f9666eb295ce196b2a9688afab07dea@localhost>
References: <5f9666eb295ce196b2a9688afab07dea@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10046

bmips.h contains BMIPS definitions that are useful for SMP, vector
relocation, performance counters, etc.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---

V2:

Rewrite all of bmips_{read,write}_zscm_reg in assembly.

Add bmips_cpu_offset.


 arch/mips/include/asm/bmips.h |  109 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/bmips.h

diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
new file mode 100644
index 0000000..1ec4a6e
--- /dev/null
+++ b/arch/mips/include/asm/bmips.h
@@ -0,0 +1,109 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 by Kevin Cernekee (cernekee@gmail.com)
+ *
+ * Definitions for BMIPS processors
+ */
+#ifndef _ASM_BMIPS_H
+#define _ASM_BMIPS_H
+
+#include <linux/compiler.h>
+#include <linux/linkage.h>
+#include <asm/addrspace.h>
+#include <asm/mipsregs.h>
+
+/* NOTE: the CBR register returns a PA, and it can be above 0xff00_0000 */
+#define BMIPS_GET_CBR()			((void __iomem *)(CKSEG1 | \
+					 (unsigned long) \
+					 ((read_c0_brcm_cbr() >> 18) << 18)))
+
+#define BMIPS_RAC_CONFIG		0x00000000
+#define BMIPS_RAC_ADDRESS_RANGE		0x00000004
+#define BMIPS_RAC_CONFIG_1		0x00000008
+#define BMIPS_L2_CONFIG			0x0000000c
+#define BMIPS_LMB_CONTROL		0x0000001c
+#define BMIPS_SYSTEM_BASE		0x00000020
+#define BMIPS_PERF_GLOBAL_CONTROL	0x00020000
+#define BMIPS_PERF_CONTROL_0		0x00020004
+#define BMIPS_PERF_CONTROL_1		0x00020008
+#define BMIPS_PERF_COUNTER_0		0x00020010
+#define BMIPS_PERF_COUNTER_1		0x00020014
+#define BMIPS_PERF_COUNTER_2		0x00020018
+#define BMIPS_PERF_COUNTER_3		0x0002001c
+#define BMIPS_RELO_VECTOR_CONTROL_0	0x00030000
+#define BMIPS_RELO_VECTOR_CONTROL_1	0x00038000
+
+#define BMIPS_NMI_RESET_VEC		0x80000000
+#define BMIPS_WARM_RESTART_VEC		0x80000380
+
+#define ZSCM_REG_BASE			0x97000000
+
+#if !defined(__ASSEMBLY__)
+
+#include <linux/cpumask.h>
+#include <asm/r4kcache.h>
+
+extern struct plat_smp_ops bmips_smp_ops;
+extern char bmips_reset_nmi_vec;
+extern char bmips_reset_nmi_vec_end;
+extern char bmips_smp_movevec;
+extern char bmips_smp_int_vec;
+extern char bmips_smp_int_vec_end;
+
+extern int bmips_smp_enabled;
+extern int bmips_cpu_offset;
+extern cpumask_t bmips_booted_mask;
+
+extern void bmips_ebase_setup(void);
+extern asmlinkage void plat_wired_tlb_setup(void);
+
+static inline unsigned long bmips_read_zscm_reg(unsigned int offset)
+{
+	unsigned long ret;
+
+	__asm__ __volatile__(
+		".set push\n"
+		".set noreorder\n"
+		"cache %1, 0(%2)\n"
+		"sync\n"
+		"ssnop\n"
+		"ssnop\n"
+		"ssnop\n"
+		"ssnop\n"
+		"ssnop\n"
+		"ssnop\n"
+		"ssnop\n"
+		"mfc0 %0, $28, 3\n"
+		"ssnop\n"
+		".set pop\n"
+		: "=&r" (ret)
+		: "i" (Index_Load_Tag_S), "r" (ZSCM_REG_BASE + offset)
+		: "memory");
+	return ret;
+}
+
+static inline void bmips_write_zscm_reg(unsigned int offset, unsigned long data)
+{
+	__asm__ __volatile__(
+		".set push\n"
+		".set noreorder\n"
+		"mtc0 %0, $28, 3\n"
+		"ssnop\n"
+		"ssnop\n"
+		"ssnop\n"
+		"cache %1, 0(%2)\n"
+		"ssnop\n"
+		"ssnop\n"
+		"ssnop\n"
+		: /* no outputs */
+		: "r" (data),
+		  "i" (Index_Store_Tag_S), "r" (ZSCM_REG_BASE + offset)
+		: "memory");
+}
+
+#endif /* !defined(__ASSEMBLY__) */
+
+#endif /* _ASM_BMIPS_H */
-- 
1.7.6.3
