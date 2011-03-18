Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2011 14:29:56 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:4556 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491882Ab1CRN1o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2011 14:27:44 +0100
X-TM-IMSS-Message-ID: <2f31622d0001a99f@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 2f31622d0001a99f ; Fri, 18 Mar 2011 06:27:33 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 18 Mar 2011 06:23:42 -0700
Date:   Fri, 18 Mar 2011 18:58:58 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 3/7] Cache, TLB support, and feature overrides for XLR
Message-ID: <a632e957d813fc652a23cfafeb13d3b39b914f94.1300452150.git.jayachandranc@netlogicmicro.com>
References: <cover.1300452150.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1300452150.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 18 Mar 2011 13:23:42.0332 (UTC) FILETIME=[B359ABC0:01CBE56F]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

CPU_XLR case added to mm/tlbex.c
CPU_XLR case added to mm/c-r4k.c for PINDEX attribute
Feature overrides for XLR cpu.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 .../asm/mach-netlogic/cpu-feature-overrides.h      |   47 ++++++++++++++++++++
 arch/mips/mm/c-r4k.c                               |    1 +
 arch/mips/mm/tlbex.c                               |    1 +
 3 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
new file mode 100644
index 0000000..343926b
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
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index b4923a7..1ee251f 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1006,6 +1006,7 @@ static void __cpuinit probe_pcache(void)
 	case CPU_25KF:
 	case CPU_SB1:
 	case CPU_SB1A:
+	case CPU_XLR:
 		c->dcache.flags |= MIPS_CACHE_PINDEX;
 		break;
 
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 04f9e17..c9f9e27 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -404,6 +404,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_5KC:
 	case CPU_TX49XX:
 	case CPU_PR4450:
+	case CPU_XLR:
 		uasm_i_nop(p);
 		tlbw(p);
 		break;
-- 
1.7.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
