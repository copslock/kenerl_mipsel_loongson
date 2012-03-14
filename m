Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:35:04 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:42741 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903728Ab2CNJbJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:31:09 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id DC82123C00EF;
        Wed, 14 Mar 2012 10:00:09 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org
Subject: [PATCH v3 11/12] MIPS: ath79: register PCI controller on the PB44 board
Date:   Wed, 14 Mar 2012 11:36:13 +0100
Message-Id: <1331721374-4144-12-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
References: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The PB44 reference board has two miniPCI slots. Register
the PCI controller to make those usable.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v3: - no changes
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
