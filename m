Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 00:20:06 +0100 (CET)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:46537 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011792AbaJ1XTAN0WxY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 00:19:00 +0100
Received: by mail-lb0-f171.google.com with SMTP id z11so1550692lbi.30
        for <multiple recipients>; Tue, 28 Oct 2014 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C/DCzOZ7u0LZGiDG5X0SUtxbQKqcDhh63Dz+Qk+vimc=;
        b=A2XXr+UfSr6JWrORjQwPUwWXQ0nKDaAch3ArQBhIuNlj2L32cjIizXZsT/Ljdd8Bpb
         beHp/vzr52f+fEItfIr0MNjWyLKVte7K4tWXH65J2OLTXnm+ESvxBd4Ys5o+vQQxsVU5
         3ca83pOQG2+rsd4vAI/jOszZuAT4/7fHVM5GBCaLelG8Hd9ENyZP6gv8J97lfFbXp0vn
         f9iAIhLKQSwPYTdLbb1cj24VJwuKkx1GS8sOU5X5A0QPGOVSSPK4e3ZxG2tyRIwpuh0+
         hClJAaFoBKnt1JU5cD0I2akpSWO3+vkvB3O9c6Rcl8zNBlt5Y0haXXEqCnAnQd2YxFLf
         EisQ==
X-Received: by 10.112.219.3 with SMTP id pk3mr7419754lbc.18.1414538334641;
        Tue, 28 Oct 2014 16:18:54 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id i6sm1173752laf.47.2014.10.28.16.18.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 16:18:53 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v3 04/13] MIPS: ath25: add interrupts handling routines
Date:   Wed, 29 Oct 2014 03:18:41 +0400
Message-Id: <1414538330-5548-5-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43655
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

Changes since v1:
  - rename MIPS machine ar231x -> ath25

Changes since v2:
  - use braces on all arms inside the interrupt handling routines
  - use irq_domain

 arch/mips/Kconfig             |   1 +
 arch/mips/ath25/ar2315.c      | 114 ++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ath25/ar2315.h      |   2 +
 arch/mips/ath25/ar2315_regs.h |  23 +++++++++
 arch/mips/ath25/ar5312.c      | 112 +++++++++++++++++++++++++++++++++++++++++
 arch/mips/ath25/ar5312.h      |   2 +
 arch/mips/ath25/ar5312_regs.h |  23 +++++++++
 arch/mips/ath25/board.c       |   9 ++++
 arch/mips/ath25/devices.h     |   4 ++
 9 files changed, 290 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7346471..3daeed5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -102,6 +102,7 @@ config ATH25
 	select CSRC_R4K
 	select DMA_NONCOHERENT
 	select IRQ_CPU
+	select IRQ_DOMAIN
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index 8289432..d92aa91 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -16,6 +16,9 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
 #include <linux/reboot.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
@@ -26,6 +29,7 @@
 #include "ar2315_regs.h"
 
 static void __iomem *ar2315_rst_base;
+static struct irq_domain *ar2315_misc_irq_domain;
 
 static inline u32 ar2315_rst_reg_read(u32 reg)
 {
@@ -46,6 +50,116 @@ static inline void ar2315_rst_reg_mask(u32 reg, u32 mask, u32 val)
 	ar2315_rst_reg_write(reg, ret);
 }
 
