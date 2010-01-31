Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 13:24:55 +0100 (CET)
Received: from mail-px0-f181.google.com ([209.85.216.181]:39509 "EHLO
        mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492288Ab0AaMW3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 13:22:29 +0100
Received: by mail-px0-f181.google.com with SMTP id 11so3141197pxi.22
        for <multiple recipients>; Sun, 31 Jan 2010 04:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=7jkN5dCftprlPOlXWdheijT1t7nAVNEB1x0dI5W19mI=;
        b=Gy35xTIjzK6q4VmheQDLkqeJjQq8SZmPvQDdexgJJ+VbbVTfPQffjDZW6T+pTUjkBp
         RxwJZuQ4eh0WaCwRNHcXIYvf9mDabx04CMoVEh0FDorblzkmqbGFgc/mX+V3tEvPfYfh
         QKZ+iom4eKQWlamRl5/0roQZ4mXBHJJCitW00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ITKM+qNoalRhV/TpfEzcSygfxPrhD+onGw9XRvV1jDAgCUVkzrRpcrqGYddiwNuTf+
         5oPI3MrYLhPEs3RC2uiNHSMez2fh/goCzhYwgUwduJP328FfEKrwzDAt6V1nP4vA8pzm
         qcy93h00V5v5kF8TfRqVZGHbbMp5Gr1kIQZaU=
Received: by 10.141.187.27 with SMTP id o27mr2213342rvp.299.1264940549115;
        Sun, 31 Jan 2010 04:22:29 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm3552209pzk.3.2010.01.31.04.22.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 04:22:28 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: [PATCH v11 6/9] Loongson: YeeLoong: add suspend support
Date:   Sun, 31 Jan 2010 20:15:52 +0800
Message-Id: <c9b93c006f7dd475b3781e4917ada1f441edcaa9.1264940063.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <a3f00c700de6209c22d3e526ef6869814b1483fc.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
 <b25d80b0d15f92b93fa3cb70c97c39cfb0d79c16.1264940063.git.wuzhangjin@gmail.com>
 <b1305e7c601d017d8c612c985cc20bb1003620f4.1264940063.git.wuzhangjin@gmail.com>
 <edfa13e4c6c10f97ba984f0fa5b65404a9468cec.1264940063.git.wuzhangjin@gmail.com>
 <d83f0e8948c0552fe26998537d984bf47ef691ae.1264940063.git.wuzhangjin@gmail.com>
 <a3f00c700de6209c22d3e526ef6869814b1483fc.1264940063.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
X-archive-position: 25783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19722

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch add support to suspend the yeeloong platform specific
devices(LCD, CRT, USB...).

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/platform/mips/yeeloong_laptop.c |   41 ++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index 4f11bc1..8abe88d 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -452,6 +452,38 @@ static void yeeloong_vo_exit(void)
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
+	usb_ports_set(BIT_USB_FLAG_ON);
+	yeeloong_crt_vo_set(BIT_CRT_DETECT_PLUG);
+	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
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
@@ -463,9 +495,12 @@ MODULE_DEVICE_TABLE(platform, platform_device_ids);
 
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
1.6.6
