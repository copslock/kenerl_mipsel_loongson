Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 00:21:33 +0100 (CET)
Received: from mail-la0-f51.google.com ([209.85.215.51]:39503 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011811AbaJ1XTIRawh5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 00:19:08 +0100
Received: by mail-la0-f51.google.com with SMTP id q1so1570951lam.10
        for <multiple recipients>; Tue, 28 Oct 2014 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7egc1zNEpVnWQRYbX2UFdg0E6ULOdjhC+9G0f2XiXSc=;
        b=MelfZqFDSgFWIBwp2JTX4fYD89QK8ydyyCbZERkDcQrpxP8L+yWwqzMriAFfAEI1pX
         GMEr7Yd6OmUtlEPl4a/oqxqRCTs26Lm6S7GelFawHrVK7b8CbDH/i52yz/LWYv3zWvZ7
         m4YD95PAYM0t09VVEg4jXdp+7nu0EpFRZ1TNFLeePT/i13gAz02+EdqHFckKhBZ5ZnkT
         43bMM0EShdHD/79KrJJ+Iz4TqFFirKNPbwtHZjyvuGlWHDJeMNB1pWf+2xKnbzyvSVaQ
         edAP1rTKrIaczSwZYprVDb+nz/BOjm57hPR8jlIWl6c99StGxV7uIa5SL4y6zDDsMAux
         WGng==
X-Received: by 10.152.44.233 with SMTP id h9mr7275655lam.73.1414538342953;
        Tue, 28 Oct 2014 16:19:02 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id i6sm1173752laf.47.2014.10.28.16.19.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 16:19:02 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: [PATCH v3 09/13] MIPS: ath25: register AR5312 flash controller
Date:   Wed, 29 Oct 2014 03:18:46 +0400
Message-Id: <1414538330-5548-10-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43660
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

AR5312 SoC flash controller maps the flash content to memory and
translates the memory access operations to the flash access operations.
Such controller is fully supported by the physmap-flash driver.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>R5312 SoC flash
---

Changes since v1:
  - rename MIPS machine ar231x -> ath25

Changes since v2:
  - drop GPIO, watchdog and AR2315 spiflash device registration
  - rename the patch

 arch/mips/ath25/ar5312.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index 26942a2..383dd6c 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -19,6 +19,8 @@
 #include <linux/bitops.h>
 #include <linux/irqdomain.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
 #include <linux/reboot.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
@@ -160,6 +162,24 @@ void __init ar5312_arch_init_irq(void)
 	ar5312_misc_irq_domain = domain;
 }
 
+static struct physmap_flash_data ar5312_flash_data = {
+	.width = 2,
+};
+
+static struct resource ar5312_flash_resource = {
+	.start = AR5312_FLASH_BASE,
+	.end = AR5312_FLASH_BASE + AR5312_FLASH_SIZE - 1,
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
 static void __init ar5312_flash_init(void)
 {
 	void __iomem *flashctl_base;
@@ -168,12 +188,24 @@ static void __init ar5312_flash_init(void)
 	flashctl_base = ioremap_nocache(AR5312_FLASHCTL_BASE,
 					AR5312_FLASHCTL_SIZE);
 
+	ctl = __raw_readl(flashctl_base + AR5312_FLASHCTL0);
+	ctl &= AR5312_FLASHCTL_MW;
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
+
 	/*
 	 * Configure flash bank 0.
 	 * Assume 8M window size. Flash will be aliased if it's smaller
 	 */
-	ctl = __raw_readl(flashctl_base + AR5312_FLASHCTL0);
-	ctl &= AR5312_FLASHCTL_MW;
 	ctl |= AR5312_FLASHCTL_E | AR5312_FLASHCTL_AC_8M | AR5312_FLASHCTL_RBLE;
 	ctl |= 0x01 << AR5312_FLASHCTL_IDCY_S;
 	ctl |= 0x07 << AR5312_FLASHCTL_WST1_S;
@@ -212,6 +244,8 @@ void __init ar5312_init_devices(void)
 	/* Everything else is probably AR5312 or compatible */
 	else
 		ath25_soc = ATH25_SOC_AR5312;
+
+	platform_device_register(&ar5312_physmap_flash);
 }
 
 static void ar5312_restart(char *command)
-- 
1.8.5.5
