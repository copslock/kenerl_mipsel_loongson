Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 19:12:51 +0100 (CET)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52237 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904137Ab1KDSME (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 19:12:04 +0100
Received: from sakura.staff.proxad.net (unknown [213.36.7.13])
        by smtp4-g21.free.fr (Postfix) with ESMTP id AA7F14C81B3;
        Fri,  4 Nov 2011 19:11:59 +0100 (CET)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 943D8557C0B; Fri,  4 Nov 2011 19:11:58 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Subject: [PATCH v2 02/11] MIPS: BCM63XX: hook up plat_ioremap to intercept soc registers remapping.
Date:   Fri,  4 Nov 2011 19:09:26 +0100
Message-Id: <1320430175-13725-3-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
References: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
To:     ralf@linux-mips.org
X-archive-position: 31392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3868

Internal SOC registers can be directly accessed, no need to waste a
TLB entry.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/include/asm/mach-bcm63xx/ioremap.h |   38 ++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/ioremap.h

diff --git a/arch/mips/include/asm/mach-bcm63xx/ioremap.h b/arch/mips/include/asm/mach-bcm63xx/ioremap.h
new file mode 100644
index 0000000..e3fe04d
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/ioremap.h
@@ -0,0 +1,38 @@
+#ifndef BCM63XX_IOREMAP_H_
+#define BCM63XX_IOREMAP_H_
+
+#include <bcm63xx_cpu.h>
+
+static inline phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
+{
+	return phys_addr;
+}
+
+static inline int is_bcm63xx_internal_registers(phys_t offset)
+{
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6338_CPU_ID:
+	case BCM6345_CPU_ID:
+	case BCM6348_CPU_ID:
+	case BCM6358_CPU_ID:
+		if (offset >= 0xfff00000)
+			return 1;
+		break;
+	}
+	return 0;
+}
+
+static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
+					 unsigned long flags)
+{
+	if (is_bcm63xx_internal_registers(offset))
+		return (void __iomem *)offset;
+	return NULL;
+}
+
+static inline int plat_iounmap(const volatile void __iomem *addr)
+{
+	return is_bcm63xx_internal_registers((unsigned long)addr);
+}
+
+#endif /* BCM63XX_IOREMAP_H_ */
-- 
1.7.1.1
