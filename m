Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 01:07:31 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49979 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012113AbaJUXD5e1N0w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 01:03:57 +0200
Received: by mail-lb0-f174.google.com with SMTP id p9so1872241lbv.5
        for <multiple recipients>; Tue, 21 Oct 2014 16:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ErYkUVZZfmAf2fpLqWCmpsHTVxu4UsCXmMgEngoM6+U=;
        b=hK4TElucHEYCQ7jERotIpVzrLzozdxlZ80l3HIQBmQf2bzi7NB+WgnVRC7w28yXBp/
         kCNsLwnF4ZwYPQkFQuvm3RjXgpLqLM1nYVbMIKv43U1+QyXN3VzKhI1tf8qzLJUEpYTj
         Mbl49ZwQL8HwzQbcqrlJDgALqYrCqhYpXEXIG5rjNUOhc+emBRMMYM5B6UQhPT5YCPI+
         IgtYJ8YMKNUQCBcFF2fs3U4uKDda/iM6OpSyPWt4i+qCCnvZCKQj2HcUjH1bNNiNg4AF
         7Qsb7DR+WOiLsi3FrpmFVEYXnyiIMaW/NLhm+X1bJdN0xyq2SHjn9Xb/oFFFnY2V76u/
         Liog==
X-Received: by 10.112.29.175 with SMTP id l15mr37254107lbh.39.1413932632205;
        Tue, 21 Oct 2014 16:03:52 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id lk5sm5077133lac.45.2014.10.21.16.03.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 16:03:51 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v2 13/13] MIPS: ath25: add Wireless device support
Date:   Wed, 22 Oct 2014 03:03:51 +0400
Message-Id: <1413932631-12866-14-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43460
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

Changes since v1:
  - rename MIPS machine ar231x -> ath25

 arch/mips/ath25/ar2315.c  |  1 +
 arch/mips/ath25/ar5312.c  | 22 +++++++++++++++++++
 arch/mips/ath25/devices.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ath25/devices.h |  1 +
 4 files changed, 78 insertions(+)

diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index 76679c0..b39440e 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -227,6 +227,7 @@ void __init ar2315_init_devices(void)
 	res->end = res->start;
 	platform_device_register(&ar2315_wdt);
 	platform_device_register(&ar2315_spiflash);
+	ath25_add_wmac(0, AR2315_WLAN0, AR2315_IRQ_WLAN0);
 }
 
 static void ar2315_restart(char *command)
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index 99c2745..043cf96 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -231,6 +231,28 @@ void __init ar5312_init_devices(void)
 
 	platform_device_register(&ar5312_physmap_flash);
 	platform_device_register(&ar5312_gpio);
+
+	switch (ath25_soc) {
+	case ATH25_SOC_AR5312:
+		if (!ath25_board.radio)
+			return;
+
+		if (!(config->flags & BD_WLAN0))
+			break;
+
+		ath25_add_wmac(0, AR5312_WLAN0, AR5312_IRQ_WLAN0);
+		break;
+	case ATH25_SOC_AR2312:
+	case ATH25_SOC_AR2313:
+		if (!ath25_board.radio)
+			return;
+		break;
+	default:
+		break;
+	}
+
+	if (config->flags & BD_WLAN1)
+		ath25_add_wmac(1, AR5312_WLAN1, AR5312_IRQ_WLAN1);
 }
 
 static void ar5312_restart(char *command)
diff --git a/arch/mips/ath25/devices.c b/arch/mips/ath25/devices.c
index 6218547..7a64567 100644
--- a/arch/mips/ath25/devices.c
+++ b/arch/mips/ath25/devices.c
@@ -1,6 +1,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/serial_8250.h>
+#include <linux/platform_device.h>
 #include <asm/bootinfo.h>
 
 #include <ath25_platform.h>
@@ -11,6 +12,45 @@
 struct ar231x_board_config ath25_board;
 enum ath25_soc_type ath25_soc = ATH25_SOC_UNKNOWN;
 
+static struct resource ath25_wmac0_res[] = {
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
+static struct resource ath25_wmac1_res[] = {
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
+static struct platform_device ath25_wmac[] = {
+	{
+		.id = 0,
+		.name = "ar231x-wmac",
+		.resource = ath25_wmac0_res,
+		.num_resources = ARRAY_SIZE(ath25_wmac0_res),
+		.dev.platform_data = &ath25_board,
+	},
+	{
+		.id = 1,
+		.name = "ar231x-wmac",
+		.resource = ath25_wmac1_res,
+		.num_resources = ARRAY_SIZE(ath25_wmac1_res),
+		.dev.platform_data = &ath25_board,
+	},
+};
+
 static const char * const soc_type_strings[] = {
 	[ATH25_SOC_AR5312] = "Atheros AR5312",
 	[ATH25_SOC_AR2312] = "Atheros AR2312",
@@ -46,6 +86,20 @@ void __init ath25_serial_setup(u32 mapbase, int irq, unsigned int uartclk)
 	early_serial_setup(&s);
 }
 
+int __init ath25_add_wmac(int nr, u32 base, int irq)
+{
+	struct resource *res;
+
+	ath25_wmac[nr].dev.platform_data = &ath25_board;
+	res = &ath25_wmac[nr].resource[0];
+	res->start = base;
+	res->end = base + 0x10000 - 1;
+	res++;
+	res->start = irq;
+	res->end = irq;
+	return platform_device_register(&ath25_wmac[nr]);
+}
+
 static int __init ath25_register_devices(void)
 {
 	if (is_ar5312())
diff --git a/arch/mips/ath25/devices.h b/arch/mips/ath25/devices.h
index 8555e32..eb8a1d1 100644
--- a/arch/mips/ath25/devices.h
+++ b/arch/mips/ath25/devices.h
@@ -24,6 +24,7 @@ extern void (*ath25_irq_dispatch)(void);
 
 int ath25_find_config(const u8 *flash_limit);
 void ath25_serial_setup(u32 mapbase, int irq, unsigned int uartclk);
+int ath25_add_wmac(int nr, u32 base, int irq);
 
 static inline bool is_ar2315(void)
 {
-- 
1.8.5.5
