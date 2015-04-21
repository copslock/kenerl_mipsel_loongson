Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 16:50:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36501 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025944AbbDUOugqueZB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 16:50:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 40DEF877405AF;
        Tue, 21 Apr 2015 15:50:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 21 Apr 2015 15:50:32 +0100
Received: from localhost (192.168.159.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 21 Apr
 2015 15:50:31 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v3 11/37] MIPS: JZ4740: probe interrupt controller via DT
Date:   Tue, 21 Apr 2015 15:46:38 +0100
Message-ID: <1429627624-30525-12-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.67]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Declare the JZ4740 interrupt controller for probe via DT using the
standard irqchip_init function, and make use of that function to probe
the controller by adding the appropriate node to the JZ4740 dtsi.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
---
Changes in v3:
  - New patch, merging patches 8 through 10 of v2 & dropping the addition
    of temporary code removed a couple of patches later.
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi  | 11 +++++++++++
 arch/mips/include/asm/mach-jz4740/irq.h |  2 --
 arch/mips/jz4740/irq.c                  |  8 +++++++-
 arch/mips/jz4740/setup.c                |  2 --
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 2d64765c..3841024 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -9,4 +9,15 @@
 		interrupt-controller;
 		compatible = "mti,cpu-interrupt-controller";
 	};
+
+	intc: intc@10001000 {
+		compatible = "ingenic,jz4740-intc";
+		reg = <0x10001000 0x14>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <2>;
+	};
 };
diff --git a/arch/mips/include/asm/mach-jz4740/irq.h b/arch/mips/include/asm/mach-jz4740/irq.h
index 5ce4302..df50736 100644
--- a/arch/mips/include/asm/mach-jz4740/irq.h
+++ b/arch/mips/include/asm/mach-jz4740/irq.h
@@ -54,6 +54,4 @@
 
 #define NR_IRQS (JZ4740_IRQ_ADC_BASE + 6)
 
-extern void __init jz4740_intc_init(void);
-
 #endif
diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index bac1f52..43e000a 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/of_irq.h>
 #include <linux/timex.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -32,6 +33,8 @@
 
 #include "irq.h"
 
+#include "../../drivers/irqchip/irqchip.h"
+
 static void __iomem *jz_intc_base;
 
 #define JZ_REG_INTC_STATUS	0x00
@@ -77,7 +80,8 @@ static struct irqaction jz4740_cascade_action = {
 	.name = "JZ4740 cascade interrupt",
 };
 
-void __init jz4740_intc_init(void)
+static int __init jz4740_intc_of_init(struct device_node *node,
+	struct device_node *parent)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
@@ -105,7 +109,9 @@ void __init jz4740_intc_init(void)
 	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0, IRQ_NOPROBE | IRQ_LEVEL);
 
 	setup_irq(2, &jz4740_cascade_action);
+	return 0;
 }
+IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", jz4740_intc_of_init);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index 4808730..8c08d7d 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -25,7 +25,6 @@
 #include <asm/prom.h>
 
 #include <asm/mach-jz4740/base.h>
-#include <asm/mach-jz4740/irq.h>
 
 #include "reset.h"
 
@@ -84,5 +83,4 @@ const char *get_system_type(void)
 void __init arch_init_irq(void)
 {
 	irqchip_init();
-	jz4740_intc_init();
 }
-- 
2.3.5
