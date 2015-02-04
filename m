Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 16:24:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41790 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011486AbbBDPWgErAbr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 16:22:36 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9FB452A29E931;
        Wed,  4 Feb 2015 15:22:27 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 4 Feb 2015 15:22:30 +0000
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 4 Feb 2015 15:22:29 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Zubair.Kakakhel@imgtec.com>,
        <gregkh@linuxfoundation.org>, <mturquette@linaro.org>,
        <sboyd@codeaurora.org>, <ralf@linux-mips.org>, <jslaby@suse.cz>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <lars@metafoo.de>,
        <paul.burton@imgtec.com>
Subject: [PATCH_V2 06/34] MIPS: jz4740: move arch_init_irq out of arch/mips/jz4740/irq.c
Date:   Wed, 4 Feb 2015 15:21:35 +0000
Message-ID: <1423063323-19419-7-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

From: Paul Burton <paul.burton@imgtec.com>

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
1.9.1
