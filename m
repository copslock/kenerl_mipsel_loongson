Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 14:20:37 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:43167 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835012Ab3DJMUEWo8uE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 14:20:04 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 17/18] MIPS: ralink: add cpu-feature-overrides.h
Date:   Wed, 10 Apr 2013 13:47:26 +0200
Message-Id: <1365594447-13068-18-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

From: Gabor Juhos <juhosg@openwrt.org>

Add cpu-feature-overrides.h for RT288x, RT305x and RT3883.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 .../asm/mach-ralink/rt288x/cpu-feature-overrides.h |   56 ++++++++++++++++++++
 .../asm/mach-ralink/rt305x/cpu-feature-overrides.h |   56 ++++++++++++++++++++
 .../asm/mach-ralink/rt3883/cpu-feature-overrides.h |   55 +++++++++++++++++++
 arch/mips/ralink/Platform                          |    3 ++
 4 files changed, 170 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
new file mode 100644
index 0000000..72fc106
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
@@ -0,0 +1,56 @@
+/*
+ * Ralink RT288x specific CPU feature overrides
+ *
+ * Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ * This file was derived from: include/asm-mips/cpu-features.h
+ *	Copyright (C) 2003, 2004 Ralf Baechle
+ *	Copyright (C) 2004 Maciej W. Rozycki
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ */
+#ifndef _RT288X_CPU_FEATURE_OVERRIDES_H
+#define _RT288X_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_tlb		1
+#define cpu_has_4kex		1
+#define cpu_has_3k_cache	0
+#define cpu_has_4k_cache	1
+#define cpu_has_tx39_cache	0
+#define cpu_has_sb1_cache	0
+#define cpu_has_fpu		0
+#define cpu_has_32fpr		0
+#define cpu_has_counter		1
+#define cpu_has_watch		1
+#define cpu_has_divec		1
+
+#define cpu_has_prefetch	1
+#define cpu_has_ejtag		1
+#define cpu_has_llsc		1
+
+#define cpu_has_mips16		1
+#define cpu_has_mdmx		0
+#define cpu_has_mips3d		0
+#define cpu_has_smartmips	0
+
+#define cpu_has_mips32r1	1
+#define cpu_has_mips32r2	1
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+
+#define cpu_has_dsp		0
+#define cpu_has_mipsmt		0
+
+#define cpu_has_64bits		0
+#define cpu_has_64bit_zero_reg	0
+#define cpu_has_64bit_gp_regs	0
+#define cpu_has_64bit_addresses	0
+
+#define cpu_dcache_line_size()	16
+#define cpu_icache_line_size()	16
+
+#endif /* _RT288X_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
new file mode 100644
index 0000000..917c286
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
@@ -0,0 +1,56 @@
+/*
+ * Ralink RT305x specific CPU feature overrides
+ *
+ * Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ * This file was derived from: include/asm-mips/cpu-features.h
+ *	Copyright (C) 2003, 2004 Ralf Baechle
+ *	Copyright (C) 2004 Maciej W. Rozycki
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ */
+#ifndef _RT305X_CPU_FEATURE_OVERRIDES_H
+#define _RT305X_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_tlb		1
+#define cpu_has_4kex		1
+#define cpu_has_3k_cache	0
+#define cpu_has_4k_cache	1
+#define cpu_has_tx39_cache	0
+#define cpu_has_sb1_cache	0
+#define cpu_has_fpu		0
+#define cpu_has_32fpr		0
+#define cpu_has_counter		1
+#define cpu_has_watch		1
+#define cpu_has_divec		1
+
+#define cpu_has_prefetch	1
+#define cpu_has_ejtag		1
+#define cpu_has_llsc		1
+
+#define cpu_has_mips16		1
+#define cpu_has_mdmx		0
+#define cpu_has_mips3d		0
+#define cpu_has_smartmips	0
+
+#define cpu_has_mips32r1	1
+#define cpu_has_mips32r2	1
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+
+#define cpu_has_dsp		1
+#define cpu_has_mipsmt		0
+
+#define cpu_has_64bits		0
+#define cpu_has_64bit_zero_reg	0
+#define cpu_has_64bit_gp_regs	0
+#define cpu_has_64bit_addresses	0
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+
+#endif /* _RT305X_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h
new file mode 100644
index 0000000..181fbf4
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h
@@ -0,0 +1,55 @@
+/*
+ * Ralink RT3662/RT3883 specific CPU feature overrides
+ *
+ * Copyright (C) 2011-2013 Gabor Juhos <juhosg@openwrt.org>
+ *
+ * This file was derived from: include/asm-mips/cpu-features.h
+ *	Copyright (C) 2003, 2004 Ralf Baechle
+ *	Copyright (C) 2004 Maciej W. Rozycki
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ */
+#ifndef _RT3883_CPU_FEATURE_OVERRIDES_H
+#define _RT3883_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_tlb		1
+#define cpu_has_4kex		1
+#define cpu_has_3k_cache	0
+#define cpu_has_4k_cache	1
+#define cpu_has_tx39_cache	0
+#define cpu_has_sb1_cache	0
+#define cpu_has_fpu		0
+#define cpu_has_32fpr		0
+#define cpu_has_counter		1
+#define cpu_has_watch		1
+#define cpu_has_divec		1
+
+#define cpu_has_prefetch	1
+#define cpu_has_ejtag		1
+#define cpu_has_llsc		1
+
+#define cpu_has_mips16		1
+#define cpu_has_mdmx		0
+#define cpu_has_mips3d		0
+#define cpu_has_smartmips	0
+
+#define cpu_has_mips32r1	1
+#define cpu_has_mips32r2	1
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+
+#define cpu_has_dsp		1
+#define cpu_has_mipsmt		0
+
+#define cpu_has_64bits		0
+#define cpu_has_64bit_zero_reg	0
+#define cpu_has_64bit_gp_regs	0
+#define cpu_has_64bit_addresses	0
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+
+#endif /* _RT3883_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/ralink/Platform b/arch/mips/ralink/Platform
index b2cbf16..cda4b66 100644
--- a/arch/mips/ralink/Platform
+++ b/arch/mips/ralink/Platform
@@ -8,16 +8,19 @@ cflags-$(CONFIG_RALINK)		+= -I$(srctree)/arch/mips/include/asm/mach-ralink
 # Ralink RT288x
 #
 load-$(CONFIG_SOC_RT288X)	+= 0xffffffff88000000
+cflags-$(CONFIG_SOC_RT288X)	+= -I$(srctree)/arch/mips/include/asm/mach-ralink/rt288x
 
 #
 # Ralink RT305x
 #
 load-$(CONFIG_SOC_RT305X)	+= 0xffffffff80000000
+cflags-$(CONFIG_SOC_RT305X)	+= -I$(srctree)/arch/mips/include/asm/mach-ralink/rt305x
 
 #
 # Ralink RT3883
 #
 load-$(CONFIG_SOC_RT3883)	+= 0xffffffff80000000
+cflags-$(CONFIG_SOC_RT3883)	+= -I$(srctree)/arch/mips/include/asm/mach-ralink/rt3883
 
 #
 # Ralink MT7620
-- 
1.7.10.4
