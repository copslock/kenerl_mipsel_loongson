Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 20:35:46 +0200 (CEST)
Received: from mail-la0-f41.google.com ([209.85.215.41]:49375 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010022AbaI1Sbj0IaZx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 20:31:39 +0200
Received: by mail-la0-f41.google.com with SMTP id pn19so1491031lab.0
        for <multiple recipients>; Sun, 28 Sep 2014 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x0FcLx8m1U2dt4t+OzH31sbjIfzuJds1IT5vljeJx30=;
        b=aQOTfU0d/P06u2023wVMspBw1pxsertUTQgIvk1kKW1dtuGqnWtoWHg9fTTkgTk1y0
         B58Vd7XmAD1+8uGajtG2sXZ2UVgpGw8bLRo1KK+3xa3C47Jj5nqvtY1yR55xNGYheg8y
         +HvZDpRmjuJEpMSHHL3e41KaUonozWtKcTwLV47hZmT+UuVzF4WKVUi5lOD3x9k4fhz+
         QqDZsEj2Y4/qHRehLGoQn7qmMtKxIe1VR8YrY5llZWdheF7VV6KCoZ/QGk8eHpEbSEst
         yhdUQ6DQEWl6MSJQymNAZ2KBqvoqY2s5GcBeCWcHw/U1rGhpux67jgbr0g65Melq5kuU
         zwGg==
X-Received: by 10.112.129.228 with SMTP id nz4mr32643333lbb.9.1411929094032;
        Sun, 28 Sep 2014 11:31:34 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id je9sm581674lbc.3.2014.09.28.11.31.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 11:31:33 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 16/16] MIPS: ar231x: add Wireless device support
Date:   Sun, 28 Sep 2014 22:33:15 +0400
Message-Id: <1411929195-23775-17-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42867
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

Atheros AR5312 and AR2315 both have a builtin wireless device, this
patch add helper code and register platform device for all supported
WiSoCs.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 arch/mips/ar231x/ar2315.c  |  1 +
 arch/mips/ar231x/ar5312.c  | 22 +++++++++++++++++++
 arch/mips/ar231x/devices.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ar231x/devices.h |  1 +
 4 files changed, 78 insertions(+)

diff --git a/arch/mips/ar231x/ar2315.c b/arch/mips/ar231x/ar2315.c
index 0d50718..837fcad 100644
--- a/arch/mips/ar231x/ar2315.c
+++ b/arch/mips/ar231x/ar2315.c
@@ -233,6 +233,7 @@ void __init ar2315_init_devices(void)
 	res->end = res->start;
 	platform_device_register(&ar2315_wdt);
 	platform_device_register(&ar2315_spiflash);
+	ar231x_add_wmac(0, AR2315_WLAN0, AR2315_IRQ_WLAN0);
 }
 
 static void ar2315_restart(char *command)
diff --git a/arch/mips/ar231x/ar5312.c b/arch/mips/ar231x/ar5312.c
index 5efbe00..33b22e2 100644
--- a/arch/mips/ar231x/ar5312.c
+++ b/arch/mips/ar231x/ar5312.c
@@ -237,6 +237,28 @@ void __init ar5312_init_devices(void)
 
 	platform_device_register(&ar5312_physmap_flash);
 	platform_device_register(&ar5312_gpio);
+
+	switch (ar231x_devtype) {
+	case DEV_TYPE_AR5312:
+		if (!ar231x_board.radio)
+			return;
+
+		if (!(config->flags & BD_WLAN0))
+			break;
+
+		ar231x_add_wmac(0, AR5312_WLAN0, AR5312_IRQ_WLAN0);
+		break;
+	case DEV_TYPE_AR2312:
+	case DEV_TYPE_AR2313:
+		if (!ar231x_board.radio)
+			return;
+		break;
+	default:
+		break;
+	}
+
+	if (config->flags & BD_WLAN1)
+		ar231x_add_wmac(1, AR5312_WLAN1, AR5312_IRQ_WLAN1);
 }
 
 static void ar5312_restart(char *command)
diff --git a/arch/mips/ar231x/devices.c b/arch/mips/ar231x/devices.c
index 21f90f2..65d1026 100644
--- a/arch/mips/ar231x/devices.c
+++ b/arch/mips/ar231x/devices.c
@@ -1,6 +1,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/serial_8250.h>
+#include <linux/platform_device.h>
 #include <asm/bootinfo.h>
 
 #include <ar231x_platform.h>
@@ -11,6 +12,45 @@
 struct ar231x_board_config ar231x_board;
 int ar231x_devtype = DEV_TYPE_UNKNOWN;
 
+static struct resource ar231x_wmac0_res[] = {
+	{
+		.name = "wmac0_membase",
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.name = "wmac0_irq",
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct resource ar231x_wmac1_res[] = {
+	{
+		.name = "wmac1_membase",
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.name = "wmac1_irq",
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device ar231x_wmac[] = {
+	{
+		.id = 0,
+		.name = "ar231x-wmac",
+		.resource = ar231x_wmac0_res,
+		.num_resources = ARRAY_SIZE(ar231x_wmac0_res),
+		.dev.platform_data = &ar231x_board,
+	},
+	{
+		.id = 1,
+		.name = "ar231x-wmac",
+		.resource = ar231x_wmac1_res,
+		.num_resources = ARRAY_SIZE(ar231x_wmac1_res),
+		.dev.platform_data = &ar231x_board,
+	},
+};
+
 static const char * const devtype_strings[] = {
 	[DEV_TYPE_AR5312] = "Atheros AR5312",
 	[DEV_TYPE_AR2312] = "Atheros AR2312",
@@ -46,6 +86,20 @@ void __init ar231x_serial_setup(u32 mapbase, int irq, unsigned int uartclk)
 	early_serial_setup(&s);
 }
 
+int __init ar231x_add_wmac(int nr, u32 base, int irq)
+{
+	struct resource *res;
+
+	ar231x_wmac[nr].dev.platform_data = &ar231x_board;
+	res = &ar231x_wmac[nr].resource[0];
+	res->start = base;
+	res->end = base + 0x10000 - 1;
+	res++;
+	res->start = irq;
+	res->end = irq;
+	return platform_device_register(&ar231x_wmac[nr]);
+}
+
 static int __init ar231x_register_devices(void)
 {
 	ar5312_init_devices();
diff --git a/arch/mips/ar231x/devices.h b/arch/mips/ar231x/devices.h
index 5ffa091..6e3d242 100644
--- a/arch/mips/ar231x/devices.h
+++ b/arch/mips/ar231x/devices.h
@@ -24,6 +24,7 @@ extern void (*ar231x_irq_dispatch)(void);
 
 int ar231x_find_config(const u8 *flash_limit);
 void ar231x_serial_setup(u32 mapbase, int irq, unsigned int uartclk);
+int ar231x_add_wmac(int nr, u32 base, int irq);
 
 static inline bool is_2315(void)
 {
-- 
1.8.5.5
