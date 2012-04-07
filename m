Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2012 18:52:42 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:36615 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904124Ab2DGQtB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Apr 2012 18:49:01 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SGYop-0004dH-Ps; Sat, 07 Apr 2012 11:48:55 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Douglas Leung <douglas@mips.com>,
        Chris Dearman <chris@mips.com>
Subject: [PATCH 09/10] cobalt_lcdfb: LCD panel framebuffer support for SEAD-3 platform.
Date:   Sat,  7 Apr 2012 11:48:34 -0500
Message-Id: <1333817315-30091-10-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1333817315-30091-1-git-send-email-sjhill@mips.com>
References: <1333817315-30091-1-git-send-email-sjhill@mips.com>
X-archive-position: 32887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Add support for LCD panel on MIPS SEAD-3 development platform.

Signed-off-by: Douglas Leung <douglas@mips.com>
Signed-off-by: Chris Dearman <chris@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 drivers/video/Kconfig        |    2 +-
 drivers/video/cobalt_lcdfb.c |   45 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index a8a897a..e921a45 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2210,7 +2210,7 @@ config FB_XILINX
 
 config FB_COBALT
 	tristate "Cobalt server LCD frame buffer support"
-	depends on FB && MIPS_COBALT
+	depends on FB && (MIPS_COBALT || MIPS_SEAD3)
 
 config FB_SH7760
 	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
diff --git a/drivers/video/cobalt_lcdfb.c b/drivers/video/cobalt_lcdfb.c
index f56699d..eae46f6 100644
--- a/drivers/video/cobalt_lcdfb.c
+++ b/drivers/video/cobalt_lcdfb.c
@@ -1,7 +1,8 @@
 /*
- *  Cobalt server LCD frame buffer driver.
+ *  Cobalt/SEAD3 LCD frame buffer driver.
  *
  *  Copyright (C) 2008  Yoichi Yuasa <yuasa@linux-mips.org>
+ *  Copyright (C) 2012  MIPS Technologies, Inc.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -62,6 +63,7 @@
 #define LCD_CUR_POS(x)		((x) & LCD_CUR_POS_MASK)
 #define LCD_TEXT_POS(x)		((x) | LCD_TEXT_MODE)
 
+#ifdef CONFIG_MIPS_COBALT
 static inline void lcd_write_control(struct fb_info *info, u8 control)
 {
 	writel((u32)control << 24, info->screen_base);
@@ -81,6 +83,47 @@ static inline u8 lcd_read_data(struct fb_info *info)
 {
 	return readl(info->screen_base + LCD_DATA_REG_OFFSET) >> 24;
 }
+#else
+
+#define LCD_CTL			0x00
+#define LCD_DATA		0x08
+#define CPLD_STATUS		0x10
+#define CPLD_DATA		0x18
+
+static inline void cpld_wait(struct fb_info *info)
+{
+	do {
+	} while (readl(info->screen_base + CPLD_STATUS) & 1);
+}
+
+static inline void lcd_write_control(struct fb_info *info, u8 control)
+{
+	cpld_wait(info);
+	writel(control, info->screen_base + LCD_CTL);
+}
+
+static inline u8 lcd_read_control(struct fb_info *info)
+{
+	cpld_wait(info);
+	readl(info->screen_base + LCD_CTL);
+	cpld_wait(info);
+	return readl(info->screen_base + CPLD_DATA) & 0xff;
+}
+
+static inline void lcd_write_data(struct fb_info *info, u8 data)
+{
+	cpld_wait(info);
+	writel(data, info->screen_base + LCD_DATA);
+}
+
+static inline u8 lcd_read_data(struct fb_info *info)
+{
+	cpld_wait(info);
+	readl(info->screen_base + LCD_DATA);
+	cpld_wait(info);
+	return readl(info->screen_base + CPLD_DATA) & 0xff;
+}
+#endif
 
 static int lcd_busy_wait(struct fb_info *info)
 {
-- 
1.7.9.6
