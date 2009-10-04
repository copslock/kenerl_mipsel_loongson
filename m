Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Oct 2009 14:55:39 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.148]:26174 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492478AbZJDMzd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Oct 2009 14:55:33 +0200
Received: by ey-out-1920.google.com with SMTP id 13so382155eye.52
        for <multiple recipients>; Sun, 04 Oct 2009 05:55:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fq00PyTneMc7YfLfolupzE8iLpWZaNbSbeFB8moNibA=;
        b=SUXIwa5c9FGi9iu6GwPQSWgL+jAvw9y02e4ygwQV+Uec6VKhRjn2IYhZ60HHEOh0x9
         0ZpTqwON1fI3V6kXUaV/Thju1om8PIXmNH2u3Y8Lnp1l9O1+PjlbhA65JrmF6CKurAFb
         tbMYZuBN4sjADYZZLmNo8RwK5wKu0n6fIcOoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TK5HipspVUyrdpLFaU6qcNHf2/xNhDRgleT8zfi7w/orz4fXUsjeuZzVAGKzO59Rmx
         4CXiz19wg4xYPB5yHgo2NXtwO2MKeemJoT0WjfoV8VixIrL+8Ih33GTetO6gfJ2mD6KN
         HIZflqVMfAAd+RbaA8SQs9P8SPiaJLgS0vSQE=
Received: by 10.210.3.21 with SMTP id 21mr1951233ebc.40.1254660932373;
        Sun, 04 Oct 2009 05:55:32 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 28sm1555483eyg.4.2009.10.04.05.55.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 05:55:31 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/6] Alchemy: devboard register abstraction
Date:	Sun,  4 Oct 2009 14:55:24 +0200
Message-Id: <1254660929-15453-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
In-Reply-To: <1254660929-15453-1-git-send-email-manuel.lauss@gmail.com>
References: <1254660929-15453-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

All Alchemy development boards have external CPLDs with a few registers
in them.  They all share an identical register layout with only a few
minor differences (except the PB1000) in bit functions and base
addresses.

This patch
- adds a primitive facility to initialize and use these external
  registers,
- replaces all occurrences of bcsr->xxx accesses with calls to the new
  functions (the pb1200 cascade irq handling code is special).
- collects BCSR register information scattered throughout the board
  headers in a central place.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/Makefile             |    2 +-
 arch/mips/alchemy/devboards/bcsr.c               |   76 +++++++
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   62 +++---
 arch/mips/alchemy/devboards/pb1100/board_setup.c |    7 +-
 arch/mips/alchemy/devboards/pb1200/board_setup.c |   49 ++---
 arch/mips/alchemy/devboards/pb1200/irqmap.c      |   42 +++--
 arch/mips/alchemy/devboards/pb1200/platform.c    |   25 ++-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |    7 +-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   11 +-
 arch/mips/include/asm/mach-db1x00/bcsr.h         |  235 ++++++++++++++++++++++
 arch/mips/include/asm/mach-db1x00/db1200.h       |  109 +----------
 arch/mips/include/asm/mach-db1x00/db1x00.h       |   92 ---------
 arch/mips/include/asm/mach-pb1x00/pb1100.h       |   49 -----
 arch/mips/include/asm/mach-pb1x00/pb1200.h       |  109 +----------
 arch/mips/include/asm/mach-pb1x00/pb1500.h       |   13 --
 arch/mips/include/asm/mach-pb1x00/pb1550.h       |   89 --------
 drivers/mtd/nand/au1550nd.c                      |    4 +-
 drivers/net/irda/au1k_ir.c                       |   14 +-
 drivers/pcmcia/au1000_db1x00.c                   |   76 ++++----
 19 files changed, 475 insertions(+), 596 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/bcsr.c
 create mode 100644 arch/mips/include/asm/mach-db1x00/bcsr.h

diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index 730f9f2..adc6717 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -2,7 +2,7 @@
 # Alchemy Develboards
 #
 
-obj-y += prom.o
+obj-y += prom.o bcsr.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_MIPS_PB1000)	+= pb1000/
 obj-$(CONFIG_MIPS_PB1100)	+= pb1100/
diff --git a/arch/mips/alchemy/devboards/bcsr.c b/arch/mips/alchemy/devboards/bcsr.c
new file mode 100644
index 0000000..85b7715
--- /dev/null
+++ b/arch/mips/alchemy/devboards/bcsr.c
@@ -0,0 +1,76 @@
+/*
+ * bcsr.h -- Db1xxx/Pb1xxx Devboard CPLD registers ("BCSR") abstraction.
+ *
+ * All Alchemy development boards (except, of course, the weird PB1000)
+ * have a few registers in a CPLD with standardised layout; they mostly
+ * only differ in base address.
+ * All registers are 16bits wide with 32bit spacing.
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <asm/addrspace.h>
+#include <asm/io.h>
+#include <asm/mach-db1x00/bcsr.h>
+
+static struct bcsr_reg {
+	void __iomem *raddr;
+	spinlock_t lock;
+} bcsr_regs[BCSR_CNT];
+
+void __init bcsr_init(unsigned long bcsr1_phys, unsigned long bcsr2_phys)
+{
+	int i;
+
+	bcsr1_phys = KSEG1ADDR(CPHYSADDR(bcsr1_phys));
+	bcsr2_phys = KSEG1ADDR(CPHYSADDR(bcsr2_phys));
+
+	for (i = 0; i < BCSR_CNT; i++) {
+		if (i >= BCSR_HEXLEDS)
+			bcsr_regs[i].raddr = (void __iomem *)bcsr2_phys +
+					(0x04 * (i - BCSR_HEXLEDS));
+		else
+			bcsr_regs[i].raddr = (void __iomem *)bcsr1_phys +
+					(0x04 * i);
+
+		spin_lock_init(&bcsr_regs[i].lock);
+	}
+}
+
+unsigned short bcsr_read(enum bcsr_id reg)
+{
+	unsigned short r;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bcsr_regs[reg].lock, flags);
+	r = __raw_readw(bcsr_regs[reg].raddr);
+	spin_unlock_irqrestore(&bcsr_regs[reg].lock, flags);
+	return r;
+}
+EXPORT_SYMBOL_GPL(bcsr_read);
+
+void bcsr_write(enum bcsr_id reg, unsigned short val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&bcsr_regs[reg].lock, flags);
+	__raw_writew(val, bcsr_regs[reg].raddr);
+	wmb();
+	spin_unlock_irqrestore(&bcsr_regs[reg].lock, flags);
+}
+EXPORT_SYMBOL_GPL(bcsr_write);
+
+void bcsr_mod(enum bcsr_id reg, unsigned short clr, unsigned short set)
+{
+	unsigned short r;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bcsr_regs[reg].lock, flags);
+	r = __raw_readw(bcsr_regs[reg].raddr);
+	r &= ~clr;
+	r |= set;
+	__raw_writew(r, bcsr_regs[reg].raddr);
+	wmb();
+	spin_unlock_irqrestore(&bcsr_regs[reg].lock, flags);
+}
+EXPORT_SYMBOL_GPL(bcsr_mod);
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index de30d8e..e713390 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -32,12 +32,10 @@
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/db1x00.h>
+#include <asm/mach-db1x00/bcsr.h>
 
 #include <prom.h>
 
-
-static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
-
 const char *get_system_type(void)
 {
 #ifdef CONFIG_MIPS_BOSPORUS
@@ -49,15 +47,43 @@ const char *get_system_type(void)
 
 void board_reset(void)
 {
-	/* Hit BCSR.SW_RESET[RESET] */
-	bcsr->swreset = 0x0000;
+	bcsr_write(BCSR_SYSTEM, 0);
 }
 
 void __init board_setup(void)
 {
+	unsigned long bcsr1, bcsr2;
 	u32 pin_func = 0;
 	char *argptr;
 
+	bcsr1 = DB1000_BCSR_PHYS_ADDR;
+	bcsr2 = DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS;
+
+#ifdef CONFIG_MIPS_DB1000
+	printk(KERN_INFO "AMD Alchemy Au1000/Db1000 Board\n");
+#endif
+#ifdef CONFIG_MIPS_DB1500
+	printk(KERN_INFO "AMD Alchemy Au1500/Db1500 Board\n");
+#endif
+#ifdef CONFIG_MIPS_DB1100
+	printk(KERN_INFO "AMD Alchemy Au1100/Db1100 Board\n");
+#endif
+#ifdef CONFIG_MIPS_BOSPORUS
+	printk(KERN_INFO "AMD Alchemy Bosporus Board\n");
+#endif
+#ifdef CONFIG_MIPS_MIRAGE
+	printk(KERN_INFO "AMD Alchemy Mirage Board\n");
+#endif
+#ifdef CONFIG_MIPS_DB1550
+	printk(KERN_INFO "AMD Alchemy Au1550/Db1550 Board\n");
+
+	bcsr1 = DB1550_BCSR_PHYS_ADDR;
+	bcsr2 = DB1550_BCSR_PHYS_ADDR + DB1550_BCSR_HEXLED_OFS;
+#endif
+
+	/* initialize board register space */
+	bcsr_init(bcsr1, bcsr2);
+
 	argptr = prom_getcmdline();
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	argptr = strstr(argptr, "console=");
@@ -89,11 +115,10 @@ void __init board_setup(void)
 	pin_func = au_readl(SYS_PINFUNC) | SYS_PF_IRF;
 	au_writel(pin_func, SYS_PINFUNC);
 	/* Power off until the driver is in use */
-	bcsr->resets &= ~BCSR_RESETS_IRDA_MODE_MASK;
-	bcsr->resets |=  BCSR_RESETS_IRDA_MODE_OFF;
-	au_sync();
+	bcsr_mod(BCSR_RESETS, BCSR_RESETS_IRDA_MODE_MASK,
+				BCSR_RESETS_IRDA_MODE_OFF);
 #endif
-	bcsr->pcmcia = 0x0000; /* turn off PCMCIA power */
+	bcsr_write(BCSR_PCMCIA, 0);	/* turn off PCMCIA power */
 
 	/* Enable GPIO[31:0] inputs */
 	alchemy_gpio1_input_enable();
@@ -123,23 +148,4 @@ void __init board_setup(void)
 #endif
 
 	au_sync();
-
-#ifdef CONFIG_MIPS_DB1000
-	printk(KERN_INFO "AMD Alchemy Au1000/Db1000 Board\n");
-#endif
-#ifdef CONFIG_MIPS_DB1500
-	printk(KERN_INFO "AMD Alchemy Au1500/Db1500 Board\n");
-#endif
-#ifdef CONFIG_MIPS_DB1100
-	printk(KERN_INFO "AMD Alchemy Au1100/Db1100 Board\n");
-#endif
-#ifdef CONFIG_MIPS_BOSPORUS
-	printk(KERN_INFO "AMD Alchemy Bosporus Board\n");
-#endif
-#ifdef CONFIG_MIPS_MIRAGE
-	printk(KERN_INFO "AMD Alchemy Mirage Board\n");
-#endif
-#ifdef CONFIG_MIPS_DB1550
-	printk(KERN_INFO "AMD Alchemy Au1550/Db1550 Board\n");
-#endif
 }
