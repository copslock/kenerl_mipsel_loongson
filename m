Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2009 14:50:24 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:44032 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492976AbZI1MuR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Sep 2009 14:50:17 +0200
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 4F65BE08119;
	Mon, 28 Sep 2009 14:49:46 +0200 (CEST)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 74768E0805A;
	Mon, 28 Sep 2009 14:49:43 +0200 (CEST)
Subject: [PATCH v3] MIPS: BCM63xx: Add PCMCIA & Cardbus support.
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Wolfram Sang <w.sang@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-pcmcia@lists.infradead.org, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <4ABCF1E7.4010304@ru.mvista.com>
References: <1253272891.1627.284.camel@sakura.staff.proxad.net>
	 <20090923123143.GB3131@pengutronix.de>
	 <1253709915.1627.397.camel@sakura.staff.proxad.net>
	 <1253890476.1627.468.camel@sakura.staff.proxad.net>
	 <4ABCF1E7.4010304@ru.mvista.com>
Content-Type: text/plain
Organization: Freebox
Date:	Mon, 28 Sep 2009 14:49:43 +0200
Message-Id: <1254142183.1627.488.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Fri, 2009-09-25 at 20:37 +0400, Sergei Shtylyov wrote:

Hi Sergei,

>     Then why initialize it?

fixed

>     Shouln't this be array of structures instead?

fixed

>     Is this GPIO selection really chip- and not board-specific?

yes

>     I don't think having both board code and the driver in a single patch is 
> a good idea. I'd put the driver in its own separate patch...

Ralf seems ok with merging as-is, next time I'll split board support and
driver I guess.

>     Are you sure you can drive any Broadcom's bridge?

fixed

>     Why it's called the same as 'yenta_cardbus_driver' and not 
> "bcm63xx_cardbus"?

copy/paste, fixed

>     Why so many empty lines in between?

fixed


Updated patch.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

---
 arch/mips/bcm63xx/Makefile                         |    2 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |    4 +
 arch/mips/bcm63xx/dev-pcmcia.c                     |  144 ++++++
 .../include/asm/mach-bcm63xx/bcm63xx_dev_pcmcia.h  |   13 +
 drivers/pcmcia/Kconfig                             |    4 +
 drivers/pcmcia/Makefile                            |    1 +
 drivers/pcmcia/bcm63xx_pcmcia.c                    |  536 ++++++++++++++++++++
 drivers/pcmcia/bcm63xx_pcmcia.h                    |   60 +++
 8 files changed, 763 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-pcmcia.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_pcmcia.h
 create mode 100644 drivers/pcmcia/bcm63xx_pcmcia.c
 create mode 100644 drivers/pcmcia/bcm63xx_pcmcia.h

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index cff75de..c146d1e 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,5 +1,5 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o setup.o timer.o \
-		   dev-dsp.o dev-enet.o dev-uart.o
+		   dev-dsp.o dev-enet.o dev-pcmcia.o dev-uart.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index d3fdf27..e3e6205 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -24,6 +24,7 @@
 #include <bcm63xx_dev_pci.h>
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_dsp.h>
+#include <bcm63xx_dev_pcmcia.h>
 #include <bcm63xx_dev_uart.h>
 #include <board_bcm963xx.h>
 
@@ -796,6 +797,9 @@ int __init board_register_devices(void)
 
 	bcm63xx_uart_register();
 
+	if (board.has_pccard)
+		bcm63xx_pcmcia_register();
+
 	if (board.has_enet0 &&
 	    !board_get_mac_address(board.enet0.mac_addr))
 		bcm63xx_enet_register(0, &board.enet0);
