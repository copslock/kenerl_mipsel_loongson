Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Feb 2013 13:44:57 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:45814 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827470Ab3BBMo4Y5SK6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Feb 2013 13:44:56 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 3DACC25D27C;
        Sat,  2 Feb 2013 13:44:51 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uBbie7X6EeGo; Sat,  2 Feb 2013 13:44:51 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 5ACA425D27A;
        Sat,  2 Feb 2013 13:44:50 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 3/5] MIPS: ath79: move global PCI defines into a common header
Date:   Sat,  2 Feb 2013 13:44:23 +0100
Message-Id: <1359809064-23253-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1359808846-23083-1-git-send-email-juhosg@openwrt.org>
References: <1359808846-23083-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35682
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The constants will be used by a subsequent patch.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   24 ++++++++++++++++++++++++
 arch/mips/pci/pci-ar71xx.c                     |   16 ----------------
 arch/mips/pci/pci-ar724x.c                     |    8 --------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 7d44b5d..7c87bfe 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -41,11 +41,35 @@
 #define AR71XX_RESET_BASE	(AR71XX_APB_BASE + 0x00060000)
 #define AR71XX_RESET_SIZE	0x100
 
+#define AR71XX_PCI_MEM_BASE	0x10000000
+#define AR71XX_PCI_MEM_SIZE	0x07000000
+
+#define AR71XX_PCI_WIN0_OFFS	0x10000000
+#define AR71XX_PCI_WIN1_OFFS	0x11000000
+#define AR71XX_PCI_WIN2_OFFS	0x12000000
+#define AR71XX_PCI_WIN3_OFFS	0x13000000
+#define AR71XX_PCI_WIN4_OFFS	0x14000000
+#define AR71XX_PCI_WIN5_OFFS	0x15000000
+#define AR71XX_PCI_WIN6_OFFS	0x16000000
+#define AR71XX_PCI_WIN7_OFFS	0x07000000
+
+#define AR71XX_PCI_CFG_BASE	\
+	(AR71XX_PCI_MEM_BASE + AR71XX_PCI_WIN7_OFFS + 0x10000)
+#define AR71XX_PCI_CFG_SIZE	0x100
+
 #define AR7240_USB_CTRL_BASE	(AR71XX_APB_BASE + 0x00030000)
 #define AR7240_USB_CTRL_SIZE	0x100
 #define AR7240_OHCI_BASE	0x1b000000
 #define AR7240_OHCI_SIZE	0x1000
 
+#define AR724X_PCI_MEM_BASE	0x10000000
+#define AR724X_PCI_MEM_SIZE	0x04000000
+
+#define AR724X_PCI_CFG_BASE	0x14000000
+#define AR724X_PCI_CFG_SIZE	0x1000
+#define AR724X_PCI_CTRL_BASE	(AR71XX_APB_BASE + 0x000f0000)
+#define AR724X_PCI_CTRL_SIZE	0x100
+
 #define AR724X_EHCI_BASE	0x1b000000
 #define AR724X_EHCI_SIZE	0x1000
 
diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index 0d8412f..35ee234 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -25,22 +25,6 @@
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/pci.h>
 
-#define AR71XX_PCI_MEM_BASE	0x10000000
-#define AR71XX_PCI_MEM_SIZE	0x07000000
-
-#define AR71XX_PCI_WIN0_OFFS		0x10000000
-#define AR71XX_PCI_WIN1_OFFS		0x11000000
-#define AR71XX_PCI_WIN2_OFFS		0x12000000
-#define AR71XX_PCI_WIN3_OFFS		0x13000000
-#define AR71XX_PCI_WIN4_OFFS		0x14000000
-#define AR71XX_PCI_WIN5_OFFS		0x15000000
-#define AR71XX_PCI_WIN6_OFFS		0x16000000
-#define AR71XX_PCI_WIN7_OFFS		0x07000000
-
-#define AR71XX_PCI_CFG_BASE		\
-	(AR71XX_PCI_MEM_BASE + AR71XX_PCI_WIN7_OFFS + 0x10000)
-#define AR71XX_PCI_CFG_SIZE		0x100
-
 #define AR71XX_PCI_REG_CRP_AD_CBE	0x00
 #define AR71XX_PCI_REG_CRP_WRDATA	0x04
 #define AR71XX_PCI_REG_CRP_RDDATA	0x08
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index e7aca88b..b3f9d09 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -17,14 +17,6 @@
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include <asm/mach-ath79/pci.h>
 
-#define AR724X_PCI_CFG_BASE	0x14000000
-#define AR724X_PCI_CFG_SIZE	0x1000
-#define AR724X_PCI_CTRL_BASE	(AR71XX_APB_BASE + 0x000f0000)
-#define AR724X_PCI_CTRL_SIZE	0x100
-
-#define AR724X_PCI_MEM_BASE	0x10000000
-#define AR724X_PCI_MEM_SIZE	0x04000000
-
 #define AR724X_PCI_REG_RESET		0x18
 #define AR724X_PCI_REG_INT_STATUS	0x4c
 #define AR724X_PCI_REG_INT_MASK		0x50
-- 
1.7.10
