Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2011 05:07:21 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:1462 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1490975Ab1DADGx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Apr 2011 05:06:53 +0200
X-TM-IMSS-Message-ID: <7511d71000009b48@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 7511d71000009b48 ; Thu, 31 Mar 2011 20:06:43 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 31 Mar 2011 20:07:34 -0700
Date:   Fri, 1 Apr 2011 08:37:08 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 2/6] mach-netlogic include directory and files.
Message-ID: <6841269a1e6689072a1e87958a2bc579a25d0bdd.1301626288.git.jayachandranc@netlogicmicro.com>
References: <cover.1301626288.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1301626288.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 01 Apr 2011 03:07:35.0014 (UTC) FILETIME=[F2E51860:01CBF019]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

Add war.h and irq.h with XLR/XLS definitions.
Add feature overrides for XLR/XLS.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 .../asm/mach-netlogic/cpu-feature-overrides.h      |   47 ++++++++++++++++++++
 arch/mips/include/asm/mach-netlogic/irq.h          |   14 ++++++
 arch/mips/include/asm/mach-netlogic/war.h          |   26 +++++++++++
 3 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-netlogic/irq.h
 create mode 100644 arch/mips/include/asm/mach-netlogic/war.h

diff --git a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
new file mode 100644
index 0000000..3b72827
--- /dev/null
+++ b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
@@ -0,0 +1,47 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 Netlogic Microsystems
+ * Copyright (C) 2003 Ralf Baechle
+ */
+#ifndef __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_4kex		1
+#define cpu_has_4k_cache	1
+#define cpu_has_watch		1
+#define cpu_has_mips16		0
+#define cpu_has_counter		1
+#define cpu_has_divec		1
+#define cpu_has_vce		0
+#define cpu_has_cache_cdex_p	0
+#define cpu_has_cache_cdex_s	0
+#define cpu_has_prefetch	1
+#define cpu_has_mcheck		1
+#define cpu_has_ejtag		1
+
+#define cpu_has_llsc		1
+#define cpu_has_vtag_icache	0
+#define cpu_has_dc_aliases	0
+#define cpu_has_ic_fills_f_dc	0
+#define cpu_has_dsp		0
+#define cpu_has_mipsmt		0
+#define cpu_has_userlocal	0
+#define cpu_icache_snoops_remote_store	0
+
+#define cpu_has_nofpuex		0
+#define cpu_has_64bits		1
+
+#define cpu_has_mips32r1	1
+#define cpu_has_mips32r2	0
+#define cpu_has_mips64r1	1
+#define cpu_has_mips64r2	0
+
+#define cpu_has_inclusive_pcaches	0
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+
+#endif /* __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-netlogic/irq.h b/arch/mips/include/asm/mach-netlogic/irq.h
new file mode 100644
index 0000000..b590245
--- /dev/null
+++ b/arch/mips/include/asm/mach-netlogic/irq.h
@@ -0,0 +1,14 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 Netlogic Microsystems.
+ */
+#ifndef __ASM_NETLOGIC_IRQ_H
+#define __ASM_NETLOGIC_IRQ_H
+
+#define NR_IRQS			64
+#define MIPS_CPU_IRQ_BASE	0
+
+#endif /* __ASM_NETLOGIC_IRQ_H */
diff --git a/arch/mips/include/asm/mach-netlogic/war.h b/arch/mips/include/asm/mach-netlogic/war.h
new file mode 100644
index 0000000..22da893
--- /dev/null
+++ b/arch/mips/include/asm/mach-netlogic/war.h
@@ -0,0 +1,26 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 Netlogic Microsystems.
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MIPS_MACH_NLM_WAR_H
+#define __ASM_MIPS_MACH_NLM_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_NLM_WAR_H */
-- 
1.7.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
