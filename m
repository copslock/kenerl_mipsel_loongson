Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 18:59:57 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:42058 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904620Ab1KXR4f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Nov 2011 18:56:35 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 93BC814051D;
        Thu, 24 Nov 2011 18:56:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8YdhgvxCV20R; Thu, 24 Nov 2011 18:56:32 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 75F0F140510;
        Thu, 24 Nov 2011 18:56:24 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?q?Ren=C3=A9=20Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2 11/12] MIPS: ath79: register PCI controller on the PB44 board
Date:   Thu, 24 Nov 2011 18:56:06 +0100
Message-Id: <1322157367-31089-12-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1322157367-31089-1-git-send-email-juhosg@openwrt.org>
References: <1322157367-31089-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21016

The PB44 reference board has two miniPCI slots. Register
the PCI controller to make those usable.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v2: - no changes

 arch/mips/ath79/mach-pb44.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/mach-pb44.c b/arch/mips/ath79/mach-pb44.c
index fe9701a..c5f0ea5 100644
--- a/arch/mips/ath79/mach-pb44.c
+++ b/arch/mips/ath79/mach-pb44.c
@@ -19,6 +19,7 @@
 #include "dev-leds-gpio.h"
 #include "dev-spi.h"
 #include "dev-usb.h"
+#include "pci.h"
 
 #define PB44_GPIO_I2C_SCL	0
 #define PB44_GPIO_I2C_SDA	1
@@ -114,6 +115,7 @@ static void __init pb44_init(void)
 	ath79_register_spi(&pb44_spi_data, pb44_spi_info,
 			   ARRAY_SIZE(pb44_spi_info));
 	ath79_register_usb();
+	ath79_register_pci();
 }
 
 MIPS_MACHINE(ATH79_MACH_PB44, "PB44", "Atheros PB44 reference board",
-- 
1.7.2.1
