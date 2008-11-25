Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 23:12:43 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:16064 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S23914932AbYKYXMe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Nov 2008 23:12:34 +0000
Received: (qmail 10397 invoked by uid 1000); 26 Nov 2008 00:12:30 +0100
Date:	Wed, 26 Nov 2008 00:12:30 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	LMO <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2] Alchemy: cpu feature override constants.
Message-ID: <20081125231230.GA10366@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Add cpu feature override constants for Alchemy.

This helps code generation: fls() for instance is compiled without
using the clz instruction; other macros which do runtime feature
detection fall back on safe legacy code as well.  Adding this override
fixes that.  As a sideeffect, the size of a kernel built with an
extended db1200 defconfig is reduced by over 200kB:

   text    data     bss     dec     hex filename
3901089  124160  436528 4461777  4414d1 vmlinux
3676433  124096  436528 4237057  40a701 vmlinux-patched

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
This v2 version fixes a few typos.

 .../asm/mach-au1x00/cpu-feature-overrides.h        |   51 ++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
new file mode 100644
index 0000000..c22492e
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
+#define cpu_has_tlb		1
+#define cpu_has_4kex		1
+#define cpu_has_3k_cache	0
+#define cpu_has_4k_cache	1
+#define cpu_has_tx39_cache	0
+#define cpu_has_fpu		0
+#define cpu_has_32fpr		0
+#define cpu_has_counter		1
+#define cpu_has_watch		1
+#define cpu_has_divec		1
+#define cpu_has_vce		0
+#define cpu_has_cache_cdex_p	0
+#define cpu_has_cache_cdex_s	0
+#define cpu_has_mcheck		1
+#define cpu_has_ejtag		1
+#define cpu_has_llsc		1
+#define cpu_has_mips16		0
+#define cpu_has_mdmx		0
+#define cpu_has_mips3d		0
+#define cpu_has_smartmips	0
+#define cpu_has_vtag_icache	0
+#define cpu_has_dc_aliases	0
+#define cpu_has_ic_fills_f_dc	1
+#define cpu_has_pindexed_cache	0
+#define cpu_has_mips32r1	1
+#define cpu_has_mips32r2	0
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+#define cpu_has_dsp		0
+#define cpu_has_mipsmt		0
+#define cpu_has_userlocal	0
+#define cpu_has_nofpuex		0
+#define cpu_has_64bits		0
+#define cpu_has_64bit_zero_reg	0
+#define cpu_has_vint		0
+#define cpu_has_veic		0
+#define cpu_has_inclusive_pcaches 0
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()  32
+
+#endif /* __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H */
-- 
1.6.0.4
