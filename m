Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 14:38:23 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:46548 "EHLO
        mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492335AbZLDNiT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 14:38:19 +0100
Received: by pxi6 with SMTP id 6so513170pxi.0
        for <multiple recipients>; Fri, 04 Dec 2009 05:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=aF16QHvsve/DyHG97+B8dhtjD7zlc2OteiLXq3gf4W0=;
        b=pvNP3qCNr/ht7/Yxd+TIv30uwgjAZlbt83JxdyKYIc5GEOoRHtuv8GejXMpXcXZfB2
         9o9q4VGPIZhwcX6rHhp6+kwyxWK9nHyRI0vEkt453pkJvbbIi1q0mVNafNzoXTFY6/ha
         VdKxgEcdCqakismcl1ThZmnQdrXPARgVrrLJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uFZ8kfyFD7QiZix/GF6joKSdjGTw3CU23ulOo+rMrIH2Donl5tTzVu4ItVklvdf+ZP
         KRbLFPItUk/XaUs2SH9krX7MlDIV9rMZSZ2Tc9psTRH9FAWli8LAcwdBZK+b99lTg/3w
         WOT7yLagz9ud8BmGIt+u8alzLWkNAYQyd7EBs=
Received: by 10.115.87.33 with SMTP id p33mr4127047wal.101.1259933892502;
        Fri, 04 Dec 2009 05:38:12 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm2512895pzk.3.2009.12.04.05.38.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 05:38:11 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        zhangfx@lemote.com, linux-laptop@vger.kernel.org,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v7 7/8] Loongson: YeeLoong: add suspend support
Date:   Fri,  4 Dec 2009 21:37:41 +0800
Message-Id: <1811181c553c2c8e7e841540e57444e54c33d65f.1259932036.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259932036.git.wuzhangjin@gmail.com>
References: <cover.1259932036.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25307
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
 drivers/platform/mips/yeeloong_laptop.c |   41 +++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index 8378926..d31824b 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -536,6 +536,45 @@ static void yeeloong_vo_exit(void)
 	}
 }
 
+#ifdef CONFIG_LOONGSON_SUSPEND
+static void usb_ports_set(int status)
+{
+	status = !!status;
+
+	ec_write(REG_USB0_FLAG, status);
+	ec_write(REG_USB1_FLAG, status);
+	ec_write(REG_USB2_FLAG, status);
+}
+
+static int yeeloong_suspend(struct platform_device *dev, pm_message_t state)
+
+{
+	/* Turn off LCD */
+	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+	/* Turn off CRT */
+	yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+	/* Poweroff three usb ports */
+	usb_ports_set(BIT_USB_FLAG_OFF);
+
+	return 0;
+}
+
+static int yeeloong_resume(struct platform_device *pdev)
+{
+	/* Resume the status of lcd & crt */
+	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+	yeeloong_crt_vo_set(BIT_CRT_DETECT_PLUG);
+
+	/* Poweron three usb ports */
+	usb_ports_set(BIT_USB_FLAG_ON);
+
+	return 0;
+}
+#else	/* !CONFIG_LOONGSON_SUSPEND */
+#define yeeloong_suspend NULL
+#define yeeloong_resume NULL
+#endif
+
 static struct platform_device_id platform_device_ids[] = {
 	{
 		.name = "yeeloong_laptop",
@@ -551,6 +590,8 @@ static struct platform_driver platform_driver = {
 		   .owner = THIS_MODULE,
 		   },
 	.id_table = platform_device_ids,
+	.suspend = yeeloong_suspend,
+	.resume = yeeloong_resume,
 };
 
 static int __init yeeloong_init(void)
-- 
1.6.2.1
