Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2008 19:42:49 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:52383 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S23974375AbYK1Tml (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Nov 2008 19:42:41 +0000
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id EC0FC386DBBE;
	Fri, 28 Nov 2008 20:42:34 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: rb532: add set_type() function to IRQ struct
Date:	Fri, 28 Nov 2008 20:45:10 +0100
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
Message-Id: <20081128194234.EC0FC386DBBE@mail.ifyouseekate.net>
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Interrupt Group 4 mapps the GPIO pins enabled as interrupt sources;
add defines to make this clear when addressing them later in code.

The mapped GPIOs support triggering on either level high or low. To
achieve this, the set_type() function calls rb532_gpio_set_ilevel() for
interrupts of the above mentioned group.

As there is no way to alter the triggering characteristics of the other
interrupts, accept level triggering on status high only. (This is just a
guess; but as the system boots fine and interrupt-driven devices (e.g.
serial console) work with no implications, it seems to be right.)

To clear a GPIO mapped IRQ, the source has to be cleared (i.e., the
interrupt status bit of the corresponding GPIO pin). This is done inside
rb532_disable_irq().

After applying these changes I could undo most of my former "fixes" to
pata-rb532-cf. Particularly all interrupt handling can be done
generically via set_irq_type() as it was before.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/include/asm/mach-rc32434/irq.h |    3 +++
 arch/mips/rb532/irq.c                    |   26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-rc32434/irq.h b/arch/mips/include/asm/mach-rc32434/irq.h
index 56738d8..023a5b1 100644
--- a/arch/mips/include/asm/mach-rc32434/irq.h
+++ b/arch/mips/include/asm/mach-rc32434/irq.h
@@ -30,4 +30,7 @@
 #define ETH0_RX_OVR_IRQ   	(GROUP3_IRQ_BASE + 9)
 #define ETH0_TX_UND_IRQ   	(GROUP3_IRQ_BASE + 10)
 
+#define GPIO_MAPPED_IRQ_BASE	GROUP4_IRQ_BASE
+#define GPIO_MAPPED_IRQ_GROUP	4
+
 #endif  /* __ASM_RC32434_IRQ_H */
diff --git a/arch/mips/rb532/irq.c b/arch/mips/rb532/irq.c
index 549b46d..e265af5 100644
--- a/arch/mips/rb532/irq.c
+++ b/arch/mips/rb532/irq.c
@@ -46,6 +46,7 @@
 #include <asm/system.h>
 
 #include <asm/mach-rc32434/irq.h>
+#include <asm/mach-rc32434/gpio.h>
 
 struct intr_group {
 	u32 mask;	/* mask of valid bits in pending/mask registers */
@@ -150,6 +151,9 @@ static void rb532_disable_irq(unsigned int irq_nr)
 		mask |= intr_bit;
 		WRITE_MASK(addr, mask);
 
+		if (group == GPIO_MAPPED_IRQ_GROUP)
+			rb532_gpio_set_istat(0, irq_nr - GPIO_MAPPED_IRQ_BASE);
+
 		/*
 		 * if there are no more interrupts enabled in this
 		 * group, disable corresponding IP
@@ -165,12 +169,34 @@ static void rb532_mask_and_ack_irq(unsigned int irq_nr)
 	ack_local_irq(group_to_ip(irq_to_group(irq_nr)));
 }
 
+static int rb532_set_type(unsigned int irq_nr, unsigned type)
+{
+	int gpio = irq_nr - GPIO_MAPPED_IRQ_BASE;
+	int group = irq_to_group(irq_nr);
+
+	if (group != GPIO_MAPPED_IRQ_GROUP)
+		return (type == IRQ_TYPE_LEVEL_HIGH) ? 0 : -EINVAL;
+
+	switch (type) {
+		case IRQ_TYPE_LEVEL_HIGH:
+			rb532_gpio_set_ilevel(1, gpio);
+			break;
+		case IRQ_TYPE_LEVEL_LOW:
+			rb532_gpio_set_ilevel(0, gpio);
+			break;
+		default:
+			return -EINVAL;
+	}
+	return 0;
+}
+
 static struct irq_chip rc32434_irq_type = {
 	.name		= "RB532",
 	.ack		= rb532_disable_irq,
 	.mask		= rb532_disable_irq,
 	.mask_ack	= rb532_mask_and_ack_irq,
 	.unmask		= rb532_enable_irq,
+	.set_type	= rb532_set_type,
 };
 
 void __init arch_init_irq(void)
-- 
1.5.6.4
