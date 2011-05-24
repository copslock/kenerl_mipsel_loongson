Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 20:59:41 +0200 (CEST)
Received: from ogre.sisk.pl ([217.79.144.158]:53091 "EHLO ogre.sisk.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491178Ab1EXS7d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 May 2011 20:59:33 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by ogre.sisk.pl (Postfix) with ESMTP id 0593D1AEE09;
        Tue, 24 May 2011 20:48:04 +0200 (CEST)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24670-10; Tue, 24 May 2011 20:47:46 +0200 (CEST)
Received: from ferrari.rjw.lan (220-bem-13.acn.waw.pl [82.210.184.220])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ogre.sisk.pl (Postfix) with ESMTP id 117FF1AED37;
        Tue, 24 May 2011 20:47:46 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@sisk.pl>
To:     wanlong.gao@gmail.com
Subject: Re: [PATCH] MIPS:i8259.c remove resume and shutdown to syscore_ops
Date:   Tue, 24 May 2011 20:59:59 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.39+; KDE/4.6.0; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Pengfei Zhang <zoppof.zhang@gmail.com>,
        Linux PM mailing list <linux-pm@lists.linux-foundation.org>
References: <1306247112.2066.8.camel@Tux>
In-Reply-To: <1306247112.2066.8.camel@Tux>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201105242059.59770.rjw@sisk.pl>
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
Return-Path: <rjw@sisk.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@sisk.pl
Precedence: bulk
X-list: linux-mips

On Tuesday, May 24, 2011, Wanlong Gao wrote:
> 
> > On Tue, May 24, 2011 at 08:19:18PM +0800, Pengfei Zhang wrote:
> > 
> > > Remove the resume and shutdown of i8259A from the sysdev_class
> > > to the syscore_ops since these members had removed from the
> > > structure sysdev_class.
> > 
> > I don't see why one would want to want to first call
> > register_syscore_ops
> > then sysdev_class_register and sysdev_register?
> > 
> Hi Ralf:
> If these not moved to syscore_ops, building will get error.
> 
> Hi Thomas:
> Does you mean that we can just remove the sysfs entry now ?

I had the appended patch in my tree before the merge window started,
but it conflicted with analogous changes in the MIPS tree, so I had
dropped it.  Was it a mistake?

Rafael


---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM / MIPS: Use struct syscore_ops instead of sysdevs for PM (v2)

Convert some MIPS architecture's code to using struct syscore_ops
objects for power management instead of sysdev classes and sysdevs.

This simplifies the code and reduces the kernel's memory footprint.
It also is necessary for removing sysdevs from the kernel entirely in
the future.

This change includes a build fix from Ralf Baechle.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Acked-and-tested-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/alchemy/common/dbdma.c |   92 +++++++++++----------------------------
 arch/mips/alchemy/common/irq.c   |   62 +++++++++-----------------
 arch/mips/jz4740/gpio.c          |   52 +++++++++-------------
 arch/mips/kernel/i8259.c         |   26 +++--------
 4 files changed, 80 insertions(+), 152 deletions(-)

Index: linux-2.6/arch/mips/alchemy/common/irq.c
===================================================================
--- linux-2.6.orig/arch/mips/alchemy/common/irq.c
+++ linux-2.6/arch/mips/alchemy/common/irq.c
@@ -30,7 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
@@ -556,17 +556,15 @@ void __init arch_init_irq(void)
 	}
 }
 
