Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2011 18:48:09 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:45254 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491084Ab1EIQrj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 May 2011 18:47:39 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH 2/4] MIPS: lantiq: adds Amazon SE serial port platform device
Date:   Mon,  9 May 2011 18:49:08 +0200
Message-Id: <1304959750-8557-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1304959750-8557-1-git-send-email-blogic@openwrt.org>
References: <1304959750-8557-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

Amazon SE only has 1 serial port. We use a seperate function to register the
platform device as the IRQ mappings also differ.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---
 .../mips/include/asm/mach-lantiq/xway/lantiq_irq.h |    4 +++
 arch/mips/lantiq/xway/devices.c                    |   21 ++++++++++++++++++++
 arch/mips/lantiq/xway/devices.h                    |    1 +
 3 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
index 5c81c98..b4465a8 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
@@ -21,6 +21,10 @@
 #define LTQ_ASC_RIR(x)		(INT_NUM_IM3_IRL0 + (x * 8) + 1)
 #define LTQ_ASC_EIR(x)		(INT_NUM_IM3_IRL0 + (x * 8) + 2)
 
+#define LTQ_ASC_ASE_TIR		INT_NUM_IM2_IRL0
+#define LTQ_ASC_ASE_RIR		(INT_NUM_IM2_IRL0 + 2)
+#define LTQ_ASC_ASE_EIR		(INT_NUM_IM2_IRL0 + 3)
+
 #define LTQ_SSC_TIR		(INT_NUM_IM0_IRL0 + 15)
 #define LTQ_SSC_RIR		(INT_NUM_IM0_IRL0 + 14)
 #define LTQ_SSC_EIR		(INT_NUM_IM0_IRL0 + 16)
diff --git a/arch/mips/lantiq/xway/devices.c b/arch/mips/lantiq/xway/devices.c
index c257026..2fd1733 100644
--- a/arch/mips/lantiq/xway/devices.c
+++ b/arch/mips/lantiq/xway/devices.c
@@ -29,6 +29,8 @@
 #include <lantiq_irq.h>
 #include <lantiq_platform.h>
 
+#include "devices.h"
+
 /* gpio */
 static struct resource ltq_gpio_resource[] = {
 	{
@@ -98,3 +100,22 @@ ltq_register_etop(struct ltq_eth_data *eth)
 		platform_device_register(&ltq_etop);
 	}
 }
+
+/* asc ports - amazon se has its own serial mapping */
+static struct resource ltq_ase_asc_resources[] = {
+	{
+		.name	= "asc0",
+		.start  = LTQ_ASC1_BASE_ADDR,
+		.end    = LTQ_ASC1_BASE_ADDR + LTQ_ASC_SIZE - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	IRQ_RES(tx, LTQ_ASC_ASE_TIR),
+	IRQ_RES(rx, LTQ_ASC_ASE_RIR),
+	IRQ_RES(err, LTQ_ASC_ASE_EIR),
+};
+
+void __init ltq_register_ase_asc(void)
+{
+	platform_device_register_simple("ltq_asc", 0,
+		ltq_ase_asc_resources, ARRAY_SIZE(ltq_ase_asc_resources));
+}
diff --git a/arch/mips/lantiq/xway/devices.h b/arch/mips/lantiq/xway/devices.h
index 2deb68e..e904934 100644
--- a/arch/mips/lantiq/xway/devices.h
+++ b/arch/mips/lantiq/xway/devices.h
@@ -14,6 +14,7 @@
 
 extern void ltq_register_gpio(void);
 extern void ltq_register_gpio_stp(void);
+extern void ltq_register_ase_asc(void);
 extern void ltq_register_etop(struct ltq_eth_data *eth);
 
 #endif
-- 
1.7.2.3
