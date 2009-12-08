Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 15:18:42 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:40284 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494195AbZLHORC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 15:17:02 +0100
Received: by mail-pz0-f197.google.com with SMTP id 35so4728625pzk.22
        for <multiple recipients>; Tue, 08 Dec 2009 06:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=HWbleMQTWkyICrk7Cwepvs+tJX25vw3FV48JsZt9mas=;
        b=NqaU68nJfxFPlN7YBtMl1sOv/t8tKzr53f9AVlFfnH6Mr4F9AjAvKHw8S0+GXrqWFW
         FpZtOUhMVBG3b3lJbeFZQxm3aZ3yhrWDbrwk9KaFn0KBDnPESVtftFdrhXqRQpt7kOr8
         bpb7BSxTS+lzWIXyOcVmq5c225xMstovzSY+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=glMFOPG+FcVUUEZyKTxyeHGnvnMClD4oGB8ol2FMEsE6j0fyaJxG1535iH9QBFMcHm
         VadPeD6dgcm/Y9zElnA2S3ivWHikb2oO5ABtJ9ewfPAmDBOmPx5vKoMkBpJK2Dm/TfFl
         yOdo2nupfZN7fdB2druuGFPVvRes9JewHZuek=
Received: by 10.115.39.8 with SMTP id r8mr11202035waj.104.1260281821901;
        Tue, 08 Dec 2009 06:17:01 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm6030062pzk.2.2009.12.08.06.16.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 06:17:01 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     akpm@linux-foundation.org, Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v9 7/8] Loongson: YeeLoong: add suspend support
Date:   Tue,  8 Dec 2009 22:15:55 +0800
Message-Id: <6af33d6c42ba4de9eea27316c64f81b96e01c948.1260281599.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <234c5ecd475b05e3eb17ead3ae107cfe3426e0e0.1260281599.git.wuzhangjin@gmail.com>
References: <cover.1260254344.git.wuzhangjin@gmail.com>
 <39d232e3f8359e9c11bad7536f0162444401ec94.1260281599.git.wuzhangjin@gmail.com>
 <7676d8397e593dbec0d40e24429b7ccbcecfa588.1260281599.git.wuzhangjin@gmail.com>
 <4d821efaecc3dee0b9124119507a694e81572437.1260281599.git.wuzhangjin@gmail.com>
 <5c426a5091bee3e4483fc0b93f26359e2840428b.1260281599.git.wuzhangjin@gmail.com>
 <5e9acb4cd757075f617daa45cbd6f5fad94678ac.1260281599.git.wuzhangjin@gmail.com>
 <234c5ecd475b05e3eb17ead3ae107cfe3426e0e0.1260281599.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1260281599.git.wuzhangjin@gmail.com>
References: <cover.1260281599.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25378
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
index f8907da..baf3e81 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -512,6 +512,39 @@ static void yeeloong_vo_exit(void)
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
@@ -523,9 +556,12 @@ MODULE_DEVICE_TABLE(platform, platform_device_ids);
 
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
