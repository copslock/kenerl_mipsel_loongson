Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 20:32:18 +0200 (CEST)
Received: from mail-la0-f42.google.com ([209.85.215.42]:51935 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010010AbaI1SbKyeZVf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 20:31:10 +0200
Received: by mail-la0-f42.google.com with SMTP id mk6so574518lab.15
        for <multiple recipients>; Sun, 28 Sep 2014 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fimF6CmV9o2RjSFfiAxKwTF7pmOONOqPbGF06c2dXnc=;
        b=JCC5+s/GQEi/Ny+Dp9mWpFeP0vtD46i371eIzE/DeqvKjsCU7FX+kZeb+dZLCYre4D
         0Xsfoju4jJEE5hbvs4FfxDKzd3mO4TuJv9tL4CBmkVkQb5+QN8u3x42CTPLVkDK6PS5E
         doyCA+zrWm9xohsGtLxF3Jie3dmHPm8bPNcYN3Wbelykwa05GmjvxBaeXsKUY4dGtCsy
         9hXd4NKb6g328XbQeAo+THQ/4eRF0Jl/ge8Rbvwiq2L6tU6odSzBStcLmrjNNret0bY8
         HZ41XDJP+/piMSjr45gntAOLeUUo+W19I6v3dfnR73W+uLAfncSM385g6SQPkwp58xES
         2hDw==
X-Received: by 10.152.44.136 with SMTP id e8mr34673860lam.36.1411929065426;
        Sun, 28 Sep 2014 11:31:05 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id je9sm581674lbc.3.2014.09.28.11.31.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 11:31:04 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 04/16] MIPS: ar231x: add interrupts handling routines
Date:   Sun, 28 Sep 2014 22:33:03 +0400
Message-Id: <1411929195-23775-5-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Add interrupts initialization and handling routines, also add AHB bus
error interrupt handlers for both SoCs families.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---

Changes since RFC:
  - add all interrupts
  - use dynamic IRQ numbers allocation

 arch/mips/ar231x/ar2315.c                       | 111 ++++++++++++++++++++++++
 arch/mips/ar231x/ar2315.h                       |   2 +
 arch/mips/ar231x/ar5312.c                       | 106 ++++++++++++++++++++++
 arch/mips/ar231x/ar5312.h                       |   2 +
 arch/mips/ar231x/board.c                        |   8 ++
 arch/mips/ar231x/devices.h                      |   1 +
 arch/mips/include/asm/mach-ar231x/ar2315_regs.h |  23 +++++
 arch/mips/include/asm/mach-ar231x/ar231x.h      |   2 +
 arch/mips/include/asm/mach-ar231x/ar5312_regs.h |  23 +++++
 9 files changed, 278 insertions(+)

diff --git a/arch/mips/ar231x/ar2315.c b/arch/mips/ar231x/ar2315.c
index 5f8b7c4..320893a 100644
--- a/arch/mips/ar231x/ar2315.c
+++ b/arch/mips/ar231x/ar2315.c
@@ -27,6 +27,117 @@
 #include "devices.h"
 #include "ar2315.h"
 
