Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 11:15:35 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50039 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822837Ab3HHJOdudKC7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 11:14:33 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH 3/4] MIPS: lantiq: falcon: add cpu-feature-override.h
Date:   Thu,  8 Aug 2013 11:07:25 +0200
Message-Id: <1375952846-25812-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1375952846-25812-1-git-send-email-blogic@openwrt.org>
References: <1375952846-25812-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37446
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

From: Thomas Langer <thomas.langer@lantiq.com>

Add cpu-feature-override.h for the GPON SoC

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Acked-by: John Crispin <blogic@openwrt.org>
---
 .../asm/mach-lantiq/falcon/cpu-feature-overrides.h |   58 ++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-lantiq/falcon/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-lantiq/falcon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-lantiq/falcon/cpu-feature-overrides.h
new file mode 100644
index 0000000..096a100
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/falcon/cpu-feature-overrides.h
@@ -0,0 +1,58 @@
+/*
+ *  Lantiq FALCON specific CPU feature overrides
+ *
+ *  Copyright (C) 2013 Thomas Langer, Lantiq Deutschland
+ *
+ *  This file was derived from: include/asm-mips/cpu-features.h
+ *	Copyright (C) 2003, 2004 Ralf Baechle
+ *	Copyright (C) 2004 Maciej W. Rozycki
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ */
+#ifndef __ASM_MACH_FALCON_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_FALCON_CPU_FEATURE_OVERRIDES_H
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
+#define cpu_has_mipsmt		1
+
+#define cpu_has_vint		1
+#define cpu_has_veic		1
+
+#define cpu_has_64bits		0
+#define cpu_has_64bit_zero_reg	0
+#define cpu_has_64bit_gp_regs	0
+#define cpu_has_64bit_addresses	0
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+
+#endif /* __ASM_MACH_FALCON_CPU_FEATURE_OVERRIDES_H */
-- 
1.7.10.4