-struct alchemy_ic_sysdev {
-	struct sys_device sysdev;
+struct alchemy_ic {
 	void __iomem *base;
 	unsigned long pmdata[7];
 };
 
-static int alchemy_ic_suspend(struct sys_device *dev, pm_message_t state)
-{
-	struct alchemy_ic_sysdev *icdev =
-			container_of(dev, struct alchemy_ic_sysdev, sysdev);
+static struct alchemy_ic alchemy_ic_data[2];
 
+static void alchemy_suspend_one_ic(struct alchemy_ic *icdev)
+{
 	icdev->pmdata[0] = __raw_readl(icdev->base + IC_CFG0RD);
 	icdev->pmdata[1] = __raw_readl(icdev->base + IC_CFG1RD);
 	icdev->pmdata[2] = __raw_readl(icdev->base + IC_CFG2RD);
@@ -574,15 +572,17 @@ static int alchemy_ic_suspend(struct sys
 	icdev->pmdata[4] = __raw_readl(icdev->base + IC_ASSIGNRD);
 	icdev->pmdata[5] = __raw_readl(icdev->base + IC_WAKERD);
 	icdev->pmdata[6] = __raw_readl(icdev->base + IC_MASKRD);
+}
 
+static int alchemy_ic_suspend(void)
+{
+	alchemy_suspend_one_ic(alchemy_ic_data);
+	alchemy_suspend_one_ic(alchemy_ic_data + 1);
 	return 0;
 }
 
-static int alchemy_ic_resume(struct sys_device *dev)
+static void alchemy_resume_one_ic(struct alchemy_ic *icdev)
 {
-	struct alchemy_ic_sysdev *icdev =
-			container_of(dev, struct alchemy_ic_sysdev, sysdev);
-
 	__raw_writel(0xffffffff, icdev->base + IC_MASKCLR);
 	__raw_writel(0xffffffff, icdev->base + IC_CFG0CLR);
 	__raw_writel(0xffffffff, icdev->base + IC_CFG1CLR);
@@ -604,42 +604,26 @@ static int alchemy_ic_resume(struct sys_
 
 	__raw_writel(icdev->pmdata[6], icdev->base + IC_MASKSET);
 	wmb();
+}
 
-	return 0;
+static void alchemy_ic_resume(void)
+{
+	alchemy_resume_one_ic(alchemy_ic_data + 1);
+	alchemy_resume_one_ic(alchemy_ic_data);
 }
 
-static struct sysdev_class alchemy_ic_sysdev_class = {
-	.name		= "ic",
+static struct syscore_ops alchemy_ic_syscore_ops = {
 	.suspend	= alchemy_ic_suspend,
 	.resume		= alchemy_ic_resume,
 };
 
-static int __init alchemy_ic_sysdev_init(void)
+static int __init alchemy_ic_syscore_init(void)
 {
-	struct alchemy_ic_sysdev *icdev;
-	unsigned long icbase[2] = { IC0_PHYS_ADDR, IC1_PHYS_ADDR };
-	int err, i;
-
-	err = sysdev_class_register(&alchemy_ic_sysdev_class);
-	if (err)
-		return err;
-
-	for (i = 0; i < 2; i++) {
-		icdev = kzalloc(sizeof(struct alchemy_ic_sysdev), GFP_KERNEL);
-		if (!icdev)
-			return -ENOMEM;
-
-		icdev->base = ioremap(icbase[i], 0x1000);
-
-		icdev->sysdev.id = i;
-		icdev->sysdev.cls = &alchemy_ic_sysdev_class;
-		err = sysdev_register(&icdev->sysdev);
-		if (err) {
-			kfree(icdev);
-			return err;
-		}
-	}
+	alchemy_ic_data[0].base = ioremap(IC0_PHYS_ADDR, 0x1000);
+	alchemy_ic_data[1].base = ioremap(IC1_PHYS_ADDR, 0x1000);
+
+	register_syscore_ops(&alchemy_ic_syscore_ops);
 
 	return 0;
 }
-device_initcall(alchemy_ic_sysdev_init);
+device_initcall(alchemy_ic_syscore_init);
Index: linux-2.6/arch/mips/alchemy/common/dbdma.c
===================================================================
--- linux-2.6.orig/arch/mips/alchemy/common/dbdma.c
+++ linux-2.6/arch/mips/alchemy/common/dbdma.c
@@ -36,7 +36,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 
@@ -957,37 +957,30 @@ u32 au1xxx_dbdma_put_dscr(u32 chanid, au
 	return nbytes;
 }
 
+static u32 alchemy_dbdma_pm_regs[NUM_DBDMA_CHANS + 1][6];
 
-struct alchemy_dbdma_sysdev {
-	struct sys_device sysdev;
-	u32 pm_regs[NUM_DBDMA_CHANS + 1][6];
-};
-
-static int alchemy_dbdma_suspend(struct sys_device *dev,
-				 pm_message_t state)
+static int alchemy_dbdma_suspend(void)
 {
-	struct alchemy_dbdma_sysdev *sdev =
-		container_of(dev, struct alchemy_dbdma_sysdev, sysdev);
 	int i;
 	u32 addr;
 
 	addr = DDMA_GLOBAL_BASE;
-	sdev->pm_regs[0][0] = au_readl(addr + 0x00);
-	sdev->pm_regs[0][1] = au_readl(addr + 0x04);
-	sdev->pm_regs[0][2] = au_readl(addr + 0x08);
-	sdev->pm_regs[0][3] = au_readl(addr + 0x0c);
+	alchemy_dbdma_pm_regs[0][0] = au_readl(addr + 0x00);
+	alchemy_dbdma_pm_regs[0][1] = au_readl(addr + 0x04);
+	alchemy_dbdma_pm_regs[0][2] = au_readl(addr + 0x08);
+	alchemy_dbdma_pm_regs[0][3] = au_readl(addr + 0x0c);
 
 	/* save channel configurations */
 	for (i = 1, addr = DDMA_CHANNEL_BASE; i <= NUM_DBDMA_CHANS; i++) {
-		sdev->pm_regs[i][0] = au_readl(addr + 0x00);
-		sdev->pm_regs[i][1] = au_readl(addr + 0x04);
-		sdev->pm_regs[i][2] = au_readl(addr + 0x08);
-		sdev->pm_regs[i][3] = au_readl(addr + 0x0c);
-		sdev->pm_regs[i][4] = au_readl(addr + 0x10);
-		sdev->pm_regs[i][5] = au_readl(addr + 0x14);
+		alchemy_dbdma_pm_regs[i][0] = au_readl(addr + 0x00);
+		alchemy_dbdma_pm_regs[i][1] = au_readl(addr + 0x04);
+		alchemy_dbdma_pm_regs[i][2] = au_readl(addr + 0x08);
+		alchemy_dbdma_pm_regs[i][3] = au_readl(addr + 0x0c);
+		alchemy_dbdma_pm_regs[i][4] = au_readl(addr + 0x10);
+		alchemy_dbdma_pm_regs[i][5] = au_readl(addr + 0x14);
 
 		/* halt channel */
-		au_writel(sdev->pm_regs[i][0] & ~1, addr + 0x00);
+		au_writel(alchemy_dbdma_pm_regs[i][0] & ~1, addr + 0x00);
 		au_sync();
 		while (!(au_readl(addr + 0x14) & 1))
 			au_sync();
@@ -1001,62 +994,35 @@ static int alchemy_dbdma_suspend(struct
 	return 0;
 }
 
-static int alchemy_dbdma_resume(struct sys_device *dev)
+static void alchemy_dbdma_resume(void)
 {
-	struct alchemy_dbdma_sysdev *sdev =
-		container_of(dev, struct alchemy_dbdma_sysdev, sysdev);
 	int i;
 	u32 addr;
 
 	addr = DDMA_GLOBAL_BASE;
-	au_writel(sdev->pm_regs[0][0], addr + 0x00);
-	au_writel(sdev->pm_regs[0][1], addr + 0x04);
-	au_writel(sdev->pm_regs[0][2], addr + 0x08);
-	au_writel(sdev->pm_regs[0][3], addr + 0x0c);
+	au_writel(alchemy_dbdma_pm_regs[0][0], addr + 0x00);
+	au_writel(alchemy_dbdma_pm_regs[0][1], addr + 0x04);
+	au_writel(alchemy_dbdma_pm_regs[0][2], addr + 0x08);
+	au_writel(alchemy_dbdma_pm_regs[0][3], addr + 0x0c);
 
 	/* restore channel configurations */
 	for (i = 1, addr = DDMA_CHANNEL_BASE; i <= NUM_DBDMA_CHANS; i++) {
-		au_writel(sdev->pm_regs[i][0], addr + 0x00);
-		au_writel(sdev->pm_regs[i][1], addr + 0x04);
-		au_writel(sdev->pm_regs[i][2], addr + 0x08);
-		au_writel(sdev->pm_regs[i][3], addr + 0x0c);
-		au_writel(sdev->pm_regs[i][4], addr + 0x10);
-		au_writel(sdev->pm_regs[i][5], addr + 0x14);
+		au_writel(alchemy_dbdma_pm_regs[i][0], addr + 0x00);
+		au_writel(alchemy_dbdma_pm_regs[i][1], addr + 0x04);
+		au_writel(alchemy_dbdma_pm_regs[i][2], addr + 0x08);
+		au_writel(alchemy_dbdma_pm_regs[i][3], addr + 0x0c);
+		au_writel(alchemy_dbdma_pm_regs[i][4], addr + 0x10);
+		au_writel(alchemy_dbdma_pm_regs[i][5], addr + 0x14);
 		au_sync();
 		addr += 0x100;	/* next channel base */
 	}
-
-	return 0;
 }
 
-static struct sysdev_class alchemy_dbdma_sysdev_class = {
-	.name		= "dbdma",
+static struct syscore_ops alchemy_dbdma_syscore_ops = {
 	.suspend	= alchemy_dbdma_suspend,
 	.resume		= alchemy_dbdma_resume,
 };
 
-static int __init alchemy_dbdma_sysdev_init(void)
-{
-	struct alchemy_dbdma_sysdev *sdev;
-	int ret;
-
-	ret = sysdev_class_register(&alchemy_dbdma_sysdev_class);
-	if (ret)
-		return ret;
-
-	sdev = kzalloc(sizeof(struct alchemy_dbdma_sysdev), GFP_KERNEL);
-	if (!sdev)
-		return -ENOMEM;
-
-	sdev->sysdev.id = -1;
-	sdev->sysdev.cls = &alchemy_dbdma_sysdev_class;
-	ret = sysdev_register(&sdev->sysdev);
-	if (ret)
-		kfree(sdev);
-
-	return ret;
-}
-
 static int __init au1xxx_dbdma_init(void)
 {
 	int irq_nr, ret;
@@ -1084,11 +1050,7 @@ static int __init au1xxx_dbdma_init(void
 	else {
 		dbdma_initialized = 1;
 		printk(KERN_INFO "Alchemy DBDMA initialized\n");
-		ret = alchemy_dbdma_sysdev_init();
-		if (ret) {
-			printk(KERN_ERR "DBDMA PM init failed\n");
-			ret = 0;
-		}
+		register_syscore_ops(&alchemy_dbdma_syscore_ops);
 	}
 
 	return ret;
Index: linux-2.6/arch/mips/jz4740/gpio.c
===================================================================
--- linux-2.6.orig/arch/mips/jz4740/gpio.c
+++ linux-2.6/arch/mips/jz4740/gpio.c
@@ -18,7 +18,7 @@
 #include <linux/init.h>
 
 #include <linux/spinlock.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
@@ -86,7 +86,6 @@ struct jz_gpio_chip {
 	spinlock_t lock;
 
 	struct gpio_chip gpio_chip;
-	struct sys_device sysdev;
 };
 
 static struct jz_gpio_chip jz4740_gpio_chips[];
@@ -459,49 +458,47 @@ static struct jz_gpio_chip jz4740_gpio_c
 	JZ4740_GPIO_CHIP(D),
 };
 
-static inline struct jz_gpio_chip *sysdev_to_chip(struct sys_device *dev)
+static void jz4740_gpio_suspend_chip(struct jz_gpio_chip *chip)
 {
-	return container_of(dev, struct jz_gpio_chip, sysdev);
+	chip->suspend_mask = readl(chip->base + JZ_REG_GPIO_MASK);
+	writel(~(chip->wakeup), chip->base + JZ_REG_GPIO_MASK_SET);
+	writel(chip->wakeup, chip->base + JZ_REG_GPIO_MASK_CLEAR);
 }
 
-static int jz4740_gpio_suspend(struct sys_device *dev, pm_message_t state)
+static int jz4740_gpio_suspend(void)
 {
-	struct jz_gpio_chip *chip = sysdev_to_chip(dev);
+	int i;
 
-	chip->suspend_mask = readl(chip->base + JZ_REG_GPIO_MASK);
-	writel(~(chip->wakeup), chip->base + JZ_REG_GPIO_MASK_SET);
-	writel(chip->wakeup, chip->base + JZ_REG_GPIO_MASK_CLEAR);
+	for (i = 0; i < ARRAY_SIZE(jz4740_gpio_chips); i++)
+		jz4740_gpio_suspend_chip(&jz4740_gpio_chips[i]);
 
 	return 0;
 }
 
-static int jz4740_gpio_resume(struct sys_device *dev)
+static void jz4740_gpio_resume_chip(struct jz_gpio_chip *chip)
 {
-	struct jz_gpio_chip *chip = sysdev_to_chip(dev);
 	uint32_t mask = chip->suspend_mask;
 
 	writel(~mask, chip->base + JZ_REG_GPIO_MASK_CLEAR);
 	writel(mask, chip->base + JZ_REG_GPIO_MASK_SET);
+}
 
-	return 0;
+static void jz4740_gpio_resume(void)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(jz4740_gpio_chips) - 1; i >= 0 ; i--)
+		jz4740_gpio_resume_chip(&jz4740_gpio_chips[i]);
 }
 
-static struct sysdev_class jz4740_gpio_sysdev_class = {
-	.name = "gpio",
+static struct syscore_ops jz4740_gpio_syscore_ops = {
 	.suspend = jz4740_gpio_suspend,
 	.resume = jz4740_gpio_resume,
 };
 
-static int jz4740_gpio_chip_init(struct jz_gpio_chip *chip, unsigned int id)
+static void jz4740_gpio_chip_init(struct jz_gpio_chip *chip, unsigned int id)
 {
-	int ret, irq;
-
-	chip->sysdev.id = id;
-	chip->sysdev.cls = &jz4740_gpio_sysdev_class;
-	ret = sysdev_register(&chip->sysdev);
-
-	if (ret)
-		return ret;
+	int irq;
 
 	spin_lock_init(&chip->lock);
 
@@ -519,22 +516,17 @@ static int jz4740_gpio_chip_init(struct
 		irq_set_chip_and_handler(irq, &jz_gpio_irq_chip,
 					 handle_level_irq);
 	}
-
-	return 0;
 }
 
 static int __init jz4740_gpio_init(void)
 {
 	unsigned int i;
-	int ret;
-
-	ret = sysdev_class_register(&jz4740_gpio_sysdev_class);
-	if (ret)
-		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(jz4740_gpio_chips); ++i)
 		jz4740_gpio_chip_init(&jz4740_gpio_chips[i], i);
 
+	register_syscore_ops(&jz4740_gpio_syscore_ops);
+
 	printk(KERN_INFO "JZ4740 GPIO initialized\n");
 
 	return 0;
Index: linux-2.6/arch/mips/kernel/i8259.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/i8259.c
+++ linux-2.6/arch/mips/kernel/i8259.c
@@ -14,7 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/irq.h>
 
 #include <asm/i8259.h>
@@ -215,14 +215,13 @@ spurious_8259A_irq:
 	}
 }
 
-static int i8259A_resume(struct sys_device *dev)
+static void i8259A_resume(void)
 {
 	if (i8259A_auto_eoi >= 0)
 		init_8259A(i8259A_auto_eoi);
-	return 0;
 }
 
-static int i8259A_shutdown(struct sys_device *dev)
+static void i8259A_shutdown(void)
 {
 	/* Put the i8259A into a quiescent state that
 	 * the kernel initialization code can get it
@@ -232,29 +231,20 @@ static int i8259A_shutdown(struct sys_de
 		outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
 		outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-1 */
 	}
-	return 0;
 }
 
-static struct sysdev_class i8259_sysdev_class = {
-	.name = "i8259",
+static struct syscore_ops i8259_syscore_ops = {
 	.resume = i8259A_resume,
 	.shutdown = i8259A_shutdown,
 };
 
-static struct sys_device device_i8259A = {
-	.id	= 0,
-	.cls	= &i8259_sysdev_class,
-};
-
-static int __init i8259A_init_sysfs(void)
+static int __init i8259A_init_syscore(void)
 {
-	int error = sysdev_class_register(&i8259_sysdev_class);
-	if (!error)
-		error = sysdev_register(&device_i8259A);
-	return error;
+	register_syscore_ops(&i8259_syscore_ops);
+	return 0;
 }
 
-device_initcall(i8259A_init_sysfs);
+device_initcall(i8259A_init_syscore);
 
 static void init_8259A(int auto_eoi)
 {
