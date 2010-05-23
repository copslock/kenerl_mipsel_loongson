Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 16:00:08 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:53436 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491859Ab0EWN6w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 15:58:52 +0200
Received: by mail-px0-f177.google.com with SMTP id 1so1165383pxi.36
        for <multiple recipients>; Sun, 23 May 2010 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=esxexwCba3vT1PMg/mH2BNUIL8sgdwkMIh8adFRt608=;
        b=kv+wd0iz0yG+q27xPlAP8gPw56HYYA/lA3H1VVkHphyWkGbGZD54qG6mLt/2JFixXb
         m5MnmlTiFAsg0p8MjlJiMDC+FGFdLy4GgJk7bHKDltoZGf2w2AEi8UTHj0/1kNGEclaT
         uITRSewwMeFE3Xzy6xGyFkwp0M9+kxXUKW/m0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=B1fBO0uqo8Hu90E8xl1VawzdY5TlSVwsIbUX+9vL8obTJ0W3IpNYPv/zszinf4nuvz
         WX3IJKweeiJwiW+y7RCboH0R1OZcNew1FqbXmJk3vjFEpY5XFqTqv28hknJ4ikqD2kL4
         HLlOtUUhP4fxQy1jgt5CFJe7S6LW1Z3FHndz0=
Received: by 10.115.134.14 with SMTP id l14mr3659788wan.184.1274623131830;
        Sun, 23 May 2010 06:58:51 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm29067398wam.17.2010.05.23.06.58.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 06:58:51 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 6/9] Loongson: YeeLoong: add suspend support
Date:   Sun, 23 May 2010 21:58:01 +0800
Message-Id: <adb4a0d4c03c2e70f71f154f6cc41c1193fd63bc.1274622624.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1274622624.git.wuzhangjin@gmail.com>
References: <cover.1274622624.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1274622624.git.wuzhangjin@gmail.com>
References: <cover.1274622624.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch add support to suspend the yeeloong platform specific
devices(LCD, CRT, USB...).

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/platform/mips/yeeloong_laptop.c |   41 ++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index 9fd70ae..16e34e8 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -454,6 +454,38 @@ static void yeeloong_vo_exit(void)
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
@@ -465,9 +497,12 @@ MODULE_DEVICE_TABLE(platform, platform_device_ids);
 
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
1.7.0.4