diff --git a/arch/mips/alchemy/devboards/pb1100/board_setup.c b/arch/mips/alchemy/devboards/pb1100/board_setup.c
index 6126308..eb749fb 100644
--- a/arch/mips/alchemy/devboards/pb1100/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1100/board_setup.c
@@ -30,6 +30,7 @@
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1100.h>
+#include <asm/mach-db1x00/bcsr.h>
 
 #include <prom.h>
 
@@ -49,8 +50,7 @@ const char *get_system_type(void)
 
 void board_reset(void)
 {
-	/* Hit BCSR.RST_VDDI[SOFT_RESET] */
-	au_writel(0x00000000, PB1100_RST_VDDI);
+	bcsr_write(BCSR_SYSTEM, 0);
 }
 
 void __init board_init_irq(void)
@@ -63,6 +63,9 @@ void __init board_setup(void)
 	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
 	char *argptr;
 
+	bcsr_init(DB1000_BCSR_PHYS_ADDR,
+		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
+
 	argptr = prom_getcmdline();
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	argptr = strstr(argptr, "console=");
diff --git a/arch/mips/alchemy/devboards/pb1200/board_setup.c b/arch/mips/alchemy/devboards/pb1200/board_setup.c
index 94e6b7e..db56380 100644
--- a/arch/mips/alchemy/devboards/pb1200/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1200/board_setup.c
@@ -27,6 +27,8 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 
+#include <asm/mach-db1x00/bcsr.h>
+
 #include <prom.h>
 #include <au1xxx.h>
 
@@ -38,14 +40,25 @@ const char *get_system_type(void)
 
 void board_reset(void)
 {
-	bcsr->resets = 0;
-	bcsr->system = 0;
+	bcsr_write(BCSR_RESETS, 0);
+	bcsr_write(BCSR_SYSTEM, 0);
 }
 
 void __init board_setup(void)
 {
 	char *argptr;
 
+#ifdef CONFIG_MIPS_PB1200
+	printk(KERN_INFO "AMD Alchemy Pb1200 Board\n");
+	bcsr_init(PB1200_BCSR_PHYS_ADDR,
+		  PB1200_BCSR_PHYS_ADDR + PB1200_BCSR_HEXLED_OFS);
+#endif
+#ifdef CONFIG_MIPS_DB1200
+	printk(KERN_INFO "AMD Alchemy Db1200 Board\n");
+	bcsr_init(DB1200_BCSR_PHYS_ADDR,
+		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
+#endif
+
 	argptr = prom_getcmdline();
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	argptr = strstr(argptr, "console=");
@@ -82,7 +95,7 @@ void __init board_setup(void)
 		u32 pin_func;
 
 		/* Select SMBus in CPLD */
-		bcsr->resets &= ~BCSR_RESETS_PCS0MUX;
+		bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC0MUX, 0);
 
 		pin_func = au_readl(SYS_PINFUNC);
 		au_sync();
@@ -116,38 +129,24 @@ void __init board_setup(void)
 
 	/*
 	 * The Pb1200 development board uses external MUX for PSC0 to
-	 * support SMB/SPI. bcsr->resets bit 12: 0=SMB 1=SPI
+	 * support SMB/SPI. bcsr_resets bit 12: 0=SMB 1=SPI
 	 */
 #ifdef CONFIG_I2C_AU1550
-	bcsr->resets &= ~BCSR_RESETS_PCS0MUX;
+	bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC0MUX, 0);
 #endif
 	au_sync();
-
-#ifdef CONFIG_MIPS_PB1200
-	printk(KERN_INFO "AMD Alchemy Pb1200 Board\n");
-#endif
-#ifdef CONFIG_MIPS_DB1200
-	printk(KERN_INFO "AMD Alchemy Db1200 Board\n");
-#endif
 }
 
 int board_au1200fb_panel(void)
 {
-	BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
-	int p;
-
-	p = bcsr->switches;
-	p >>= 8;
-	p &= 0x0F;
-	return p;
+	return (bcsr_read(BCSR_SWITCHES) >> 8) & 0x0f;
 }
 
 int board_au1200fb_panel_init(void)
 {
 	/* Apply power */
-	BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
-
-	bcsr->board |= BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD | BCSR_BOARD_LCDBL;
+	bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
+				BCSR_BOARD_LCDBL);
 	/* printk(KERN_DEBUG "board_au1200fb_panel_init()\n"); */
 	return 0;
 }
@@ -155,10 +154,8 @@ int board_au1200fb_panel_init(void)
 int board_au1200fb_panel_shutdown(void)
 {
 	/* Remove power */
-	BCSR *bcsr = (BCSR *)BCSR_KSEG1_ADDR;
-
-	bcsr->board &= ~(BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
-			 BCSR_BOARD_LCDBL);
+	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
+			     BCSR_BOARD_LCDBL, 0);
 	/* printk(KERN_DEBUG "board_au1200fb_panel_shutdown()\n"); */
 	return 0;
 }
diff --git a/arch/mips/alchemy/devboards/pb1200/irqmap.c b/arch/mips/alchemy/devboards/pb1200/irqmap.c
index fe47498..f379b02 100644
--- a/arch/mips/alchemy/devboards/pb1200/irqmap.c
+++ b/arch/mips/alchemy/devboards/pb1200/irqmap.c
@@ -38,11 +38,14 @@
 #define PB1200_INT_END DB1200_INT_END
 #endif
 
+#include <asm/mach-db1x00/bcsr.h>
+
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 	/* This is external interrupt cascade */
 	{ AU1000_GPIO_7, IRQF_TRIGGER_LOW, 0 },
 };
 
