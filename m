Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 07:55:08 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:54921 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021498AbXFFGxJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 07:53:09 +0100
Received: (qmail 7030 invoked by uid 511); 6 Jun 2007 07:00:18 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 07:00:18 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Songmao Tian <tiansm@lemote.com>
Subject: [PATCH 01/15] new files for lemote fulong mini-PC support
Date:	Wed,  6 Jun 2007 14:52:38 +0800
Message-Id: <1181112773134-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11811127722019-git-send-email-tiansm@lemote.com>
References: <11811127722019-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Songmao Tian <tiansm@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
Signed-off-by: Songmao Tian <tiansm@lemote.com>
---
 arch/mips/lemote/lm2e/Makefile               |    7 +
 arch/mips/lemote/lm2e/bonito-irq.c           |   74 +++++
 arch/mips/lemote/lm2e/dbg_io.c               |  146 ++++++++++
 arch/mips/lemote/lm2e/irq.c                  |  146 ++++++++++
 arch/mips/lemote/lm2e/pci.c                  |   72 +++++
 arch/mips/lemote/lm2e/prom.c                 |  109 ++++++++
 arch/mips/lemote/lm2e/reset.c                |   49 ++++
 arch/mips/lemote/lm2e/setup.c                |  144 ++++++++++
 arch/mips/pci/fixup-lm2e.c                   |  255 +++++++++++++++++
 arch/mips/pci/ops-lm2e.c                     |  153 +++++++++++
 include/asm-mips/mach-lemote/bonito.h        |  381 ++++++++++++++++++++++++++
 include/asm-mips/mach-lemote/dma-coherence.h |   43 +++
 include/asm-mips/mach-lemote/mc146818rtc.h   |   36 +++
 13 files changed, 1615 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/lemote/lm2e/Makefile
 create mode 100644 arch/mips/lemote/lm2e/bonito-irq.c
 create mode 100644 arch/mips/lemote/lm2e/dbg_io.c
 create mode 100644 arch/mips/lemote/lm2e/irq.c
 create mode 100644 arch/mips/lemote/lm2e/pci.c
 create mode 100644 arch/mips/lemote/lm2e/prom.c
 create mode 100644 arch/mips/lemote/lm2e/reset.c
 create mode 100644 arch/mips/lemote/lm2e/setup.c
 create mode 100644 arch/mips/pci/fixup-lm2e.c
 create mode 100644 arch/mips/pci/ops-lm2e.c
 create mode 100644 include/asm-mips/mach-lemote/bonito.h
 create mode 100644 include/asm-mips/mach-lemote/dma-coherence.h
 create mode 100644 include/asm-mips/mach-lemote/mc146818rtc.h

