Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2013 21:33:02 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:53334 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827531Ab3BGUcnD5gpd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2013 21:32:43 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id E816A25E203;
        Thu,  7 Feb 2013 21:32:37 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yft5PsHitNj9; Thu,  7 Feb 2013 21:32:37 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 7924425E1F1;
        Thu,  7 Feb 2013 21:32:37 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/2] ath79: remove ATH79_MISC_IRQ_* defines
Date:   Thu,  7 Feb 2013 21:32:24 +0100
Message-Id: <1360269144-13853-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1360269144-13853-1-git-send-email-juhosg@openwrt.org>
References: <1360269144-13853-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Use the ATH79_MISC_IRQ() macro instead.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-common.c           |    6 +++---
 arch/mips/ath79/dev-usb.c              |    2 +-
 arch/mips/ath79/irq.c                  |    2 +-
 arch/mips/include/asm/mach-ath79/irq.h |   13 -------------
 4 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index ea3a814..9be1465 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -36,7 +36,7 @@ static struct resource ath79_uart_resources[] = {
 static struct plat_serial8250_port ath79_uart_data[] = {
 	{
 		.mapbase	= AR71XX_UART_BASE,
-		.irq		= ATH79_MISC_IRQ_UART,
+		.irq		= ATH79_MISC_IRQ(3),
 		.flags		= AR71XX_UART_FLAGS,
 		.iotype		= UPIO_MEM32,
 		.regshift	= 2,
@@ -62,8 +62,8 @@ static struct resource ar933x_uart_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= ATH79_MISC_IRQ_UART,
-		.end	= ATH79_MISC_IRQ_UART,
+		.start	= ATH79_MISC_IRQ(3),
+		.end	= ATH79_MISC_IRQ(3),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index 2e04197..bcb165b 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -107,7 +107,7 @@ static void __init ath79_usb_setup(void)
 	mdelay(900);
 
 	ath79_usb_init_resource(ath79_ohci_resources, AR71XX_OHCI_BASE,
-				AR71XX_OHCI_SIZE, ATH79_MISC_IRQ_OHCI);
+				AR71XX_OHCI_SIZE, ATH79_MISC_IRQ(6));
 	platform_device_register(&ath79_ohci_device);
 
 	ath79_usb_init_resource(ath79_ehci_resources, AR71XX_EHCI_BASE,
diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 2934895..df88d49 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -265,7 +265,7 @@ void __init arch_init_irq(void)
 		BUG();
 	}
 
-	cp0_perfcount_irq = ATH79_MISC_IRQ_PERFC;
+	cp0_perfcount_irq = ATH79_MISC_IRQ(5);
 	mips_cpu_irq_init();
 	ath79_misc_irq_init();
 
diff --git a/arch/mips/include/asm/mach-ath79/irq.h b/arch/mips/include/asm/mach-ath79/irq.h
index 3dda4c2..23e2bba 100644
--- a/arch/mips/include/asm/mach-ath79/irq.h
+++ b/arch/mips/include/asm/mach-ath79/irq.h
@@ -26,19 +26,6 @@
 #define ATH79_IP2_IRQ_COUNT	2
 #define ATH79_IP2_IRQ(_x)	(ATH79_IP2_IRQ_BASE + (_x))
 
-#define ATH79_MISC_IRQ_TIMER	(ATH79_MISC_IRQ_BASE + 0)
-#define ATH79_MISC_IRQ_ERROR	(ATH79_MISC_IRQ_BASE + 1)
-#define ATH79_MISC_IRQ_GPIO	(ATH79_MISC_IRQ_BASE + 2)
-#define ATH79_MISC_IRQ_UART	(ATH79_MISC_IRQ_BASE + 3)
-#define ATH79_MISC_IRQ_WDOG	(ATH79_MISC_IRQ_BASE + 4)
-#define ATH79_MISC_IRQ_PERFC	(ATH79_MISC_IRQ_BASE + 5)
-#define ATH79_MISC_IRQ_OHCI	(ATH79_MISC_IRQ_BASE + 6)
-#define ATH79_MISC_IRQ_DMA	(ATH79_MISC_IRQ_BASE + 7)
-#define ATH79_MISC_IRQ_TIMER2	(ATH79_MISC_IRQ_BASE + 8)
-#define ATH79_MISC_IRQ_TIMER3	(ATH79_MISC_IRQ_BASE + 9)
-#define ATH79_MISC_IRQ_TIMER4	(ATH79_MISC_IRQ_BASE + 10)
-#define ATH79_MISC_IRQ_ETHSW	(ATH79_MISC_IRQ_BASE + 12)
-
 #include_next <irq.h>
 
 #endif /* __ASM_MACH_ATH79_IRQ_H */
-- 
1.7.10