+static void __iomem *bcsr_virt;
 
 /*
  * Support for External interrupts on the Pb1200 Development platform.
@@ -50,7 +53,7 @@ struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 
 static void pb1200_cascade_handler(unsigned int irq, struct irq_desc *d)
 {
-	unsigned short bisr = bcsr->int_status;
+	unsigned short bisr = __raw_readw(bcsr_virt + BCSR_REG_INTSTAT);
 
 	for ( ; bisr; bisr &= bisr - 1)
 		generic_handle_irq(PB1200_INT_BEGIN + __ffs(bisr));
@@ -61,24 +64,27 @@ static void pb1200_cascade_handler(unsigned int irq, struct irq_desc *d)
  */
 static void pb1200_mask_irq(unsigned int irq_nr)
 {
-	bcsr->intclr_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
-	bcsr->intclr = 1 << (irq_nr - PB1200_INT_BEGIN);
-	au_sync();
+	unsigned short v = 1 << (irq_nr - PB1200_INT_BEGIN);
+	__raw_writew(v, bcsr_virt + BCSR_REG_INTCLR);
+	__raw_writew(v, bcsr_virt + BCSR_REG_MASKCLR);
+	wmb();
 }
 
 static void pb1200_maskack_irq(unsigned int irq_nr)
 {
-	bcsr->intclr_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
-	bcsr->intclr = 1 << (irq_nr - PB1200_INT_BEGIN);
-	bcsr->int_status = 1 << (irq_nr - PB1200_INT_BEGIN);	/* ack */
-	au_sync();
+	unsigned short v = 1 << (irq_nr - PB1200_INT_BEGIN);
+	__raw_writew(v, bcsr_virt + BCSR_REG_INTCLR);
+	__raw_writew(v, bcsr_virt + BCSR_REG_MASKCLR);
+	__raw_writew(v, bcsr_virt + BCSR_REG_INTSTAT);	/* ack */
+	wmb();
 }
 
 static void pb1200_unmask_irq(unsigned int irq_nr)
 {
-	bcsr->intset = 1 << (irq_nr - PB1200_INT_BEGIN);
-	bcsr->intset_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
-	au_sync();
+	unsigned short v = 1 << (irq_nr - PB1200_INT_BEGIN);
+	__raw_writew(v, bcsr_virt + BCSR_REG_INTSET);
+	__raw_writew(v, bcsr_virt + BCSR_REG_MASKSET);
+	wmb();
 }
 
 static struct irq_chip pb1200_cpld_irq_type = {
@@ -100,8 +106,10 @@ void __init board_init_irq(void)
 	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
 
 #ifdef CONFIG_MIPS_PB1200
+	bcsr_virt = (void __iomem *)KSEG1ADDR(PB1200_BCSR_PHYS_ADDR);
+
 	/* We have a problem with CPLD rev 3. */
-	if (((bcsr->whoami & BCSR_WHOAMI_CPLD) >> 4) <= 3) {
+	if (BCSR_WHOAMI_CPLD(bcsr_read(BCSR_WHOAMI)) <= 3) {
 		printk(KERN_ERR "WARNING!!!\n");
 		printk(KERN_ERR "WARNING!!!\n");
 		printk(KERN_ERR "WARNING!!!\n");
@@ -119,12 +127,14 @@ void __init board_init_irq(void)
 		printk(KERN_ERR "WARNING!!!\n");
 		panic("Game over.  Your score is 0.");
 	}
+#else
+	bcsr_virt = (void __iomem *)KSEG1ADDR(DB1200_BCSR_PHYS_ADDR);
 #endif
+
 	/* mask & disable & ack all */
-	bcsr->intclr_mask = 0xffff;
-	bcsr->intclr = 0xffff;
-	bcsr->int_status = 0xffff;
-	au_sync();
+	bcsr_write(BCSR_INTCLR, 0xffff);
+	bcsr_write(BCSR_MASKCLR, 0xffff);
+	bcsr_write(BCSR_INTSTAT, 0xffff);
 
 	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++)
 		set_irq_chip_and_handler_name(irq, &pb1200_cpld_irq_type,
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index b93dff4..dfdaabf 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -26,27 +26,28 @@
 
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
+#include <asm/mach-db1x00/bcsr.h>
 
 static int mmc_activity;
 
 static void pb1200mmc0_set_power(void *mmc_host, int state)
 {
 	if (state)
-		bcsr->board |= BCSR_BOARD_SD0PWR;
+		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD0PWR);
 	else
-		bcsr->board &= ~BCSR_BOARD_SD0PWR;
+		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD0PWR, 0);
 
-	au_sync_delay(1);
+	msleep(1);
 }
 
 static int pb1200mmc0_card_readonly(void *mmc_host)
 {
-	return (bcsr->status & BCSR_STATUS_SD0WP) ? 1 : 0;
+	return (bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD0WP) ? 1 : 0;
 }
 
 static int pb1200mmc0_card_inserted(void *mmc_host)
 {
-	return (bcsr->sig_status & BCSR_INT_SD0INSERT) ? 1 : 0;
+	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD0INSERT) ? 1 : 0;
 }
 
 static void pb1200_mmcled_set(struct led_classdev *led,
@@ -54,10 +55,10 @@ static void pb1200_mmcled_set(struct led_classdev *led,
 {
 	if (brightness != LED_OFF) {
 		if (++mmc_activity == 1)
-			bcsr->disk_leds &= ~(1 << 8);
+			bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED0, 0);
 	} else {
 		if (--mmc_activity == 0)
-			bcsr->disk_leds |= (1 << 8);
+			bcsr_mod(BCSR_LEDS, 0, BCSR_LEDS_LED0);
 	}
 }
 
@@ -69,21 +70,21 @@ static struct led_classdev pb1200mmc_led = {
 static void pb1200mmc1_set_power(void *mmc_host, int state)
 {
 	if (state)
-		bcsr->board |= BCSR_BOARD_SD1PWR;
+		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD1PWR);
 	else
-		bcsr->board &= ~BCSR_BOARD_SD1PWR;
+		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD1PWR, 0);
 
-	au_sync_delay(1);
+	msleep(1);
 }
 
 static int pb1200mmc1_card_readonly(void *mmc_host)
 {
-	return (bcsr->status & BCSR_STATUS_SD1WP) ? 1 : 0;
+	return (bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD1WP) ? 1 : 0;
 }
 
 static int pb1200mmc1_card_inserted(void *mmc_host)
 {
-	return (bcsr->sig_status & BCSR_INT_SD1INSERT) ? 1 : 0;
+	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD1INSERT) ? 1 : 0;
 }
 #endif
 
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index d7a5656..c5389e5 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -30,6 +30,7 @@
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1500.h>
+#include <asm/mach-db1x00/bcsr.h>
 
 #include <prom.h>
 
@@ -55,8 +56,7 @@ const char *get_system_type(void)
 
 void board_reset(void)
 {
-	/* Hit BCSR.RST_VDDI[SOFT_RESET] */
-	au_writel(0x00000000, PB1500_RST_VDDI);
+	bcsr_write(BCSR_SYSTEM, 0);
 }
 
 void __init board_init_irq(void)
@@ -70,6 +70,9 @@ void __init board_setup(void)
 	u32 sys_freqctrl, sys_clksrc;
 	char *argptr;
 
