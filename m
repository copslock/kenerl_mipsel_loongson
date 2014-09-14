Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2014 21:36:08 +0200 (CEST)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33290 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008899AbaINTcJe0IFd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2014 21:32:09 +0200
Received: by mail-lb0-f182.google.com with SMTP id v6so3425619lbi.13
        for <multiple recipients>; Sun, 14 Sep 2014 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c11vlN+ADSc+WNiS8jmEH+I5C0yWbM3G598wfxL0xYQ=;
        b=FaAH62YE2GtKYuQhYOm8NRLilMOIwOkqY3NotpYbnvZuG+XyAIqF+lczyEc/RXZDqk
         un2+B0Vl4D6QHT4FwUkDhov+QFrwHzJBHYP6UWvbjZS3dEhztqISVEBckojEC9EUvtdG
         aGWDFANevnVbgxh5aHWp7kcquBFTVmQgz183HWtofC0d/Mj8AmURrpsDsuB63gvIMYJ/
         Leljo7a1bRSpoiKJFV+Y3ip189dAfUfhRke4fNtx6lma1lkx7sKUvu8MO/dZPNNEk5QQ
         5kXpa/dKrDSjwLjbzyeG/yx6oTkVGlyERziQZZ0bB5fNPOxtn/hDoXc+lwWkIi6d0l4L
         9PRA==
X-Received: by 10.112.4.33 with SMTP id h1mr21636832lbh.67.1410723124175;
        Sun, 14 Sep 2014 12:32:04 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id y5sm3339621laa.20.2014.09.14.12.32.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2014 12:32:03 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [RFC 15/18] MIPS: ar231x: add Wireless device support
Date:   Sun, 14 Sep 2014 23:33:30 +0400
Message-Id: <1410723213-22440-16-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42558
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
 arch/mips/ar231x/ar2315.c  |  8 ++++---
 arch/mips/ar231x/ar5312.c  | 28 +++++++++++++++++++++++-
 arch/mips/ar231x/devices.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ar231x/devices.h |  1 +
 4 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/arch/mips/ar231x/ar2315.c b/arch/mips/ar231x/ar2315.c
index a9fbe4b..ce4be47 100644
--- a/arch/mips/ar231x/ar2315.c
+++ b/arch/mips/ar231x/ar2315.c
@@ -103,12 +103,13 @@ static void ar2315_irq_dispatch(void)
 {
 	u32 pending = read_c0_status() & read_c0_cause();
 
+	if (pending & CAUSEF_IP3)
+		do_IRQ(AR2315_IRQ_WLAN0);
 #ifdef CONFIG_PCI_AR2315
-	if (pending & CAUSEF_IP5)
+	else if (pending & CAUSEF_IP5)
 		do_IRQ(AR2315_IRQ_LCBUS_PCI);
-	else
 #endif
-	if (pending & CAUSEF_IP2)
+	else if (pending & CAUSEF_IP2)
 		do_IRQ(AR2315_IRQ_MISC);
 	else if (pending & CAUSEF_IP7)
 		do_IRQ(AR231X_IRQ_CPU_CLOCK);
@@ -223,6 +224,7 @@ void __init ar2315_init_devices(void)
 	platform_device_register(&ar2315_gpio);
 	platform_device_register(&ar2315_wdt);
 	platform_device_register(&ar2315_spiflash);
+	ar231x_add_wmac(0, AR2315_WLAN0, AR2315_IRQ_WLAN0);
 }
 
 static void ar2315_restart(char *command)
diff --git a/arch/mips/ar231x/ar5312.c b/arch/mips/ar231x/ar5312.c
index 944cd16..975f580 100644
--- a/arch/mips/ar231x/ar5312.c
+++ b/arch/mips/ar231x/ar5312.c
@@ -95,7 +95,11 @@ static void ar5312_irq_dispatch(void)
 {
 	u32 pending = read_c0_status() & read_c0_cause();
 
-	if (pending & CAUSEF_IP6)
+	if (pending & CAUSEF_IP2)
+		do_IRQ(AR5312_IRQ_WLAN0);
+	else if (pending & CAUSEF_IP5)
+		do_IRQ(AR5312_IRQ_WLAN1);
+	else if (pending & CAUSEF_IP6)
 		do_IRQ(AR5312_IRQ_MISC);
 	else if (pending & CAUSEF_IP7)
 		do_IRQ(AR231X_IRQ_CPU_CLOCK);
@@ -222,6 +226,28 @@ void __init ar5312_init_devices(void)
 
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
index 95083b0..951e7d7 100644
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
1.8.1.5
