Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:31:17 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8160 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010992AbbARWbOxaZHg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:31:14 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 76ADDC2E3BDD5;
        Sun, 18 Jan 2015 22:31:03 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:31:07 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:31:04 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/36] MIPS: jz4740: move arch_init_irq out of arch/mips/jz4740/irq.c
Date:   Sun, 18 Jan 2015 14:27:17 -0800
Message-ID: <1421620067-23933-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45255
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

In preparation for moving the jz4740 interrupt controller driver to
drivers/irqchip, move arch_init_irq into setup.c such that everything
remaining in irq.c is related to said jz4740 interrupt controller.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/mach-jz4740/irq.h | 2 ++
 arch/mips/jz4740/irq.c                  | 5 +----
 arch/mips/jz4740/setup.c                | 8 ++++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/irq.h b/arch/mips/include/asm/mach-jz4740/irq.h
index df50736..5ce4302 100644
--- a/arch/mips/include/asm/mach-jz4740/irq.h
+++ b/arch/mips/include/asm/mach-jz4740/irq.h
@@ -54,4 +54,6 @@
 
 #define NR_IRQS (JZ4740_IRQ_ADC_BASE + 6)
 
+extern void __init jz4740_intc_init(void);
+
 #endif
diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 999d64b..1b742c3 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -18,7 +18,6 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/irqchip.h>
 #include <linux/timex.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -75,13 +74,11 @@ static struct irqaction jz4740_cascade_action = {
 	.name = "JZ4740 cascade interrupt",
 };
 
-void __init arch_init_irq(void)
+void __init jz4740_intc_init(void)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 
-	irqchip_init();
-
 	jz_intc_base = ioremap(JZ4740_INTC_BASE_ADDR, 0x14);
 
 	/* Mask all irqs */
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index d6bb7a3..4808730 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -16,6 +16,7 @@
 
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
@@ -24,6 +25,7 @@
 #include <asm/prom.h>
 
 #include <asm/mach-jz4740/base.h>
+#include <asm/mach-jz4740/irq.h>
 
 #include "reset.h"
 
@@ -78,3 +80,9 @@ const char *get_system_type(void)
 {
 	return "JZ4740";
 }
+
+void __init arch_init_irq(void)
+{
+	irqchip_init();
+	jz4740_intc_init();
+}
-- 
2.2.1
