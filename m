Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 09:51:12 +0100 (CET)
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34186 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008653AbcAYIvKhh07X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jan 2016 09:51:10 +0100
Received: by mail-lf0-f52.google.com with SMTP id 17so80023497lfz.1;
        Mon, 25 Jan 2016 00:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=V3se5fESVTLi2V3XyFNEbrbX1KkP2TGeUmWuOmIYm9g=;
        b=qolCri/IO3GC3RHvxmvllkYK5c35UPoQVRRt2tMR2g65hEIwTy5QitlgUf5RJOQurW
         MK917cbu7Uy37GeWtAecey5RsLySqs9oX0qJssrSB4F5JJkiMeBKLxRfflyQHwWtQwmv
         s9AFz4h/u3ZUerX1nRBawb4YbU6b0XF+SDVOSC4G3onpyBNmbTvZU9EtrdKW1xH7a9uw
         8wqTb776YN/o4lMxOdVQ52h+k5d8eaDPX+kv/IpyynDC66GYcmz+ozAHrcMATz8JTQ+Y
         fGgd5TgDTg7/3U5H5O78R/RJbhudT12+bC+enKc8fDo+3kFLFgGnGqmcpmSlrB27F9MH
         YZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=V3se5fESVTLi2V3XyFNEbrbX1KkP2TGeUmWuOmIYm9g=;
        b=UAWaOm39jvV2f24s3EjzXMw7vrgkalY60o+JquvqtCXQj7mil3uFpOc2Ex5U4v5f5C
         /lxW72x8jJ1j7ooj7AMqpCjJKl3Q2Ik8FYFWrtBAXMxHpmWKP8RADWTMVoP6aUKUzwQP
         FVRvrZK4Gduqyd0/QRNknPJAUIkwI5NwoIWGU1o5/Dv5g76Y3Bn79OW5gBhxv6Nqwrk+
         cYY8v8WveCluSfu+TDbcBpohBCU66sJfZHYKnnCZYVcT+gC8HGbPdkkvz0cE08+v3zw2
         lmFPZlZIZBR3vLSoaoPoroa/ytx7JG4MU5cClytlZ+Jv3XpvtBMwNFe7MKMTf27tlj33
         Idvw==
X-Gm-Message-State: AG10YOQ5ZqhFd5KbHRPSsUAMMedSfk5O0p2J0SjLMN0xJtKJXgIUmvyDb5oeJN+QZRyzlw==
X-Received: by 10.25.141.206 with SMTP id p197mr4739876lfd.104.1453711863575;
        Mon, 25 Jan 2016 00:51:03 -0800 (PST)
Received: from linux-samsung.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id uk7sm2515673lbb.32.2016.01.25.00.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 00:51:02 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47xx: Move SPROM driver to drivers/firmware/
Date:   Mon, 25 Jan 2016 09:50:29 +0100
Message-Id: <1453711829-19001-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

Broadcom ARM home routers store SPROM content in NVRAM just like MIPS
ones. To share SPROM code we need to move it out of arch/mips/ to some
common place. We already have bcm47xx_nvram in firmware path and SPROM
should fit there as well.
This driver is responsible for parsing SoC configuration data into a
struct shared between ssb and bcma buses.
This was tested with BCM4706 & BCM5357C0 (BCM47XX) and BCM4708A0
(ARCH_BCM_5301X).

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/Kconfig                                  |  1 +
 arch/mips/bcm47xx/Makefile                         |  2 +-
 arch/mips/bcm47xx/bcm47xx_private.h                |  3 ---
 arch/mips/bcm47xx/setup.c                          |  2 +-
 drivers/firmware/broadcom/Kconfig                  | 11 +++++++++
 drivers/firmware/broadcom/Makefile                 |  1 +
 .../firmware/broadcom/bcm47xx_sprom.c              | 27 ++++++++++++++++------
 include/linux/bcm47xx_sprom.h                      | 24 +++++++++++++++++++
 8 files changed, 59 insertions(+), 12 deletions(-)
 rename arch/mips/bcm47xx/sprom.c => drivers/firmware/broadcom/bcm47xx_sprom.c (98%)
 create mode 100644 include/linux/bcm47xx_sprom.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 57a945e..6beb7d1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -195,6 +195,7 @@ config BCM47XX
 	select GPIOLIB
 	select LEDS_GPIO_REGISTER
 	select BCM47XX_NVRAM
+	select BCM47XX_SPROM
 	help
 	 Support for BCM47XX based boards
 
diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index 66bea4e..6d86150 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -3,5 +3,5 @@
 # under Linux.
 #
 
-obj-y				+= irq.o prom.o serial.o setup.o time.o sprom.o
+obj-y				+= irq.o prom.o serial.o setup.o time.o
 obj-y				+= board.o buttons.o leds.o workarounds.o
diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
index 41796be..0367ac7 100644
--- a/arch/mips/bcm47xx/bcm47xx_private.h
+++ b/arch/mips/bcm47xx/bcm47xx_private.h
@@ -10,9 +10,6 @@
 /* prom.c */
 void __init bcm47xx_prom_highmem_init(void);
 
-/* sprom.c */
-void bcm47xx_sprom_register_fallbacks(void);
-
 /* buttons.c */
 int __init bcm47xx_buttons_register(void);
 
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index c807e32..6054d49 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -28,6 +28,7 @@
 
 #include "bcm47xx_private.h"
 
