Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 16:25:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5055 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992630AbcHZOWd0ahIn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 16:22:33 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CF6CCA5912202;
        Fri, 26 Aug 2016 15:22:10 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 15:22:14 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ondrej Zary <linux@rainbow-software.org>,
        <linux-fbdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 15/19] fbdev: cobalt_lcdfb: Drop SEAD3 support
Date:   Fri, 26 Aug 2016 15:17:47 +0100
Message-ID: <20160826141751.13121-16-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826141751.13121-1-paul.burton@imgtec.com>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The SEAD3 board no longer uses the cobalt_lcdfb driver, so remove the
SEAD3-specific code from it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---

Changes in v2: None

 drivers/video/fbdev/Kconfig        |  2 +-
 drivers/video/fbdev/cobalt_lcdfb.c | 42 --------------------------------------
 2 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 88b008f..914bfb2 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2183,7 +2183,7 @@ config FB_GOLDFISH
 
 config FB_COBALT
 	tristate "Cobalt server LCD frame buffer support"
-	depends on FB && (MIPS_COBALT || MIPS_SEAD3)
+	depends on FB && MIPS_COBALT
 
 config FB_SH7760
 	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
diff --git a/drivers/video/fbdev/cobalt_lcdfb.c b/drivers/video/fbdev/cobalt_lcdfb.c
index 07675d6..2d3b691 100644
--- a/drivers/video/fbdev/cobalt_lcdfb.c
+++ b/drivers/video/fbdev/cobalt_lcdfb.c
@@ -63,7 +63,6 @@
 #define LCD_CUR_POS(x)		((x) & LCD_CUR_POS_MASK)
 #define LCD_TEXT_POS(x)		((x) | LCD_TEXT_MODE)
 
-#ifdef CONFIG_MIPS_COBALT
 static inline void lcd_write_control(struct fb_info *info, u8 control)
 {
 	writel((u32)control << 24, info->screen_base);
@@ -83,47 +82,6 @@ static inline u8 lcd_read_data(struct fb_info *info)
 {
 	return readl(info->screen_base + LCD_DATA_REG_OFFSET) >> 24;
 }
-#else
-
-#define LCD_CTL			0x00
-#define LCD_DATA		0x08
-#define CPLD_STATUS		0x10
-#define CPLD_DATA		0x18
-
-static inline void cpld_wait(struct fb_info *info)
-{
-	do {
-	} while (readl(info->screen_base + CPLD_STATUS) & 1);
-}
-
-static inline void lcd_write_control(struct fb_info *info, u8 control)
-{
-	cpld_wait(info);
-	writel(control, info->screen_base + LCD_CTL);
-}
-
-static inline u8 lcd_read_control(struct fb_info *info)
-{
-	cpld_wait(info);
-	readl(info->screen_base + LCD_CTL);
-	cpld_wait(info);
-	return readl(info->screen_base + CPLD_DATA) & 0xff;
-}
-
-static inline void lcd_write_data(struct fb_info *info, u8 data)
-{
-	cpld_wait(info);
-	writel(data, info->screen_base + LCD_DATA);
-}
-
-static inline u8 lcd_read_data(struct fb_info *info)
-{
-	cpld_wait(info);
-	readl(info->screen_base + LCD_DATA);
-	cpld_wait(info);
-	return readl(info->screen_base + CPLD_DATA) & 0xff;
-}
-#endif
 
 static int lcd_busy_wait(struct fb_info *info)
 {
-- 
2.9.3
