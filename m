Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:32:55 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29023 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010992AbbARWcxbIQMn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:32:53 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 718CB947CC2EA;
        Sun, 18 Jan 2015 22:32:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:32:46 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:32:42 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/36] MIPS: jz4740: remove non-DT interrupt controller init
Date:   Sun, 18 Jan 2015 14:27:21 -0800
Message-ID: <1421620067-23933-11-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 45259
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

The jz4740 now probes the interrupt controller using DT, so remove the
now dead non-DT init code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/mach-jz4740/irq.h |  2 --
 arch/mips/jz4740/irq.c                  | 25 +++++++------------------
 2 files changed, 7 insertions(+), 20 deletions(-)

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
index a4f0a82..9a8bda3 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -77,10 +77,16 @@ static struct irqaction jz4740_cascade_action = {
 	.name = "JZ4740 cascade interrupt",
 };
 
-static void __init __jz4740_intc_init(int parent_irq)
+static int __init jz4740_intc_of_init(struct device_node *node,
+	struct device_node *parent)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
+	int parent_irq;
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq)
+		return -EINVAL;
 
 	jz_intc_base = ioremap(JZ4740_INTC_BASE_ADDR, 0x14);
 
@@ -105,23 +111,6 @@ static void __init __jz4740_intc_init(int parent_irq)
 	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0, IRQ_NOPROBE | IRQ_LEVEL);
 
 	setup_irq(parent_irq, &jz4740_cascade_action);
-}
-
-void __init jz4740_intc_init(void)
-{
-	__jz4740_intc_init(2);
-}
-
-static int __init jz4740_intc_of_init(struct device_node *node,
-	struct device_node *parent)
-{
-	int parent_irq;
-
-	parent_irq = irq_of_parse_and_map(node, 0);
-	if (!parent_irq)
-		return -EINVAL;
-
-	__jz4740_intc_init(parent_irq);
 	return 0;
 }
 IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", jz4740_intc_of_init);
-- 
2.2.1
