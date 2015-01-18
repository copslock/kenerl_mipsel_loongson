Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:32:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55417 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010992AbbARWcFic09m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:32:05 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C6C26D6F69D13;
        Sun, 18 Jan 2015 22:31:55 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:31:59 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:31:55 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/36] MIPS: jz4740: allow interrupt controller probe via DT
Date:   Sun, 18 Jan 2015 14:27:19 -0800
Message-ID: <1421620067-23933-9-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 45257
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

Declare the interrupt controller for probe via the standard irqchip_init
function.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/irq.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 1b742c3..a4f0a82 100644
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
@@ -29,6 +30,8 @@
 
 #include <asm/mach-jz4740/base.h>
 
+#include "../../drivers/irqchip/irqchip.h"
+
 static void __iomem *jz_intc_base;
 
 #define JZ_REG_INTC_STATUS	0x00
@@ -74,7 +77,7 @@ static struct irqaction jz4740_cascade_action = {
 	.name = "JZ4740 cascade interrupt",
 };
 
-void __init jz4740_intc_init(void)
+static void __init __jz4740_intc_init(int parent_irq)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
@@ -101,8 +104,27 @@ void __init jz4740_intc_init(void)
 
 	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0, IRQ_NOPROBE | IRQ_LEVEL);
 
-	setup_irq(2, &jz4740_cascade_action);
+	setup_irq(parent_irq, &jz4740_cascade_action);
+}
+
+void __init jz4740_intc_init(void)
+{
+	__jz4740_intc_init(2);
+}
+
+static int __init jz4740_intc_of_init(struct device_node *node,
+	struct device_node *parent)
+{
+	int parent_irq;
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq)
+		return -EINVAL;
+
+	__jz4740_intc_init(parent_irq);
+	return 0;
 }
+IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", jz4740_intc_of_init);
 
 #ifdef CONFIG_DEBUG_FS
 
-- 
2.2.1