diff --git a/arch/mips/bcm63xx/dev-pcmcia.c b/arch/mips/bcm63xx/dev-pcmcia.c
new file mode 100644
index 0000000..de4d917
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-pcmcia.c
@@ -0,0 +1,144 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/bootinfo.h>
+#include <linux/platform_device.h>
+#include <bcm63xx_cs.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_dev_pcmcia.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_regs.h>
+
+static struct resource pcmcia_resources[] = {
+	/* pcmcia registers */
+	{
+		/* start & end filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+
+	/* pcmcia memory zone resources */
+	{
+		.start		= BCM_PCMCIA_COMMON_BASE_PA,
+		.end		= BCM_PCMCIA_COMMON_END_PA,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= BCM_PCMCIA_ATTR_BASE_PA,
+		.end		= BCM_PCMCIA_ATTR_END_PA,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= BCM_PCMCIA_IO_BASE_PA,
+		.end		= BCM_PCMCIA_IO_END_PA,
+		.flags		= IORESOURCE_MEM,
+	},
+
+	/* PCMCIA irq */
+	{
+		/* start filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+
+	/* declare PCMCIA IO resource also */
+	{
+		.start		= BCM_PCMCIA_IO_BASE_PA,
+		.end		= BCM_PCMCIA_IO_END_PA,
+		.flags		= IORESOURCE_IO,
+	},
+};
+
+static struct bcm63xx_pcmcia_platform_data pd;
+
+static struct platform_device bcm63xx_pcmcia_device = {
+	.name		= "bcm63xx_pcmcia",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pcmcia_resources),
+	.resource	= pcmcia_resources,
+	.dev		= {
+		.platform_data = &pd,
+	},
+};
+
+static int __init config_pcmcia_cs(unsigned int cs,
+				   u32 base, unsigned int size)
+{
+	int ret;
+
+	ret = bcm63xx_set_cs_status(cs, 0);
+	if (!ret)
+		ret = bcm63xx_set_cs_base(cs, base, size);
+	if (!ret)
+		ret = bcm63xx_set_cs_status(cs, 1);
+	return ret;
+}
+
+static const __initdata struct {
+	unsigned int	cs;
+	unsigned int	base;
+	unsigned int	size;
+} pcmcia_cs[3] = {
+	{
+		.cs	= MPI_CS_PCMCIA_COMMON,
+		.base	= BCM_PCMCIA_COMMON_BASE_PA,
+		.size	= BCM_PCMCIA_COMMON_SIZE
+	},
+	{
+		.cs	= MPI_CS_PCMCIA_ATTR,
+		.base	= BCM_PCMCIA_ATTR_BASE_PA,
+		.size	= BCM_PCMCIA_ATTR_SIZE
+	},
+	{
+		.cs	= MPI_CS_PCMCIA_IO,
+		.base	= BCM_PCMCIA_IO_BASE_PA,
+		.size	= BCM_PCMCIA_IO_SIZE
+	},
+};
+
+int __init bcm63xx_pcmcia_register(void)
+{
+	int ret, i;
+
+	if (!BCMCPU_IS_6348() && !BCMCPU_IS_6358())
+		return 0;
+
+	/* use correct pcmcia ready gpio depending on processor */
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6348_CPU_ID:
+		pd.ready_gpio = 22;
+		break;
+
+	case BCM6358_CPU_ID:
+		pd.ready_gpio = 18;
+		break;
+
+	default:
+		return -ENODEV;
+	}
+
+	pcmcia_resources[0].start = bcm63xx_regset_address(RSET_PCMCIA);
+	pcmcia_resources[0].end = pcmcia_resources[0].start +
+		RSET_PCMCIA_SIZE - 1;
+	pcmcia_resources[4].start = bcm63xx_get_irq_number(IRQ_PCMCIA);
+
+	/* configure pcmcia chip selects */
+	for (i = 0; i < 3; i++) {
+		ret = config_pcmcia_cs(pcmcia_cs[i].cs,
+				       pcmcia_cs[i].base,
+				       pcmcia_cs[i].size);
+		if (ret)
+			goto out_err;
+	}
+
+	return platform_device_register(&bcm63xx_pcmcia_device);
+
+out_err:
+	printk(KERN_ERR "unable to set pcmcia chip select\n");
+	return ret;
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_pcmcia.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_pcmcia.h
new file mode 100644
index 0000000..2beb396
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_pcmcia.h
@@ -0,0 +1,13 @@
+#ifndef BCM63XX_DEV_PCMCIA_H_
+#define BCM63XX_DEV_PCMCIA_H_
+
+/*
+ * PCMCIA driver platform data
+ */
+struct bcm63xx_pcmcia_platform_data {
+	unsigned int ready_gpio;
+};
+
+int bcm63xx_pcmcia_register(void);
+
+#endif /* BCM63XX_DEV_PCMCIA_H_ */
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index fbf965b..17f38a7 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -192,6 +192,10 @@ config PCMCIA_AU1X00
 	tristate "Au1x00 pcmcia support"
 	depends on SOC_AU1X00 && PCMCIA
 
+config PCMCIA_BCM63XX
+	tristate "bcm63xx pcmcia support"
+	depends on BCM63XX && PCMCIA
+
 config PCMCIA_SA1100
 	tristate "SA1100 support"
 	depends on ARM && ARCH_SA1100 && PCMCIA
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index 047394d..1ee57f0 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_PCMCIA_SA1111)			+= sa11xx_core.o sa1111_cs.o
 obj-$(CONFIG_M32R_PCC)				+= m32r_pcc.o
 obj-$(CONFIG_M32R_CFC)				+= m32r_cfc.o
 obj-$(CONFIG_PCMCIA_AU1X00)			+= au1x00_ss.o
