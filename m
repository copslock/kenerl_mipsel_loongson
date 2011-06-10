Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 23:47:43 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52556 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490954Ab1FJVrg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 23:47:36 +0200
Received: from bobafett.staff.proxad.net (unknown [213.228.1.121])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 9DDE84C80FF;
        Fri, 10 Jun 2011 23:47:31 +0200 (CEST)
Received: from sakura.staff.proxad.net (unknown [172.18.3.156])
        by bobafett.staff.proxad.net (Postfix) with ESMTP id 8F0EF180650;
        Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 6846355AEB4; Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, florian@openwrt.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 02/11] MIPS: BCM63XX: hook up plat_ioremap to intercept soc registers remapping.
Date:   Fri, 10 Jun 2011 23:47:12 +0200
Message-Id: <1307742441-28284-3-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 30325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9568

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
