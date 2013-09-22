Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Sep 2013 00:06:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36885 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671Ab3IVWG1Vx53a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Sep 2013 00:06:27 +0200
Date:   Sun, 22 Sep 2013 23:06:27 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: DECstation CPU feature overrides
Message-ID: <alpine.LFD.2.03.1309222300060.16797@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 Please apply.  I can't believe I sat on this so long...

  Maciej

linux-dec-cpu-overrides.patch
Index: linux/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
===================================================================
--- /dev/null
+++ linux/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
@@ -0,0 +1,87 @@
+/*
+ *	CPU feature overrides for DECstation systems.  Two variations
+ *	are generally applicable.
+ *
+ *	Copyright (C) 2013  Maciej W. Rozycki
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+#ifndef __ASM_MACH_DEC_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_DEC_CPU_FEATURE_OVERRIDES_H
+
+/* Generic ones first.  */
+#define cpu_has_tlb			1
+#define cpu_has_tx39_cache		0
+#define cpu_has_fpu			1
+#define cpu_has_divec			0
+#define cpu_has_prefetch		0
+#define cpu_has_mcheck			0
+#define cpu_has_ejtag			0
+#define cpu_has_mips16			0
+#define cpu_has_mdmx			0
+#define cpu_has_mips3d			0
+#define cpu_has_smartmips		0
+#define cpu_has_rixi			0
+#define cpu_has_vtag_icache		0
+#define cpu_has_ic_fills_f_dc		0
+#define cpu_has_pindexed_dcache		0
+#define cpu_has_local_ebase		0
+#define cpu_icache_snoops_remote_store	1
+#define cpu_has_mips_4			0
+#define cpu_has_mips_5			0
+#define cpu_has_mips32r1		0
+#define cpu_has_mips32r2		0
+#define cpu_has_mips64r1		0
+#define cpu_has_mips64r2		0
+#define cpu_has_dsp			0
+#define cpu_has_mipsmt			0
+#define cpu_has_userlocal		0
+
+/* R3k-specific ones.  */
+#ifdef CONFIG_CPU_R3000
+#define cpu_has_4kex			0
+#define cpu_has_3k_cache		1
+#define cpu_has_4k_cache		0
+#define cpu_has_32fpr			0
+#define cpu_has_counter			0
+#define cpu_has_watch			0
+#define cpu_has_vce			0
+#define cpu_has_cache_cdex_p		0
+#define cpu_has_cache_cdex_s		0
+#define cpu_has_llsc			0
+#define cpu_has_dc_aliases		0
+#define cpu_has_mips_2			0
+#define cpu_has_mips_3			0
+#define cpu_has_nofpuex			1
+#define cpu_has_inclusive_pcaches	0
+#define cpu_dcache_line_size()		4
+#define cpu_icache_line_size()		4
+#define cpu_scache_line_size()		0
+#endif /* CONFIG_CPU_R3000 */
+
+/* R4k-specific ones.  */
+#ifdef CONFIG_CPU_R4X00
+#define cpu_has_4kex			1
+#define cpu_has_3k_cache		0
+#define cpu_has_4k_cache		1
+#define cpu_has_32fpr			1
+#define cpu_has_counter			1
+#define cpu_has_watch			1
+#define cpu_has_vce			1
+#define cpu_has_cache_cdex_p		1
+#define cpu_has_cache_cdex_s		1
+#define cpu_has_llsc			1
+#define cpu_has_dc_aliases		(PAGE_SIZE < 0x4000)
+#define cpu_has_mips_2			1
+#define cpu_has_mips_3			1
+#define cpu_has_nofpuex			0
+#define cpu_has_inclusive_pcaches	1
+#define cpu_dcache_line_size()		16
+#define cpu_icache_line_size()		16
+#define cpu_scache_line_size()		32
+#endif /* CONFIG_CPU_R4X00 */
+
+#endif /* __ASM_MACH_DEC_CPU_FEATURE_OVERRIDES_H */
