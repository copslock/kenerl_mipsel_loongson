Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2014 21:35:02 +0200 (CEST)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:39533 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008806AbaINTcDSBfen (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2014 21:32:03 +0200
Received: by mail-lb0-f180.google.com with SMTP id b12so3339286lbj.25
        for <multiple recipients>; Sun, 14 Sep 2014 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JORtZflCpf8/Gi2MJRqVPJNTyhxpCkfBqhmtdC5A1Lc=;
        b=P1ne971gMdemhge+KaUKydqOMwnmryxNghabpoZr1WJipGj0mRJFtl1JeFfQyJEaHD
         un0/cSZhmd50Luo2bcOxZayeqOigSW7SFLLhHm0ibjLM731QABdCzb/W7a4x08xnM+af
         ITuhuNtxyXe3spuGMDNn1MUMIbXnBQW1n0H2cHCh+AQltisqdyahnj2mretJlHSn27rX
         pdwKghgbdCSgJXlrkHzj5K5AEKR5kbCsw7O+jlHIKRFCiEN7at5/m94DunjvXCy/z+64
         5/i7OM7L6sKH6OIH3Xi2aHkdnDHvv5rV8vSfouPsxJ2SLVu/TbLQQguZVgnjNJ/2DKQx
         HDwQ==
X-Received: by 10.112.63.136 with SMTP id g8mr266909lbs.98.1410723117943;
        Sun, 14 Sep 2014 12:31:57 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id y5sm3339621laa.20.2014.09.14.12.31.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2014 12:31:57 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [RFC 11/18] MIPS: ar231x: add AR5312 flash support
Date:   Sun, 14 Sep 2014 23:33:26 +0400
Message-Id: <1410723213-22440-12-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 arch/mips/ar231x/ar5312.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ar231x/ar5312.c b/arch/mips/ar231x/ar5312.c
index 6a429d2..944cd16 100644
--- a/arch/mips/ar231x/ar5312.c
+++ b/arch/mips/ar231x/ar5312.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
 #include <linux/reboot.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
@@ -120,6 +121,24 @@ void __init ar5312_arch_init_irq(void)
 	irq_set_chained_handler(AR5312_IRQ_MISC, ar5312_misc_irq_handler);
 }
 
+static struct physmap_flash_data ar5312_flash_data = {
+	.width = 2,
+};
+
+static struct resource ar5312_flash_resource = {
+	.start = AR5312_FLASH,
+	.end = AR5312_FLASH + 0x800000 - 1,
+	.flags = IORESOURCE_MEM,
+};
+
+static struct platform_device ar5312_physmap_flash = {
+	.name = "physmap-flash",
+	.id = 0,
+	.dev.platform_data = &ar5312_flash_data,
+	.resource = &ar5312_flash_resource,
+	.num_resources = 1,
+};
+
 static struct resource ar5312_gpio_res[] = {
 	{
 		.name = "ar5312-gpio",
@@ -138,13 +157,23 @@ static struct platform_device ar5312_gpio = {
 
 static void __init ar5312_flash_init(void)
 {
-	u32 ctl;
+	u32 ctl = ar231x_read_reg(AR5312_FLASHCTL0) & AR5312_FLASHCTL_MW;
+
+	/* fixup flash width */
+	switch (ctl) {
+	case AR5312_FLASHCTL_MW16:
+		ar5312_flash_data.width = 2;
+		break;
+	case AR5312_FLASHCTL_MW8:
+	default:
+		ar5312_flash_data.width = 1;
+		break;
+	}
 
 	/*
 	 * Configure flash bank 0.
 	 * Assume 8M window size. Flash will be aliased if it's smaller
 	 */
-	ctl = ar231x_read_reg(AR5312_FLASHCTL0) & AR5312_FLASHCTL_MW;
 	ctl |= AR5312_FLASHCTL_E | AR5312_FLASHCTL_AC_8M | AR5312_FLASHCTL_RBLE;
 	ctl |= 0x01 << AR5312_FLASHCTL_IDCY_S;
 	ctl |= 0x07 << AR5312_FLASHCTL_WST1_S;
@@ -191,6 +220,7 @@ void __init ar5312_init_devices(void)
 	else
 		ar231x_devtype = DEV_TYPE_AR5312;
 
+	platform_device_register(&ar5312_physmap_flash);
 	platform_device_register(&ar5312_gpio);
 }
 
-- 
1.8.1.5
