Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 16:01:51 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:48634 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491916Ab0EWN7E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 15:59:04 +0200
Received: by mail-pv0-f177.google.com with SMTP id 11so1163083pvg.36
        for <multiple recipients>; Sun, 23 May 2010 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=JoeZQ43Ne/t8ewt1TaGCB+JDqImD2UGhm9koYAQBbdk=;
        b=EtxT3duDLspyz19bOEe96vn5+clNFHeVxmdXU4F8WsHhH29mhGyVcJ4yMHM17ityok
         ZHickDIHGareU9wUIOYH1aVRJpvisfaXskWBG7S4WnBg83tJwNGEayINRbfVx5EVT+hI
         7en4TqcALK61XhCm/ncopKlwmtiP6W+FFe7aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xdKd+SoPbpp6xbgC8h2+7ae/rW/sckqHMMn+mX0n/Si0fVYML6tnc2oGNUnDNRUxYe
         RbzfBw2oOQKYsJiCTuMF4ON8Cz8UR9RdSkUJyJrko0OUQiN2Sz4H0nRh2ue4G0dCgVx7
         79qoCfYtPhAKPG1q2bcZV3Fxi6X0s6A3hemEw=
Received: by 10.115.21.20 with SMTP id y20mr3674342wai.84.1274623143829;
        Sun, 23 May 2010 06:59:03 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm29067398wam.17.2010.05.23.06.59.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 06:59:03 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 9/9] Loongson: YeeLoong: Co-operate with the revisions of EC
Date:   Sun, 23 May 2010 21:58:04 +0800
Message-Id: <0d086fd3a53756f66baa8ea7cf6a34c96c199140.1274622624.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1274622624.git.wuzhangjin@gmail.com>
References: <cover.1274622624.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1274622624.git.wuzhangjin@gmail.com>
References: <cover.1274622624.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch makes the platform drivers work with the revisions of EC.

  O When EC >= PQ1D26, EC will response the key of Fn+F2 and turn off
  the video output of LCD, we can no do it again in kernel.

  O When EC >= PQ1D27, EC will response the LID key and turn off the
  video output of LCD, we can not do it again in kernel.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    6 ++++
 arch/mips/loongson/common/cmdline.c            |    8 ++++++
 drivers/platform/mips/yeeloong_laptop.c        |   32 +++++++++++++++++++++--
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index fcdbe3a..53d0bef 100644
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
index e321c58..f6d91a5 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -23,8 +23,29 @@
 
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
 
@@ -738,7 +759,10 @@ static int crt_detect_handler(int status)
 
 static int displaytoggle_handler(int status)
 {
-	yeeloong_lcd_vo_set(status);
+	/* EC(>=PQ1D26) does this job for us, we can not do it again,
+	 * otherwise, the brightness will not resume to the normal level! */
+	if (ec_version_before("EC_VER=PQ1D26"))
+		yeeloong_lcd_vo_set(status);
 
 	return status;
 }
@@ -1063,7 +1087,8 @@ static void usb_ports_set(int status)
 
 static int yeeloong_suspend(struct device *dev)
 {
-	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+	if (ec_version_before("EC_VER=PQ1D27"))
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
 	yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
 	usb_ports_set(BIT_USB_FLAG_OFF);
 
@@ -1074,7 +1099,8 @@ static int yeeloong_resume(struct device *dev)
 {
 	usb_ports_set(BIT_USB_FLAG_ON);
 	yeeloong_crt_vo_set(BIT_CRT_DETECT_PLUG);
-	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+	if (ec_version_before("EC_VER=PQ1D27"))
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
 
 	return 0;
 }
-- 
1.7.0.4
