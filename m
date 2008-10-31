Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:39:16 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:18081 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S22828128AbYJaNYo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Oct 2008 13:24:44 +0000
Received: from base (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 7C5DF38CE86F;
	Fri, 31 Oct 2008 14:24:33 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] rb532: gpio register offsets are relatives to GPIOBASE
Date:	Fri, 31 Oct 2008 14:24:29 +0100
Message-Id: <1225459469-12279-1-git-send-email-n0-1@freewrt.org>
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <200810261112.37008.florian@openwrt.org>
References: <200810261112.37008.florian@openwrt.org>
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

From: Florian Fainelli <florian@openwrt.org>

This patch fixes the wrong use of GPIO register offsets
in devices.c. To avoid further problems, use gpio_get_value
to return the NAND status instead of our own expanded code.

Also define the zero offset of the alternate function register to allow
consistent access.

Signef-off-by: Phil Sutter <n0-1@freewrt.org>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/include/asm/mach-rc32434/rb.h |   14 ++++++++------
 arch/mips/rb532/devices.c               |    2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/mach-rc32434/rb.h b/arch/mips/include/asm/mach-rc32434/rb.h
index 79e8ef6..f25a849 100644
--- a/arch/mips/include/asm/mach-rc32434/rb.h
+++ b/arch/mips/include/asm/mach-rc32434/rb.h
@@ -40,12 +40,14 @@
 #define BTCS		0x010040
 #define BTCOMPARE	0x010044
 #define GPIOBASE	0x050000
-#define GPIOCFG		0x050004
-#define GPIOD		0x050008
-#define GPIOILEVEL	0x05000C
-#define GPIOISTAT	0x050010
-#define GPIONMIEN	0x050014
-#define IMASK6		0x038038
+/* Offsets relative to GPIOBASE */
+#define GPIOFUNC	0x00
+#define GPIOCFG		0x04
+#define GPIOD		0x08
+#define GPIOILEVEL	0x0C
+#define GPIOISTAT	0x10
+#define GPIONMIEN	0x14
+#define IMASK6		0x38
 #define LO_WPX		(1 << 0)
 #define LO_ALE		(1 << 1)
 #define LO_CLE		(1 << 2)
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 31619c6..c40be04 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -118,7 +118,7 @@ static struct platform_device cf_slot0 = {
 /* Resources and device for NAND */
 static int rb532_dev_ready(struct mtd_info *mtd)
 {
-	return readl(IDT434_REG_BASE + GPIOD) & GPIO_RDY;
+	return gpio_get_value(GPIO_RDY);
 }
 
 static void rb532_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
-- 
1.5.6.4
