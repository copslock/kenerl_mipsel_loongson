Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Dec 2009 08:07:55 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:34471 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492270AbZLFHFs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Dec 2009 08:05:48 +0100
Received: by mail-pw0-f45.google.com with SMTP id 18so1914974pwi.24
        for <multiple recipients>; Sat, 05 Dec 2009 23:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=tf+AIlYly9A5EewRXOtutHTn7lIQmt28QkTrRj4pwRI=;
        b=JcRjI8D+OMrbeiOIk/OarhbDIuoaPUwL/XTX+UzMso7vpBpj19tiHpv6kMuB4AI+nG
         pkKy25xwpnI1ETWCHIs7+fLfd7BM+TOm6NgSMlq/Zv5rwrvJZ4uQ6WNzn4lWiCT9W3QM
         gH0O83S6VyQxbaK4gNkIdXKamVpvWWese5rkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lnHNTOsZonPs/QWW+H7Ve53HreZzWOZKzokJxGGAqN5EkPDTuGPeNYNQatMXMu37WY
         rGHH+MAgouSopvo3vPho8w9rdwdiR/DnnWVTGAUULwnxAQpJD3JX4M1gecWdkAmxHYwX
         hniq97UlabmPfplTncwmJpIIH/ScH2GoB4gNE=
Received: by 10.115.67.24 with SMTP id u24mr8286236wak.59.1260083147559;
        Sat, 05 Dec 2009 23:05:47 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm3974972pzk.5.2009.12.05.23.05.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 23:05:47 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v8 7/8] Loongson: YeeLoong: add suspend support
Date:   Sun,  6 Dec 2009 15:01:47 +0800
Message-Id: <0d43bc3ef83540f8420a66741560e8ee817758c3.1260082252.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <a9309478df85d80c970bfc1632c1cc0147596c1c.1260082252.git.wuzhangjin@gmail.com>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
 <d6bb11d33fe01abd6de945117ce647af73841f00.1260082252.git.wuzhangjin@gmail.com>
 <5a8742a71e96ba40bee34fb37478cc8339e76530.1260082252.git.wuzhangjin@gmail.com>
 <3c77f3891e73e189cceef7155dc9cb6503084a4b.1260082252.git.wuzhangjin@gmail.com>
 <57ed2090c7f1a1a9c0e31d457617c7473b9e29ad.1260082252.git.wuzhangjin@gmail.com>
 <d8789fa7e97d8a170c4e2516d7ef2d2fbbe42cc6.1260082252.git.wuzhangjin@gmail.com>
 <a9309478df85d80c970bfc1632c1cc0147596c1c.1260082252.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1260082252.git.wuzhangjin@gmail.com>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch add support to suspend the yeeloong platform specific
devices(LCD, CRT, USB...).

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/platform/mips/yeeloong_laptop.c |   42 ++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index 180dbb1..5e83788 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -515,6 +515,39 @@ static void yeeloong_vo_exit(void)
 	}
 }
 
+#ifdef CONFIG_PM
+static void usb_ports_set(int status)
+{
+	status = !!status;
+
+	ec_write(REG_USB0_FLAG, status);
+	ec_write(REG_USB1_FLAG, status);
+	ec_write(REG_USB2_FLAG, status);
+}
+
+static int yeeloong_suspend(struct device *dev)
+
+{
+	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+	yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+	usb_ports_set(BIT_USB_FLAG_OFF);
+
+	return 0;
+}
+
+static int yeeloong_resume(struct device *dev)
+{
+	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+	yeeloong_crt_vo_set(BIT_CRT_DETECT_PLUG);
+	usb_ports_set(BIT_USB_FLAG_ON);
+
+	return 0;
+}
+
+static const SIMPLE_DEV_PM_OPS(yeeloong_pm_ops, yeeloong_suspend,
+	yeeloong_resume);
+#endif
+
 static struct platform_device_id platform_device_ids[] = {
 	{
 		.name = "yeeloong_laptop",
@@ -526,9 +559,12 @@ MODULE_DEVICE_TABLE(platform, platform_device_ids);
 
 static struct platform_driver platform_driver = {
 	.driver = {
-		   .name = "yeeloong_laptop",
-		   .owner = THIS_MODULE,
-		   },
+		.name = "yeeloong_laptop",
+		.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm = &yeeloong_pm_ops,
+#endif
+	},
 	.id_table = platform_device_ids,
 };
 
-- 
1.6.2.1
