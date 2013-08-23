Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 15:07:14 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:53298 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823064Ab3HWNHLlT7Wu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Aug 2013 15:07:11 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 96BB128061F;
        Fri, 23 Aug 2013 15:06:42 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Fri, 23 Aug 2013 15:06:42 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: ralink: mt7620: add cpu-feature-override header
Date:   Fri, 23 Aug 2013 15:06:36 +0200
Message-Id: <1377263196-20204-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

Override certain CPU features to help GCC to optimize
the generated code. Saves about 150KB in the vmlinux
image with a generic configuration.

     text    data     bss     dec     hex filename
  3824158  134820  234192 4193170  3ffb92 vmlinux.no-override
  3664054  138804  234192 4037050  3d99ba vmlinux.override

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 .../asm/mach-ralink/mt7620/cpu-feature-overrides.h |   57 ++++++++++++++++++++
 arch/mips/ralink/Platform                          |    1 +
 2 files changed, 58 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ralink/mt7620/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-ralink/mt7620/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/mt7620/cpu-feature-overrides.h
new file mode 100644
index 0000000..f7bb8cf
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/mt7620/cpu-feature-overrides.h
@@ -0,0 +1,57 @@
+/*
+ * Ralink MT7620 specific CPU feature overrides
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
+#ifndef _MT7620_CPU_FEATURE_OVERRIDES_H
+#define _MT7620_CPU_FEATURE_OVERRIDES_H
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
+#define cpu_has_dsp2		0
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
+#endif /* _MT7620_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/ralink/Platform b/arch/mips/ralink/Platform
index cda4b66..6d9c8c4 100644
--- a/arch/mips/ralink/Platform
+++ b/arch/mips/ralink/Platform
@@ -26,3 +26,4 @@ cflags-$(CONFIG_SOC_RT3883)	+= -I$(srctree)/arch/mips/include/asm/mach-ralink/rt
 # Ralink MT7620
 #
 load-$(CONFIG_SOC_MT7620)	+= 0xffffffff80000000
+cflags-$(CONFIG_SOC_MT7620)	+= -I$(srctree)/arch/mips/include/asm/mach-ralink/mt7620
-- 
1.7.10