+static irqreturn_t ar2315_ahb_err_handler(int cpl, void *dev_id)
+{
+	ar2315_rst_reg_write(AR2315_AHB_ERR0, AR2315_AHB_ERROR_DET);
+	ar2315_rst_reg_read(AR2315_AHB_ERR1);
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
+	u32 pending = ar2315_rst_reg_read(AR2315_ISR) &
+		      ar2315_rst_reg_read(AR2315_IMR);
+	unsigned nr, misc_irq = 0;
+
+	if (pending) {
+		struct irq_domain *domain = irq_get_handler_data(irq);
+
+		nr = __ffs(pending);
+		misc_irq = irq_find_mapping(domain, nr);
+	}
+
+	if (misc_irq) {
+		if (nr == AR2315_MISC_IRQ_GPIO)
+			ar2315_rst_reg_write(AR2315_ISR, AR2315_ISR_GPIO);
+		else if (nr == AR2315_MISC_IRQ_WATCHDOG)
+			ar2315_rst_reg_write(AR2315_ISR, AR2315_ISR_WD);
+		generic_handle_irq(misc_irq);
+	} else {
+		spurious_interrupt();
+	}
+}
+
+static void ar2315_misc_irq_unmask(struct irq_data *d)
+{
+	ar2315_rst_reg_mask(AR2315_IMR, 0, BIT(d->hwirq));
+}
+
+static void ar2315_misc_irq_mask(struct irq_data *d)
+{
+	ar2315_rst_reg_mask(AR2315_IMR, BIT(d->hwirq), 0);
+}
+
+static struct irq_chip ar2315_misc_irq_chip = {
+	.name		= "ar2315-misc",
+	.irq_unmask	= ar2315_misc_irq_unmask,
+	.irq_mask	= ar2315_misc_irq_mask,
+};
+
+static int ar2315_misc_irq_map(struct irq_domain *d, unsigned irq,
+			       irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &ar2315_misc_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static struct irq_domain_ops ar2315_misc_irq_domain_ops = {
+	.map = ar2315_misc_irq_map,
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
+		do_IRQ(ATH25_IRQ_CPU_CLOCK);
+	else
+		spurious_interrupt();
+}
+
+void __init ar2315_arch_init_irq(void)
+{
+	struct irq_domain *domain;
+	unsigned irq;
+
+	ath25_irq_dispatch = ar2315_irq_dispatch;
+
+	domain = irq_domain_add_linear(NULL, AR2315_MISC_IRQ_COUNT,
+				       &ar2315_misc_irq_domain_ops, NULL);
+	if (!domain)
+		panic("Failed to add IRQ domain");
+
+	irq = irq_create_mapping(domain, AR2315_MISC_IRQ_AHB);
+	setup_irq(irq, &ar2315_ahb_err_interrupt);
+
+	irq_set_chained_handler(AR2315_IRQ_MISC, ar2315_misc_irq_handler);
+	irq_set_handler_data(AR2315_IRQ_MISC, domain);
+
+	ar2315_misc_irq_domain = domain;
+}
+
 static void ar2315_restart(char *command)
 {
 	void (*mips_reset_vec)(void) = (void *)0xbfc00000;
diff --git a/arch/mips/ath25/ar2315.h b/arch/mips/ath25/ar2315.h
index baeaf84..da5b843 100644
--- a/arch/mips/ath25/ar2315.h
+++ b/arch/mips/ath25/ar2315.h
@@ -3,11 +3,13 @@
 
 #ifdef CONFIG_SOC_AR2315
 
+void ar2315_arch_init_irq(void);
 void ar2315_plat_time_init(void);
 void ar2315_plat_mem_setup(void);
 
 #else
 
+static inline void ar2315_arch_init_irq(void) {}
 static inline void ar2315_plat_time_init(void) {}
 static inline void ar2315_plat_mem_setup(void) {}
 
diff --git a/arch/mips/ath25/ar2315_regs.h b/arch/mips/ath25/ar2315_regs.h
index c97d351..16e8614 100644
--- a/arch/mips/ath25/ar2315_regs.h
+++ b/arch/mips/ath25/ar2315_regs.h
@@ -15,6 +15,29 @@
 #define __ASM_MACH_ATH25_AR2315_REGS_H
 
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
 #define AR2315_SPI_READ_BASE	0x08000000	/* SPI flash */
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index c2adaf2..b99a02a 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -16,6 +16,9 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
 #include <linux/reboot.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
@@ -26,6 +29,7 @@
 #include "ar5312_regs.h"
 
 static void __iomem *ar5312_rst_base;
+static struct irq_domain *ar5312_misc_irq_domain;
 
 static inline u32 ar5312_rst_reg_read(u32 reg)
 {
@@ -46,6 +50,114 @@ static inline void ar5312_rst_reg_mask(u32 reg, u32 mask, u32 val)
 	ar5312_rst_reg_write(reg, ret);
 }
 
+static irqreturn_t ar5312_ahb_err_handler(int cpl, void *dev_id)
+{
+	u32 proc1 = ar5312_rst_reg_read(AR5312_PROC1);
+	u32 proc_addr = ar5312_rst_reg_read(AR5312_PROCADDR); /* clears error */
+	u32 dma1 = ar5312_rst_reg_read(AR5312_DMA1);
+	u32 dma_addr = ar5312_rst_reg_read(AR5312_DMAADDR);   /* clears error */
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
+	u32 pending = ar5312_rst_reg_read(AR5312_ISR) &
+		      ar5312_rst_reg_read(AR5312_IMR);
+	unsigned nr, misc_irq = 0;
+
+	if (pending) {
+		struct irq_domain *domain = irq_get_handler_data(irq);
+
+		nr = __ffs(pending);
+		misc_irq = irq_find_mapping(domain, nr);
+	}
+
+	if (misc_irq) {
+		generic_handle_irq(misc_irq);
+		if (nr == AR5312_MISC_IRQ_TIMER)
+			ar5312_rst_reg_read(AR5312_TIMER);
+	} else {
+		spurious_interrupt();
+	}
+}
+
+/* Enable the specified AR5312_MISC_IRQ interrupt */
+static void ar5312_misc_irq_unmask(struct irq_data *d)
+{
+	ar5312_rst_reg_mask(AR5312_IMR, 0, BIT(d->hwirq));
+}
+
+/* Disable the specified AR5312_MISC_IRQ interrupt */
+static void ar5312_misc_irq_mask(struct irq_data *d)
+{
+	ar5312_rst_reg_mask(AR5312_IMR, BIT(d->hwirq), 0);
+	ar5312_rst_reg_read(AR5312_IMR); /* flush write buffer */
+}
+
+static struct irq_chip ar5312_misc_irq_chip = {
+	.name		= "ar5312-misc",
+	.irq_unmask	= ar5312_misc_irq_unmask,
+	.irq_mask	= ar5312_misc_irq_mask,
+};
+
+static int ar5312_misc_irq_map(struct irq_domain *d, unsigned irq,
+			       irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &ar5312_misc_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static struct irq_domain_ops ar5312_misc_irq_domain_ops = {
+	.map = ar5312_misc_irq_map,
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
+		do_IRQ(ATH25_IRQ_CPU_CLOCK);
+	else
+		spurious_interrupt();
+}
+
+void __init ar5312_arch_init_irq(void)
+{
+	struct irq_domain *domain;
+	unsigned irq;
+
+	ath25_irq_dispatch = ar5312_irq_dispatch;
+
+	domain = irq_domain_add_linear(NULL, AR5312_MISC_IRQ_COUNT,
+				       &ar5312_misc_irq_domain_ops, NULL);
+	if (!domain)
+		panic("Failed to add IRQ domain");
+
+	irq = irq_create_mapping(domain, AR5312_MISC_IRQ_AHB_PROC);
+	setup_irq(irq, &ar5312_ahb_err_interrupt);
+
+	irq_set_chained_handler(AR5312_IRQ_MISC, ar5312_misc_irq_handler);
+	irq_set_handler_data(AR5312_IRQ_MISC, domain);
+
+	ar5312_misc_irq_domain = domain;
+}
+
 static void ar5312_restart(char *command)
 {
 	/* reset the system */
diff --git a/arch/mips/ath25/ar5312.h b/arch/mips/ath25/ar5312.h
index 9e1e56e..254f04f 100644
--- a/arch/mips/ath25/ar5312.h
+++ b/arch/mips/ath25/ar5312.h
@@ -3,11 +3,13 @@
 
 #ifdef CONFIG_SOC_AR5312
 
+void ar5312_arch_init_irq(void);
 void ar5312_plat_time_init(void);
 void ar5312_plat_mem_setup(void);
 
 #else
 
+static inline void ar5312_arch_init_irq(void) {}
 static inline void ar5312_plat_time_init(void) {}
 static inline void ar5312_plat_mem_setup(void) {}
 
diff --git a/arch/mips/ath25/ar5312_regs.h b/arch/mips/ath25/ar5312_regs.h
index ff12011..4b947f9 100644
--- a/arch/mips/ath25/ar5312_regs.h
+++ b/arch/mips/ath25/ar5312_regs.h
@@ -12,6 +12,29 @@
 #define __ASM_MACH_ATH25_AR5312_REGS_H
 
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
diff --git a/arch/mips/ath25/board.c b/arch/mips/ath25/board.c
index 0065197..b26c462 100644
--- a/arch/mips/ath25/board.c
+++ b/arch/mips/ath25/board.c
@@ -20,6 +20,8 @@
 #include "ar5312.h"
 #include "ar2315.h"
 
+void (*ath25_irq_dispatch)(void);
+
 static void ath25_halt(void)
 {
 	local_irq_disable();
@@ -42,6 +44,7 @@ void __init plat_mem_setup(void)
 
 asmlinkage void plat_irq_dispatch(void)
 {
+	ath25_irq_dispatch();
 }
 
 void __init plat_time_init(void)
@@ -61,5 +64,11 @@ void __init arch_init_irq(void)
 {
 	clear_c0_status(ST0_IM);
 	mips_cpu_irq_init();
+
+	/* Initialize interrupt controllers */
+	if (is_ar5312())
+		ar5312_arch_init_irq();
+	else
+		ar2315_arch_init_irq();
 }
 
diff --git a/arch/mips/ath25/devices.h b/arch/mips/ath25/devices.h
index e25a326..2985586 100644
--- a/arch/mips/ath25/devices.h
+++ b/arch/mips/ath25/devices.h
@@ -5,6 +5,10 @@
 
 #define ATH25_REG_MS(_val, _field)	(((_val) & _field##_M) >> _field##_S)
 
+#define ATH25_IRQ_CPU_CLOCK	(MIPS_CPU_IRQ_BASE + 7)	/* C0_CAUSE: 0x8000 */
+
+extern void (*ath25_irq_dispatch)(void);
+
 static inline bool is_ar2315(void)
 {
 	return (current_cpu_data.cputype == CPU_4KEC);
-- 
1.8.5.5