+static unsigned ar2315_misc_irq_base;
+
+static irqreturn_t ar2315_ahb_err_handler(int cpl, void *dev_id)
+{
+	ar231x_write_reg(AR2315_AHB_ERR0, AR2315_AHB_ERROR_DET);
+	ar231x_read_reg(AR2315_AHB_ERR1);
+
+	pr_emerg("AHB fatal error\n");
+	machine_restart("AHB error"); /* Catastrophic failure */
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction ar2315_ahb_err_interrupt  = {
+	.handler	= ar2315_ahb_err_handler,
+	.name		= "ar2315-ahb-error",
+};
+
+static void ar2315_misc_irq_handler(unsigned irq, struct irq_desc *desc)
+{
+	u32 pending = ar231x_read_reg(AR2315_ISR) & ar231x_read_reg(AR2315_IMR);
+	unsigned base = ar2315_misc_irq_base;
+
+	if (pending & AR2315_ISR_SPI)
+		generic_handle_irq(base + AR2315_MISC_IRQ_SPI);
+	else if (pending & AR2315_ISR_TIMER)
+		generic_handle_irq(base + AR2315_MISC_IRQ_TIMER);
+	else if (pending & AR2315_ISR_AHB)
+		generic_handle_irq(base + AR2315_MISC_IRQ_AHB);
+	else if (pending & AR2315_ISR_GPIO) {
+		ar231x_write_reg(AR2315_ISR, AR2315_ISR_GPIO);
+		generic_handle_irq(base + AR2315_MISC_IRQ_GPIO);
+	} else if (pending & AR2315_ISR_UART0)
+		generic_handle_irq(base + AR2315_MISC_IRQ_UART0);
+	else if (pending & AR2315_ISR_WD) {
+		ar231x_write_reg(AR2315_ISR, AR2315_ISR_WD);
+		generic_handle_irq(base + AR2315_MISC_IRQ_WATCHDOG);
+	} else
+		spurious_interrupt();
+}
+
+static void ar2315_misc_irq_unmask(struct irq_data *d)
+{
+	u32 imr = ar231x_read_reg(AR2315_IMR);
+
+	imr |= 1 << (d->irq - ar2315_misc_irq_base);
+	ar231x_write_reg(AR2315_IMR, imr);
+}
+
+static void ar2315_misc_irq_mask(struct irq_data *d)
+{
+	u32 imr = ar231x_read_reg(AR2315_IMR);
+
+	imr &= ~(1 << (d->irq - ar2315_misc_irq_base));
+	ar231x_write_reg(AR2315_IMR, imr);
+}
+
+static struct irq_chip ar2315_misc_irq_chip = {
+	.name		= "ar2315-misc",
+	.irq_unmask	= ar2315_misc_irq_unmask,
+	.irq_mask	= ar2315_misc_irq_mask,
+};
+
+/*
+ * Called when an interrupt is received, this function
+ * determines exactly which interrupt it was, and it
+ * invokes the appropriate handler.
+ *
+ * Implicitly, we also define interrupt priority by
+ * choosing which to dispatch first.
+ */
+static void ar2315_irq_dispatch(void)
+{
+	u32 pending = read_c0_status() & read_c0_cause();
+
+	if (pending & CAUSEF_IP3)
+		do_IRQ(AR2315_IRQ_WLAN0);
+	else if (pending & CAUSEF_IP2)
+		do_IRQ(AR2315_IRQ_MISC);
+	else if (pending & CAUSEF_IP7)
+		do_IRQ(AR231X_IRQ_CPU_CLOCK);
+	else
+		spurious_interrupt();
+}
+
+void __init ar2315_arch_init_irq(void)
+{
+	unsigned i;
+	int res;
+
+	if (!is_2315())
+		return;
+
+	ar231x_irq_dispatch = ar2315_irq_dispatch;
+
+	res = irq_alloc_descs(-1, 0, AR2315_MISC_IRQ_COUNT, 0);
+	if (res < 0)
+		pr_emerg("Failed to allocate misc IRQ numbers\n");
+	ar2315_misc_irq_base = res;
+
+	for (i = 0; i < AR2315_MISC_IRQ_COUNT; i++) {
+		unsigned irq = ar2315_misc_irq_base + i;
+
+		irq_set_chip_and_handler(irq, &ar2315_misc_irq_chip,
+					 handle_level_irq);
+	}
+	setup_irq(ar2315_misc_irq_base + AR2315_MISC_IRQ_AHB,
+		  &ar2315_ahb_err_interrupt);
+	irq_set_chained_handler(AR2315_IRQ_MISC, ar2315_misc_irq_handler);
+}
+
 static void ar2315_restart(char *command)
 {
 	void (*mips_reset_vec)(void) = (void *)0xbfc00000;
diff --git a/arch/mips/ar231x/ar2315.h b/arch/mips/ar231x/ar2315.h
index 98d32b2..2a57858 100644
--- a/arch/mips/ar231x/ar2315.h
+++ b/arch/mips/ar231x/ar2315.h
@@ -3,12 +3,14 @@
 
 #ifdef CONFIG_SOC_AR2315
 
+void ar2315_arch_init_irq(void);
 void ar2315_plat_time_init(void);
 void ar2315_plat_mem_setup(void);
 void ar2315_prom_init(void);
 
 #else
 
+static inline void ar2315_arch_init_irq(void) {}
 static inline void ar2315_plat_time_init(void) {}
 static inline void ar2315_plat_mem_setup(void) {}
 static inline void ar2315_prom_init(void) {}
diff --git a/arch/mips/ar231x/ar5312.c b/arch/mips/ar231x/ar5312.c
index 909bee0..3f81d33 100644
--- a/arch/mips/ar231x/ar5312.c
+++ b/arch/mips/ar231x/ar5312.c
@@ -27,6 +27,112 @@
 #include "devices.h"
 #include "ar5312.h"
 
+static unsigned ar5312_misc_irq_base;
+
+static irqreturn_t ar5312_ahb_err_handler(int cpl, void *dev_id)
+{
+	u32 proc1 = ar231x_read_reg(AR5312_PROC1);
+	u32 proc_addr = ar231x_read_reg(AR5312_PROCADDR); /* clears error */
+	u32 dma1 = ar231x_read_reg(AR5312_DMA1);
+	u32 dma_addr = ar231x_read_reg(AR5312_DMAADDR);   /* clears error */
+
+	pr_emerg("AHB interrupt: PROCADDR=0x%8.8x PROC1=0x%8.8x DMAADDR=0x%8.8x DMA1=0x%8.8x\n",
+		 proc_addr, proc1, dma_addr, dma1);
+
+	machine_restart("AHB error"); /* Catastrophic failure */
+	return IRQ_HANDLED;
+}
+
+static struct irqaction ar5312_ahb_err_interrupt  = {
+	.handler = ar5312_ahb_err_handler,
+	.name    = "ar5312-ahb-error",
+};
+
+static void ar5312_misc_irq_handler(unsigned irq, struct irq_desc *desc)
+{
+	u32 pending = ar231x_read_reg(AR5312_ISR) & ar231x_read_reg(AR5312_IMR);
+	unsigned base = ar5312_misc_irq_base;
+
+	if (pending & AR5312_ISR_TIMER) {
+		generic_handle_irq(base + AR5312_MISC_IRQ_TIMER);
+		(void)ar231x_read_reg(AR5312_TIMER);
+	} else if (pending & AR5312_ISR_AHBPROC)
+		generic_handle_irq(base + AR5312_MISC_IRQ_AHB_PROC);
+	else if (pending & AR5312_ISR_UART0)
+		generic_handle_irq(base + AR5312_MISC_IRQ_UART0);
+	else if (pending & AR5312_ISR_WD)
+		generic_handle_irq(base + AR5312_MISC_IRQ_WATCHDOG);
+	else
+		spurious_interrupt();
+}
+
+/* Enable the specified AR5312_MISC_IRQ interrupt */
+static void ar5312_misc_irq_unmask(struct irq_data *d)
+{
+	u32 imr = ar231x_read_reg(AR5312_IMR);
+
+	imr |= 1 << (d->irq - ar5312_misc_irq_base);
+	ar231x_write_reg(AR5312_IMR, imr);
+}
+
+/* Disable the specified AR5312_MISC_IRQ interrupt */
+static void ar5312_misc_irq_mask(struct irq_data *d)
+{
+	u32 imr = ar231x_read_reg(AR5312_IMR);
+
+	imr &= ~(1 << (d->irq - ar5312_misc_irq_base));
+	ar231x_write_reg(AR5312_IMR, imr);
+	ar231x_read_reg(AR5312_IMR); /* flush write buffer */
+}
+
+static struct irq_chip ar5312_misc_irq_chip = {
+	.name		= "ar5312-misc",
+	.irq_unmask	= ar5312_misc_irq_unmask,
+	.irq_mask	= ar5312_misc_irq_mask,
+};
+
+static void ar5312_irq_dispatch(void)
+{
+	u32 pending = read_c0_status() & read_c0_cause();
+
+	if (pending & CAUSEF_IP2)
+		do_IRQ(AR5312_IRQ_WLAN0);
+	else if (pending & CAUSEF_IP5)
+		do_IRQ(AR5312_IRQ_WLAN1);
+	else if (pending & CAUSEF_IP6)
+		do_IRQ(AR5312_IRQ_MISC);
+	else if (pending & CAUSEF_IP7)
+		do_IRQ(AR231X_IRQ_CPU_CLOCK);
+	else
+		spurious_interrupt();
+}
+
+void __init ar5312_arch_init_irq(void)
+{
+	unsigned i;
+	int res;
+
+	if (!is_5312())
+		return;
+
+	ar231x_irq_dispatch = ar5312_irq_dispatch;
+
+	res = irq_alloc_descs(-1, 0, AR5312_MISC_IRQ_COUNT, 0);
+	if (res < 0)
+		pr_emerg("Failed to allocate misc IRQ numbers\n");
+	ar5312_misc_irq_base = res;
+
+	for (i = 0; i < AR5312_MISC_IRQ_COUNT; i++) {
+		unsigned irq = ar5312_misc_irq_base + i;
+
+		irq_set_chip_and_handler(irq, &ar5312_misc_irq_chip,
+					 handle_level_irq);
+	}
+	setup_irq(ar5312_misc_irq_base + AR5312_MISC_IRQ_AHB_PROC,
+		  &ar5312_ahb_err_interrupt);
+	irq_set_chained_handler(AR5312_IRQ_MISC, ar5312_misc_irq_handler);
+}
+
 static void ar5312_restart(char *command)
 {
 	/* reset the system */
diff --git a/arch/mips/ar231x/ar5312.h b/arch/mips/ar231x/ar5312.h
index 339b28e..b60ad38 100644
--- a/arch/mips/ar231x/ar5312.h
+++ b/arch/mips/ar231x/ar5312.h
@@ -3,12 +3,14 @@
 
 #ifdef CONFIG_SOC_AR5312
 
+void ar5312_arch_init_irq(void);
 void ar5312_plat_time_init(void);
 void ar5312_plat_mem_setup(void);
 void ar5312_prom_init(void);
 
 #else
 
+static inline void ar5312_arch_init_irq(void) {}
 static inline void ar5312_plat_time_init(void) {}
 static inline void ar5312_plat_mem_setup(void) {}
 static inline void ar5312_prom_init(void) {}
diff --git a/arch/mips/ar231x/board.c b/arch/mips/ar231x/board.c
index f50a7cf..24a00b4 100644
--- a/arch/mips/ar231x/board.c
+++ b/arch/mips/ar231x/board.c
@@ -16,9 +16,12 @@
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 
+#include "devices.h"
 #include "ar5312.h"
 #include "ar2315.h"
 
+void (*ar231x_irq_dispatch)(void);
+
 static void ar231x_halt(void)
 {
 	local_irq_disable();
@@ -40,6 +43,7 @@ void __init plat_mem_setup(void)
 
 asmlinkage void plat_irq_dispatch(void)
 {
+	ar231x_irq_dispatch();
 }
 
 void __init plat_time_init(void)
@@ -57,5 +61,9 @@ void __init arch_init_irq(void)
 {
 	clear_c0_status(ST0_IM);
 	mips_cpu_irq_init();
+
+	/* Initialize interrupt controllers */
+	ar5312_arch_init_irq();
+	ar2315_arch_init_irq();
 }
 
diff --git a/arch/mips/ar231x/devices.h b/arch/mips/ar231x/devices.h
index 1590577..82fa6fb 100644
--- a/arch/mips/ar231x/devices.h
+++ b/arch/mips/ar231x/devices.h
@@ -8,6 +8,7 @@ enum {
 };
 
 extern int ar231x_devtype;
+extern void (*ar231x_irq_dispatch)(void);
 
 static inline bool is_2315(void)
 {
diff --git a/arch/mips/include/asm/mach-ar231x/ar2315_regs.h b/arch/mips/include/asm/mach-ar231x/ar2315_regs.h
index 91197b6..a65d578 100644
--- a/arch/mips/include/asm/mach-ar231x/ar2315_regs.h
+++ b/arch/mips/include/asm/mach-ar231x/ar2315_regs.h
@@ -15,6 +15,29 @@
 #define __ASM_MACH_AR231X_AR2315_REGS_H
 
 /*
+ * IRQs
+ */
+#define AR2315_IRQ_MISC		(MIPS_CPU_IRQ_BASE + 2)	/* C0_CAUSE: 0x0400 */
+#define AR2315_IRQ_WLAN0	(MIPS_CPU_IRQ_BASE + 3)	/* C0_CAUSE: 0x0800 */
+#define AR2315_IRQ_ENET0	(MIPS_CPU_IRQ_BASE + 4)	/* C0_CAUSE: 0x1000 */
+#define AR2315_IRQ_LCBUS_PCI	(MIPS_CPU_IRQ_BASE + 5)	/* C0_CAUSE: 0x2000 */
+#define AR2315_IRQ_WLAN0_POLL	(MIPS_CPU_IRQ_BASE + 6)	/* C0_CAUSE: 0x4000 */
+
+/*
+ * Miscellaneous interrupts, which share IP2.
+ */
+#define AR2315_MISC_IRQ_UART0		0
+#define AR2315_MISC_IRQ_I2C_RSVD	1
+#define AR2315_MISC_IRQ_SPI		2
+#define AR2315_MISC_IRQ_AHB		3
+#define AR2315_MISC_IRQ_APB		4
+#define AR2315_MISC_IRQ_TIMER		5
+#define AR2315_MISC_IRQ_GPIO		6
+#define AR2315_MISC_IRQ_WATCHDOG	7
+#define AR2315_MISC_IRQ_IR_RSVD		8
+#define AR2315_MISC_IRQ_COUNT		9
+
+/*
  * Address map
  */
 #define AR2315_SPI_READ		0x08000000	/* SPI flash */
diff --git a/arch/mips/include/asm/mach-ar231x/ar231x.h b/arch/mips/include/asm/mach-ar231x/ar231x.h
index b830723..a9f05aa 100644
--- a/arch/mips/include/asm/mach-ar231x/ar231x.h
+++ b/arch/mips/include/asm/mach-ar231x/ar231x.h
@@ -3,6 +3,8 @@
 
 #include <linux/io.h>
 
+#define AR231X_IRQ_CPU_CLOCK	(MIPS_CPU_IRQ_BASE + 7)	/* C0_CAUSE: 0x8000 */
+
 #define AR231X_REG_MS(_val, _field)	(((_val) & _field##_M) >> _field##_S)
 
 static inline u32 ar231x_read_reg(u32 reg)
diff --git a/arch/mips/include/asm/mach-ar231x/ar5312_regs.h b/arch/mips/include/asm/mach-ar231x/ar5312_regs.h
index 5eb22fd..c7055e32 100644
--- a/arch/mips/include/asm/mach-ar231x/ar5312_regs.h
+++ b/arch/mips/include/asm/mach-ar231x/ar5312_regs.h
@@ -12,6 +12,29 @@
 #define __ASM_MACH_AR231X_AR5312_REGS_H
 
 /*
+ * IRQs
+ */
+#define AR5312_IRQ_WLAN0	(MIPS_CPU_IRQ_BASE + 2)	/* C0_CAUSE: 0x0400 */
+#define AR5312_IRQ_ENET0	(MIPS_CPU_IRQ_BASE + 3)	/* C0_CAUSE: 0x0800 */
+#define AR5312_IRQ_ENET1	(MIPS_CPU_IRQ_BASE + 4)	/* C0_CAUSE: 0x1000 */
+#define AR5312_IRQ_WLAN1	(MIPS_CPU_IRQ_BASE + 5)	/* C0_CAUSE: 0x2000 */
+#define AR5312_IRQ_MISC		(MIPS_CPU_IRQ_BASE + 6)	/* C0_CAUSE: 0x4000 */
+
+/*
+ * Miscellaneous interrupts, which share IP6.
+ */
+#define AR5312_MISC_IRQ_TIMER		0
+#define AR5312_MISC_IRQ_AHB_PROC	1
+#define AR5312_MISC_IRQ_AHB_DMA		2
+#define AR5312_MISC_IRQ_GPIO		3
+#define AR5312_MISC_IRQ_UART0		4
+#define AR5312_MISC_IRQ_UART0_DMA	5
+#define AR5312_MISC_IRQ_WATCHDOG	6
+#define AR5312_MISC_IRQ_LOCAL		7
+#define AR5312_MISC_IRQ_SPI		8
+#define AR5312_MISC_IRQ_COUNT		9
+
+/*
  * Address Map
  *
  * The AR5312 supports 2 enet MACS, even though many reference boards only
-- 
1.8.5.5