+#include <linux/bcm47xx_sprom.h>
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/ethtool.h>
@@ -151,7 +152,6 @@ void __init plat_mem_setup(void)
 		pr_info("Using bcma bus\n");
 #ifdef CONFIG_BCM47XX_BCMA
 		bcm47xx_bus_type = BCM47XX_BUS_TYPE_BCMA;
-		bcm47xx_sprom_register_fallbacks();
 		bcm47xx_register_bcma();
 		bcm47xx_set_system_type(bcm47xx_bus.bcma.bus.chipinfo.id);
 #ifdef CONFIG_HIGHMEM
diff --git a/drivers/firmware/broadcom/Kconfig b/drivers/firmware/broadcom/Kconfig
index 6bed119..3c7e5b7 100644
--- a/drivers/firmware/broadcom/Kconfig
+++ b/drivers/firmware/broadcom/Kconfig
@@ -9,3 +9,14 @@ config BCM47XX_NVRAM
 	  This driver provides an easy way to get value of requested parameter.
 	  It simply reads content of NVRAM and parses it. It doesn't control any
 	  hardware part itself.
+
+config BCM47XX_SPROM
+	bool "Broadcom SPROM driver"
+	depends on BCM47XX_NVRAM
+	help
+	  Broadcom devices store configuration data in SPROM. Accessing it is
+	  specific to the bus host type, e.g. PCI(e) devices have it mapped in
+	  a PCI BAR.
+	  In case of SoC devices SPROM content is stored on a flash used by
+	  bootloader firmware CFE. This driver provides method to ssb and bcma
+	  drivers to read SPROM on SoC.
diff --git a/drivers/firmware/broadcom/Makefile b/drivers/firmware/broadcom/Makefile
index d0e6835..f93efc4 100644
--- a/drivers/firmware/broadcom/Makefile
+++ b/drivers/firmware/broadcom/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_BCM47XX_NVRAM)		+= bcm47xx_nvram.o
+obj-$(CONFIG_BCM47XX_SPROM)		+= bcm47xx_sprom.o
diff --git a/arch/mips/bcm47xx/sprom.c b/drivers/firmware/broadcom/bcm47xx_sprom.c
similarity index 98%
rename from arch/mips/bcm47xx/sprom.c
rename to drivers/firmware/broadcom/bcm47xx_sprom.c
index 959c145..5dfd459 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/drivers/firmware/broadcom/bcm47xx_sprom.c
@@ -26,9 +26,11 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <bcm47xx.h>
-#include <linux/if_ether.h>
+#include <linux/bcm47xx_nvram.h>
+#include <linux/bcma/bcma.h>
 #include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/ssb/ssb.h>
 
 static void create_key(const char *prefix, const char *postfix,
 		       const char *name, char *buf, int len)
@@ -599,7 +601,7 @@ void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
 	bcm47xx_sprom_fill_auto(sprom, prefix, fallback);
 }
 
-#if defined(CONFIG_BCM47XX_SSB)
+#if defined(CONFIG_SSB_SPROM)
 static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
 {
 	char prefix[10];
@@ -622,7 +624,7 @@ static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
 }
 #endif
 
-#if defined(CONFIG_BCM47XX_BCMA)
+#if defined(CONFIG_BCMA)
 /*
  * Having many NVRAM entries for PCI devices led to repeating prefixes like
  * pci/1/1/ all the time and wasting flash space. So at some point Broadcom
@@ -706,19 +708,30 @@ static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 }
 #endif
 
+static unsigned int bcm47xx_sprom_registered;
+
 /*
  * On bcm47xx we need to register SPROM fallback handler very early, so we can't
  * use anything like platform device / driver for this.
  */
-void bcm47xx_sprom_register_fallbacks(void)
+int bcm47xx_sprom_register_fallbacks(void)
 {
-#if defined(CONFIG_BCM47XX_SSB)
+	if (bcm47xx_sprom_registered)
+		return 0;
+
+#if defined(CONFIG_SSB_SPROM)
 	if (ssb_arch_register_fallback_sprom(&bcm47xx_get_sprom_ssb))
 		pr_warn("Failed to registered ssb SPROM handler\n");
 #endif
 
-#if defined(CONFIG_BCM47XX_BCMA)
+#if defined(CONFIG_BCMA)
 	if (bcma_arch_register_fallback_sprom(&bcm47xx_get_sprom_bcma))
 		pr_warn("Failed to registered bcma SPROM handler\n");
 #endif
+
+	bcm47xx_sprom_registered = 1;
+
+	return 0;
 }
+
+fs_initcall(bcm47xx_sprom_register_fallbacks);
diff --git a/include/linux/bcm47xx_sprom.h b/include/linux/bcm47xx_sprom.h
new file mode 100644
index 0000000..c06b47c
--- /dev/null
+++ b/include/linux/bcm47xx_sprom.h
@@ -0,0 +1,24 @@
+/*
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef __BCM47XX_SPROM_H
+#define __BCM47XX_SPROM_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+
+#ifdef CONFIG_BCM47XX_SPROM
+int bcm47xx_sprom_register_fallbacks(void);
+#else
+static inline int bcm47xx_sprom_register_fallbacks(void)
+{
+	return -ENOTSUPP;
+};
+#endif
+
+#endif /* __BCM47XX_SPROM_H */
-- 
1.8.4.5
