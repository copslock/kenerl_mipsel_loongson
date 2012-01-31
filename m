Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:08:38 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:60357 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904021Ab2AaOIc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:08:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id F135A1119D1;
        Tue, 31 Jan 2012 15:08:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B-bR6ET+eoDY; Tue, 31 Jan 2012 15:08:31 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 6B8CD32CE5B;
        Tue, 31 Jan 2012 15:08:31 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/2] MIPS: BCM63XX: be consistent in clock bits enable naming
Date:   Tue, 31 Jan 2012 15:08:08 +0100
Message-Id: <1328018888-5533-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328018888-5533-1-git-send-email-florian@openwrt.org>
References: <1328018888-5533-1-git-send-email-florian@openwrt.org>
X-archive-position: 32345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Remove the _CLK suffix from the BCM6368 clock bits definitions to be
consistent with what is already present.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/clk.c                           |    6 ++--
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   36 ++++++++++----------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 9d57c71..8d2ea22 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -120,7 +120,7 @@ static void enetsw_set(struct clk *clk, int enable)
 {
 	if (!BCMCPU_IS_6368())
 		return;
-	bcm_hwclock_set(CKCTL_6368_ROBOSW_CLK_EN |
+	bcm_hwclock_set(CKCTL_6368_ROBOSW_EN |
 			CKCTL_6368_SWPKT_USB_EN |
 			CKCTL_6368_SWPKT_SAR_EN, enable);
 	if (enable) {
@@ -163,7 +163,7 @@ static void usbh_set(struct clk *clk, int enable)
 	if (BCMCPU_IS_6348())
 		bcm_hwclock_set(CKCTL_6348_USBH_EN, enable);
 	else if (BCMCPU_IS_6368())
-		bcm_hwclock_set(CKCTL_6368_USBH_CLK_EN, enable);
+		bcm_hwclock_set(CKCTL_6368_USBH_EN, enable);
 }
 
 static struct clk clk_usbh = {
@@ -199,7 +199,7 @@ static void xtm_set(struct clk *clk, int enable)
 	if (!BCMCPU_IS_6368())
 		return;
 
-	bcm_hwclock_set(CKCTL_6368_SAR_CLK_EN |
+	bcm_hwclock_set(CKCTL_6368_SAR_EN |
 			CKCTL_6368_SWPKT_SAR_EN, enable);
 
 	if (enable) {
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 94d4faa..6ddd081 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -90,29 +90,29 @@
 #define CKCTL_6368_PHYMIPS_EN		(1 << 6)
 #define CKCTL_6368_SWPKT_USB_EN		(1 << 7)
 #define CKCTL_6368_SWPKT_SAR_EN		(1 << 8)
-#define CKCTL_6368_SPI_CLK_EN		(1 << 9)
-#define CKCTL_6368_USBD_CLK_EN		(1 << 10)
-#define CKCTL_6368_SAR_CLK_EN		(1 << 11)
-#define CKCTL_6368_ROBOSW_CLK_EN	(1 << 12)
-#define CKCTL_6368_UTOPIA_CLK_EN	(1 << 13)
-#define CKCTL_6368_PCM_CLK_EN		(1 << 14)
-#define CKCTL_6368_USBH_CLK_EN		(1 << 15)
+#define CKCTL_6368_SPI_EN		(1 << 9)
+#define CKCTL_6368_USBD_EN		(1 << 10)
+#define CKCTL_6368_SAR_EN		(1 << 11)
+#define CKCTL_6368_ROBOSW_EN		(1 << 12)
+#define CKCTL_6368_UTOPIA_EN		(1 << 13)
+#define CKCTL_6368_PCM_EN		(1 << 14)
+#define CKCTL_6368_USBH_EN		(1 << 15)
 #define CKCTL_6368_DISABLE_GLESS_EN	(1 << 16)
-#define CKCTL_6368_NAND_CLK_EN		(1 << 17)
-#define CKCTL_6368_IPSEC_CLK_EN		(1 << 17)
+#define CKCTL_6368_NAND_EN		(1 << 17)
+#define CKCTL_6368_IPSEC_EN		(1 << 17)
 
 #define CKCTL_6368_ALL_SAFE_EN		(CKCTL_6368_SWPKT_USB_EN |	\
 					CKCTL_6368_SWPKT_SAR_EN |	\
-					CKCTL_6368_SPI_CLK_EN |		\
-					CKCTL_6368_USBD_CLK_EN |	\
-					CKCTL_6368_SAR_CLK_EN |		\
-					CKCTL_6368_ROBOSW_CLK_EN |	\
-					CKCTL_6368_UTOPIA_CLK_EN |	\
-					CKCTL_6368_PCM_CLK_EN |		\
-					CKCTL_6368_USBH_CLK_EN |	\
+					CKCTL_6368_SPI_EN |		\
+					CKCTL_6368_USBD_EN |		\
+					CKCTL_6368_SAR_EN |		\
+					CKCTL_6368_ROBOSW_EN |		\
+					CKCTL_6368_UTOPIA_EN |		\
+					CKCTL_6368_PCM_EN |		\
+					CKCTL_6368_USBH_EN |		\
 					CKCTL_6368_DISABLE_GLESS_EN |	\
-					CKCTL_6368_NAND_CLK_EN |	\
-					CKCTL_6368_IPSEC_CLK_EN)
+					CKCTL_6368_NAND_EN |		\
+					CKCTL_6368_IPSEC_EN)
 
 /* System PLL Control register  */
 #define PERF_SYS_PLL_CTL_REG		0x8
-- 
1.7.5.4
