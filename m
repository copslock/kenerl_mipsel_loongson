Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 13:25:47 +0100 (CET)
Received: from mail-pz0-f203.google.com ([209.85.222.203]:40072 "EHLO
        mail-pz0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491062Ab0AaMWh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 13:22:37 +0100
Received: by mail-pz0-f203.google.com with SMTP id 41so5404351pzk.0
        for <multiple recipients>; Sun, 31 Jan 2010 04:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=LcJKoUP5aJ3ScXVo8e0JIcWmiJ7R3aqMwKOxfehQj+o=;
        b=NVXGIFqlylmXIF1nO1862zVcL0LUZnzgrg7xItJifiExKD0u4D0N78UXUpf2eLFgRX
         ry6NVpfG79fJOi8UPFk7wbnp8xnRaRNzKVIwOlqU2qncs4bo3Mu6a+z0Z5mItQ3Ob7yL
         PXcayYBJwSmvD0bjb383oxQqz3s9J/eUwDx4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JTxf7Y0smSD5N/4l1Yfyh4HntpUCg5QcCtXI08xlHRGCA/7XMRN7t9xlPNHumfrwRY
         F8mYk5u1E/5LcrcxNowqKFJDxfYi1fTKSH9teg3FDYBkHCmI910+f4OgAh6NYytDDyIO
         kMkK5o1aIdjfADcRyciMLdKBFBeLWuXPxdfBE=
Received: by 10.142.6.19 with SMTP id 19mr2191915wff.131.1264940556865;
        Sun, 31 Jan 2010 04:22:36 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm3552209pzk.3.2010.01.31.04.22.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 04:22:36 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: [PATCH v11 8/9] Loongson: YeeLoong: Co-operate with the revisions of EC
Date:   Sun, 31 Jan 2010 20:15:54 +0800
Message-Id: <5eee168975db1e110be7dc554fe8f38d339cccbb.1264940063.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <f4976b3269dc1092ce495f82b4a65062f8a61bda.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
 <b25d80b0d15f92b93fa3cb70c97c39cfb0d79c16.1264940063.git.wuzhangjin@gmail.com>
 <b1305e7c601d017d8c612c985cc20bb1003620f4.1264940063.git.wuzhangjin@gmail.com>
 <edfa13e4c6c10f97ba984f0fa5b65404a9468cec.1264940063.git.wuzhangjin@gmail.com>
 <d83f0e8948c0552fe26998537d984bf47ef691ae.1264940063.git.wuzhangjin@gmail.com>
 <a3f00c700de6209c22d3e526ef6869814b1483fc.1264940063.git.wuzhangjin@gmail.com>
 <c9b93c006f7dd475b3781e4917ada1f441edcaa9.1264940063.git.wuzhangjin@gmail.com>
 <f4976b3269dc1092ce495f82b4a65062f8a61bda.1264940063.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
X-archive-position: 25785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19724

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch makes the platform drivers work with the revisions of EC.

  O When EC >= PQ1D26, EC will response the key of Fn+F2 and turn off
  the video output of LCD, we can no do it again in kernel.

  O When EC >= PQ1D27, EC will response the LID key and turn off the
  video output of LCD, we can not do it again in kerne.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    6 ++++
 arch/mips/loongson/common/cmdline.c            |    8 ++++++
 drivers/platform/mips/yeeloong_laptop.c        |   32 +++++++++++++++++++++--
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 1cf7b14..2894019 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -42,6 +42,12 @@ static inline void prom_init_uart_base(void)
 #endif
 }
 
+/*
+ * Copy kernel command line from arcs_cmdline
+ */
+#include <asm/setup.h>
+extern char loongson_cmdline[COMMAND_LINE_SIZE];
+
 /* irq operation functions */
 extern void bonito_irqdispatch(void);
 extern void __init bonito_irq_init(void);
diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/common/cmdline.c
index 1a06def..8f290c3 100644
--- a/arch/mips/loongson/common/cmdline.c
+++ b/arch/mips/loongson/common/cmdline.c
@@ -17,10 +17,15 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
+#include <linux/module.h>
 #include <asm/bootinfo.h>
 
 #include <loongson.h>
 
+/* the kernel command line copied from arcs_cmdline */
+char loongson_cmdline[COMMAND_LINE_SIZE];
+EXPORT_SYMBOL(loongson_cmdline);
+
 void __init prom_init_cmdline(void)
 {
 	int prom_argc;
@@ -50,4 +55,7 @@ void __init prom_init_cmdline(void)
 		strcat(arcs_cmdline, " root=/dev/hda1");
 
 	prom_init_machtype();
+
+	/* copy arcs_cmdline into loongson_cmdline */
+	strncpy(loongson_cmdline, arcs_cmdline, COMMAND_LINE_SIZE);
 }
diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index 4008a3f..877257a 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -22,8 +22,29 @@
 
 #include <cs5536/cs5536.h>
 
+#include <loongson.h>		/* for loongson_cmdline */
 #include <ec_kb3310b.h>
 
+/* common function */
+#define EC_VER_LEN 64
+
+static int ec_version_before(char *version)
+{
+	char *p, ec_ver[EC_VER_LEN];
+
+	p = strstr(loongson_cmdline, "EC_VER=");
+	if (!p)
+		memset(ec_ver, 0, EC_VER_LEN);
+	else {
+		strncpy(ec_ver, p, EC_VER_LEN);
+		p = strstr(ec_ver, " ");
+		if (p)
+			*p = '\0';
+	}
+
+	return (strncasecmp(ec_ver, version, 64) < 0);
+}
+
 /* backlight subdriver */
 #define MAX_BRIGHTNESS	8
 
@@ -527,7 +548,10 @@ static int crt_detect_handler(int status)
 
 static int black_screen_handler(int status)
 {
-	yeeloong_lcd_vo_set(status);
+	/* EC(>=PQ1D26) does this job for us, we can not do it again,
+	 * otherwise, the brightness will not resume to the normal level! */
+	if (ec_version_before("EC_VER=PQ1D26"))
+		yeeloong_lcd_vo_set(status);
 
 	return status;
 }
@@ -840,7 +864,8 @@ static void usb_ports_set(int status)
 
 static int yeeloong_suspend(struct device *dev)
 {
-	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+	if (ec_version_before("EC_VER=PQ1D27"))
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
 	yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
 	usb_ports_set(BIT_USB_FLAG_OFF);
 
@@ -851,7 +876,8 @@ static int yeeloong_resume(struct device *dev)
 {
 	usb_ports_set(BIT_USB_FLAG_ON);
 	yeeloong_crt_vo_set(BIT_CRT_DETECT_PLUG);
-	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+	if (ec_version_before("EC_VER=PQ1D27"))
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
 
 	return 0;
 }
-- 
1.6.6