+obj-$(CONFIG_PCMCIA_BCM63XX)			+= bcm63xx_pcmcia.o
 obj-$(CONFIG_PCMCIA_VRC4171)			+= vrc4171_card.o
 obj-$(CONFIG_PCMCIA_VRC4173)			+= vrc4173_cardu.o
 obj-$(CONFIG_OMAP_CF)				+= omap_cf.o
diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
new file mode 100644
index 0000000..bc88a3b
--- /dev/null
+++ b/drivers/pcmcia/bcm63xx_pcmcia.c
@@ -0,0 +1,536 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/timer.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/gpio.h>
+
+#include <bcm63xx_regs.h>
+#include <bcm63xx_io.h>
+#include "bcm63xx_pcmcia.h"
+
+#define PFX	"bcm63xx_pcmcia: "
+
+#ifdef CONFIG_CARDBUS
+/* if cardbus is used, platform device needs reference to actual pci
+ * device */
+static struct pci_dev *bcm63xx_cb_dev;
+#endif
+
+/*
+ * read/write helper for pcmcia regs
+ */
+static inline u32 pcmcia_readl(struct bcm63xx_pcmcia_socket *skt, u32 off)
+{
+	return bcm_readl(skt->base + off);
+}
+
+static inline void pcmcia_writel(struct bcm63xx_pcmcia_socket *skt,
+				 u32 val, u32 off)
+{
+	bcm_writel(val, skt->base + off);
+}
+
+/*
+ * This callback should (re-)initialise the socket, turn on status
+ * interrupts and PCMCIA bus, and wait for power to stabilise so that
+ * the card status signals report correctly.
+ *
+ * Hardware cannot do that.
+ */
+static int bcm63xx_pcmcia_sock_init(struct pcmcia_socket *sock)
+{
+	return 0;
+}
+
+/*
+ * This callback should remove power on the socket, disable IRQs from
+ * the card, turn off status interrupts, and disable the PCMCIA bus.
+ *
+ * Hardware cannot do that.
+ */
+static int bcm63xx_pcmcia_suspend(struct pcmcia_socket *sock)
+{
+	return 0;
+}
+
+/*
+ * Implements the set_socket() operation for the in-kernel PCMCIA
+ * service (formerly SS_SetSocket in Card Services). We more or
+ * less punt all of this work and let the kernel handle the details
+ * of power configuration, reset, &c. We also record the value of
+ * `state' in order to regurgitate it to the PCMCIA core later.
+ */
+static int bcm63xx_pcmcia_set_socket(struct pcmcia_socket *sock,
+				     socket_state_t *state)
+{
+	struct bcm63xx_pcmcia_socket *skt;
+	unsigned long flags;
+	u32 val;
+
+	skt = sock->driver_data;
+
+	spin_lock_irqsave(&skt->lock, flags);
+
+	/* note: hardware cannot control socket power, so we will
+	 * always report SS_POWERON */
+
+	/* apply socket reset */
+	val = pcmcia_readl(skt, PCMCIA_C1_REG);
+	if (state->flags & SS_RESET)
+		val |= PCMCIA_C1_RESET_MASK;
+	else
+		val &= ~PCMCIA_C1_RESET_MASK;
+
+	/* reverse reset logic for cardbus card */
+	if (skt->card_detected && (skt->card_type & CARD_CARDBUS))
+		val ^= PCMCIA_C1_RESET_MASK;
+
+	pcmcia_writel(skt, val, PCMCIA_C1_REG);
+
+	/* keep requested state for event reporting */
+	skt->requested_state = *state;
+
+	spin_unlock_irqrestore(&skt->lock, flags);
+
+	return 0;
+}
+
+/*
+ * identity cardtype from VS[12] input, CD[12] input while only VS2 is
+ * floating, and CD[12] input while only VS1 is floating
+ */
+enum {
+	IN_VS1 = (1 << 0),
+	IN_VS2 = (1 << 1),
+	IN_CD1_VS2H = (1 << 2),
+	IN_CD2_VS2H = (1 << 3),
+	IN_CD1_VS1H = (1 << 4),
+	IN_CD2_VS1H = (1 << 5),
+};
+
+static const u8 vscd_to_cardtype[] = {
+
+	/* VS1 float, VS2 float */
+	[IN_VS1 | IN_VS2] = (CARD_PCCARD | CARD_5V),
+
+	/* VS1 grounded, VS2 float */
+	[IN_VS2] = (CARD_PCCARD | CARD_5V | CARD_3V),
+
+	/* VS1 grounded, VS2 grounded */
+	[0] = (CARD_PCCARD | CARD_5V | CARD_3V | CARD_XV),
+
+	/* VS1 tied to CD1, VS2 float */
+	[IN_VS1 | IN_VS2 | IN_CD1_VS1H] = (CARD_CARDBUS | CARD_3V),
+
+	/* VS1 grounded, VS2 tied to CD2 */
+	[IN_VS2 | IN_CD2_VS2H] = (CARD_CARDBUS | CARD_3V | CARD_XV),
+
+	/* VS1 tied to CD2, VS2 grounded */
+	[IN_VS1 | IN_CD2_VS1H] = (CARD_CARDBUS | CARD_3V | CARD_XV | CARD_YV),
+
+	/* VS1 float, VS2 grounded */
+	[IN_VS1] = (CARD_PCCARD | CARD_XV),
+
+	/* VS1 float, VS2 tied to CD2 */
+	[IN_VS1 | IN_VS2 | IN_CD2_VS2H] = (CARD_CARDBUS | CARD_3V),
+
+	/* VS1 float, VS2 tied to CD1 */
+	[IN_VS1 | IN_VS2 | IN_CD1_VS2H] = (CARD_CARDBUS | CARD_XV | CARD_YV),
+
+	/* VS1 tied to CD2, VS2 float */
+	[IN_VS1 | IN_VS2 | IN_CD2_VS1H] = (CARD_CARDBUS | CARD_YV),
+
+	/* VS2 grounded, VS1 is tied to CD1, CD2 is grounded */
+	[IN_VS1 | IN_CD1_VS1H] = 0, /* ignore cardbay */
+};
+
+/*
+ * poll hardware to check card insertion status
+ */
+static unsigned int __get_socket_status(struct bcm63xx_pcmcia_socket *skt)
+{
+	unsigned int stat;
+	u32 val;
+
+	stat = 0;
+
+	/* check CD for card presence */
+	val = pcmcia_readl(skt, PCMCIA_C1_REG);
+
+	if (!(val & PCMCIA_C1_CD1_MASK) && !(val & PCMCIA_C1_CD2_MASK))
+		stat |= SS_DETECT;
+
+	/* if new insertion, detect cardtype */
+	if ((stat & SS_DETECT) && !skt->card_detected) {
+		unsigned int stat = 0;
+
+		/* float VS1, float VS2 */
+		val |= PCMCIA_C1_VS1OE_MASK;
+		val |= PCMCIA_C1_VS2OE_MASK;
+		pcmcia_writel(skt, val, PCMCIA_C1_REG);
+
+		/* wait for output to stabilize and read VS[12] */
+		udelay(10);
+		val = pcmcia_readl(skt, PCMCIA_C1_REG);
+		stat |= (val & PCMCIA_C1_VS1_MASK) ? IN_VS1 : 0;
+		stat |= (val & PCMCIA_C1_VS2_MASK) ? IN_VS2 : 0;
+
+		/* drive VS1 low, float VS2 */
+		val &= ~PCMCIA_C1_VS1OE_MASK;
+		val |= PCMCIA_C1_VS2OE_MASK;
+		pcmcia_writel(skt, val, PCMCIA_C1_REG);
+
+		/* wait for output to stabilize and read CD[12] */
+		udelay(10);
+		val = pcmcia_readl(skt, PCMCIA_C1_REG);
+		stat |= (val & PCMCIA_C1_CD1_MASK) ? IN_CD1_VS2H : 0;
+		stat |= (val & PCMCIA_C1_CD2_MASK) ? IN_CD2_VS2H : 0;
+
+		/* float VS1, drive VS2 low */
+		val |= PCMCIA_C1_VS1OE_MASK;
+		val &= ~PCMCIA_C1_VS2OE_MASK;
+		pcmcia_writel(skt, val, PCMCIA_C1_REG);
+
+		/* wait for output to stabilize and read CD[12] */
+		udelay(10);
+		val = pcmcia_readl(skt, PCMCIA_C1_REG);
+		stat |= (val & PCMCIA_C1_CD1_MASK) ? IN_CD1_VS1H : 0;
+		stat |= (val & PCMCIA_C1_CD2_MASK) ? IN_CD2_VS1H : 0;
+
+		/* guess cardtype from all this */
+		skt->card_type = vscd_to_cardtype[stat];
+		if (!skt->card_type)
+			dev_err(&skt->socket.dev, "unsupported card type\n");
+
+		/* drive both VS pin to 0 again */
+		val &= ~(PCMCIA_C1_VS1OE_MASK | PCMCIA_C1_VS2OE_MASK);
+
+		/* enable correct logic */
+		val &= ~(PCMCIA_C1_EN_PCMCIA_MASK | PCMCIA_C1_EN_CARDBUS_MASK);
+		if (skt->card_type & CARD_PCCARD)
+			val |= PCMCIA_C1_EN_PCMCIA_MASK;
+		else
+			val |= PCMCIA_C1_EN_CARDBUS_MASK;
+
+		pcmcia_writel(skt, val, PCMCIA_C1_REG);
+	}
+	skt->card_detected = (stat & SS_DETECT) ? 1 : 0;
+
+	/* report card type/voltage */
+	if (skt->card_type & CARD_CARDBUS)
+		stat |= SS_CARDBUS;
+	if (skt->card_type & CARD_3V)
+		stat |= SS_3VCARD;
+	if (skt->card_type & CARD_XV)
+		stat |= SS_XVCARD;
+	stat |= SS_POWERON;
+
+	if (gpio_get_value(skt->pd->ready_gpio))
+		stat |= SS_READY;
+
+	return stat;
+}
+
+/*
+ * core request to get current socket status
+ */
+static int bcm63xx_pcmcia_get_status(struct pcmcia_socket *sock,
+				     unsigned int *status)
+{
+	struct bcm63xx_pcmcia_socket *skt;
+
+	skt = sock->driver_data;
+
+	spin_lock_bh(&skt->lock);
+	*status = __get_socket_status(skt);
+	spin_unlock_bh(&skt->lock);
+
+	return 0;
+}
+
+/*
+ * socket polling timer callback
+ */
+static void bcm63xx_pcmcia_poll(unsigned long data)
+{
+	struct bcm63xx_pcmcia_socket *skt;
+	unsigned int stat, events;
+
+	skt = (struct bcm63xx_pcmcia_socket *)data;
+
+	spin_lock_bh(&skt->lock);
+
+	stat = __get_socket_status(skt);
+
+	/* keep only changed bits, and mask with required one from the
+	 * core */
+	events = (stat ^ skt->old_status) & skt->requested_state.csc_mask;
+	skt->old_status = stat;
+	spin_unlock_bh(&skt->lock);
+
+	if (events)
+		pcmcia_parse_events(&skt->socket, events);
+
+	mod_timer(&skt->timer,
+		  jiffies + msecs_to_jiffies(BCM63XX_PCMCIA_POLL_RATE));
+}
+
+static int bcm63xx_pcmcia_set_io_map(struct pcmcia_socket *sock,
+				     struct pccard_io_map *map)
+{
+	/* this doesn't seem to be called by pcmcia layer if static
+	 * mapping is used */
+	return 0;
+}
+
+static int bcm63xx_pcmcia_set_mem_map(struct pcmcia_socket *sock,
+				      struct pccard_mem_map *map)
+{
+	struct bcm63xx_pcmcia_socket *skt;
+	struct resource *res;
+
+	skt = sock->driver_data;
+	if (map->flags & MAP_ATTRIB)
+		res = skt->attr_res;
+	else
+		res = skt->common_res;
+
+	map->static_start = res->start + map->card_start;
+	return 0;
+}
+
+static struct pccard_operations bcm63xx_pcmcia_operations = {
+	.init			= bcm63xx_pcmcia_sock_init,
+	.suspend		= bcm63xx_pcmcia_suspend,
+	.get_status		= bcm63xx_pcmcia_get_status,
+	.set_socket		= bcm63xx_pcmcia_set_socket,
+	.set_io_map		= bcm63xx_pcmcia_set_io_map,
+	.set_mem_map		= bcm63xx_pcmcia_set_mem_map,
+};
+
+/*
+ * register pcmcia socket to core
+ */
+static int __devinit bcm63xx_drv_pcmcia_probe(struct platform_device *pdev)
+{
+	struct bcm63xx_pcmcia_socket *skt;
+	struct pcmcia_socket *sock;
+	struct resource *res, *irq_res;
+	unsigned int regmem_size = 0, iomem_size = 0;
+	u32 val;
+	int ret;
+
+	skt = kzalloc(sizeof(*skt), GFP_KERNEL);
+	if (!skt)
+		return -ENOMEM;
+	spin_lock_init(&skt->lock);
+	sock = &skt->socket;
+	sock->driver_data = skt;
+
+	/* make sure we have all resources we need */
+	skt->common_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	skt->attr_res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	skt->pd = pdev->dev.platform_data;
+	if (!skt->common_res || !skt->attr_res || !irq_res || !skt->pd) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* remap pcmcia registers */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regmem_size = resource_size(res);
+	if (!request_mem_region(res->start, regmem_size, "bcm63xx_pcmcia")) {
+		ret = -EINVAL;
+		goto err;
+	}
+	skt->reg_res = res;
+
+	skt->base = ioremap(res->start, regmem_size);
+	if (!skt->base) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/* remap io registers */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+	iomem_size = resource_size(res);
+	skt->io_base = ioremap(res->start, iomem_size);
+	if (!skt->io_base) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/* resources are static */
+	sock->resource_ops = &pccard_static_ops;
+	sock->ops = &bcm63xx_pcmcia_operations;
+	sock->owner = THIS_MODULE;
+	sock->dev.parent = &pdev->dev;
+	sock->features = SS_CAP_STATIC_MAP | SS_CAP_PCCARD;
+	sock->io_offset = (unsigned long)skt->io_base;
+	sock->pci_irq = irq_res->start;
+
+#ifdef CONFIG_CARDBUS
+	sock->cb_dev = bcm63xx_cb_dev;
+	if (bcm63xx_cb_dev)
+		sock->features |= SS_CAP_CARDBUS;
+#endif
+
+	/* assume common & attribute memory have the same size */
+	sock->map_size = resource_size(skt->common_res);
+
+	/* initialize polling timer */
+	setup_timer(&skt->timer, bcm63xx_pcmcia_poll, (unsigned long)skt);
+
+	/* initialize  pcmcia  control register,  drive  VS[12] to  0,
+	 * leave CB IDSEL to the old  value since it is set by the PCI
+	 * layer */
+	val = pcmcia_readl(skt, PCMCIA_C1_REG);
+	val &= PCMCIA_C1_CBIDSEL_MASK;
+	val |= PCMCIA_C1_EN_PCMCIA_GPIO_MASK;
+	pcmcia_writel(skt, val, PCMCIA_C1_REG);
+
+	/*
+	 * Hardware has only one set of timings registers, not one for
+	 * each memory access type, so we configure them for the
+	 * slowest one: attribute memory.
+	 */
+	val = PCMCIA_C2_DATA16_MASK;
+	val |= 10 << PCMCIA_C2_RWCOUNT_SHIFT;
+	val |= 6 << PCMCIA_C2_INACTIVE_SHIFT;
+	val |= 3 << PCMCIA_C2_SETUP_SHIFT;
+	val |= 3 << PCMCIA_C2_HOLD_SHIFT;
+	pcmcia_writel(skt, val, PCMCIA_C2_REG);
+
+	ret = pcmcia_register_socket(sock);
+	if (ret)
+		goto err;
+
+	/* start polling socket */
+	mod_timer(&skt->timer,
+		  jiffies + msecs_to_jiffies(BCM63XX_PCMCIA_POLL_RATE));
+
+	platform_set_drvdata(pdev, skt);
+	return 0;
+
+err:
+	if (skt->io_base)
+		iounmap(skt->io_base);
+	if (skt->base)
+		iounmap(skt->base);
+	if (skt->reg_res)
+		release_mem_region(skt->reg_res->start, regmem_size);
+	kfree(skt);
+	return ret;
+}
+
+static int __devexit bcm63xx_drv_pcmcia_remove(struct platform_device *pdev)
+{
+	struct bcm63xx_pcmcia_socket *skt;
+	struct resource *res;
+
+	skt = platform_get_drvdata(pdev);
+	del_timer_sync(&skt->timer);
+	iounmap(skt->base);
+	iounmap(skt->io_base);
+	res = skt->reg_res;
+	release_mem_region(res->start, resource_size(res));
+	kfree(skt);
+	return 0;
+}
+
+struct platform_driver bcm63xx_pcmcia_driver = {
+	.probe	= bcm63xx_drv_pcmcia_probe,
+	.remove	= __devexit_p(bcm63xx_drv_pcmcia_remove),
+	.driver	= {
+		.name	= "bcm63xx_pcmcia",
+		.owner  = THIS_MODULE,
+	},
+};
+
+#ifdef CONFIG_CARDBUS
+static int __devinit bcm63xx_cb_probe(struct pci_dev *dev,
+				      const struct pci_device_id *id)
+{
+	/* keep pci device */
+	bcm63xx_cb_dev = dev;
+	return platform_driver_register(&bcm63xx_pcmcia_driver);
+}
+
+static void __devexit bcm63xx_cb_exit(struct pci_dev *dev)
+{
+	platform_driver_unregister(&bcm63xx_pcmcia_driver);
+	bcm63xx_cb_dev = NULL;
+}
+
+static struct pci_device_id bcm63xx_cb_table[] = {
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= BCM6348_CPU_ID,
+		.subvendor	= PCI_VENDOR_ID_BROADCOM,
+		.subdevice	= PCI_ANY_ID,
+		.class		= PCI_CLASS_BRIDGE_CARDBUS << 8,
+		.class_mask	= ~0,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_BROADCOM,
+		.device		= BCM6358_CPU_ID,
+		.subvendor	= PCI_VENDOR_ID_BROADCOM,
+		.subdevice	= PCI_ANY_ID,
+		.class		= PCI_CLASS_BRIDGE_CARDBUS << 8,
+		.class_mask	= ~0,
+	},
+
+	{ },
+};
+
+MODULE_DEVICE_TABLE(pci, bcm63xx_cb_table);
+
+static struct pci_driver bcm63xx_cardbus_driver = {
+	.name		= "bcm63xx_cardbus",
+	.id_table	= bcm63xx_cb_table,
+	.probe		= bcm63xx_cb_probe,
+	.remove		= __devexit_p(bcm63xx_cb_exit),
+};
+#endif
+
+/*
+ * if cardbus support is enabled, register our platform device after
+ * our fake cardbus bridge has been registered
+ */
+static int __init bcm63xx_pcmcia_init(void)
+{
+#ifdef CONFIG_CARDBUS
+	return pci_register_driver(&bcm63xx_cardbus_driver);
+#else
+	return platform_driver_register(&bcm63xx_pcmcia_driver);
+#endif
+}
+
+static void __exit bcm63xx_pcmcia_exit(void)
+{
+#ifdef CONFIG_CARDBUS
+	return pci_unregister_driver(&bcm63xx_cardbus_driver);
+#else
+	platform_driver_unregister(&bcm63xx_pcmcia_driver);
+#endif
+}
+
+module_init(bcm63xx_pcmcia_init);
+module_exit(bcm63xx_pcmcia_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Maxime Bizon <mbizon@freebox.fr>");
+MODULE_DESCRIPTION("Linux PCMCIA Card Services: bcm63xx Socket Controller");
diff --git a/drivers/pcmcia/bcm63xx_pcmcia.h b/drivers/pcmcia/bcm63xx_pcmcia.h
new file mode 100644
index 0000000..ed95739
--- /dev/null
+++ b/drivers/pcmcia/bcm63xx_pcmcia.h
@@ -0,0 +1,60 @@
+#ifndef BCM63XX_PCMCIA_H_
+#define BCM63XX_PCMCIA_H_
+
+#include <linux/types.h>
+#include <linux/timer.h>
+#include <pcmcia/ss.h>
+#include <bcm63xx_dev_pcmcia.h>
+
+/* socket polling rate in ms */
+#define BCM63XX_PCMCIA_POLL_RATE	500
+
+enum {
+	CARD_CARDBUS = (1 << 0),
+	CARD_PCCARD = (1 << 1),
+	CARD_5V = (1 << 2),
+	CARD_3V = (1 << 3),
+	CARD_XV = (1 << 4),
+	CARD_YV = (1 << 5),
+};
+
+struct bcm63xx_pcmcia_socket {
+	struct pcmcia_socket socket;
+
+	/* platform specific data */
+	struct bcm63xx_pcmcia_platform_data *pd;
+
+	/* all regs access are protected by this spinlock */
+	spinlock_t lock;
+
+	/* pcmcia registers resource */
+	struct resource *reg_res;
+
+	/* base remapped address of registers */
+	void __iomem *base;
+
+	/* whether a card is detected at the moment */
+	int card_detected;
+
+	/* type of detected card (mask of above enum) */
+	u8 card_type;
+
+	/* keep last socket status to implement event reporting */
+	unsigned int old_status;
+
+	/* backup of requested socket state */
+	socket_state_t requested_state;
+
+	/* timer used for socket status polling */
+	struct timer_list timer;
+
+	/* attribute/common memory resources */
+	struct resource *attr_res;
+	struct resource *common_res;
+	struct resource *io_res;
+
+	/* base address of io memory */
+	void __iomem *io_base;
+};
+
+#endif /* BCM63XX_PCMCIA_H_ */
-- 
1.6.0.4


-- 
Maxime
