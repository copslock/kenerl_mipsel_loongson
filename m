Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 09:50:29 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:46028
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011047AbaJJHtzPtnIj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 09:49:55 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/4] MIPS: ralink: allow loading irq registers from the devicetree
Date:   Fri, 10 Oct 2014 09:49:46 +0200
Message-Id: <1412927388-60721-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412927388-60721-1-git-send-email-blogic@openwrt.org>
References: <1412927388-60721-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/irq.c |   34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 781b3d1..62ad64b 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -20,14 +20,6 @@
 
 #include "common.h"
 
-/* INTC register offsets */
-#define INTC_REG_STATUS0	0x00
-#define INTC_REG_STATUS1	0x04
-#define INTC_REG_TYPE		0x20
-#define INTC_REG_RAW_STATUS	0x30
-#define INTC_REG_ENABLE		0x34
-#define INTC_REG_DISABLE	0x38
-
 #define INTC_INT_GLOBAL		BIT(31)
 
 #define RALINK_CPU_IRQ_INTC	(MIPS_CPU_IRQ_BASE + 2)
@@ -44,16 +36,34 @@
 
 #define RALINK_INTC_IRQ_PERFC   (RALINK_INTC_IRQ_BASE + 9)
 
+enum rt_intc_regs_enum {
+	INTC_REG_STATUS0 = 0,
+	INTC_REG_STATUS1,
+	INTC_REG_TYPE,
+	INTC_REG_RAW_STATUS,
+	INTC_REG_ENABLE,
+	INTC_REG_DISABLE,
+};
+
+static u32 rt_intc_regs[] = {
+	[INTC_REG_STATUS0] = 0x00,
+	[INTC_REG_STATUS1] = 0x04,
+	[INTC_REG_TYPE] = 0x20,
+	[INTC_REG_RAW_STATUS] = 0x30,
+	[INTC_REG_ENABLE] = 0x34,
+	[INTC_REG_DISABLE] = 0x38,
+};
+
 static void __iomem *rt_intc_membase;
 
 static inline void rt_intc_w32(u32 val, unsigned reg)
 {
-	__raw_writel(val, rt_intc_membase + reg);
+	__raw_writel(val, rt_intc_membase + rt_intc_regs[reg]);
 }
 
 static inline u32 rt_intc_r32(unsigned reg)
 {
-	return __raw_readl(rt_intc_membase + reg);
+	return __raw_readl(rt_intc_membase + rt_intc_regs[reg]);
 }
 
 static void ralink_intc_irq_unmask(struct irq_data *d)
@@ -134,6 +144,10 @@ static int __init intc_of_init(struct device_node *node,
 	struct irq_domain *domain;
 	int irq;
 
+	if (!of_property_read_u32_array(node, "ralink,intc-registers",
+							rt_intc_regs, 6))
+		pr_info("intc: using register map from devicetree\n");
+
 	irq = irq_of_parse_and_map(node, 0);
 	if (!irq)
 		panic("Failed to get INTC IRQ");
-- 
1.7.10.4
