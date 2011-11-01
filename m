Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:11:36 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:32904 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903705Ab1KATFF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:05:05 +0100
Received: by mail-fx0-f49.google.com with SMTP id q17so947590faa.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hFpafFFOqe8LjOzUO+dZKr6NPHUcuu8yBex0xL/OlZQ=;
        b=HUgxWAfnhFxV7yAao+VQ4hu3BL1qlURWluWz60yIRMWW/DWrSJJKDcM3BEWR3MCyxS
         Lvv4IFhQdqu90HMjHIEFGL4VGear1vM9ECZRfwy7uUd0Y4dSPUNQPoeB5JbdFBsQUJ0q
         CLDmnZha486Rr08F//pH0gB7A9qpmtDbDjDto=
Received: by 10.223.77.71 with SMTP id f7mr2446636fak.33.1320174305245;
        Tue, 01 Nov 2011 12:05:05 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.05.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:05:04 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 17/18] MIPS: Alchemy: hook up IrDA on DB1000/DB1100
Date:   Tue,  1 Nov 2011 20:03:43 +0100
Message-Id: <1320174224-27305-18-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 666

Add necessary transceiver control platform data and hook up the
IrDA peripheral on the DB1000 and DB1100 boards.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/devboards/db1000.c |   74 ++++++++++++++++++++++++++--------
 1 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index e531bfa..f62b180 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -65,23 +65,6 @@ void __init board_setup(void)
 		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
 
 	printk(KERN_INFO "AMD Alchemy %s Board\n", board_type_str());
-
-#if defined(CONFIG_IRDA) && defined(CONFIG_AU1000_FIR)
-	{
-		u32 pin_func;
-
-		/* Set IRFIRSEL instead of GPIO15 */
-		pin_func = au_readl(SYS_PINFUNC) | SYS_PF_IRF;
-		au_writel(pin_func, SYS_PINFUNC);
-		/* Power off until the driver is in use */
-		bcsr_mod(BCSR_RESETS, BCSR_RESETS_IRDA_MODE_MASK,
-			 BCSR_RESETS_IRDA_MODE_OFF);
-	}
-#endif
-	bcsr_write(BCSR_PCMCIA, 0);	/* turn off PCMCIA power */
-
-	/* Enable GPIO[31:0] inputs */
-	alchemy_gpio1_input_enable();
 }
 
 
@@ -388,6 +371,57 @@ static struct platform_device db1100_mmc1_dev = {
 	.resource	= au1100_mmc1_res,
 };
 
+/******************************************************************************/
+
+static void db1000_irda_set_phy_mode(int mode)
+{
+	unsigned short mask = BCSR_RESETS_IRDA_MODE_MASK | BCSR_RESETS_FIR_SEL;
+
+	switch (mode) {
+	case AU1000_IRDA_PHY_MODE_OFF:
+		bcsr_mod(BCSR_RESETS, mask, BCSR_RESETS_IRDA_MODE_OFF);
+		break;
+	case AU1000_IRDA_PHY_MODE_SIR:
+		bcsr_mod(BCSR_RESETS, mask, BCSR_RESETS_IRDA_MODE_FULL);
+		break;
+	case AU1000_IRDA_PHY_MODE_FIR:
+		bcsr_mod(BCSR_RESETS, mask, BCSR_RESETS_IRDA_MODE_FULL |
+					    BCSR_RESETS_FIR_SEL);
+		break;
+	}
+}
+
+static struct au1k_irda_platform_data db1000_irda_platdata = {
+	.set_phy_mode	= db1000_irda_set_phy_mode,
+};
+
+static struct resource au1000_irda_res[] = {
+	[0] = {
+		.start	= AU1000_IRDA_PHYS_ADDR,
+		.end	= AU1000_IRDA_PHYS_ADDR + 0x0fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1000_IRDA_TX_INT,
+		.end	= AU1000_IRDA_TX_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1000_IRDA_RX_INT,
+		.end	= AU1000_IRDA_RX_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device db1000_irda_dev = {
+	.name	= "au1000-irda",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &db1000_irda_platdata,
+	},
+	.resource	= au1000_irda_res,
+	.num_resources	= ARRAY_SIZE(au1000_irda_res),
+};
 
 static struct platform_device *db1x00_devs[] = {
 	&db1x00_codec_dev,
@@ -396,10 +430,15 @@ static struct platform_device *db1x00_devs[] = {
 	&db1x00_audio_dev,
 };
 
+static struct platform_device *db1000_devs[] = {
+	&db1000_irda_dev,
+};
+
 static struct platform_device *db1100_devs[] = {
 	&au1100_lcd_device,
 	&db1100_mmc0_dev,
 	&db1100_mmc1_dev,
+	&db1000_irda_dev,
 };
 
 static int __init db1000_dev_init(void)
@@ -433,6 +472,7 @@ static int __init db1000_dev_init(void)
 		d1 = AU1000_GPIO3_INT;
 		s0 = AU1000_GPIO1_INT;
 		s1 = AU1000_GPIO4_INT;
+		platform_add_devices(db1000_devs, ARRAY_SIZE(db1000_devs));
 	} else
 		return 0; /* unknown board, no further dev setup to do */
 
-- 
1.7.7.1
