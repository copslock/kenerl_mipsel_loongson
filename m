Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:51:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17362 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994822AbdHMEsXBMRvd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:48:23 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id BBBF067011E27;
        Sun, 13 Aug 2017 05:48:14 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:48:16 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 36/38] irqchip: mips-gic: Clean up mti,reserved-cpu-vectors handling
Date:   Sat, 12 Aug 2017 21:36:44 -0700
Message-ID: <20170813043646.25821-37-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813043646.25821-1-paul.burton@imgtec.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59552
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

When parsing mti,reserved-cpu-vectors we generate a mask of all bits
that have been declared reserved, the loop through starting from bit 2
to find one that isn't reserved (ie. is zero).

This patch accomplishes the same task more simply by:

  - Inititialising the reserved mask to 0x3 (ie. the 2 software
    interrupts). This means we don't need to skip them later as the loop
    previously has.

  - Replacing the loop checking for zero bits with find_first_zero_bit,
    which fits our needs now that the 2 software interrupts are marked
    reserved. This requires that the type of reserved is changed to
    unsigned long so that it's suitable for use with bitmap functions.

  - Replacing the magic number 8 with the hamming weight of the ST0_IM
    field - ie. the number of bits that a MIPS CPU has for interrupt
    inputs. This is still a compile-time constant 8, but makes it
    clearer why it's 8.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 7a42f0b3822f..e4ab65c7056d 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -633,21 +633,21 @@ static const struct irq_domain_ops gic_ipi_domain_ops = {
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
-	unsigned int cpu_vec, i, j, reserved, gicconfig, cpu, v[2];
+	unsigned int cpu_vec, i, j, gicconfig, cpu, v[2];
+	unsigned long reserved;
 	phys_addr_t gic_base;
 	struct resource res;
 	size_t gic_len;
 
 	/* Find the first available CPU vector. */
-	i = reserved = 0;
+	i = 0;
+	reserved = (C_SW0 | C_SW1) >> __fls(C_SW0);
 	while (!of_property_read_u32_index(node, "mti,reserved-cpu-vectors",
 					   i++, &cpu_vec))
 		reserved |= BIT(cpu_vec);
-	for (cpu_vec = 2; cpu_vec < 8; cpu_vec++) {
-		if (!(reserved & BIT(cpu_vec)))
-			break;
-	}
-	if (cpu_vec == 8) {
+
+	cpu_vec = find_first_zero_bit(&reserved, hweight_long(ST0_IM));
+	if (cpu_vec == hweight_long(ST0_IM)) {
 		pr_err("No CPU vectors available for GIC\n");
 		return -ENODEV;
 	}
-- 
2.14.0
