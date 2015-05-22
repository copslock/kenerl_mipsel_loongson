Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 17:53:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54175 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006683AbbEVPxNxZDyc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 17:53:13 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4E8137C07A587;
        Fri, 22 May 2015 16:53:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 16:53:10 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 16:53:09 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH 04/15] MIPS: i8259: DT support
Date:   Fri, 22 May 2015 16:51:03 +0100
Message-ID: <1432309875-9712-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47556
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

Support probing the i8259 programmable interrupt controller, as found on
the Malta board, and using its interrupts via device tree.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/i8259.h |  1 +
 arch/mips/kernel/i8259.c      | 43 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/i8259.h b/arch/mips/include/asm/i8259.h
index c7e2784..a7fbcd6 100644
--- a/arch/mips/include/asm/i8259.h
+++ b/arch/mips/include/asm/i8259.h
@@ -41,6 +41,7 @@ extern int i8259A_irq_pending(unsigned int irq);
 extern void make_8259A_irq(unsigned int irq);
 
 extern void init_i8259_irqs(void);
+extern int i8259_of_init(struct device_node *node, struct device_node *parent);
 
 /*
  * Do the traditional i8259 interrupt polling thing.  This is for the few
diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index a74ec3a..74f6752 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/of_irq.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 #include <linux/irq.h>
@@ -21,6 +22,8 @@
 #include <asm/i8259.h>
 #include <asm/io.h>
 
+#include "../../drivers/irqchip/irqchip.h"
+
 /*
  * This is the 'legacy' 8259A Programmable Interrupt Controller,
  * present in the majority of PC/AT boxes.
@@ -327,7 +330,7 @@ static struct irq_domain_ops i8259A_ops = {
  * driver compatibility reasons interrupts 0 - 15 to be the i8259
  * interrupts even if the hardware uses a different interrupt numbering.
  */
-void __init init_i8259_irqs(void)
+struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
 {
 	struct irq_domain *domain;
 
@@ -336,10 +339,46 @@ void __init init_i8259_irqs(void)
 
 	init_8259A(0);
 
-	domain = irq_domain_add_legacy(NULL, 16, I8259A_IRQ_BASE, 0,
+	domain = irq_domain_add_legacy(node, 16, I8259A_IRQ_BASE, 0,
 				       &i8259A_ops, NULL);
 	if (!domain)
 		panic("Failed to add i8259 IRQ domain");
 
 	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
+	return domain;
+}
+
+void __init init_i8259_irqs(void)
+{
+	__init_i8259_irqs(NULL);
+}
+
+static void i8259_irq_dispatch(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_domain *domain = irq_get_handler_data(irq);
+	int hwirq = i8259_irq();
+
+	if (hwirq < 0)
+		return;
+
+	irq = irq_linear_revmap(domain, hwirq);
+	generic_handle_irq(irq);
+}
+
+int __init i8259_of_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *domain;
+	unsigned int parent_irq;
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq) {
+		pr_err("Failed to map i8259 parent IRQ\n");
+		return -ENODEV;
+	}
+
+	domain = __init_i8259_irqs(node);
+	irq_set_handler_data(parent_irq, domain);
+	irq_set_chained_handler(parent_irq, i8259_irq_dispatch);
+	return 0;
 }
+IRQCHIP_DECLARE(i8259, "intel,i8259", i8259_of_init);
-- 
2.4.1