+	bcsr_init(DB1000_BCSR_PHYS_ADDR,
+		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
+
 	argptr = prom_getcmdline();
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	argptr = strstr(argptr, "console=");
diff --git a/arch/mips/alchemy/devboards/pb1550/board_setup.c b/arch/mips/alchemy/devboards/pb1550/board_setup.c
index b6e9e7d..af7a1b5 100644
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -32,6 +32,7 @@
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
+#include <asm/mach-db1x00/bcsr.h>
 
 #include <prom.h>
 
@@ -53,8 +54,7 @@ const char *get_system_type(void)
 
 void board_reset(void)
 {
-	/* Hit BCSR.SYSTEM[RESET] */
-	au_writew(au_readw(0xAF00001C) & ~BCSR_SYSTEM_RESET, 0xAF00001C);
+	bcsr_write(BCSR_SYSTEM, 0);
 }
 
 void __init board_init_irq(void)
@@ -66,6 +66,10 @@ void __init board_setup(void)
 {
 	u32 pin_func;
 
+	bcsr_init(PB1550_BCSR_PHYS_ADDR,
+		  PB1550_BCSR_PHYS_ADDR + PB1550_BCSR_HEXLED_OFS);
+
+
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	char *argptr;
 	argptr = prom_getcmdline();
@@ -85,8 +89,7 @@ void __init board_setup(void)
 	pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
 	au_writel(pin_func, SYS_PINFUNC);
 
-	au_writel(0, (u32)bcsr | 0x10); /* turn off PCMCIA power */
-	au_sync();
+	bcsr_write(BCSR_PCMCIA, 0);	/* turn off PCMCIA power */
 
 	printk(KERN_INFO "AMD Alchemy Pb1550 Board\n");
 }
diff --git a/arch/mips/include/asm/mach-db1x00/bcsr.h b/arch/mips/include/asm/mach-db1x00/bcsr.h
new file mode 100644
index 0000000..ecbe19e
--- /dev/null
+++ b/arch/mips/include/asm/mach-db1x00/bcsr.h
@@ -0,0 +1,235 @@
+/*
+ * bcsr.h -- Db1xxx/Pb1xxx Devboard CPLD registers ("BCSR") abstraction.
+ *
+ * All Alchemy development boards (except, of course, the weird PB1000)
+ * have a few registers in a CPLD with standardised layout; they mostly
+ * only differ in base address and bit meanings in the RESETS and BOARD
+ * registers.
+ *
+ * All data taken from the official AMD board documentation sheets.
+ */
+
+#ifndef _DB1XXX_BCSR_H_
+#define _DB1XXX_BCSR_H_
+
+
+/* BCSR base addresses on various boards. BCSR base 2 refers to the
+ * physical address of the first HEXLEDS register, which is usually
+ * a variable offset from the WHOAMI register.
+ */
+
+/* DB1000, DB1100, DB1500, PB1100, PB1500 */
+#define DB1000_BCSR_PHYS_ADDR	0x0E000000
+#define DB1000_BCSR_HEXLED_OFS	0x01000000
+
+#define DB1550_BCSR_PHYS_ADDR	0x0F000000
+#define DB1550_BCSR_HEXLED_OFS	0x00400000
+
+#define PB1550_BCSR_PHYS_ADDR	0x0F000000
+#define PB1550_BCSR_HEXLED_OFS	0x00800000
+
+#define DB1200_BCSR_PHYS_ADDR	0x19800000
+#define DB1200_BCSR_HEXLED_OFS	0x00400000
+
+#define PB1200_BCSR_PHYS_ADDR	0x0D800000
+#define PB1200_BCSR_HEXLED_OFS	0x00400000
+
+
+enum bcsr_id {
+	/* BCSR base 1 */
+	BCSR_WHOAMI	= 0,
+	BCSR_STATUS,
+	BCSR_SWITCHES,
+	BCSR_RESETS,
+	BCSR_PCMCIA,
+	BCSR_BOARD,
+	BCSR_LEDS,
+	BCSR_SYSTEM,
+	/* Au1200/1300 based boards */
+	BCSR_INTCLR,
+	BCSR_INTSET,
+	BCSR_MASKCLR,
+	BCSR_MASKSET,
+	BCSR_SIGSTAT,
+	BCSR_INTSTAT,
+
+	/* BCSR base 2 */
+	BCSR_HEXLEDS,
+	BCSR_RSVD1,
+	BCSR_HEXCLEAR,
+
+	BCSR_CNT,
+};
+
+/* register offsets, valid for all Db1xxx/Pb1xxx boards */
+#define BCSR_REG_WHOAMI		0x00
+#define BCSR_REG_STATUS		0x04
+#define BCSR_REG_SWITCHES	0x08
+#define BCSR_REG_RESETS		0x0c
+#define BCSR_REG_PCMCIA		0x10
+#define BCSR_REG_BOARD		0x14
+#define BCSR_REG_LEDS		0x18
+#define BCSR_REG_SYSTEM		0x1c
+/* Au1200/Au1300 based boards: CPLD IRQ muxer */
+#define BCSR_REG_INTCLR		0x20
+#define BCSR_REG_INTSET		0x24
+#define BCSR_REG_MASKCLR	0x28
+#define BCSR_REG_MASKSET	0x2c
+#define BCSR_REG_SIGSTAT	0x30
+#define BCSR_REG_INTSTAT	0x34
+
+/* hexled control, offset from BCSR base 2 */
+#define BCSR_REG_HEXLEDS	0x00
+#define BCSR_REG_HEXCLEAR	0x08
+
+/*
+ * Register Bits and Pieces.
+ */
+#define BCSR_WHOAMI_DCID(x)		((x) & 0xf)
+#define BCSR_WHOAMI_CPLD(x)		(((x) >> 4) & 0xf)
+#define BCSR_WHOAMI_BOARD(x)		(((x) >> 8) & 0xf)
+
+/* register "WHOAMI" bits 11:8 identify the board */
+enum bcsr_whoami_boards {
+	BCSR_WHOAMI_PB1500 = 1,
+	BCSR_WHOAMI_PB1500R2,
+	BCSR_WHOAMI_PB1100,
+	BCSR_WHOAMI_DB1000,
+	BCSR_WHOAMI_DB1100,
+	BCSR_WHOAMI_DB1500,
+	BCSR_WHOAMI_DB1550,
+	BCSR_WHOAMI_PB1550_DDR,
+	BCSR_WHOAMI_PB1550 = BCSR_WHOAMI_PB1550_DDR,
+	BCSR_WHOAMI_PB1550_SDR,
+	BCSR_WHOAMI_PB1200_DDR1,
+	BCSR_WHOAMI_PB1200 = BCSR_WHOAMI_PB1200_DDR1,
+	BCSR_WHOAMI_PB1200_DDR2,
+	BCSR_WHOAMI_DB1200,
+};
+
+/* STATUS reg.  Unless otherwise noted, they're valid on all boards.
+ * PB1200 = DB1200.
+ */
+#define BCSR_STATUS_PC0VS		0x0003
+#define BCSR_STATUS_PC1VS		0x000C
+#define BCSR_STATUS_PC0FI		0x0010
+#define BCSR_STATUS_PC1FI		0x0020
+#define BCSR_STATUS_PB1550_SWAPBOOT	0x0040
+#define BCSR_STATUS_SRAMWIDTH		0x0080
+#define BCSR_STATUS_FLASHBUSY		0x0100
+#define BCSR_STATUS_ROMBUSY		0x0400
+#define BCSR_STATUS_SD0WP		0x0400	/* DB1200 */
+#define BCSR_STATUS_SD1WP		0x0800
+#define BCSR_STATUS_USBOTGID		0x0800	/* PB/DB1550 */
+#define BCSR_STATUS_DB1000_SWAPBOOT	0x2000
+#define BCSR_STATUS_DB1200_SWAPBOOT	0x0040	/* DB1200 */
+#define BCSR_STATUS_IDECBLID		0x0200	/* DB1200 */
+#define BCSR_STATUS_DB1200_U0RXD	0x1000	/* DB1200 */
+#define BCSR_STATUS_DB1200_U1RXD	0x2000	/* DB1200 */
+#define BCSR_STATUS_FLASHDEN		0xC000
+#define BCSR_STATUS_DB1550_U0RXD	0x1000	/* DB1550 */
+#define BCSR_STATUS_DB1550_U3RXD	0x2000	/* DB1550 */
+#define BCSR_STATUS_PB1550_U0RXD	0x1000	/* PB1550 */
+#define BCSR_STATUS_PB1550_U1RXD	0x2000	/* PB1550 */
+#define BCSR_STATUS_PB1550_U3RXD	0x8000	/* PB1550 */
+
+
+/* DB/PB1000,1100,1500,1550 */
+#define BCSR_RESETS_PHY0		0x0001
+#define BCSR_RESETS_PHY1		0x0002
+#define BCSR_RESETS_DC			0x0004
+#define BCSR_RESETS_FIR_SEL		0x2000
+#define BCSR_RESETS_IRDA_MODE_MASK	0xC000
+#define BCSR_RESETS_IRDA_MODE_FULL	0x0000
+#define BCSR_RESETS_PB1550_WSCFSM	0x2000
+#define BCSR_RESETS_IRDA_MODE_OFF	0x4000
+#define BCSR_RESETS_IRDA_MODE_2_3	0x8000
+#define BCSR_RESETS_IRDA_MODE_1_3	0xC000
+#define BCSR_RESETS_DMAREQ		0x8000	/* PB1550 */
+
+#define BCSR_BOARD_PCIM66EN		0x0001
+#define BCSR_BOARD_SD0PWR		0x0040
+#define BCSR_BOARD_SD1PWR		0x0080
+#define BCSR_BOARD_PCIM33		0x0100
+#define BCSR_BOARD_PCIEXTARB		0x0200
+#define BCSR_BOARD_GPIO200RST		0x0400
+#define BCSR_BOARD_PCICLKOUT		0x0800
+#define BCSR_BOARD_PCICFG		0x1000
+#define BCSR_BOARD_SPISEL		0x4000	/* PB/DB1550 */
+#define BCSR_BOARD_SD0WP		0x4000	/* DB1100 */
+#define BCSR_BOARD_SD1WP		0x8000	/* DB1100 */
+
+
+/* DB/PB1200 */
+#define BCSR_RESETS_ETH			0x0001
+#define BCSR_RESETS_CAMERA		0x0002
+#define BCSR_RESETS_DC			0x0004
+#define BCSR_RESETS_IDE			0x0008
+#define BCSR_RESETS_TV			0x0010	/* DB1200 */
+/* Not resets but in the same register */
+#define BCSR_RESETS_PWMR1MUX		0x0800	/* DB1200 */
+#define BCSR_RESETS_PB1200_WSCFSM	0x0800	/* PB1200 */
+#define BCSR_RESETS_PSC0MUX		0x1000
+#define BCSR_RESETS_PSC1MUX		0x2000
+#define BCSR_RESETS_SPISEL		0x4000
+#define BCSR_RESETS_SD1MUX		0x8000	/* PB1200 */
+
+#define BCSR_BOARD_LCDVEE		0x0001
+#define BCSR_BOARD_LCDVDD		0x0002
+#define BCSR_BOARD_LCDBL		0x0004
+#define BCSR_BOARD_CAMSNAP		0x0010
+#define BCSR_BOARD_CAMPWR		0x0020
+#define BCSR_BOARD_SD0PWR		0x0040
+
+
+#define BCSR_SWITCHES_DIP		0x00FF
+#define BCSR_SWITCHES_DIP_1		0x0080
+#define BCSR_SWITCHES_DIP_2		0x0040
+#define BCSR_SWITCHES_DIP_3		0x0020
+#define BCSR_SWITCHES_DIP_4		0x0010
+#define BCSR_SWITCHES_DIP_5		0x0008
+#define BCSR_SWITCHES_DIP_6		0x0004
+#define BCSR_SWITCHES_DIP_7		0x0002
+#define BCSR_SWITCHES_DIP_8		0x0001
+#define BCSR_SWITCHES_ROTARY		0x0F00
+
+
+#define BCSR_PCMCIA_PC0VPP		0x0003
+#define BCSR_PCMCIA_PC0VCC		0x000C
+#define BCSR_PCMCIA_PC0DRVEN		0x0010
+#define BCSR_PCMCIA_PC0RST		0x0080
+#define BCSR_PCMCIA_PC1VPP		0x0300
+#define BCSR_PCMCIA_PC1VCC		0x0C00
+#define BCSR_PCMCIA_PC1DRVEN		0x1000
+#define BCSR_PCMCIA_PC1RST		0x8000
+
+
+#define BCSR_LEDS_DECIMALS		0x0003
+#define BCSR_LEDS_LED0			0x0100
+#define BCSR_LEDS_LED1			0x0200
+#define BCSR_LEDS_LED2			0x0400
+#define BCSR_LEDS_LED3			0x0800
+
+
+#define BCSR_SYSTEM_RESET		0x8000	/* clear to reset */
+#define BCSR_SYSTEM_PWROFF		0x4000	/* set to power off */
+#define BCSR_SYSTEM_VDDI		0x001F	/* PB1xxx boards */
+
+
+
+
+/* initialize BCSR for a board. Provide the PHYSICAL addresses of both
+ * BCSR spaces.
+ */
+void __init bcsr_init(unsigned long bcsr1_phys, unsigned long bcsr2_phys);
+
+/* read a board register */
+unsigned short bcsr_read(enum bcsr_id reg);
+
+/* write to a board register */
+void bcsr_write(enum bcsr_id reg, unsigned short val);
+
+/* modify a register. clear bits set in 'clr', set bits set in 'set' */
+void bcsr_mod(enum bcsr_id reg, unsigned short clr, unsigned short set);
+
+#endif
diff --git a/arch/mips/include/asm/mach-db1x00/db1200.h b/arch/mips/include/asm/mach-db1x00/db1200.h
index 27f2610..2909b83 100644
--- a/arch/mips/include/asm/mach-db1x00/db1200.h
+++ b/arch/mips/include/asm/mach-db1x00/db1200.h
@@ -45,113 +45,6 @@
 #define AC97_PSC_BASE		PSC1_BASE_ADDR
 #define I2S_PSC_BASE		PSC1_BASE_ADDR
 
-#define BCSR_KSEG1_ADDR 	0xB9800000
-
-typedef volatile struct
-{
-	/*00*/	u16 whoami;
-		u16 reserved0;
-	/*04*/	u16 status;
-		u16 reserved1;
-	/*08*/	u16 switches;
-		u16 reserved2;
-	/*0C*/	u16 resets;
-		u16 reserved3;
-
-	/*10*/	u16 pcmcia;
-		u16 reserved4;
-	/*14*/	u16 board;
-		u16 reserved5;
-	/*18*/	u16 disk_leds;
-		u16 reserved6;
-	/*1C*/	u16 system;
-		u16 reserved7;
-
-	/*20*/	u16 intclr;
-		u16 reserved8;
-	/*24*/	u16 intset;
-		u16 reserved9;
-	/*28*/	u16 intclr_mask;
-		u16 reserved10;
-	/*2C*/	u16 intset_mask;
-		u16 reserved11;
-
-	/*30*/	u16 sig_status;
-		u16 reserved12;
-	/*34*/	u16 int_status;
-		u16 reserved13;
-	/*38*/	u16 reserved14;
-		u16 reserved15;
-	/*3C*/	u16 reserved16;
-		u16 reserved17;
-
-} BCSR;
-
-static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
-
-/*
- * Register bit definitions for the BCSRs
- */
-#define BCSR_WHOAMI_DCID	0x000F
-#define BCSR_WHOAMI_CPLD	0x00F0
-#define BCSR_WHOAMI_BOARD	0x0F00
-
-#define BCSR_STATUS_PCMCIA0VS	0x0003
-#define BCSR_STATUS_PCMCIA1VS	0x000C
-#define BCSR_STATUS_SWAPBOOT	0x0040
-#define BCSR_STATUS_FLASHBUSY	0x0100
-#define BCSR_STATUS_IDECBLID	0x0200
-#define BCSR_STATUS_SD0WP	0x0400
-#define BCSR_STATUS_U0RXD	0x1000
-#define BCSR_STATUS_U1RXD	0x2000
-
-#define BCSR_SWITCHES_OCTAL	0x00FF
-#define BCSR_SWITCHES_DIP_1	0x0080
-#define BCSR_SWITCHES_DIP_2	0x0040
-#define BCSR_SWITCHES_DIP_3	0x0020
-#define BCSR_SWITCHES_DIP_4	0x0010
-#define BCSR_SWITCHES_DIP_5	0x0008
-#define BCSR_SWITCHES_DIP_6	0x0004
-#define BCSR_SWITCHES_DIP_7	0x0002
-#define BCSR_SWITCHES_DIP_8	0x0001
-#define BCSR_SWITCHES_ROTARY	0x0F00
-
-#define BCSR_RESETS_ETH		0x0001
-#define BCSR_RESETS_CAMERA	0x0002
-#define BCSR_RESETS_DC		0x0004
-#define BCSR_RESETS_IDE		0x0008
-#define BCSR_RESETS_TV		0x0010
-/* Not resets but in the same register */
-#define BCSR_RESETS_PWMR1MUX	0x0800
-#define BCSR_RESETS_PCS0MUX	0x1000
-#define BCSR_RESETS_PCS1MUX	0x2000
-#define BCSR_RESETS_SPISEL	0x4000
-
-#define BCSR_PCMCIA_PC0VPP	0x0003
-#define BCSR_PCMCIA_PC0VCC	0x000C
-#define BCSR_PCMCIA_PC0DRVEN	0x0010
-#define BCSR_PCMCIA_PC0RST	0x0080
-#define BCSR_PCMCIA_PC1VPP	0x0300
-#define BCSR_PCMCIA_PC1VCC	0x0C00
-#define BCSR_PCMCIA_PC1DRVEN	0x1000
-#define BCSR_PCMCIA_PC1RST	0x8000
-
-#define BCSR_BOARD_LCDVEE	0x0001
-#define BCSR_BOARD_LCDVDD	0x0002
-#define BCSR_BOARD_LCDBL	0x0004
-#define BCSR_BOARD_CAMSNAP	0x0010
-#define BCSR_BOARD_CAMPWR	0x0020
-#define BCSR_BOARD_SD0PWR	0x0040
-
-#define BCSR_LEDS_DECIMALS	0x0003
-#define BCSR_LEDS_LED0		0x0100
-#define BCSR_LEDS_LED1		0x0200
-#define BCSR_LEDS_LED2		0x0400
-#define BCSR_LEDS_LED3		0x0800
-
-#define BCSR_SYSTEM_POWEROFF	0x4000
-#define BCSR_SYSTEM_RESET	0x8000
-
 /* Bit positions for the different interrupt sources */
 #define BCSR_INT_IDE		0x0001
 #define BCSR_INT_ETH		0x0002
@@ -222,7 +115,7 @@ enum external_pb1200_ints {
 
 #define BOARD_PC0_INT	DB1200_PC0_INT
 #define BOARD_PC1_INT	DB1200_PC1_INT
-#define BOARD_CARD_INSERTED(SOCKET) bcsr->sig_status & (1 << (8 + (2 * SOCKET)))
+#define BOARD_CARD_INSERTED(SOCKET) (bcsr_read(BCSR_SIGSTAT) & (1 << (8 + (2 * SOCKET))))
 
 /* NAND chip select */
 #define NAND_CS 1
diff --git a/arch/mips/include/asm/mach-db1x00/db1x00.h b/arch/mips/include/asm/mach-db1x00/db1x00.h
index 1a515b8..cfa6429 100644
--- a/arch/mips/include/asm/mach-db1x00/db1x00.h
+++ b/arch/mips/include/asm/mach-db1x00/db1x00.h
@@ -41,102 +41,10 @@
 #define SMBUS_PSC_BASE		PSC2_BASE_ADDR
 #define I2S_PSC_BASE		PSC3_BASE_ADDR
 
-#define BCSR_KSEG1_ADDR 	0xAF000000
 #define NAND_PHYS_ADDR		0x20000000
 
-#else
-#define BCSR_KSEG1_ADDR 0xAE000000
 #endif
 
-/*
- * Overlay data structure of the DBAu1x00 board registers.
- * Registers are located at physical 0E0000xx, KSEG1 0xAE0000xx.
- */
-typedef volatile struct
-{
-	/*00*/	unsigned short whoami;
-	unsigned short reserved0;
-	/*04*/	unsigned short status;
-	unsigned short reserved1;
-	/*08*/	unsigned short switches;
-	unsigned short reserved2;
-	/*0C*/	unsigned short resets;
-	unsigned short reserved3;
-	/*10*/	unsigned short pcmcia;
-	unsigned short reserved4;
-	/*14*/	unsigned short specific;
-	unsigned short reserved5;
-	/*18*/	unsigned short leds;
-	unsigned short reserved6;
-	/*1C*/	unsigned short swreset;
-	unsigned short reserved7;
-
-} BCSR;
-
-
-/*
- * Register/mask bit definitions for the BCSRs
- */
-#define BCSR_WHOAMI_DCID		0x000F
-#define BCSR_WHOAMI_CPLD		0x00F0
-#define BCSR_WHOAMI_BOARD		0x0F00
-
-#define BCSR_STATUS_PC0VS		0x0003
-#define BCSR_STATUS_PC1VS		0x000C
-#define BCSR_STATUS_PC0FI		0x0010
-#define BCSR_STATUS_PC1FI		0x0020
-#define BCSR_STATUS_FLASHBUSY		0x0100
-#define BCSR_STATUS_ROMBUSY		0x0400
-#define BCSR_STATUS_SWAPBOOT		0x2000
-#define BCSR_STATUS_FLASHDEN		0xC000
-
-#define BCSR_SWITCHES_DIP		0x00FF
-#define BCSR_SWITCHES_DIP_1		0x0080
-#define BCSR_SWITCHES_DIP_2		0x0040
-#define BCSR_SWITCHES_DIP_3		0x0020
-#define BCSR_SWITCHES_DIP_4		0x0010
-#define BCSR_SWITCHES_DIP_5		0x0008
-#define BCSR_SWITCHES_DIP_6		0x0004
-#define BCSR_SWITCHES_DIP_7		0x0002
-#define BCSR_SWITCHES_DIP_8		0x0001
-#define BCSR_SWITCHES_ROTARY		0x0F00
-
-#define BCSR_RESETS_PHY0		0x0001
-#define BCSR_RESETS_PHY1		0x0002
-#define BCSR_RESETS_DC			0x0004
-#define BCSR_RESETS_FIR_SEL		0x2000
-#define BCSR_RESETS_IRDA_MODE_MASK	0xC000
-#define BCSR_RESETS_IRDA_MODE_FULL	0x0000
-#define BCSR_RESETS_IRDA_MODE_OFF	0x4000
-#define BCSR_RESETS_IRDA_MODE_2_3	0x8000
-#define BCSR_RESETS_IRDA_MODE_1_3	0xC000
-
-#define BCSR_PCMCIA_PC0VPP		0x0003
-#define BCSR_PCMCIA_PC0VCC		0x000C
-#define BCSR_PCMCIA_PC0DRVEN		0x0010
-#define BCSR_PCMCIA_PC0RST		0x0080
-#define BCSR_PCMCIA_PC1VPP		0x0300
-#define BCSR_PCMCIA_PC1VCC		0x0C00
-#define BCSR_PCMCIA_PC1DRVEN		0x1000
-#define BCSR_PCMCIA_PC1RST		0x8000
-
-#define BCSR_BOARD_PCIM66EN		0x0001
-#define BCSR_BOARD_SD0_PWR		0x0040
-#define BCSR_BOARD_SD1_PWR		0x0080
-#define BCSR_BOARD_PCIM33		0x0100
-#define BCSR_BOARD_GPIO200RST		0x0400
-#define BCSR_BOARD_PCICFG		0x1000
-#define BCSR_BOARD_SD0_WP		0x4000
-#define BCSR_BOARD_SD1_WP		0x8000
-
-#define BCSR_LEDS_DECIMALS		0x0003
-#define BCSR_LEDS_LED0			0x0100
-#define BCSR_LEDS_LED1			0x0200
-#define BCSR_LEDS_LED2			0x0400
-#define BCSR_LEDS_LED3			0x0800
-
-#define BCSR_SWRESET_RESET		0x0080
-
 /* PCMCIA DBAu1x00 specific defines */
 #define PCMCIA_MAX_SOCK  1
 #define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1100.h b/arch/mips/include/asm/mach-pb1x00/pb1100.h
index b1a60f1..f2bf73a 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1100.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1100.h
@@ -26,55 +26,6 @@
 #ifndef __ASM_PB1100_H
 #define __ASM_PB1100_H
 
-#define PB1100_IDENT		0xAE000000
-#define BOARD_STATUS_REG	0xAE000004
-#  define PB1100_ROM_SEL	(1 << 15)
-#  define PB1100_ROM_SIZ	(1 << 14)
-#  define PB1100_SWAP_BOOT	(1 << 13)
-#  define PB1100_FLASH_WP	(1 << 12)
-#  define PB1100_ROM_H_STS	(1 << 11)
-#  define PB1100_ROM_L_STS	(1 << 10)
-#  define PB1100_FLASH_H_STS	(1 << 9)
-#  define PB1100_FLASH_L_STS	(1 << 8)
-#  define PB1100_SRAM_SIZ	(1 << 7)
-#  define PB1100_TSC_BUSY	(1 << 6)
-#  define PB1100_PCMCIA_VS_MASK (3 << 4)
-#  define PB1100_RS232_CD	(1 << 3)
-#  define PB1100_RS232_CTS	(1 << 2)
-#  define PB1100_RS232_DSR	(1 << 1)
-#  define PB1100_RS232_RI	(1 << 0)
-
-#define PB1100_IRDA_RS232	0xAE00000C
-#  define PB1100_IRDA_FULL	(0 << 14)	/* full power		*/
-#  define PB1100_IRDA_SHUTDOWN	(1 << 14)
-#  define PB1100_IRDA_TT	(2 << 14)	/* 2/3 power		*/
-#  define PB1100_IRDA_OT	(3 << 14)	/* 1/3 power		*/
-#  define PB1100_IRDA_FIR	(1 << 13)
-
-#define PCMCIA_BOARD_REG	0xAE000010
-#  define PB1100_SD_WP1_RO	(1 << 15)	/* read only		*/
-#  define PB1100_SD_WP0_RO	(1 << 14)	/* read only		*/
-#  define PB1100_SD_PWR1	(1 << 11)	/* applies power to SD1 */
-#  define PB1100_SD_PWR0	(1 << 10)	/* applies power to SD0 */
-#  define PB1100_SEL_SD_CONN1	(1 << 9)
-#  define PB1100_SEL_SD_CONN0	(1 << 8)
-#  define PC_DEASSERT_RST	(1 << 7)
-#  define PC_DRV_EN		(1 << 4)
-
-#define PB1100_G_CONTROL	0xAE000014	/* graphics control	*/
-
-#define PB1100_RST_VDDI 	0xAE00001C
-#  define PB1100_SOFT_RESET	(1 << 15)	/* clear to reset the board */
-#  define PB1100_VDDI_MASK	0x1F
-
-#define PB1100_LEDS		0xAE000018
-
-/*
- * 11:8 is 4 discreet LEDs. Clearing a bit illuminates the LED.
- * 7:0  is the LED Display's decimal points.
- */
-#define PB1100_HEX_LED		0xAE000018
-
 /* PCMCIA Pb1100 specific defines */
 #define PCMCIA_MAX_SOCK  0
 #define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1200.h b/arch/mips/include/asm/mach-pb1x00/pb1200.h
index c8618df..a51512c 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1200.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1200.h
@@ -43,113 +43,8 @@
  * Refer to board documentation.
  */
 #define AC97_PSC_BASE       PSC1_BASE_ADDR
-#define I2S_PSC_BASE		PSC1_BASE_ADDR
+#define I2S_PSC_BASE	PSC1_BASE_ADDR
 
-#define BCSR_KSEG1_ADDR 0xAD800000
-
-typedef volatile struct
-{
-	/*00*/	u16 whoami;
-		u16 reserved0;
-	/*04*/	u16 status;
-		u16 reserved1;
-	/*08*/	u16 switches;
-		u16 reserved2;
-	/*0C*/	u16 resets;
-		u16 reserved3;
-
-	/*10*/	u16 pcmcia;
-		u16 reserved4;
-	/*14*/	u16 board;
-		u16 reserved5;
-	/*18*/	u16 disk_leds;
-		u16 reserved6;
-	/*1C*/	u16 system;
-		u16 reserved7;
-
-	/*20*/	u16 intclr;
-		u16 reserved8;
-	/*24*/	u16 intset;
-		u16 reserved9;
-	/*28*/	u16 intclr_mask;
-		u16 reserved10;
-	/*2C*/	u16 intset_mask;
-		u16 reserved11;
-
-	/*30*/	u16 sig_status;
-		u16 reserved12;
-	/*34*/	u16 int_status;
-		u16 reserved13;
-	/*38*/	u16 reserved14;
-		u16 reserved15;
-	/*3C*/	u16 reserved16;
-		u16 reserved17;
-
-} BCSR;
-
-static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
-
-/*
- * Register bit definitions for the BCSRs
- */
-#define BCSR_WHOAMI_DCID	0x000F
-#define BCSR_WHOAMI_CPLD	0x00F0
-#define BCSR_WHOAMI_BOARD	0x0F00
-
-#define BCSR_STATUS_PCMCIA0VS	0x0003
-#define BCSR_STATUS_PCMCIA1VS	0x000C
-#define BCSR_STATUS_SWAPBOOT	0x0040
-#define BCSR_STATUS_FLASHBUSY	0x0100
-#define BCSR_STATUS_IDECBLID	0x0200
-#define BCSR_STATUS_SD0WP	0x0400
-#define BCSR_STATUS_SD1WP	0x0800
-#define BCSR_STATUS_U0RXD	0x1000
-#define BCSR_STATUS_U1RXD	0x2000
-
-#define BCSR_SWITCHES_OCTAL	0x00FF
-#define BCSR_SWITCHES_DIP_1	0x0080
-#define BCSR_SWITCHES_DIP_2	0x0040
-#define BCSR_SWITCHES_DIP_3	0x0020
-#define BCSR_SWITCHES_DIP_4	0x0010
-#define BCSR_SWITCHES_DIP_5	0x0008
-#define BCSR_SWITCHES_DIP_6	0x0004
-#define BCSR_SWITCHES_DIP_7	0x0002
-#define BCSR_SWITCHES_DIP_8	0x0001
-#define BCSR_SWITCHES_ROTARY	0x0F00
-
-#define BCSR_RESETS_ETH		0x0001
-#define BCSR_RESETS_CAMERA	0x0002
-#define BCSR_RESETS_DC		0x0004
-#define BCSR_RESETS_IDE		0x0008
-/* not resets but in the same register */
-#define BCSR_RESETS_WSCFSM	0x0800
-#define BCSR_RESETS_PCS0MUX	0x1000
-#define BCSR_RESETS_PCS1MUX	0x2000
-#define BCSR_RESETS_SPISEL	0x4000
-#define BCSR_RESETS_SD1MUX	0x8000
-
-#define BCSR_PCMCIA_PC0VPP	0x0003
-#define BCSR_PCMCIA_PC0VCC	0x000C
-#define BCSR_PCMCIA_PC0DRVEN	0x0010
-#define BCSR_PCMCIA_PC0RST	0x0080
-#define BCSR_PCMCIA_PC1VPP	0x0300
-#define BCSR_PCMCIA_PC1VCC	0x0C00
-#define BCSR_PCMCIA_PC1DRVEN	0x1000
-#define BCSR_PCMCIA_PC1RST	0x8000
-
-#define BCSR_BOARD_LCDVEE	0x0001
-#define BCSR_BOARD_LCDVDD	0x0002
-#define BCSR_BOARD_LCDBL	0x0004
-#define BCSR_BOARD_CAMSNAP	0x0010
-#define BCSR_BOARD_CAMPWR	0x0020
-#define BCSR_BOARD_SD0PWR	0x0040
-#define BCSR_BOARD_SD1PWR	0x0080
-
-#define BCSR_LEDS_DECIMALS	0x00FF
-#define BCSR_LEDS_LED0		0x0100
-#define BCSR_LEDS_LED1		0x0200
-#define BCSR_LEDS_LED2		0x0400
-#define BCSR_LEDS_LED3		0x0800
 
 #define BCSR_SYSTEM_VDDI	0x001F
 #define BCSR_SYSTEM_POWEROFF	0x4000
@@ -251,7 +146,7 @@ enum external_pb1200_ints {
 
 #define BOARD_PC0_INT	PB1200_PC0_INT
 #define BOARD_PC1_INT	PB1200_PC1_INT
-#define BOARD_CARD_INSERTED(SOCKET) bcsr->sig_status & (1 << (8 + (2 * SOCKET)))
+#define BOARD_CARD_INSERTED(SOCKET) (bcsr_read(BCSR_SIGSTAT & (1 << (8 + (2 * SOCKET))))
 
 /* NAND chip select */
 #define NAND_CS 1
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1500.h b/arch/mips/include/asm/mach-pb1x00/pb1500.h
index da51a2e..82431a7 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1500.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1500.h
@@ -26,19 +26,6 @@
 #ifndef __ASM_PB1500_H
 #define __ASM_PB1500_H
 
-#define IDENT_BOARD_REG 	0xAE000000
-#define BOARD_STATUS_REG	0xAE000004
-#define PCI_BOARD_REG		0xAE000010
-#define PCMCIA_BOARD_REG	0xAE000010
-#  define PC_DEASSERT_RST	      0x80
-#  define PC_DRV_EN		      0x10
-#define PB1500_G_CONTROL	0xAE000014
-#define PB1500_RST_VDDI 	0xAE00001C
-#define PB1500_LEDS		0xAE000018
-
-#define PB1500_HEX_LED		0xAF000004
-#define PB1500_HEX_LED_BLANK	0xAF000008
-
 /* PCMCIA Pb1500 specific defines */
 #define PCMCIA_MAX_SOCK  0
 #define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1550.h b/arch/mips/include/asm/mach-pb1x00/pb1550.h
index 6704a11..306d584 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1550.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1550.h
@@ -40,95 +40,6 @@
 #define SMBUS_PSC_BASE		PSC2_BASE_ADDR
 #define I2S_PSC_BASE		PSC3_BASE_ADDR
 
-#define BCSR_PHYS_ADDR 0xAF000000
-
-typedef volatile struct
-{
-	/*00*/	u16 whoami;
-		u16 reserved0;
-	/*04*/	u16 status;
-		u16 reserved1;
-	/*08*/	u16 switches;
-		u16 reserved2;
-	/*0C*/	u16 resets;
-		u16 reserved3;
-	/*10*/	u16 pcmcia;
-		u16 reserved4;
-	/*14*/	u16 pci;
-		u16 reserved5;
-	/*18*/	u16 leds;
-		u16 reserved6;
-	/*1C*/	u16 system;
-		u16 reserved7;
-
-} BCSR;
-
-static BCSR * const bcsr = (BCSR *)BCSR_PHYS_ADDR;
-
-/*
- * Register bit definitions for the BCSRs
- */
-#define BCSR_WHOAMI_DCID	0x000F
-#define BCSR_WHOAMI_CPLD	0x00F0
-#define BCSR_WHOAMI_BOARD	0x0F00
-
-#define BCSR_STATUS_PCMCIA0VS	0x0003
-#define BCSR_STATUS_PCMCIA1VS	0x000C
-#define BCSR_STATUS_PCMCIA0FI	0x0010
-#define BCSR_STATUS_PCMCIA1FI	0x0020
-#define BCSR_STATUS_SWAPBOOT	0x0040
-#define BCSR_STATUS_SRAMWIDTH	0x0080
-#define BCSR_STATUS_FLASHBUSY	0x0100
-#define BCSR_STATUS_ROMBUSY	0x0200
-#define BCSR_STATUS_USBOTGID	0x0800
-#define BCSR_STATUS_U0RXD	0x1000
-#define BCSR_STATUS_U1RXD	0x2000
-#define BCSR_STATUS_U3RXD	0x8000
-
-#define BCSR_SWITCHES_OCTAL	0x00FF
-#define BCSR_SWITCHES_DIP_1	0x0080
-#define BCSR_SWITCHES_DIP_2	0x0040
-#define BCSR_SWITCHES_DIP_3	0x0020
-#define BCSR_SWITCHES_DIP_4	0x0010
-#define BCSR_SWITCHES_DIP_5	0x0008
-#define BCSR_SWITCHES_DIP_6	0x0004
-#define BCSR_SWITCHES_DIP_7	0x0002
-#define BCSR_SWITCHES_DIP_8	0x0001
-#define BCSR_SWITCHES_ROTARY	0x0F00
-
-#define BCSR_RESETS_PHY0	0x0001
-#define BCSR_RESETS_PHY1	0x0002
-#define BCSR_RESETS_DC		0x0004
-#define BCSR_RESETS_WSC		0x2000
-#define BCSR_RESETS_SPISEL	0x4000
-#define BCSR_RESETS_DMAREQ	0x8000
-
-#define BCSR_PCMCIA_PC0VPP	0x0003
-#define BCSR_PCMCIA_PC0VCC	0x000C
-#define BCSR_PCMCIA_PC0DRVEN	0x0010
-#define BCSR_PCMCIA_PC0RST	0x0080
-#define BCSR_PCMCIA_PC1VPP	0x0300
-#define BCSR_PCMCIA_PC1VCC	0x0C00
-#define BCSR_PCMCIA_PC1DRVEN	0x1000
-#define BCSR_PCMCIA_PC1RST	0x8000
-
-#define BCSR_PCI_M66EN		0x0001
-#define BCSR_PCI_M33		0x0100
-#define BCSR_PCI_EXTERNARB	0x0200
-#define BCSR_PCI_GPIO200RST	0x0400
-#define BCSR_PCI_CLKOUT		0x0800
-#define BCSR_PCI_CFGHOST	0x1000
-
-#define BCSR_LEDS_DECIMALS	0x00FF
-#define BCSR_LEDS_LED0		0x0100
-#define BCSR_LEDS_LED1		0x0200
-#define BCSR_LEDS_LED2		0x0400
-#define BCSR_LEDS_LED3		0x0800
-
-#define BCSR_SYSTEM_VDDI	0x001F
-#define BCSR_SYSTEM_POWEROFF	0x4000
-#define BCSR_SYSTEM_RESET	0x8000
-
 #define PCMCIA_MAX_SOCK  1
 #define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
 
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index 92c334f..43d46e4 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-db1x00/bcsr.h>
 
 /*
  * MTD structure for NAND controller
@@ -475,7 +476,8 @@ static int __init au1xxx_nand_init(void)
 	/* set gpio206 high */
 	au_writel(au_readl(GPIO2_DIR) & ~(1 << 6), GPIO2_DIR);
 
-	boot_swapboot = (au_readl(MEM_STSTAT) & (0x7 << 1)) | ((bcsr->status >> 6) & 0x1);
+	boot_swapboot = (au_readl(MEM_STSTAT) & (0x7 << 1)) | ((bcsr_read(BCSR_STATUS) >> 6) & 0x1);
+
 	switch (boot_swapboot) {
 	case 0:
 	case 2:
diff --git a/drivers/net/irda/au1k_ir.c b/drivers/net/irda/au1k_ir.c
index eb42468..955f04e 100644
--- a/drivers/net/irda/au1k_ir.c
+++ b/drivers/net/irda/au1k_ir.c
@@ -36,6 +36,7 @@
 #include <asm/pb1000.h>
 #elif defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
 #include <asm/db1x00.h>
+#include <asm/mach-db1x00/bcsr.h>
 #else 
 #error au1k_ir: unsupported board
 #endif
@@ -66,10 +67,6 @@ static char version[] __devinitdata =
 
 #define RUN_AT(x) (jiffies + (x))
 
-#if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
-static BCSR * const bcsr = (BCSR *)0xAE000000;
-#endif
-
 static DEFINE_SPINLOCK(ir_lock);
 
 /*
@@ -282,9 +279,8 @@ static int au1k_irda_net_init(struct net_device *dev)
 
 #if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
 	/* power on */
-	bcsr->resets &= ~BCSR_RESETS_IRDA_MODE_MASK;
-	bcsr->resets |= BCSR_RESETS_IRDA_MODE_FULL;
-	au_sync();
+	bcsr_mod(BCSR_RESETS, BCSR_RESETS_IRDA_MODE_MASK,
+			      BCSR_RESETS_IRDA_MODE_FULL);
 #endif
 
 	return 0;
@@ -720,14 +716,14 @@ au1k_irda_set_speed(struct net_device *dev, int speed)
 
 	if (speed == 4000000) {
 #if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
-		bcsr->resets |= BCSR_RESETS_FIR_SEL;
+		bcsr_mod(BCSR_RESETS, 0, BCSR_RESETS_FIR_SEL);
 #else /* Pb1000 and Pb1100 */
 		writel(1<<13, CPLD_AUX1);
 #endif
 	}
 	else {
 #if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
-		bcsr->resets &= ~BCSR_RESETS_FIR_SEL;
+		bcsr_mod(BCSR_RESETS, BCSR_RESETS_FIR_SEL, 0);
 #else /* Pb1000 and Pb1100 */
 		writel(readl(CPLD_AUX1) & ~(1<<13), CPLD_AUX1);
 #endif
diff --git a/drivers/pcmcia/au1000_db1x00.c b/drivers/pcmcia/au1000_db1x00.c
index c78d77f..3fdd664 100644
--- a/drivers/pcmcia/au1000_db1x00.c
+++ b/drivers/pcmcia/au1000_db1x00.c
@@ -47,9 +47,9 @@
 	#include <pb1200.h>
 #else
 	#include <asm/mach-db1x00/db1x00.h>
-	static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
 #endif
 
+#include <asm/mach-db1x00/bcsr.h>
 #include "au1000_generic.h"
 
 #if 0
@@ -76,8 +76,8 @@ static int db1x00_pcmcia_hw_init(struct au1000_pcmcia_socket *skt)
 
 static void db1x00_pcmcia_shutdown(struct au1000_pcmcia_socket *skt)
 {
-	bcsr->pcmcia = 0; /* turn off power */
-	au_sync_delay(2);
+	bcsr_write(BCSR_PCMCIA, 0);	/* turn off power */
+	msleep(2);
 }
 
 static void
@@ -93,19 +93,19 @@ db1x00_pcmcia_socket_state(struct au1000_pcmcia_socket *skt, struct pcmcia_state
 
 	switch (skt->nr) {
 	case 0:
-		vs = bcsr->status & 0x3;
+		vs = bcsr_read(BCSR_STATUS) & 0x3;
 #if defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200)
 		inserted = BOARD_CARD_INSERTED(0);
 #else
-		inserted = !(bcsr->status & (1<<4));
+		inserted = !(bcsr_read(BCSR_STATUS) & (1 << 4));
 #endif
 		break;
 	case 1:
-		vs = (bcsr->status & 0xC)>>2;
+		vs = (bcsr_read(BCSR_STATUS) & 0xC) >> 2;
 #if defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200)
 		inserted = BOARD_CARD_INSERTED(1);
 #else
-		inserted = !(bcsr->status & (1<<5));
+		inserted = !(bcsr_read(BCSR_STATUS) & (1<<5));
 #endif
 		break;
 	default:/* should never happen */
@@ -114,7 +114,7 @@ db1x00_pcmcia_socket_state(struct au1000_pcmcia_socket *skt, struct pcmcia_state
 
 	if (inserted)
 		debug("db1x00 socket %d: inserted %d, vs %d pcmcia %x\n",
-				skt->nr, inserted, vs, bcsr->pcmcia);
+				skt->nr, inserted, vs, bcsr_read(BCSR_PCMCIA));
 
 	if (inserted) {
 		switch (vs) {
@@ -136,19 +136,21 @@ db1x00_pcmcia_socket_state(struct au1000_pcmcia_socket *skt, struct pcmcia_state
 		/* if the card was previously inserted and then ejected,
 		 * we should turn off power to it
 		 */
-		if ((skt->nr == 0) && (bcsr->pcmcia & BCSR_PCMCIA_PC0RST)) {
-			bcsr->pcmcia &= ~(BCSR_PCMCIA_PC0RST |
-					BCSR_PCMCIA_PC0DRVEN |
-					BCSR_PCMCIA_PC0VPP |
-					BCSR_PCMCIA_PC0VCC);
-			au_sync_delay(10);
+		if ((skt->nr == 0) &&
+		    (bcsr_read(BCSR_PCMCIA) & BCSR_PCMCIA_PC0RST)) {
+			bcsr_mod(BCSR_PCMCIA, BCSR_PCMCIA_PC0RST   |
+					      BCSR_PCMCIA_PC0DRVEN |
+					      BCSR_PCMCIA_PC0VPP   |
+					      BCSR_PCMCIA_PC0VCC, 0);
+			msleep(10);
 		}
-		else if ((skt->nr == 1) && bcsr->pcmcia & BCSR_PCMCIA_PC1RST) {
-			bcsr->pcmcia &= ~(BCSR_PCMCIA_PC1RST |
-					BCSR_PCMCIA_PC1DRVEN |
-					BCSR_PCMCIA_PC1VPP |
-					BCSR_PCMCIA_PC1VCC);
-			au_sync_delay(10);
+		else if ((skt->nr == 1) &&
+			 (bcsr_read(BCSR_PCMCIA) & BCSR_PCMCIA_PC1RST)) {
+			bcsr_mod(BCSR_PCMCIA, BCSR_PCMCIA_PC1RST   |
+					      BCSR_PCMCIA_PC1DRVEN |
+					      BCSR_PCMCIA_PC1VPP   |
+					      BCSR_PCMCIA_PC1VCC, 0);
+			msleep(10);
 		}
 	}
 
@@ -171,7 +173,7 @@ db1x00_pcmcia_configure_socket(struct au1000_pcmcia_socket *skt, struct socket_s
 	 * initializing a socket not to wipe out the settings of the
 	 * other socket.
 	 */
-	pwr = bcsr->pcmcia;
+	pwr = bcsr_read(BCSR_PCMCIA);
 	pwr &= ~(0xf << sock*8); /* clear voltage settings */
 
 	state->Vpp = 0;
@@ -228,37 +230,37 @@ db1x00_pcmcia_configure_socket(struct au1000_pcmcia_socket *skt, struct socket_s
 			break;
 	}
 
-	bcsr->pcmcia = pwr;
-	au_sync_delay(300);
+	bcsr_write(BCSR_PCMCIA, pwr);
+	msleep(300);
 
 	if (sock == 0) {
 		if (!(state->flags & SS_RESET)) {
 			pwr |= BCSR_PCMCIA_PC0DRVEN;
-			bcsr->pcmcia = pwr;
-			au_sync_delay(300);
+			bcsr_write(BCSR_PCMCIA, pwr);
+			msleep(300);
 			pwr |= BCSR_PCMCIA_PC0RST;
-			bcsr->pcmcia = pwr;
-			au_sync_delay(100);
+			bcsr_write(BCSR_PCMCIA, pwr);
+			msleep(100);
 		}
 		else {
 			pwr &= ~(BCSR_PCMCIA_PC0RST | BCSR_PCMCIA_PC0DRVEN);
-			bcsr->pcmcia = pwr;
-			au_sync_delay(100);
+			bcsr_write(BCSR_PCMCIA, pwr);
+			msleep(100);
 		}
 	}
 	else {
 		if (!(state->flags & SS_RESET)) {
 			pwr |= BCSR_PCMCIA_PC1DRVEN;
-			bcsr->pcmcia = pwr;
-			au_sync_delay(300);
+			bcsr_write(BCSR_PCMCIA, pwr);
+			msleep(300);
 			pwr |= BCSR_PCMCIA_PC1RST;
-			bcsr->pcmcia = pwr;
-			au_sync_delay(100);
+			bcsr_write(BCSR_PCMCIA, pwr);
+			msleep(100);
 		}
 		else {
 			pwr &= ~(BCSR_PCMCIA_PC1RST | BCSR_PCMCIA_PC1DRVEN);
-			bcsr->pcmcia = pwr;
-			au_sync_delay(100);
+			bcsr_write(BCSR_PCMCIA, pwr);
+			msleep(100);
 		}
 	}
 	return 0;
@@ -298,8 +300,8 @@ struct pcmcia_low_level db1x00_pcmcia_ops = {
 int au1x_board_init(struct device *dev)
 {
 	int ret = -ENODEV;
-	bcsr->pcmcia = 0; /* turn off power, if it's not already off */
-	au_sync_delay(2);
+	bcsr_write(BCSR_PCMCIA, 0); /* turn off power, if it's not already off */
+	msleep(2);
 	ret = au1x00_pcmcia_socket_probe(dev, &db1x00_pcmcia_ops, 0, 2);
 	return ret;
 }
-- 
1.6.5.rc2
