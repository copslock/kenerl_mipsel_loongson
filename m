Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:32:08 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:42632 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903719Ab2CNJao (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:30:44 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id AD9D023C00D6;
        Wed, 14 Mar 2012 10:00:08 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org
Subject: [PATCH v3 04/12] MIPS: ath79: fix a wrong IRQ number
Date:   Wed, 14 Mar 2012 11:36:06 +0100
Message-Id: <1331721374-4144-5-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
References: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The Ubiquiti XM board setup code uses an invalid
IRQ number, because it if above of NR_IRQS. This
leads to failed 'request_irq' calls:

  ath9k 0000:00:00.0: request_irq failed
  ath9k: probe of 0000:00:00.0 failed with error -22

Preserve some IRQ numbers for the built-in IRQ
controller of PCI host controllers in the
AR71XX/AR724X SoCs, and use the correct IRQ
number in the board setup code.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v3: - no changes
v2: - no changes

The IRQ controller code is also missing, that will be
added in a separate patch.

 arch/mips/ath79/mach-ubnt-xm.c         |    5 +++--
 arch/mips/include/asm/mach-ath79/irq.h |    6 +++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
index 3266ee0..0d95b67 100644
--- a/arch/mips/ath79/mach-ubnt-xm.c
+++ b/arch/mips/ath79/mach-ubnt-xm.c
@@ -17,6 +17,8 @@
 #include <linux/ath9k_platform.h>
 #endif /* CONFIG_PCI */
 
+#include <asm/mach-ath79/irq.h>
+
 #include "machtypes.h"
 #include "dev-gpio-buttons.h"
 #include "dev-leds-gpio.h"
@@ -33,7 +35,6 @@
 #define UBNT_XM_KEYS_POLL_INTERVAL	20
 #define UBNT_XM_KEYS_DEBOUNCE_INTERVAL	(3 * UBNT_XM_KEYS_POLL_INTERVAL)
 
-#define UBNT_XM_PCI_IRQ			48
 #define UBNT_XM_EEPROM_ADDR		(u8 *) KSEG1ADDR(0x1fff1000)
 
 static struct gpio_led ubnt_xm_leds_gpio[] __initdata = {
@@ -86,7 +87,7 @@ static struct ath9k_platform_data ubnt_xm_eeprom_data;
 
 static struct ar724x_pci_data ubnt_xm_pci_data[] = {
 	{
-		.irq	= UBNT_XM_PCI_IRQ,
+		.irq	= ATH79_PCI_IRQ(0),
 		.pdata	= &ubnt_xm_eeprom_data,
 	},
 };
diff --git a/arch/mips/include/asm/mach-ath79/irq.h b/arch/mips/include/asm/mach-ath79/irq.h
index 519958f..6ae2646 100644
--- a/arch/mips/include/asm/mach-ath79/irq.h
+++ b/arch/mips/include/asm/mach-ath79/irq.h
@@ -10,11 +10,15 @@
 #define __ASM_MACH_ATH79_IRQ_H
 
 #define MIPS_CPU_IRQ_BASE	0
-#define NR_IRQS			40
+#define NR_IRQS			46
 
 #define ATH79_MISC_IRQ_BASE	8
 #define ATH79_MISC_IRQ_COUNT	32
 
+#define ATH79_PCI_IRQ_BASE	(ATH79_MISC_IRQ_BASE + ATH79_MISC_IRQ_COUNT)
+#define ATH79_PCI_IRQ_COUNT	6
+#define ATH79_PCI_IRQ(_x)	(ATH79_PCI_IRQ_BASE + (_x))
+
 #define ATH79_CPU_IRQ_IP2	(MIPS_CPU_IRQ_BASE + 2)
 #define ATH79_CPU_IRQ_USB	(MIPS_CPU_IRQ_BASE + 3)
 #define ATH79_CPU_IRQ_GE0	(MIPS_CPU_IRQ_BASE + 4)
-- 
1.7.2.1