diff --git a/arch/mips/lemote/lm2e/Makefile b/arch/mips/lemote/lm2e/Makefile
new file mode 100644
index 0000000..0ba6f12
--- /dev/null
+++ b/arch/mips/lemote/lm2e/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for Lemote Fulong mini-PC board.
+#
+
+obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o dbg_io.o
+EXTRA_AFLAGS := $(CFLAGS)
+
diff --git a/arch/mips/lemote/lm2e/bonito-irq.c b/arch/mips/lemote/lm2e/bonito-irq.c
new file mode 100644
index 0000000..e7decd3
--- /dev/null
+++ b/arch/mips/lemote/lm2e/bonito-irq.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <asm/io.h>
+
+#include <bonito.h>
+
+
+static inline void bonito_irq_enable(unsigned int irq)
+{
+	BONITO_INTENSET = (1 << (irq - BONITO_IRQ_BASE));
+	mmiowb();
+}
+
+static inline void bonito_irq_disable(unsigned int irq)
+{
+	BONITO_INTENCLR = (1 << (irq - BONITO_IRQ_BASE));
+	mmiowb();
+}
+
+static struct irq_chip bonito_irq_type = {
+	.name	= "bonito_irq",
+	.ack	= bonito_irq_disable,
+	.mask	= bonito_irq_disable,
+	.mask_ack = bonito_irq_disable,
+	.unmask	= bonito_irq_enable,
+};
+
+static struct irqaction dma_timeout_irqaction = {
+	.handler	= no_action,
+	.name		= "dma_timeout",
+};
+
+void bonito_irq_init(void)
+{
+	u32 i;
+
+	for (i = BONITO_IRQ_BASE; i < BONITO_IRQ_BASE + 32; i++) {
+		set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
+	}
+
+	setup_irq(BONITO_IRQ_BASE + 10, &dma_timeout_irqaction);
+}
diff --git a/arch/mips/lemote/lm2e/dbg_io.c b/arch/mips/lemote/lm2e/dbg_io.c
new file mode 100644
index 0000000..b82d34a
--- /dev/null
+++ b/arch/mips/lemote/lm2e/dbg_io.c
@@ -0,0 +1,146 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <asm/types.h>
+#include <linux/init.h>
+#include <asm/serial.h>		/* For the serial port location and base baud */
+
+#define         UART16550_BAUD_2400             2400
+#define         UART16550_BAUD_4800             4800
+#define         UART16550_BAUD_9600             9600
+#define         UART16550_BAUD_19200            19200
+#define         UART16550_BAUD_38400            38400
+#define         UART16550_BAUD_57600            57600
+#define         UART16550_BAUD_115200           115200
+
+#define         UART16550_PARITY_NONE           0
+#define         UART16550_PARITY_ODD            0x08
+#define         UART16550_PARITY_EVEN           0x18
+#define         UART16550_PARITY_MARK           0x28
+#define         UART16550_PARITY_SPACE          0x38
+
+#define         UART16550_DATA_5BIT             0x0
+#define         UART16550_DATA_6BIT             0x1
+#define         UART16550_DATA_7BIT             0x2
+#define         UART16550_DATA_8BIT             0x3
+
+#define         UART16550_STOP_1BIT             0x0
+#define         UART16550_STOP_2BIT             0x4
+
+/* ----------------------------------------------------- */
+
+/* === CONFIG === */
+#ifdef CONFIG_64BIT
+#define         BASE                    (0xffffffffbfd003f8)
+#else
+#define         BASE                    (0xbfd003f8)
+#endif
+
+#define         MAX_BAUD                BASE_BAUD
+/* === END OF CONFIG === */
+
+#define         REG_OFFSET              1
+
+/* register offset */
+#define         OFS_RCV_BUFFER          0
+#define         OFS_TRANS_HOLD          0
+#define         OFS_SEND_BUFFER         0
+#define         OFS_INTR_ENABLE         (1*REG_OFFSET)
+#define         OFS_INTR_ID             (2*REG_OFFSET)
+#define         OFS_DATA_FORMAT         (3*REG_OFFSET)
+#define         OFS_LINE_CONTROL        (3*REG_OFFSET)
+#define         OFS_MODEM_CONTROL       (4*REG_OFFSET)
+#define         OFS_RS232_OUTPUT        (4*REG_OFFSET)
+#define         OFS_LINE_STATUS         (5*REG_OFFSET)
+#define         OFS_MODEM_STATUS        (6*REG_OFFSET)
+#define         OFS_RS232_INPUT         (6*REG_OFFSET)
+#define         OFS_SCRATCH_PAD         (7*REG_OFFSET)
+
+#define         OFS_DIVISOR_LSB         (0*REG_OFFSET)
+#define         OFS_DIVISOR_MSB         (1*REG_OFFSET)
+
+/* memory-mapped read/write of the port */
+#define         UART16550_READ(y)    (*((volatile u8*)(BASE + y)))
+#define         UART16550_WRITE(y, z)  ((*((volatile u8*)(BASE + y))) = z)
+
+void debugInit(u32 baud, u8 data, u8 parity, u8 stop)
+{
+	/* disable interrupts */
+	UART16550_WRITE(OFS_INTR_ENABLE, 0);
+
+	/* set up buad rate */
+	{
+		u32 divisor;
+
+		/* set DIAB bit */
+		UART16550_WRITE(OFS_LINE_CONTROL, 0x80);
+
+		/* set divisor */
+		divisor = MAX_BAUD / baud;
+		UART16550_WRITE(OFS_DIVISOR_LSB, divisor & 0xff);
+		UART16550_WRITE(OFS_DIVISOR_MSB, (divisor & 0xff00) >> 8);
+
+		/* clear DIAB bit */
+		UART16550_WRITE(OFS_LINE_CONTROL, 0x0);
+	}
+
+	/* set data format */
+	UART16550_WRITE(OFS_DATA_FORMAT, data | parity | stop);
+}
+
+static int remoteDebugInitialized = 0;
+
+u8 getDebugChar(void)
+{
+	if (!remoteDebugInitialized) {
+		remoteDebugInitialized = 1;
+		debugInit(UART16550_BAUD_115200,
+			  UART16550_DATA_8BIT,
+			  UART16550_PARITY_NONE, UART16550_STOP_1BIT);
+	}
+
+	while ((UART16550_READ(OFS_LINE_STATUS) & 0x1) == 0) ;
+	return UART16550_READ(OFS_RCV_BUFFER);
+}
+
+int putDebugChar(u8 byte)
+{
+	if (!remoteDebugInitialized) {
+		remoteDebugInitialized = 1;
+		/*
+		   debugInit(UART16550_BAUD_115200,
+		   UART16550_DATA_8BIT,
+		   UART16550_PARITY_NONE, UART16550_STOP_1BIT); */
+	}
+
+	while ((UART16550_READ(OFS_LINE_STATUS) & 0x20) == 0) ;
+	UART16550_WRITE(OFS_SEND_BUFFER, byte);
+	return 1;
+}
diff --git a/arch/mips/lemote/lm2e/irq.c b/arch/mips/lemote/lm2e/irq.c
new file mode 100644
index 0000000..1f31ec9
--- /dev/null
+++ b/arch/mips/lemote/lm2e/irq.c
@@ -0,0 +1,146 @@
+/*
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/irq_cpu.h>
+#include <asm/i8259.h>
+#include <asm/mipsregs.h>
+#include <asm/delay.h>
+#include <bonito.h>
+
+/*
+ * the first level int-handler will jump here if it is a bonito irq
+ */
+static void bonito_irqdispatch(void)
+{
+	u32 int_status;
+	int i;
+
+	/* workaround the IO dma problem: let cpu looping to allow DMA finish */
+	int_status = BONITO_INTISR;
+	if (int_status & (1 << 10)) {
+		while (int_status & (1 << 10)) {
+			udelay(1);
+			int_status = BONITO_INTISR;
+		}
+	}
+
+	/* Get pending sources, masked by current enables */
+	int_status = BONITO_INTISR & BONITO_INTEN;
+
+	if (int_status != 0) {
+		i = __ffs(int_status);
+		int_status &= ~(1 << i);
+		do_IRQ(i +BONITO_IRQ_BASE);
+	}
+	return;
+}
+
+static void i8259_irqdispatch(void)
+{
+	int irq;
+
+	irq = i8259_irq();
+	if (irq >= 0) {
+		do_IRQ(irq);
+	} else {
+		spurious_interrupt();
+	}
+
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
+
+	if (pending & CAUSEF_IP7) {
+		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
+	} else if (pending & CAUSEF_IP5) {
+		i8259_irqdispatch();
+	} else if (pending & CAUSEF_IP2) {
+		bonito_irqdispatch();
+	} else {
+		spurious_interrupt();
+	}
+}
+
+static struct irqaction cascade_irqaction = {
+	.handler = no_action,
+	.mask = CPU_MASK_NONE,
+	.name = "cascade",
+};
+
+void __init arch_init_irq(void)
+{
+	extern void bonito_irq_init(void);
+
+	printk(KERN_INFO"arch init irq\n");
+	/*
+	 * Clear all of the interrupts while we change the able around a bit.
+	 * int-handler is not on bootstrap
+	 */
+	clear_c0_status(ST0_IM | ST0_BEV);
+	local_irq_disable();
+
+	/* most bonito irq should be level triggered */
+	BONITO_INTEDGE = BONITO_ICU_SYSTEMERR | BONITO_ICU_MASTERERR
+	    | BONITO_ICU_RETRYERR | BONITO_ICU_MBOXES;
+	BONITO_INTSTEER = 0;
+
+	/*
+	 * Mask out all interrupt by writing "1" to all bit position in
+	 * the interrupt reset reg.
+	 */
+	BONITO_INTENCLR = ~0;
+
+	/* init all controller
+	 *   0-15         ------> i8259 interrupt
+	 *   16-23        ------> mips cpu interrupt
+	 *   32-63        ------> bonito irq
+	 */
+
+	/* Sets the first-level interrupt dispatcher. */
+	mips_cpu_irq_init();
+	init_i8259_irqs();
+	bonito_irq_init();
+
+	/*
+	printk("GPIODATA=%x, GPIOIE=%x\n", BONITO_GPIODATA, BONITO_GPIOIE);
+	printk("INTEN=%x, INTSET=%x, INTCLR=%x, INTISR=%x\n",
+			BONITO_INTEN, BONITO_INTENSET,
+			BONITO_INTENCLR, BONITO_INTISR);
+	*/
+
+	/* bonito irq at IP2 */
+	setup_irq(MIPS_CPU_IRQ_BASE + 2, &cascade_irqaction);
+	/* 8259 irq at IP5 */
+	setup_irq(MIPS_CPU_IRQ_BASE + 5, &cascade_irqaction);
+
+}
diff --git a/arch/mips/lemote/lm2e/pci.c b/arch/mips/lemote/lm2e/pci.c
new file mode 100644
index 0000000..e9c5ce2
--- /dev/null
+++ b/arch/mips/lemote/lm2e/pci.c
@@ -0,0 +1,72 @@
+/*
+ * pci.c
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+extern struct pci_ops loongson2e_pci_pci_ops;
+
+static struct resource loongson2e_pci_mem_resource = {
+	.name   = "LOONGSON2E PCI MEM",
+	.start  = 0x14000000UL,
+	.end    = 0x1fffffffUL,
+	.flags  = IORESOURCE_MEM,
+};
+
+static struct resource loongson2e_pci_io_resource = {
+	.name   = "LOONGSON2E PCI IO MEM",
+	.start  = 0x00004000UL,
+	.end    = 0x1fffffffUL,
+	.flags  = IORESOURCE_IO,
+};
+
+
+static struct pci_controller  loongson2e_pci_controller = {
+	.pci_ops        = &loongson2e_pci_pci_ops,
+	.io_resource    = &loongson2e_pci_io_resource,
+	.mem_resource   = &loongson2e_pci_mem_resource,
+	.mem_offset     = 0x00000000UL,
+	.io_offset      = 0x00000000UL,
+};
+
+
+static int __init pcibios_init(void)
+{
+	extern int pci_probe_only;
+	pci_probe_only = 0;
+
+#ifdef CONFIG_TRACE_BOOT
+	printk(KERN_INFO"arch_initcall:pcibios_init\n");
+	printk(KERN_INFO"register_pci_controller : %x\n",&loongson2e_pci_controller);
+#endif
+	register_pci_controller(&loongson2e_pci_controller);
+	return 0;
+}
+
+arch_initcall(pcibios_init);
diff --git a/arch/mips/lemote/lm2e/prom.c b/arch/mips/lemote/lm2e/prom.c
new file mode 100644
index 0000000..6704ca0
--- /dev/null
+++ b/arch/mips/lemote/lm2e/prom.c
@@ -0,0 +1,109 @@
+/*
+ * Based on Ocelot Linux port, which is
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * Copyright 2003 ICT CAS
+ * Author: Michael Guo <guoyi@ict.ac.cn>
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+extern unsigned long bus_clock;
+extern unsigned long cpu_clock;
+extern unsigned int memsize, highmemsize;
+extern int putDebugChar(unsigned char byte);
+
+static int argc;
+/* pmon passes arguments in 32bit pointers */
+static int *arg;
+static int *env;
+
+const char *get_system_type(void)
+{
+	return "lemote-fulong";
+}
+
+void __init prom_init_cmdline(void)
+{
+	int i;
+	long l;
+
+	/* arg[0] is "g", the rest is boot parameters */
+	arcs_cmdline[0] = '\0';
+	for (i = 1; i < argc; i++) {
+		l = (long)arg[i];
+		if (strlen(arcs_cmdline) + strlen(((char *)l) + 1)
+		    >= sizeof(arcs_cmdline))
+			break;
+		strcat(arcs_cmdline, ((char *)l));
+		strcat(arcs_cmdline, " ");
+	}
+}
+
+void __init prom_init(void)
+{
+	long l;
+	argc = fw_arg0;
+	arg = (int *)fw_arg1;
+	env = (int *)fw_arg2;
+
+	mips_machgroup = MACH_GROUP_LEMOTE;
+	mips_machtype = MACH_LEMOTE_FULONG;
+
+	prom_init_cmdline();
+
+	if ((strstr(arcs_cmdline, "console=")) == NULL)
+		strcat(arcs_cmdline, " console=ttyS0,115200");
+	if ((strstr(arcs_cmdline, "root=")) == NULL)
+		strcat(arcs_cmdline, " root=/dev/hda1");
+
+	l = (long)*env;
+	while (l != 0) {
+		if (strncmp("busclock", (char *)l, strlen("busclock")) == 0) {
+			bus_clock = simple_strtol((char *)l + strlen("busclock="),
+					NULL, 10);
+		}
+		if (strncmp("cpuclock", (char *)l, strlen("cpuclock")) == 0) {
+			cpu_clock = simple_strtol((char *)l + strlen("cpuclock="),
+					NULL, 10);
+		}
+		if (strncmp("memsize", (char *)l, strlen("memsize")) == 0) {
+			memsize = simple_strtol((char *)l + strlen("memsize="),
+						NULL, 10);
+		}
+		if (strncmp("highmemsize", (char *)l, strlen("highmemsize")) == 0) {
+			highmemsize = simple_strtol((char *)l + strlen("highmemsize="),
+					  NULL, 10);
+		}
+		env++;
+		l = (long)*env;
+	}
+	if (memsize == 0)
+		memsize = 256;
+
+	printk("busclock=%ld, cpuclock=%ld,memsize=%d,highmemsize=%d\n",
+	       bus_clock, cpu_clock, memsize, highmemsize);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+void prom_putchar(char c)
+{
+	putDebugChar(c);
+}
diff --git a/arch/mips/lemote/lm2e/reset.c b/arch/mips/lemote/lm2e/reset.c
new file mode 100644
index 0000000..ec1b08c
--- /dev/null
+++ b/arch/mips/lemote/lm2e/reset.c
@@ -0,0 +1,49 @@
+/*
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ */
+
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+#include <asm/system.h>
+
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/pm.h>
+#include <linux/delay.h>
+
+static void loongson2e_restart(char *command)
+{
+#ifdef CONFIG_32BIT
+	*(unsigned long *)0xbfe00104 &= ~(1 << 2);
+	*(unsigned long *)0xbfe00104 |= (1 << 2);
+#else
+	*(unsigned long *)0xffffffffbfe00104 &= ~(1 << 2);
+	*(unsigned long *)0xffffffffbfe00104 |= (1 << 2);
+#endif
+	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
+}
+
+static void loongson2e_halt(void)
+{
+	while (1) ;
+}
+
+static void loongson2e_power_off(void)
+{
+	loongson2e_halt();
+}
+
+void mips_reboot_setup(void)
+{
+	_machine_restart = loongson2e_restart;
+	_machine_halt = loongson2e_halt;
+	pm_power_off = loongson2e_power_off;
+}
diff --git a/arch/mips/lemote/lm2e/setup.c b/arch/mips/lemote/lm2e/setup.c
new file mode 100644
index 0000000..3030518
--- /dev/null
+++ b/arch/mips/lemote/lm2e/setup.c
@@ -0,0 +1,144 @@
+/*
+ * BRIEF MODULE DESCRIPTION
+ * setup.c - board dependent boot routines
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+
+#include <asm/mc146818-time.h>
+#include <asm/time.h>
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/pci.h>
+#include <asm/wbflush.h>
+
+#include <linux/bootmem.h>
+#include <linux/tty.h>
+#include <linux/mc146818rtc.h>
+
+#ifdef CONFIG_VT
+#include <linux/console.h>
+#include <linux/screen_info.h>
+#endif
+
+extern void mips_reboot_setup(void);
+
+#ifdef CONFIG_64BIT
+#define PTR_PAD(p) ((0xffffffff00000000)|((unsigned long long)(p)))
+#else
+#define PTR_PAD(p) (p)
+#endif
+
+unsigned long cpu_clock;
+unsigned long bus_clock;
+unsigned int memsize;
+unsigned int highmemsize = 0;
+
+void __init plat_timer_setup(struct irqaction *irq)
+{
+	setup_irq(MIPS_CPU_IRQ_BASE + 7, irq);
+}
+
+static void __init loongson2e_time_init(void)
+{
+	/* setup mips r4k timer */
+	mips_hpt_frequency = cpu_clock / 2;
+}
+
+static unsigned long __init mips_rtc_get_time(void)
+{
+	return mc146818_get_cmos_time();
+}
+
+void (*__wbflush) (void);
+static void wbflush_loongson2e(void)
+{
+	asm(".set\tpush\n\t"
+	    ".set\tnoreorder\n\t"
+	    ".set mips3\n\t"
+	    "sync\n\t"
+	    "nop\n\t"
+	    ".set\tpop\n\t"
+	    ".set mips0\n\t");
+}
+
+void __init plat_mem_setup(void)
+{
+	set_io_port_base(PTR_PAD(0xbfd00000));
+
+	ioport_resource.start = 0;
+	ioport_resource.end = 0xffffffff;
+	iomem_resource.start = 0;
+	iomem_resource.end = 0xffffffff;
+
+	mips_reboot_setup();
+
+	board_time_init = loongson2e_time_init;
+	rtc_mips_get_time = mips_rtc_get_time;
+
+	__wbflush = wbflush_loongson2e;
+
+	//add_memory_region(0x100000, (memsize<<20) - 0x100000, BOOT_MEM_RAM);
+	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+#ifdef CONFIG_64BIT
+	if (highmemsize > 0) {
+		add_memory_region(0x10000000, 0x10000000, BOOT_MEM_RESERVED);
+		add_memory_region(0x20000000, highmemsize << 20, BOOT_MEM_RAM);
+	}
+#endif
+
+#ifdef CONFIG_VT
+#if defined(CONFIG_VGA_CONSOLE)
+	conswitchp = &vga_con;
+
+	screen_info = (struct screen_info) {
+		0, 25,		/* orig-x, orig-y */
+		    0,		/* unused */
+		    0,		/* orig-video-page */
+		    0,		/* orig-video-mode */
+		    80,		/* orig-video-cols */
+		    0, 0, 0,	/* ega_ax, ega_bx, ega_cx */
+		    25,		/* orig-video-lines */
+		    VIDEO_TYPE_VGAC,	/* orig-video-isVGA */
+		    16		/* orig-video-points */
+	};
+#elif defined(CONFIG_DUMMY_CONSOLE)
+	conswitchp = &dummy_con;
+#endif
+#endif
+
+}
+
+#include <linux/module.h>
+EXPORT_SYMBOL(__wbflush);
+
diff --git a/arch/mips/pci/fixup-lm2e.c b/arch/mips/pci/fixup-lm2e.c
new file mode 100644
index 0000000..e9ae996
--- /dev/null
+++ b/arch/mips/pci/fixup-lm2e.c
@@ -0,0 +1,255 @@
+/*
+ * fixup-lm2e.c
+ *
+ * Copyright (C) 2004 ICT CAS
+ * Author: Li xiaoyu, ICT CAS
+ *   lixy@ict.ac.cn
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <bonito.h>
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	unsigned int val;
+	if (PCI_SLOT(dev->devfn) == 4) {	/* wireless card(notebook) */
+		dev->irq = BONITO_IRQ_BASE + 26;
+		return dev->irq;
+	} else if (PCI_SLOT(dev->devfn) == 5) {	/* via686b */
+		switch (PCI_FUNC(dev->devfn)) {
+		case 2:
+			dev->irq = 10;
+			break;
+		case 3:
+			dev->irq = 11;
+			break;
+		case 5:
+			dev->irq = 9;
+			break;
+		}
+		return dev->irq;
+	} else if (PCI_SLOT(dev->devfn) == 6) {	/* radeon 7000 */
+		dev->irq = BONITO_IRQ_BASE + 27;
+		return dev->irq;
+	} else if (PCI_SLOT(dev->devfn) == 7) {	/* 8139 */
+		dev->irq = BONITO_IRQ_BASE + 26;
+		return dev->irq;
+	} else if (PCI_SLOT(dev->devfn) == 8) {	/* nec usb */
+		switch (PCI_FUNC(dev->devfn)) {
+		case 0:
+			dev->irq = BONITO_IRQ_BASE + 26;
+			break;
+		case 1:
+			dev->irq = BONITO_IRQ_BASE + 27;
+			break;
+		case 2:
+			dev->irq = BONITO_IRQ_BASE + 28;
+			break;
+		}
+		pci_read_config_dword(dev, 0xe0, &val);
+		pci_write_config_dword(dev, 0xe0, (val & ~7) | 0x4);
+		pci_write_config_dword(dev, 0xe4, 1 << 5);
+		return dev->irq;
+	} else
+		return 0;
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+static void __init loongson2e_686b_func0_fixup(struct pci_dev *pdev)
+{
+	unsigned char c;
+
+	printk(KERN_INFO"via686b fix: ISA bridge\n");
+
+	/*  Enable I/O Recovery time */
+	pci_write_config_byte(pdev, 0x40, 0x08);
+
+	/*  Enable ISA refresh */
+	pci_write_config_byte(pdev, 0x41, 0x01);
+
+	/*  disable ISA line buffer */
+	pci_write_config_byte(pdev, 0x45, 0x00);
+
+	/*  Gate INTR, and flush line buffer */
+	pci_write_config_byte(pdev, 0x46, 0xe0);
+
+	/*  Disable PCI Delay Transaction, Enable EISA ports 4D0/4D1. */
+	//pci_write_config_byte(pdev, 0x47, 0x20);
+	/*  enable PCI Delay Transaction, Enable EISA ports 4D0/4D1.
+	 *  enable time-out timer
+	 */
+	pci_write_config_byte(pdev, 0x47, 0xe6);
+
+	/* enable level trigger on pci irqs: 9,10,11,13 */
+	/* important! without this PCI interrupts won't work */
+	outb(0x2e, 0x4d1);
+
+	/*  512 K PCI Decode */
+	pci_write_config_byte(pdev, 0x48, 0x01);
+
+	/*  Wait for PGNT before grant to ISA Master/DMA */
+	pci_write_config_byte(pdev, 0x4a, 0x84);
+
+	/*  Plug'n'Play */
+	/*  Parallel DRQ 3, Floppy DRQ 2 (default) */
+	pci_write_config_byte(pdev, 0x50, 0x0e);
+
+	/*  IRQ Routing for Floppy and Parallel port */
+	/*  IRQ 6 for floppy, IRQ 7 for parallel port */
+	pci_write_config_byte(pdev, 0x51, 0x76);
+
+	/*  IRQ Routing for serial ports (take IRQ 3 and 4) */
+	pci_write_config_byte(pdev, 0x52, 0x34);
+
+	/*  All IRQ's level triggered. */
+	pci_write_config_byte(pdev, 0x54, 0x00);
+
+	/* route PIRQA-D irq */
+	pci_write_config_byte(pdev, 0x55, 0x90);	/* bit 7-4, PIRQA */
+	pci_write_config_byte(pdev, 0x56, 0xba);	/* bit 7-4, PIRQC; 3-0, PIRQB */
+	pci_write_config_byte(pdev, 0x57, 0xd0);	/* bit 7-4, PIRQD */
+
+	/* enable function 5/6, audio/modem */
+	pci_read_config_byte(pdev, 0x85, &c);
+	c &= ~(0x3 << 2);
+	pci_write_config_byte(pdev, 0x85, c);
+
+	printk(KERN_INFO"via686b fix: ISA bridge done\n");
+}
+
+static void __init loongson2e_686b_func1_fixup(struct pci_dev *pdev)
+{
+	printk(KERN_INFO"via686b fix: IDE\n");
+
+	/* Modify IDE controller setup */
+	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 48);
+	pci_write_config_byte(pdev, PCI_COMMAND,
+			      PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+			      PCI_COMMAND_MASTER);
+	pci_write_config_byte(pdev, 0x40, 0x0b);
+	/* legacy mode */
+	pci_write_config_byte(pdev, 0x42, 0x09);
+
+#if 1/* play safe, otherwise we may see notebook's usb keyboard lockup */
+	/* disable read prefetch/write post buffers */
+	pci_write_config_byte(pdev, 0x41, 0x02);
+
+	/* use 3/4 as fifo thresh hold  */
+	pci_write_config_byte(pdev, 0x43, 0x0a);
+	pci_write_config_byte(pdev, 0x44, 0x00);
+
+	pci_write_config_byte(pdev, 0x45, 0x00);
+#else
+	pci_write_config_byte(pdev, 0x41, 0xc2);
+	pci_write_config_byte(pdev, 0x43, 0x35);
+	pci_write_config_byte(pdev, 0x44, 0x1c);
+
+	pci_write_config_byte(pdev, 0x45, 0x10);
+#endif
+
+	printk(KERN_INFO"via686b fix: IDE done\n");
+}
+
+static void __init loongson2e_686b_func5_fixup(struct pci_dev *pdev)
+{
+	unsigned int val;
+	unsigned char c;
+
+	/* enable IO */
+	pci_write_config_byte(pdev, PCI_COMMAND,
+			      PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+			      PCI_COMMAND_MASTER);
+	pci_read_config_dword(pdev, 0x4, &val);
+	pci_write_config_dword(pdev, 0x4, val | 1);
+
+	/* route ac97 IRQ */
+	pci_write_config_byte(pdev, 0x3c, 9);
+	pdev->irq = 9;
+	printk(KERN_INFO"ac97 interrupt = 9\n");
+
+	pci_read_config_byte(pdev, 0x8, &c);
+	printk(KERN_INFO"ac97 rev=%d\n", c);
+
+	/* link control: enable link & SGD PCM output */
+	pci_write_config_byte(pdev, 0x41, 0xcc);
+
+	/* disable game port, FM, midi, sb, enable write to reg2c-2f */
+	pci_write_config_byte(pdev, 0x42, 0x20);
+
+	printk(KERN_INFO"Setting sub-vendor ID & device ID\n");
+
+	/* we are using Avance logic codec */
+	pci_write_config_word(pdev, 0x2c, 0x1005);
+	pci_write_config_word(pdev, 0x2e, 0x4710);
+	pci_read_config_dword(pdev, 0x2c, &val);
+	printk(KERN_INFO"sub vendor-device id=%x\n", val);
+
+	pci_write_config_byte(pdev, 0x42, 0x0);
+}
+
+static void __init loongson2e_fixup_pcimap(struct pci_dev *pdev)
+{
+	static int first = 1;
+
+	(void)pdev;
+	if (first)
+		first = 0;
+	else
+		return;
+
+	/* local to PCI mapping: [256M,512M] -> [256M,512M]; differ from pmon */
+	/*
+	 *       cpu address space [256M,448M] is window for accessing pci space
+	 *       we set pcimap_lo[0,1,2] to map it to pci space [256M,448M]
+	 *        pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
+	 */
+	/* 1,00 0110 ,0001 01,00 0000 */
+	BONITO_PCIMAP = 0x46140;
+	//1, 00 0010, 0000,01, 00 0000
+	//BONITO_PCIMAP = 0x42040;
+
+	/*
+	 * PCI to local mapping: [2G,2G+256M] -> [0,256M]
+	 */
+	BONITO_PCIBASE0 = 0x80000000;
+	BONITO_PCIBASE1 = 0x00800000;
+	BONITO_PCIBASE2 = 0x90000000;
+
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, loongson2e_fixup_pcimap);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686,
+			 loongson2e_686b_func0_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
+			 loongson2e_686b_func1_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,
+			 loongson2e_686b_func5_fixup);
diff --git a/arch/mips/pci/ops-lm2e.c b/arch/mips/pci/ops-lm2e.c
new file mode 100644
index 0000000..87497e8
--- /dev/null
+++ b/arch/mips/pci/ops-lm2e.c
@@ -0,0 +1,153 @@
+/*
+ * ops-lm2e.c
+ *
+ * Copyright (C) 2004 ICT CAS
+ * Author: Li xiaoyu, ICT CAS
+ *   lixy@ict.ac.cn
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+
+#include <bonito.h>
+
+#define PCI_ACCESS_READ  0
+#define PCI_ACCESS_WRITE 1
+
+static inline void bflush(void)
+{
+	/* flush Bonito register writes */
+	(void)BONITO_PCICMD;
+}
+
+static int lm2e_pci_config_access(unsigned char access_type,
+				  struct pci_bus *bus, unsigned int devfn,
+				  int where, u32 *data)
+{
+	u32 busnum = bus->number;
+	u32 addr, type;
+	void *addrp;
+	int device = PCI_SLOT(devfn);
+	int function = PCI_FUNC(devfn);
+	int reg = where & ~3;
+
+	if (busnum == 0) {
+		/* Type 0 configuration on onboard PCI bus */
+		if (device > 20 || function > 7) {
+			*data = -1;	/* device out of range */
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+		addr = (1 << (device + 11)) | (function << 8) | reg;
+		type = 0;
+	} else {
+		/* Type 1 configuration on offboard PCI bus */
+		if (device > 31 || function > 7) {
+			*data = -1;	/* device out of range */
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+		type = 0x10000;
+	}
+
+	/* clear aborts */
+	BONITO_PCICMD |= BONITO_PCICMD_MABORT | BONITO_PCICMD_MTABORT;
+
+	BONITO_PCIMAP_CFG = (addr >> 16) | type;
+	bflush();
+
+	addrp = (void *)CKSEG1ADDR(BONITO_PCICFG_BASE | (addr & 0xffff));
+	if (access_type == PCI_ACCESS_WRITE) {
+		*(volatile unsigned int *)addrp = cpu_to_le32(*data);
+	} else {
+		*data = le32_to_cpu(*(volatile unsigned int *)addrp);
+	}
+	if (BONITO_PCICMD & (BONITO_PCICMD_MABORT | BONITO_PCICMD_MTABORT)) {
+		BONITO_PCICMD |= BONITO_PCICMD_MABORT | BONITO_PCICMD_MTABORT;
+		*data = -1;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+
+}
+
+static int lm2e_pci_pcibios_read(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 * val)
+{
+	u32 data = 0;
+
+	int ret = lm2e_pci_config_access(PCI_ACCESS_READ,
+			bus, devfn, where, &data);
+
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
+
+	if (size == 1)
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+	else if (size == 2)
+		*val = (data >> ((where & 3) << 3)) & 0xffff;
+	else
+		*val = data;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int lm2e_pci_pcibios_write(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 val)
+{
+	u32 data = 0;
+	int ret;
+
+	if (size == 4)
+		data = val;
+	else {
+		ret = lm2e_pci_config_access(PCI_ACCESS_READ,
+				bus, devfn, where, &data);
+		if (ret != PCIBIOS_SUCCESSFUL)
+			return ret;
+
+		if (size == 1)
+			data = (data & ~(0xff << ((where & 3) << 3))) |
+			    (val << ((where & 3) << 3));
+		else if (size == 2)
+			data = (data & ~(0xffff << ((where & 3) << 3))) |
+			    (val << ((where & 3) << 3));
+	}
+
+	ret = lm2e_pci_config_access(PCI_ACCESS_WRITE,
+			bus, devfn, where, &data);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ops loongson2e_pci_pci_ops = {
+	.read = lm2e_pci_pcibios_read,
+	.write = lm2e_pci_pcibios_write
+};
diff --git a/include/asm-mips/mach-lemote/bonito.h b/include/asm-mips/mach-lemote/bonito.h
new file mode 100644
index 0000000..83f7ac3
--- /dev/null
+++ b/include/asm-mips/mach-lemote/bonito.h
@@ -0,0 +1,381 @@
+/*
+ * Based on Algorithmics header
+ */
+
+#ifndef _BONITO_H
+#define _BONITI_H
+
+#ifdef __ASSEMBLER__
+
+/* offsets from base register */
+#define BONITO(x)	(x)
+
+#else /* !__ASSEMBLER */
+
+/* offsets from base pointer */
+#define BONITO(x) *(volatile u32 *)((char *)CKSEG1ADDR(BONITO_REG_BASE) + (x))
+
+#endif /* __ASSEMBLER__ */
+
+#define BONITO_BOOT_BASE		0x1fc00000
+#define BONITO_BOOT_SIZE		0x00100000
+#define BONITO_BOOT_TOP 		(BONITO_BOOT_BASE+BONITO_BOOT_SIZE-1)
+#define BONITO_FLASH_BASE		0x1c000000
+#define BONITO_FLASH_SIZE		0x03000000
+#define BONITO_FLASH_TOP		(BONITO_FLASH_BASE+BONITO_FLASH_SIZE-1)
+#define BONITO_SOCKET_BASE		0x1f800000
+#define BONITO_SOCKET_SIZE		0x00400000
+#define BONITO_SOCKET_TOP		(BONITO_SOCKET_BASE+BONITO_SOCKET_SIZE-1)
+#define BONITO_REG_BASE 		0x1fe00000
+#define BONITO_REG_SIZE 		0x00040000
+#define BONITO_REG_TOP			(BONITO_REG_BASE+BONITO_REG_SIZE-1)
+#define BONITO_DEV_BASE 		0x1ff00000
+#define BONITO_DEV_SIZE 		0x00100000
+#define BONITO_DEV_TOP			(BONITO_DEV_BASE+BONITO_DEV_SIZE-1)
+#define BONITO_PCILO_BASE		0x10000000
+#define BONITO_PCILO_SIZE		0x0c000000
+#define BONITO_PCILO_TOP		(BONITO_PCILO_BASE+BONITO_PCILO_SIZE-1)
+#define BONITO_PCILO0_BASE		0x10000000
+#define BONITO_PCILO1_BASE		0x14000000
+#define BONITO_PCILO2_BASE		0x18000000
+#define BONITO_PCIHI_BASE		0x20000000
+#define BONITO_PCIHI_SIZE		0x20000000
+#define BONITO_PCIHI_TOP		(BONITO_PCIHI_BASE+BONITO_PCIHI_SIZE-1)
+#define BONITO_PCIIO_BASE		0x1fd00000
+#define BONITO_PCIIO_SIZE		0x00100000
+#define BONITO_PCIIO_TOP		(BONITO_PCIIO_BASE+BONITO_PCIIO_SIZE-1)
+#define BONITO_PCICFG_BASE		0x1fe80000
+#define BONITO_PCICFG_SIZE		0x00080000
+#define BONITO_PCICFG_TOP		(BONITO_PCICFG_BASE+BONITO_PCICFG_SIZE-1)
+
+/* Bonito Register Bases */
+
+#define BONITO_PCICONFIGBASE		0x00
+#define BONITO_REGBASE			0x100
+
+/* PCI Configuration  Registers */
+
+#define BONITO_PCI_REG(x)               BONITO(BONITO_PCICONFIGBASE + (x))
+#define BONITO_PCIDID			BONITO_PCI_REG(0x00)
+#define BONITO_PCICMD			BONITO_PCI_REG(0x04)
+#define BONITO_PCICLASS 		BONITO_PCI_REG(0x08)
+#define BONITO_PCILTIMER		BONITO_PCI_REG(0x0c)
+#define BONITO_PCIBASE0 		BONITO_PCI_REG(0x10)
+#define BONITO_PCIBASE1 		BONITO_PCI_REG(0x14)
+#define BONITO_PCIBASE2 		BONITO_PCI_REG(0x18)
+#define BONITO_PCIEXPRBASE		BONITO_PCI_REG(0x30)
+#define BONITO_PCIINT			BONITO_PCI_REG(0x3c)
+
+#define BONITO_PCICMD_PERR		0x80000000
+#define BONITO_PCICMD_SERR		0x40000000
+#define BONITO_PCICMD_MABORT		0x20000000
+#define BONITO_PCICMD_MTABORT		0x10000000
+#define BONITO_PCICMD_TABORT		0x08000000
+#define BONITO_PCICMD_MPERR	 	0x01000000
+#define BONITO_PCICMD_PERRRESPEN	0x00000040
+#define BONITO_PCICMD_ASTEPEN		0x00000080
+#define BONITO_PCICMD_SERREN		0x00000100
+#define BONITO_PCILTIMER_BUSLATENCY	0x0000ff00
+#define BONITO_PCILTIMER_BUSLATENCY_SHIFT	8
+
+/* 1. Bonito h/w Configuration */
+/* Power on register */
+
+#define BONITO_BONPONCFG		BONITO(BONITO_REGBASE + 0x00)
+
+#define BONITO_BONPONCFG_SYSCONTROLLERRD	0x00040000
+#define BONITO_BONPONCFG_ROMCS1SAMP	0x00020000
+#define BONITO_BONPONCFG_ROMCS0SAMP	0x00010000
+#define BONITO_BONPONCFG_CPUBIGEND	0x00004000
+#define BONITO_BONPONCFG_CPUPARITY	0x00002000
+#define BONITO_BONPONCFG_CPUTYPE	0x00000007
+#define BONITO_BONPONCFG_CPUTYPE_SHIFT	0
+#define BONITO_BONPONCFG_PCIRESET_OUT	0x00000008
+#define BONITO_BONPONCFG_IS_ARBITER	0x00000010
+#define BONITO_BONPONCFG_ROMBOOT	0x000000c0
+#define BONITO_BONPONCFG_ROMBOOT_SHIFT	6
+
+#define BONITO_BONPONCFG_ROMBOOT_FLASH	(0x0<<BONITO_BONPONCFG_ROMBOOT_SHIFT)
+#define BONITO_BONPONCFG_ROMBOOT_SOCKET (0x1<<BONITO_BONPONCFG_ROMBOOT_SHIFT)
+#define BONITO_BONPONCFG_ROMBOOT_SDRAM	(0x2<<BONITO_BONPONCFG_ROMBOOT_SHIFT)
+#define BONITO_BONPONCFG_ROMBOOT_CPURESET	(0x3<<BONITO_BONPONCFG_ROMBOOT_SHIFT)
+
+#define BONITO_BONPONCFG_ROMCS0WIDTH	0x00000100
+#define BONITO_BONPONCFG_ROMCS1WIDTH	0x00000200
+#define BONITO_BONPONCFG_ROMCS0FAST	0x00000400
+#define BONITO_BONPONCFG_ROMCS1FAST	0x00000800
+#define BONITO_BONPONCFG_CONFIG_DIS	0x00000020
+
+/* Other Bonito configuration */
+
+#define BONITO_BONGENCFG_OFFSET         0x4
+#define BONITO_BONGENCFG		BONITO(BONITO_REGBASE + BONITO_BONGENCFG_OFFSET)
+
+#define BONITO_BONGENCFG_DEBUGMODE	0x00000001
+#define BONITO_BONGENCFG_SNOOPEN	0x00000002
+#define BONITO_BONGENCFG_CPUSELFRESET	0x00000004
+
+#define BONITO_BONGENCFG_FORCE_IRQA	0x00000008
+#define BONITO_BONGENCFG_IRQA_ISOUT	0x00000010
+#define BONITO_BONGENCFG_IRQA_FROM_INT1 0x00000020
+#define BONITO_BONGENCFG_BYTESWAP	0x00000040
+
+#define BONITO_BONGENCFG_UNCACHED	0x00000080
+#define BONITO_BONGENCFG_PREFETCHEN	0x00000100
+#define BONITO_BONGENCFG_WBEHINDEN	0x00000200
+#define BONITO_BONGENCFG_CACHEALG	0x00000c00
+#define BONITO_BONGENCFG_CACHEALG_SHIFT 10
+#define BONITO_BONGENCFG_PCIQUEUE	0x00001000
+#define BONITO_BONGENCFG_CACHESTOP	0x00002000
+#define BONITO_BONGENCFG_MSTRBYTESWAP	0x00004000
+#define BONITO_BONGENCFG_BUSERREN	0x00008000
+#define BONITO_BONGENCFG_NORETRYTIMEOUT 0x00010000
+#define BONITO_BONGENCFG_SHORTCOPYTIMEOUT	0x00020000
+
+/* 2. IO & IDE configuration */
+
+#define BONITO_IODEVCFG 		BONITO(BONITO_REGBASE + 0x08)
+
+/* 3. IO & IDE configuration */
+
+#define BONITO_SDCFG			BONITO(BONITO_REGBASE + 0x0c)
+
+/* 4. PCI address map control */
+
+#define BONITO_PCIMAP			BONITO(BONITO_REGBASE + 0x10)
+#define BONITO_PCIMEMBASECFG		BONITO(BONITO_REGBASE + 0x14)
+#define BONITO_PCIMAP_CFG		BONITO(BONITO_REGBASE + 0x18)
+
+/* 5. ICU & GPIO regs */
+
+/* GPIO Regs - r/w */
+
+#define BONITO_GPIODATA_OFFSET          0x1c
+#define BONITO_GPIODATA 		BONITO(BONITO_REGBASE + BONITO_GPIODATA_OFFSET)
+#define BONITO_GPIOIE			BONITO(BONITO_REGBASE + 0x20)
+
+/* ICU Configuration Regs - r/w */
+
+#define BONITO_INTEDGE			BONITO(BONITO_REGBASE + 0x24)
+#define BONITO_INTSTEER 		BONITO(BONITO_REGBASE + 0x28)
+#define BONITO_INTPOL			BONITO(BONITO_REGBASE + 0x2c)
+
+/* ICU Enable Regs - IntEn & IntISR are r/o. */
+
+#define BONITO_INTENSET 		BONITO(BONITO_REGBASE + 0x30)
+#define BONITO_INTENCLR 		BONITO(BONITO_REGBASE + 0x34)
+#define BONITO_INTEN			BONITO(BONITO_REGBASE + 0x38)
+#define BONITO_INTISR			BONITO(BONITO_REGBASE + 0x3c)
+
+/* PCI mail boxes */
+
+#define BONITO_PCIMAIL0_OFFSET          0x40
+#define BONITO_PCIMAIL1_OFFSET          0x44
+#define BONITO_PCIMAIL2_OFFSET          0x48
+#define BONITO_PCIMAIL3_OFFSET          0x4c
+#define BONITO_PCIMAIL0 		BONITO(BONITO_REGBASE + 0x40)
+#define BONITO_PCIMAIL1 		BONITO(BONITO_REGBASE + 0x44)
+#define BONITO_PCIMAIL2 		BONITO(BONITO_REGBASE + 0x48)
+#define BONITO_PCIMAIL3 		BONITO(BONITO_REGBASE + 0x4c)
+
+/* 6. PCI cache */
+
+#define BONITO_PCICACHECTRL		BONITO(BONITO_REGBASE + 0x50)
+#define BONITO_PCICACHETAG		BONITO(BONITO_REGBASE + 0x54)
+
+#define BONITO_PCIBADADDR		BONITO(BONITO_REGBASE + 0x58)
+#define BONITO_PCIMSTAT 		BONITO(BONITO_REGBASE + 0x5c)
+
+/*
+#define BONITO_PCIRDPOST		BONITO(BONITO_REGBASE + 0x60)
+#define BONITO_PCIDATA			BONITO(BONITO_REGBASE + 0x64)
+*/
+
+/* 7. IDE DMA & Copier */
+
+#define BONITO_CONFIGBASE		0x000
+#define BONITO_BONITOBASE		0x100
+#define BONITO_LDMABASE 		0x200
+#define BONITO_COPBASE			0x300
+#define BONITO_REG_BLOCKMASK		0x300
+
+#define BONITO_LDMACTRL 		BONITO(BONITO_LDMABASE + 0x0)
+#define BONITO_LDMASTAT 		BONITO(BONITO_LDMABASE + 0x0)
+#define BONITO_LDMAADDR 		BONITO(BONITO_LDMABASE + 0x4)
+#define BONITO_LDMAGO			BONITO(BONITO_LDMABASE + 0x8)
+#define BONITO_LDMADATA 		BONITO(BONITO_LDMABASE + 0xc)
+
+#define BONITO_COPCTRL			BONITO(BONITO_COPBASE + 0x0)
+#define BONITO_COPSTAT			BONITO(BONITO_COPBASE + 0x0)
+#define BONITO_COPPADDR 		BONITO(BONITO_COPBASE + 0x4)
+#define BONITO_COPDADDR 		BONITO(BONITO_COPBASE + 0x8)
+#define BONITO_COPGO			BONITO(BONITO_COPBASE + 0xc)
+
+/* ###### Bit Definitions for individual Registers #### */
+
+/* Gen DMA. */
+
+#define BONITO_IDECOPDADDR_DMA_DADDR	0x0ffffffc
+#define BONITO_IDECOPDADDR_DMA_DADDR_SHIFT	2
+#define BONITO_IDECOPPADDR_DMA_PADDR	0xfffffffc
+#define BONITO_IDECOPPADDR_DMA_PADDR_SHIFT	2
+#define BONITO_IDECOPGO_DMA_SIZE	0x0000fffe
+#define BONITO_IDECOPGO_DMA_SIZE_SHIFT	0
+#define BONITO_IDECOPGO_DMA_WRITE	0x00010000
+#define BONITO_IDECOPGO_DMAWCOUNT	0x000f0000
+#define BONITO_IDECOPGO_DMAWCOUNT_SHIFT	16
+
+#define BONITO_IDECOPCTRL_DMA_STARTBIT	0x80000000
+#define BONITO_IDECOPCTRL_DMA_RSTBIT	0x40000000
+
+/* DRAM - sdCfg */
+
+#define BONITO_SDCFG_AROWBITS		0x00000003
+#define BONITO_SDCFG_AROWBITS_SHIFT	0
+#define BONITO_SDCFG_ACOLBITS		0x0000000c
+#define BONITO_SDCFG_ACOLBITS_SHIFT	2
+#define BONITO_SDCFG_ABANKBIT		0x00000010
+#define BONITO_SDCFG_ASIDES		0x00000020
+#define BONITO_SDCFG_AABSENT		0x00000040
+#define BONITO_SDCFG_AWIDTH64		0x00000080
+
+#define BONITO_SDCFG_BROWBITS		0x00000300
+#define BONITO_SDCFG_BROWBITS_SHIFT	8
+#define BONITO_SDCFG_BCOLBITS		0x00000c00
+#define BONITO_SDCFG_BCOLBITS_SHIFT	10
+#define BONITO_SDCFG_BBANKBIT		0x00001000
+#define BONITO_SDCFG_BSIDES		0x00002000
+#define BONITO_SDCFG_BABSENT		0x00004000
+#define BONITO_SDCFG_BWIDTH64		0x00008000
+
+#define BONITO_SDCFG_EXTRDDATA		0x00010000
+#define BONITO_SDCFG_EXTRASCAS		0x00020000
+#define BONITO_SDCFG_EXTPRECH		0x00040000
+#define BONITO_SDCFG_EXTRASWIDTH	0x00180000
+#define BONITO_SDCFG_EXTRASWIDTH_SHIFT	19
+#define BONITO_SDCFG_DRAMRESET		0x00200000
+#define BONITO_SDCFG_DRAMEXTREGS	0x00400000
+#define BONITO_SDCFG_DRAMPARITY 	0x00800000
+
+/* PCI Cache - pciCacheCtrl */
+
+#define BONITO_PCICACHECTRL_CACHECMD	0x00000007
+#define BONITO_PCICACHECTRL_CACHECMD_SHIFT	0
+#define BONITO_PCICACHECTRL_CACHECMDLINE	0x00000018
+#define BONITO_PCICACHECTRL_CACHECMDLINE_SHIFT	3
+#define BONITO_PCICACHECTRL_CMDEXEC	0x00000020
+
+#define BONITO_IODEVCFG_BUFFBIT_CS0	0x00000001
+#define BONITO_IODEVCFG_SPEEDBIT_CS0	0x00000002
+#define BONITO_IODEVCFG_MOREABITS_CS0	0x00000004
+
+#define BONITO_IODEVCFG_BUFFBIT_CS1	0x00000008
+#define BONITO_IODEVCFG_SPEEDBIT_CS1	0x00000010
+#define BONITO_IODEVCFG_MOREABITS_CS1	0x00000020
+
+#define BONITO_IODEVCFG_BUFFBIT_CS2	0x00000040
+#define BONITO_IODEVCFG_SPEEDBIT_CS2	0x00000080
+#define BONITO_IODEVCFG_MOREABITS_CS2	0x00000100
+
+#define BONITO_IODEVCFG_BUFFBIT_CS3	0x00000200
+#define BONITO_IODEVCFG_SPEEDBIT_CS3	0x00000400
+#define BONITO_IODEVCFG_MOREABITS_CS3	0x00000800
+
+#define BONITO_IODEVCFG_BUFFBIT_IDE	0x00001000
+#define BONITO_IODEVCFG_SPEEDBIT_IDE	0x00002000
+#define BONITO_IODEVCFG_WORDSWAPBIT_IDE 0x00004000
+#define BONITO_IODEVCFG_MODEBIT_IDE	0x00008000
+#define BONITO_IODEVCFG_DMAON_IDE	0x001f0000
+#define BONITO_IODEVCFG_DMAON_IDE_SHIFT 16
+#define BONITO_IODEVCFG_DMAOFF_IDE	0x01e00000
+#define BONITO_IODEVCFG_DMAOFF_IDE_SHIFT	21
+#define BONITO_IODEVCFG_EPROMSPLIT	0x02000000
+
+/* gpio */
+#define BONITO_GPIO_GPIOW		0x000003ff
+#define BONITO_GPIO_GPIOW_SHIFT 	0
+#define BONITO_GPIO_GPIOR		0x01ff0000
+#define BONITO_GPIO_GPIOR_SHIFT 	16
+#define BONITO_GPIO_GPINR		0xfe000000
+#define BONITO_GPIO_GPINR_SHIFT 	25
+#define BONITO_GPIO_IOW(N)		(1<<(BONITO_GPIO_GPIOW_SHIFT+(N)))
+#define BONITO_GPIO_IOR(N)		(1<<(BONITO_GPIO_GPIOR_SHIFT+(N)))
+#define BONITO_GPIO_INR(N)		(1<<(BONITO_GPIO_GPINR_SHIFT+(N)))
+
+/* ICU */
+#define BONITO_ICU_MBOXES		0x0000000f
+#define BONITO_ICU_MBOXES_SHIFT 	0
+#define BONITO_ICU_DMARDY		0x00000010
+#define BONITO_ICU_DMAEMPTY		0x00000020
+#define BONITO_ICU_COPYRDY		0x00000040
+#define BONITO_ICU_COPYEMPTY		0x00000080
+#define BONITO_ICU_COPYERR		0x00000100
+#define BONITO_ICU_PCIIRQ		0x00000200
+#define BONITO_ICU_MASTERERR		0x00000400
+#define BONITO_ICU_SYSTEMERR		0x00000800
+#define BONITO_ICU_DRAMPERR		0x00001000
+#define BONITO_ICU_RETRYERR		0x00002000
+#define BONITO_ICU_GPIOS		0x01ff0000
+#define BONITO_ICU_GPIOS_SHIFT		16
+#define BONITO_ICU_GPINS		0x7e000000
+#define BONITO_ICU_GPINS_SHIFT		25
+#define BONITO_ICU_MBOX(N)		(1<<(BONITO_ICU_MBOXES_SHIFT+(N)))
+#define BONITO_ICU_GPIO(N)		(1<<(BONITO_ICU_GPIOS_SHIFT+(N)))
+#define BONITO_ICU_GPIN(N)		(1<<(BONITO_ICU_GPINS_SHIFT+(N)))
+
+/* pcimap */
+
+#define BONITO_PCIMAP_PCIMAP_LO0	0x0000003f
+#define BONITO_PCIMAP_PCIMAP_LO0_SHIFT	0
+#define BONITO_PCIMAP_PCIMAP_LO1	0x00000fc0
+#define BONITO_PCIMAP_PCIMAP_LO1_SHIFT	6
+#define BONITO_PCIMAP_PCIMAP_LO2	0x0003f000
+#define BONITO_PCIMAP_PCIMAP_LO2_SHIFT	12
+#define BONITO_PCIMAP_PCIMAP_2		0x00040000
+#define BONITO_PCIMAP_WIN(WIN,ADDR)	((((ADDR)>>26) & BONITO_PCIMAP_PCIMAP_LO0) << ((WIN)*6))
+
+#define BONITO_PCIMAP_WINSIZE           (1<<26)
+#define BONITO_PCIMAP_WINOFFSET(ADDR)	((ADDR) & (BONITO_PCIMAP_WINSIZE - 1))
+#define BONITO_PCIMAP_WINBASE(ADDR)	((ADDR) << 26)
+
+/* pcimembaseCfg */
+
+#define BONITO_PCIMEMBASECFG_MASK               0xf0000000
+#define BONITO_PCIMEMBASECFG_MEMBASE0_MASK	0x0000001f
+#define BONITO_PCIMEMBASECFG_MEMBASE0_MASK_SHIFT	0
+#define BONITO_PCIMEMBASECFG_MEMBASE0_TRANS	0x000003e0
+#define BONITO_PCIMEMBASECFG_MEMBASE0_TRANS_SHIFT	5
+#define BONITO_PCIMEMBASECFG_MEMBASE0_CACHED	0x00000400
+#define BONITO_PCIMEMBASECFG_MEMBASE0_IO	0x00000800
+
+#define BONITO_PCIMEMBASECFG_MEMBASE1_MASK	0x0001f000
+#define BONITO_PCIMEMBASECFG_MEMBASE1_MASK_SHIFT	12
+#define BONITO_PCIMEMBASECFG_MEMBASE1_TRANS	0x003e0000
+#define BONITO_PCIMEMBASECFG_MEMBASE1_TRANS_SHIFT	17
+#define BONITO_PCIMEMBASECFG_MEMBASE1_CACHED	0x00400000
+#define BONITO_PCIMEMBASECFG_MEMBASE1_IO	0x00800000
+
+#define BONITO_PCIMEMBASECFG_ASHIFT	23
+#define BONITO_PCIMEMBASECFG_AMASK              0x007fffff
+#define BONITO_PCIMEMBASECFGSIZE(WIN,SIZE)	(((~((SIZE)-1))>>(BONITO_PCIMEMBASECFG_ASHIFT-BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK_SHIFT)) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK)
+#define BONITO_PCIMEMBASECFGBASE(WIN,BASE)	(((BASE)>>(BONITO_PCIMEMBASECFG_ASHIFT-BONITO_PCIMEMBASECFG_MEMBASE##WIN##_TRANS_SHIFT)) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_TRANS)
+
+#define BONITO_PCIMEMBASECFG_SIZE(WIN,CFG)  (((((~(CFG)) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK)) << (BONITO_PCIMEMBASECFG_ASHIFT - BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK_SHIFT)) | BONITO_PCIMEMBASECFG_AMASK)
+
+#define BONITO_PCIMEMBASECFG_ADDRMASK(WIN,CFG)  ((((CFG) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK) >> BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK_SHIFT) << BONITO_PCIMEMBASECFG_ASHIFT)
+#define BONITO_PCIMEMBASECFG_ADDRMASK(WIN,CFG)  ((((CFG) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK) >> BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK_SHIFT) << BONITO_PCIMEMBASECFG_ASHIFT)
+#define BONITO_PCIMEMBASECFG_ADDRTRANS(WIN,CFG) ((((CFG) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_TRANS) >> BONITO_PCIMEMBASECFG_MEMBASE##WIN##_TRANS_SHIFT) << BONITO_PCIMEMBASECFG_ASHIFT)
+
+#define BONITO_PCITOPHYS(WIN,ADDR,CFG)          ( \
+                                                  (((ADDR) & (~(BONITO_PCIMEMBASECFG_MASK))) & (~(BONITO_PCIMEMBASECFG_ADDRMASK(WIN,CFG)))) | \
+                                                  (BONITO_PCIMEMBASECFG_ADDRTRANS(WIN,CFG)) \
+                                                )
+
+/* PCICmd */
+
+#define BONITO_PCICMD_MEMEN		0x00000002
+#define BONITO_PCICMD_MSTREN		0x00000004
+
+#define BONITO_IRQ_BASE   32
+
+#endif /* !_BONITO_H */
diff --git a/include/asm-mips/mach-lemote/dma-coherence.h b/include/asm-mips/mach-lemote/dma-coherence.h
new file mode 100644
index 0000000..9506af4
--- /dev/null
+++ b/include/asm-mips/mach-lemote/dma-coherence.h
@@ -0,0 +1,43 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ */
+#ifndef __ASM_MACH_GENERIC_DMA_COHERENCE_H
+#define __ASM_MACH_GENERIC_DMA_COHERENCE_H
+
+struct device;
+
+static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
+					  size_t size)
+{
+	return virt_to_phys(addr) | 0x80000000;
+}
+
+static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
+					       struct page *page)
+{
+	return page_to_phys(page) | 0x80000000;
+}
+
+static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
+{
+	return dma_addr & 0x7fffffff;
+}
+
+static inline void plat_unmap_dma_mem(dma_addr_t dma_addr)
+{
+}
+
+static inline int plat_device_is_coherent(struct device *dev)
+{
+	return 0;
+}
+
+#endif /* __ASM_MACH_GENERIC_DMA_COHERENCE_H */
diff --git a/include/asm-mips/mach-lemote/mc146818rtc.h b/include/asm-mips/mach-lemote/mc146818rtc.h
new file mode 100644
index 0000000..7850f89
--- /dev/null
+++ b/include/asm-mips/mach-lemote/mc146818rtc.h
@@ -0,0 +1,36 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1998, 2001, 03 by Ralf Baechle
+ *
+ * RTC routines for PC style attached Dallas chip.
+ */
+#ifndef __ASM_MACH_GENERIC_MC146818RTC_H
+#define __ASM_MACH_GENERIC_MC146818RTC_H
+
+#include <asm/io.h>
+
+#define RTC_PORT(x)	(0x70 + (x))
+#define RTC_IRQ		8
+
+static inline unsigned char CMOS_READ(unsigned long addr)
+{
+	outb_p(addr, RTC_PORT(0));
+	return inb_p(RTC_PORT(1));
+}
+
+static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
+{
+	outb_p(addr, RTC_PORT(0));
+	outb_p(data, RTC_PORT(1));
+}
+
+#define RTC_ALWAYS_BCD	0
+
+#ifndef mc146818_decode_year
+#define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1970)
+#endif
+
+#endif /* __ASM_MACH_GENERIC_MC146818RTC_H */
-- 
1.5.2.1
