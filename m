Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Dec 2008 19:21:37 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:2485 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24208383AbYLVTVS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Dec 2008 19:21:18 +0000
Received: (qmail 15756 invoked from network); 22 Dec 2008 20:20:50 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 22 Dec 2008 20:20:50 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 2/2] Alchemy: provide cpu feature overrides.
Date:	Mon, 22 Dec 2008 20:21:08 +0100
Message-Id: <1229973668-18182-2-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1229973668-18182-1-git-send-email-mano@roarinelk.homelinux.net>
References: <1229973668-18182-1-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Add cpu feature override constants for Alchemy.

Code generated for Alchemy does not use all MIPS32r1 features.  Add cpu
feature overrides tailored for Alchemy chips and help GCC create better
code.  As a nice sideeffect the size of the resulting kernel is reduced
by a few kilobytes (~200kB for a non-modular db1200 devboard build).

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 .../asm/mach-au1x00/cpu-feature-overrides.h        |   51 ++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
new file mode 100644
index 0000000..725e575
--- /dev/null
+++ b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
@@ -0,0 +1,51 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_tlb			1
+#define cpu_has_4kex			1
+#define cpu_has_3k_cache		0
+#define cpu_has_4k_cache		1
+#define cpu_has_tx39_cache		0
+#define cpu_has_fpu			0
+#define cpu_has_32fpr			0
+#define cpu_has_counter			1
+#define cpu_has_watch			1
+#define cpu_has_divec			1
+#define cpu_has_vce			0
+#define cpu_has_cache_cdex_p		0
+#define cpu_has_cache_cdex_s		0
+#define cpu_has_mcheck			1
+#define cpu_has_ejtag			1
+#define cpu_has_llsc			1
+#define cpu_has_mips16			0
+#define cpu_has_mdmx			0
+#define cpu_has_mips3d			0
+#define cpu_has_smartmips		0
+#define cpu_has_vtag_icache		0
+#define cpu_has_dc_aliases		0
+#define cpu_has_ic_fills_f_dc		1
+#define cpu_has_pindexed_cache		0
+#define cpu_has_mips32r1		1
+#define cpu_has_mips32r2		0
+#define cpu_has_mips64r1		0
+#define cpu_has_mips64r2		0
+#define cpu_has_dsp			0
+#define cpu_has_mipsmt			0
+#define cpu_has_userlocal		0
+#define cpu_has_nofpuex			0
+#define cpu_has_64bits			0
+#define cpu_has_64bit_zero_reg		0
+#define cpu_has_vint			0
+#define cpu_has_veic			0
+#define cpu_has_inclusive_pcaches	0
+
+#define cpu_dcache_line_size()		32
+#define cpu_icache_line_size()		32
+
+#endif /* __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H */
-- 
1.6.0.4
