Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 05:40:38 +0200 (CEST)
Received: from smtpbgbr1.qq.com ([54.207.19.206]:53878 "EHLO smtpbgbr1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012185AbbD2DkIqAdej (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Apr 2015 05:40:08 +0200
X-QQ-mid: bizesmtp2t1430278789t636t097
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 29 Apr 2015 11:39:48 +0800 (CST)
X-QQ-SSF: 01100000002000F0F422B00A0000000
X-QQ-FEAT: 8YYOEVtNMVlb8yMA9zKtk3C3jVqi97Mc8bG/I2WeEIUN4eh1oaiNQ35azFOYQ
        XNE9Fk/CVMH4hvggHBfm3kcJ7TsVayOaJdKY+TV2rfKIJveSh1wAgdNW4RVz3SsjftFnuDR
        eDA1WaUs8PMlMcW8n+Yux7irxPrcv+tanqA92rE/DwhqVW/2HZjnUHVryyRh8WEQgnD7eVi
        /zhxDpNNIeAyJaYd+EmBLGvbqykq6F139Q+MUjXNyGBAHQf2UMhwV
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 6/8] MIPS: Loongson-1A: Add IRQ type setting support
Date:   Wed, 29 Apr 2015 11:57:25 +0800
Message-Id: <1430279847-25120-7-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
References: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

Loongson 1A's INT controller support two different interrupt trigger mode:
level trigger and edge trigger.

Whether the INT controller stores the external interrupts is
the difference between them.
The edge trigger should do this, and operate INT_CLR register
to clear the CPU interrupt state.

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson1/common/irq.c | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/mips/loongson1/common/irq.c b/arch/mips/loongson1/common/irq.c
index 455a770..28683c7 100644
--- a/arch/mips/loongson1/common/irq.c
+++ b/arch/mips/loongson1/common/irq.c
@@ -62,12 +62,57 @@ static void ls1x_irq_unmask(struct irq_data *d)
 			| (1 << bit), LS1X_INTC_INTIEN(n));
 }
 
+static int ls1x_irq_set_type(struct irq_data *d, unsigned int flow_type)
+{
+	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
+
+	if (flow_type & IRQ_TYPE_EDGE_BOTH) {
+		if ((flow_type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
+			printk(KERN_INFO "ls1x irq don't support both rising and falling\n");
+			return -1;
+		}
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTCLR(n))
+				| (1 << bit), LS1X_INTC_INTCLR(n));
+		if (flow_type & IRQ_TYPE_EDGE_RISING)
+			ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n))
+					| (1 << bit), LS1X_INTC_INTPOL(n));
+		else
+			ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n))
+					& ~(1 << bit), LS1X_INTC_INTPOL(n));
+
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTEDGE(n))
+				| (1 << bit), LS1X_INTC_INTEDGE(n));
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n))
+				| (1 << bit), LS1X_INTC_INTIEN(n));
+		__irq_set_handler_locked(d->irq, handle_edge_irq);
+	} else if (flow_type && IRQ_TYPE_LEVEL_MASK) {
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTCLR(n))
+				| (1 << bit), LS1X_INTC_INTCLR(n));
+		if (flow_type & IRQ_TYPE_LEVEL_HIGH)
+			ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n))
+					| (1 << bit), LS1X_INTC_INTPOL(n));
+		else if (flow_type & IRQ_TYPE_LEVEL_LOW)
+			ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n))
+					& ~(1 << bit), LS1X_INTC_INTPOL(n));
+
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTEDGE(n))
+				& ~(1 << bit), LS1X_INTC_INTEDGE(n));
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n))
+				| (1 << bit), LS1X_INTC_INTIEN(n));
+		__irq_set_handler_locked(d->irq, handle_level_irq);
+	}
+
+	return IRQ_SET_MASK_OK;
+}
+
 static struct irq_chip ls1x_irq_chip = {
 	.name		= "LS1X-INTC",
 	.irq_ack	= ls1x_irq_ack,
 	.irq_mask	= ls1x_irq_mask,
 	.irq_mask_ack	= ls1x_irq_mask_ack,
 	.irq_unmask	= ls1x_irq_unmask,
+	.irq_set_type	= ls1x_irq_set_type,
 };
 
 static void ls1x_irq_dispatch(int n)
@@ -138,6 +183,7 @@ static void __init ls1x_irq_init(int base)
 	setup_irq(INT1_IRQ, &cascade_irqaction);
 	setup_irq(INT2_IRQ, &cascade_irqaction);
 	setup_irq(INT3_IRQ, &cascade_irqaction);
+	setup_irq(INT4_IRQ, &cascade_irqaction);
 }
 
 void __init arch_init_irq(void)
-- 
1.9.0
