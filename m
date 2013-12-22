Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Dec 2013 14:37:33 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:41105 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822311Ab3LVNgwGwsUf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Dec 2013 14:36:52 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B5F68857F;
        Sun, 22 Dec 2013 14:36:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1GQqx1kObrPz; Sun, 22 Dec 2013 14:36:48 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 25BD48F62;
        Sun, 22 Dec 2013 14:36:45 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] MIPS: BCM47XX: add vectored interrupt support
Date:   Sun, 22 Dec 2013 14:36:32 +0100
Message-Id: <1387719392-17565-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1387719392-17565-1-git-send-email-hauke@hauke-m.de>
References: <1387719392-17565-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This adds support for vectored interrupt which is supported by the SoC
using a MIPS 74K CPU like the BCM4716 and BCM4706.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/Kconfig |    1 +
 arch/mips/bcm47xx/irq.c   |   23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index 09fc922..582a8454 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -21,6 +21,7 @@ config BCM47XX_SSB
 config BCM47XX_BCMA
 	bool "BCMA Support for Broadcom BCM47XX"
 	select SYS_HAS_CPU_MIPS32_R2
+	select CPU_MIPSR2_IRQ_VI
 	select BCMA
 	select BCMA_HOST_SOC
 	select BCMA_DRIVER_MIPS
diff --git a/arch/mips/bcm47xx/irq.c b/arch/mips/bcm47xx/irq.c
index a9133e9..e0585b7 100644
--- a/arch/mips/bcm47xx/irq.c
+++ b/arch/mips/bcm47xx/irq.c
@@ -25,6 +25,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <asm/setup.h>
 #include <asm/irq_cpu.h>
 #include <bcm47xx.h>
 
@@ -50,6 +51,18 @@ asmlinkage void plat_irq_dispatch(void)
 		do_IRQ(6);
 }
 
+#define DEFINE_HWx_IRQDISPATCH(x)					\
+	static void bcm47xx_hw ## x ## _irqdispatch(void)		\
+	{								\
+		do_IRQ(x);						\
+	}
+DEFINE_HWx_IRQDISPATCH(2)
+DEFINE_HWx_IRQDISPATCH(3)
+DEFINE_HWx_IRQDISPATCH(4)
+DEFINE_HWx_IRQDISPATCH(5)
+DEFINE_HWx_IRQDISPATCH(6)
+DEFINE_HWx_IRQDISPATCH(7)
+
 void __init arch_init_irq(void)
 {
 #ifdef CONFIG_BCM47XX_BCMA
@@ -64,4 +77,14 @@ void __init arch_init_irq(void)
 	}
 #endif
 	mips_cpu_irq_init();
+
+	if (cpu_has_vint) {
+		pr_info("Setting up vectored interrupts\n");
+		set_vi_handler(2, bcm47xx_hw2_irqdispatch);
+		set_vi_handler(3, bcm47xx_hw3_irqdispatch);
+		set_vi_handler(4, bcm47xx_hw4_irqdispatch);
+		set_vi_handler(5, bcm47xx_hw5_irqdispatch);
+		set_vi_handler(6, bcm47xx_hw6_irqdispatch);
+		set_vi_handler(7, bcm47xx_hw7_irqdispatch);
+	}
 }
-- 
1.7.10.4
