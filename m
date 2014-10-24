Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2014 14:27:02 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53221 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010574AbaJXM07dUIG3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Oct 2014 14:26:59 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9OCQvPi024553;
        Fri, 24 Oct 2014 14:26:57 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9OCQvRI024552;
        Fri, 24 Oct 2014 14:26:57 +0200
Date:   Fri, 24 Oct 2014 14:26:57 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Chris Dearman <chris.dearman@imgtec.com>
Subject: [PATCH] MIPS/I2C: Move SEAD3 I2C driver to where it belongs.
Message-ID: <20141024122656.GC12641@linux-mips.org>
References: <1412847261-7930-1-git-send-email-markos.chandras@imgtec.com>
 <1412847261-7930-3-git-send-email-markos.chandras@imgtec.com>
 <20141023181925.GA6719@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141023181925.GA6719@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Fixes the following build problem if CONFIG_I2C is disabled:

arch/mips/mti-sead3/sead3-pic32-i2c-drv.c: In function 'i2c_platform_probe':
arch/mips/mti-sead3/sead3-pic32-i2c-drv.c:345:2: error: implicit declaration of
function 'i2c_add_numbered_adapter' [-Werror=implicit-function-declaration]
  ret = i2c_add_numbered_adapter(&priv->adap);
    ^
arch/mips/mti-sead3/sead3-pic32-i2c-drv.c: In function
'i2c_platform_remove':
arch/mips/mti-sead3/sead3-pic32-i2c-drv.c:361:2: error: implicit declaration
of function 'i2c_del_adapter' [-Werror=implicit-function-declaration]
i2c_del_adapter(&priv->adap);

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: Chris Dearman <chris.dearman@imgtec.com>

diff --git a/arch/mips/mti-sead3/sead3-i2c-drv.c b/arch/mips/mti-sead3/sead3-i2c-drv.c
deleted file mode 100644
index 1f787a6..0000000
--- a/arch/mips/mti-sead3/sead3-i2c-drv.c
+++ /dev/null
@@ -1,405 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/platform_device.h>
-
-#define PIC32_I2CxCON		0x0000
-#define	 PIC32_I2CCON_ON	(1<<15)
-#define	 PIC32_I2CCON_ACKDT	(1<<5)
-#define	 PIC32_I2CCON_ACKEN	(1<<4)
-#define	 PIC32_I2CCON_RCEN	(1<<3)
-#define	 PIC32_I2CCON_PEN	(1<<2)
-#define	 PIC32_I2CCON_RSEN	(1<<1)
-#define	 PIC32_I2CCON_SEN	(1<<0)
-#define PIC32_I2CxCONCLR	0x0004
-#define PIC32_I2CxCONSET	0x0008
-#define PIC32_I2CxSTAT		0x0010
-#define PIC32_I2CxSTATCLR	0x0014
-#define	 PIC32_I2CSTAT_ACKSTAT	(1<<15)
-#define	 PIC32_I2CSTAT_TRSTAT	(1<<14)
-#define	 PIC32_I2CSTAT_BCL	(1<<10)
-#define	 PIC32_I2CSTAT_IWCOL	(1<<7)
-#define	 PIC32_I2CSTAT_I2COV	(1<<6)
-#define PIC32_I2CxBRG		0x0040
-#define PIC32_I2CxTRN		0x0050
-#define PIC32_I2CxRCV		0x0060
-
-static DEFINE_SPINLOCK(pic32_bus_lock);
-
-static void __iomem *bus_xfer	= (void __iomem *)0xbf000600;
-static void __iomem *bus_status = (void __iomem *)0xbf000060;
-
-#define DELAY() udelay(100)
-
-static inline unsigned int ioready(void)
-{
-	return readl(bus_status) & 1;
-}
-
-static inline void wait_ioready(void)
-{
-	do { } while (!ioready());
-}
-
-static inline void wait_ioclear(void)
-{
-	do { } while (ioready());
-}
-
-static inline void check_ioclear(void)
-{
-	if (ioready()) {
-		do {
-			(void) readl(bus_xfer);
-			DELAY();
-		} while (ioready());
-	}
-}
-
-static u32 pic32_bus_readl(u32 reg)
-{
-	unsigned long flags;
-	u32 status, val;
-
-	spin_lock_irqsave(&pic32_bus_lock, flags);
-
-	check_ioclear();
-	writel((0x01 << 24) | (reg & 0x00ffffff), bus_xfer);
-	DELAY();
-	wait_ioready();
-	status = readl(bus_xfer);
-	DELAY();
-	val = readl(bus_xfer);
-	wait_ioclear();
-
-	spin_unlock_irqrestore(&pic32_bus_lock, flags);
-
-	return val;
-}
-
-static void pic32_bus_writel(u32 val, u32 reg)
-{
-	unsigned long flags;
-	u32 status;
-
-	spin_lock_irqsave(&pic32_bus_lock, flags);
-
-	check_ioclear();
-	writel((0x10 << 24) | (reg & 0x00ffffff), bus_xfer);
-	DELAY();
-	writel(val, bus_xfer);
-	DELAY();
-	wait_ioready();
-	status = readl(bus_xfer);
-	wait_ioclear();
-
-	spin_unlock_irqrestore(&pic32_bus_lock, flags);
-}
-
-struct pic32_i2c_platform_data {
-	u32	base;
-	struct i2c_adapter adap;
-	u32	xfer_timeout;
-	u32	ack_timeout;
-	u32	ctl_timeout;
-};
-
-static inline void pic32_i2c_start(struct pic32_i2c_platform_data *adap)
-{
-	pic32_bus_writel(PIC32_I2CCON_SEN, adap->base + PIC32_I2CxCONSET);
-}
-
-static inline void pic32_i2c_stop(struct pic32_i2c_platform_data *adap)
-{
-	pic32_bus_writel(PIC32_I2CCON_PEN, adap->base + PIC32_I2CxCONSET);
-}
-
-static inline void pic32_i2c_ack(struct pic32_i2c_platform_data *adap)
-{
-	pic32_bus_writel(PIC32_I2CCON_ACKDT, adap->base + PIC32_I2CxCONCLR);
-	pic32_bus_writel(PIC32_I2CCON_ACKEN, adap->base + PIC32_I2CxCONSET);
-}
-
-static inline void pic32_i2c_nack(struct pic32_i2c_platform_data *adap)
-{
-	pic32_bus_writel(PIC32_I2CCON_ACKDT, adap->base + PIC32_I2CxCONSET);
-	pic32_bus_writel(PIC32_I2CCON_ACKEN, adap->base + PIC32_I2CxCONSET);
-}
-
-static inline int pic32_i2c_idle(struct pic32_i2c_platform_data *adap)
-{
-	int i;
-
-	for (i = 0; i < adap->ctl_timeout; i++) {
-		if (((pic32_bus_readl(adap->base + PIC32_I2CxCON) &
-		      (PIC32_I2CCON_ACKEN | PIC32_I2CCON_RCEN |
-		       PIC32_I2CCON_PEN | PIC32_I2CCON_RSEN |
-		       PIC32_I2CCON_SEN)) == 0) &&
-		    ((pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
-		      (PIC32_I2CSTAT_TRSTAT)) == 0))
-			return 0;
-		udelay(1);
-	}
-	return -ETIMEDOUT;
-}
-
-static inline u32 pic32_i2c_master_write(struct pic32_i2c_platform_data *adap,
-		u32 byte)
-{
-	pic32_bus_writel(byte, adap->base + PIC32_I2CxTRN);
-	return pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
-			PIC32_I2CSTAT_IWCOL;
-}
-
-static inline u32 pic32_i2c_master_read(struct pic32_i2c_platform_data *adap)
-{
-	pic32_bus_writel(PIC32_I2CCON_RCEN, adap->base + PIC32_I2CxCONSET);
-	while (pic32_bus_readl(adap->base + PIC32_I2CxCON) & PIC32_I2CCON_RCEN)
-		;
-	pic32_bus_writel(PIC32_I2CSTAT_I2COV, adap->base + PIC32_I2CxSTATCLR);
-	return pic32_bus_readl(adap->base + PIC32_I2CxRCV);
-}
-
-static int pic32_i2c_address(struct pic32_i2c_platform_data *adap,
-		unsigned int addr, int rd)
-{
-	pic32_i2c_idle(adap);
-	pic32_i2c_start(adap);
-	pic32_i2c_idle(adap);
-
-	addr <<= 1;
-	if (rd)
-		addr |= 1;
-
-	if (pic32_i2c_master_write(adap, addr))
-		return -EIO;
-	pic32_i2c_idle(adap);
-	if (pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
-			PIC32_I2CSTAT_ACKSTAT)
-		return -EIO;
-	return 0;
-}
-
-static int sead3_i2c_read(struct pic32_i2c_platform_data *adap,
-		unsigned char *buf, unsigned int len)
-{
-	u32 data;
-	int i;
-
-	i = 0;
-	while (i < len) {
-		data = pic32_i2c_master_read(adap);
-		buf[i++] = data;
-		if (i < len)
-			pic32_i2c_ack(adap);
-		else
-			pic32_i2c_nack(adap);
-	}
-
-	pic32_i2c_stop(adap);
-	pic32_i2c_idle(adap);
-	return 0;
-}
-
-static int sead3_i2c_write(struct pic32_i2c_platform_data *adap,
-		unsigned char *buf, unsigned int len)
-{
-	int i;
-	u32 data;
-
-	i = 0;
-	while (i < len) {
-		data = buf[i];
-		if (pic32_i2c_master_write(adap, data))
-			return -EIO;
-		pic32_i2c_idle(adap);
-		if (pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
-					PIC32_I2CSTAT_ACKSTAT)
-			return -EIO;
-		i++;
-	}
-
-	pic32_i2c_stop(adap);
-	pic32_i2c_idle(adap);
-	return 0;
-}
-
-static int sead3_pic32_platform_xfer(struct i2c_adapter *i2c_adap,
-		struct i2c_msg *msgs, int num)
-{
-	struct pic32_i2c_platform_data *adap = i2c_adap->algo_data;
-	struct i2c_msg *p;
-	int i, err = 0;
-
-	for (i = 0; i < num; i++) {
-#define __BUFSIZE 80
-		int ii;
-		static char buf[__BUFSIZE];
-		char *b = buf;
-
-		p = &msgs[i];
-		b += sprintf(buf, " [%d bytes]", p->len);
-		if ((p->flags & I2C_M_RD) == 0) {
-			for (ii = 0; ii < p->len; ii++) {
-				if (b < &buf[__BUFSIZE-4]) {
-					b += sprintf(b, " %02x", p->buf[ii]);
-				} else {
-					strcat(b, "...");
-					break;
-				}
-			}
-		}
-	}
-
-	for (i = 0; !err && i < num; i++) {
-		p = &msgs[i];
-		err = pic32_i2c_address(adap, p->addr, p->flags & I2C_M_RD);
-		if (err || !p->len)
-			continue;
-		if (p->flags & I2C_M_RD)
-			err = sead3_i2c_read(adap, p->buf, p->len);
-		else
-			err = sead3_i2c_write(adap, p->buf, p->len);
-	}
-
-	/* Return the number of messages processed, or the error code. */
-	if (err == 0)
-		err = num;
-
-	return err;
-}
-
-static u32 sead3_pic32_platform_func(struct i2c_adapter *adap)
-{
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
-}
-
-static const struct i2c_algorithm sead3_platform_algo = {
-	.master_xfer	= sead3_pic32_platform_xfer,
-	.functionality	= sead3_pic32_platform_func,
-};
-
-static void sead3_i2c_platform_setup(struct pic32_i2c_platform_data *priv)
-{
-	pic32_bus_writel(500, priv->base + PIC32_I2CxBRG);
-	pic32_bus_writel(PIC32_I2CCON_ON, priv->base + PIC32_I2CxCONCLR);
-	pic32_bus_writel(PIC32_I2CCON_ON, priv->base + PIC32_I2CxCONSET);
-	pic32_bus_writel(PIC32_I2CSTAT_BCL | PIC32_I2CSTAT_IWCOL,
-		priv->base + PIC32_I2CxSTATCLR);
-}
-
-static int sead3_i2c_platform_probe(struct platform_device *pdev)
-{
-	struct pic32_i2c_platform_data *priv;
-	struct resource *r;
-	int ret;
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		ret = -ENODEV;
-		goto out;
-	}
-
-	priv = kzalloc(sizeof(struct pic32_i2c_platform_data), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	priv->base = r->start;
-	if (!priv->base) {
-		ret = -EBUSY;
-		goto out_mem;
-	}
-
-	priv->xfer_timeout = 200;
-	priv->ack_timeout = 200;
-	priv->ctl_timeout = 200;
-
-	priv->adap.nr = pdev->id;
-	priv->adap.algo = &sead3_platform_algo;
-	priv->adap.algo_data = priv;
-	priv->adap.dev.parent = &pdev->dev;
-	strlcpy(priv->adap.name, "SEAD3 PIC32", sizeof(priv->adap.name));
-
-	sead3_i2c_platform_setup(priv);
-
-	ret = i2c_add_numbered_adapter(&priv->adap);
-	if (ret == 0) {
-		platform_set_drvdata(pdev, priv);
-		return 0;
-	}
-
-out_mem:
-	kfree(priv);
-out:
-	return ret;
-}
-
-static int sead3_i2c_platform_remove(struct platform_device *pdev)
-{
-	struct pic32_i2c_platform_data *priv = platform_get_drvdata(pdev);
-
-	platform_set_drvdata(pdev, NULL);
-	i2c_del_adapter(&priv->adap);
-	kfree(priv);
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int sead3_i2c_platform_suspend(struct platform_device *pdev,
-		pm_message_t state)
-{
-	dev_dbg(&pdev->dev, "i2c_platform_disable\n");
-	return 0;
-}
-
-static int sead3_i2c_platform_resume(struct platform_device *pdev)
-{
-	struct pic32_i2c_platform_data *priv = platform_get_drvdata(pdev);
-
-	dev_dbg(&pdev->dev, "sead3_i2c_platform_setup\n");
-	sead3_i2c_platform_setup(priv);
-
-	return 0;
-}
-#else
-#define sead3_i2c_platform_suspend	NULL
-#define sead3_i2c_platform_resume	NULL
-#endif
-
-static struct platform_driver sead3_i2c_platform_driver = {
-	.driver = {
-		.name	= "sead3-i2c",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= sead3_i2c_platform_probe,
-	.remove		= sead3_i2c_platform_remove,
-	.suspend	= sead3_i2c_platform_suspend,
-	.resume		= sead3_i2c_platform_resume,
-};
-
-static int __init sead3_i2c_platform_init(void)
-{
-	return platform_driver_register(&sead3_i2c_platform_driver);
-}
-module_init(sead3_i2c_platform_init);
-
-static void __exit sead3_i2c_platform_exit(void)
-{
-	platform_driver_unregister(&sead3_i2c_platform_driver);
-}
-module_exit(sead3_i2c_platform_exit);
-
-MODULE_AUTHOR("Chris Dearman, MIPS Technologies INC.");
-MODULE_DESCRIPTION("SEAD3 PIC32 I2C driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 917c358..1e849d7 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -724,6 +724,13 @@ config I2C_S3C2410
 	  Say Y here to include support for I2C controller in the
 	  Samsung SoCs.
 
+config I2C_SEAD3
+	tristate "SEAD3 I2C Driver"
+	depends on MIPS_SEAD3
+	help
+	  Say Y here to include support for I2C controller on the
+	  MIPS SEAD3 evaluation board.
+
 config I2C_SH7760
 	tristate "Renesas SH7760 I2C Controller"
 	depends on CPU_SUBTYPE_SH7760
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 78d56c5..ec255db 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_I2C_QUP)		+= i2c-qup.o
 obj-$(CONFIG_I2C_RIIC)		+= i2c-riic.o
 obj-$(CONFIG_I2C_RK3X)		+= i2c-rk3x.o
 obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
+obj-$(CONFIG_I2C_SEAD3)		+= i2c-sead3.o
 obj-$(CONFIG_I2C_SH7760)	+= i2c-sh7760.o
 obj-$(CONFIG_I2C_SH_MOBILE)	+= i2c-sh_mobile.o
 obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
diff --git a/drivers/i2c/busses/i2c-sead3.c b/drivers/i2c/busses/i2c-sead3.c
new file mode 100644
index 0000000..1f787a6
--- /dev/null
+++ b/drivers/i2c/busses/i2c-sead3.c
@@ -0,0 +1,405 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+
+#define PIC32_I2CxCON		0x0000
+#define	 PIC32_I2CCON_ON	(1<<15)
+#define	 PIC32_I2CCON_ACKDT	(1<<5)
+#define	 PIC32_I2CCON_ACKEN	(1<<4)
+#define	 PIC32_I2CCON_RCEN	(1<<3)
+#define	 PIC32_I2CCON_PEN	(1<<2)
+#define	 PIC32_I2CCON_RSEN	(1<<1)
+#define	 PIC32_I2CCON_SEN	(1<<0)
+#define PIC32_I2CxCONCLR	0x0004
+#define PIC32_I2CxCONSET	0x0008
+#define PIC32_I2CxSTAT		0x0010
+#define PIC32_I2CxSTATCLR	0x0014
+#define	 PIC32_I2CSTAT_ACKSTAT	(1<<15)
+#define	 PIC32_I2CSTAT_TRSTAT	(1<<14)
+#define	 PIC32_I2CSTAT_BCL	(1<<10)
+#define	 PIC32_I2CSTAT_IWCOL	(1<<7)
+#define	 PIC32_I2CSTAT_I2COV	(1<<6)
+#define PIC32_I2CxBRG		0x0040
+#define PIC32_I2CxTRN		0x0050
+#define PIC32_I2CxRCV		0x0060
+
+static DEFINE_SPINLOCK(pic32_bus_lock);
+
+static void __iomem *bus_xfer	= (void __iomem *)0xbf000600;
+static void __iomem *bus_status = (void __iomem *)0xbf000060;
+
+#define DELAY() udelay(100)
+
+static inline unsigned int ioready(void)
+{
+	return readl(bus_status) & 1;
+}
+
+static inline void wait_ioready(void)
+{
+	do { } while (!ioready());
+}
+
+static inline void wait_ioclear(void)
+{
+	do { } while (ioready());
+}
+
+static inline void check_ioclear(void)
+{
+	if (ioready()) {
+		do {
+			(void) readl(bus_xfer);
+			DELAY();
+		} while (ioready());
+	}
+}
+
+static u32 pic32_bus_readl(u32 reg)
+{
+	unsigned long flags;
+	u32 status, val;
+
+	spin_lock_irqsave(&pic32_bus_lock, flags);
+
+	check_ioclear();
+	writel((0x01 << 24) | (reg & 0x00ffffff), bus_xfer);
+	DELAY();
+	wait_ioready();
+	status = readl(bus_xfer);
+	DELAY();
+	val = readl(bus_xfer);
+	wait_ioclear();
+
+	spin_unlock_irqrestore(&pic32_bus_lock, flags);
+
+	return val;
+}
+
+static void pic32_bus_writel(u32 val, u32 reg)
+{
+	unsigned long flags;
+	u32 status;
+
+	spin_lock_irqsave(&pic32_bus_lock, flags);
+
+	check_ioclear();
+	writel((0x10 << 24) | (reg & 0x00ffffff), bus_xfer);
+	DELAY();
+	writel(val, bus_xfer);
+	DELAY();
+	wait_ioready();
+	status = readl(bus_xfer);
+	wait_ioclear();
+
+	spin_unlock_irqrestore(&pic32_bus_lock, flags);
+}
+
+struct pic32_i2c_platform_data {
+	u32	base;
+	struct i2c_adapter adap;
+	u32	xfer_timeout;
+	u32	ack_timeout;
+	u32	ctl_timeout;
+};
+
+static inline void pic32_i2c_start(struct pic32_i2c_platform_data *adap)
+{
+	pic32_bus_writel(PIC32_I2CCON_SEN, adap->base + PIC32_I2CxCONSET);
+}
+
+static inline void pic32_i2c_stop(struct pic32_i2c_platform_data *adap)
+{
+	pic32_bus_writel(PIC32_I2CCON_PEN, adap->base + PIC32_I2CxCONSET);
+}
+
+static inline void pic32_i2c_ack(struct pic32_i2c_platform_data *adap)
+{
+	pic32_bus_writel(PIC32_I2CCON_ACKDT, adap->base + PIC32_I2CxCONCLR);
+	pic32_bus_writel(PIC32_I2CCON_ACKEN, adap->base + PIC32_I2CxCONSET);
+}
+
+static inline void pic32_i2c_nack(struct pic32_i2c_platform_data *adap)
+{
+	pic32_bus_writel(PIC32_I2CCON_ACKDT, adap->base + PIC32_I2CxCONSET);
+	pic32_bus_writel(PIC32_I2CCON_ACKEN, adap->base + PIC32_I2CxCONSET);
+}
+
+static inline int pic32_i2c_idle(struct pic32_i2c_platform_data *adap)
+{
+	int i;
+
+	for (i = 0; i < adap->ctl_timeout; i++) {
+		if (((pic32_bus_readl(adap->base + PIC32_I2CxCON) &
+		      (PIC32_I2CCON_ACKEN | PIC32_I2CCON_RCEN |
+		       PIC32_I2CCON_PEN | PIC32_I2CCON_RSEN |
+		       PIC32_I2CCON_SEN)) == 0) &&
+		    ((pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
+		      (PIC32_I2CSTAT_TRSTAT)) == 0))
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+static inline u32 pic32_i2c_master_write(struct pic32_i2c_platform_data *adap,
+		u32 byte)
+{
+	pic32_bus_writel(byte, adap->base + PIC32_I2CxTRN);
+	return pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
+			PIC32_I2CSTAT_IWCOL;
+}
+
+static inline u32 pic32_i2c_master_read(struct pic32_i2c_platform_data *adap)
+{
+	pic32_bus_writel(PIC32_I2CCON_RCEN, adap->base + PIC32_I2CxCONSET);
+	while (pic32_bus_readl(adap->base + PIC32_I2CxCON) & PIC32_I2CCON_RCEN)
+		;
+	pic32_bus_writel(PIC32_I2CSTAT_I2COV, adap->base + PIC32_I2CxSTATCLR);
+	return pic32_bus_readl(adap->base + PIC32_I2CxRCV);
+}
+
+static int pic32_i2c_address(struct pic32_i2c_platform_data *adap,
+		unsigned int addr, int rd)
+{
+	pic32_i2c_idle(adap);
+	pic32_i2c_start(adap);
+	pic32_i2c_idle(adap);
+
+	addr <<= 1;
+	if (rd)
+		addr |= 1;
+
+	if (pic32_i2c_master_write(adap, addr))
+		return -EIO;
+	pic32_i2c_idle(adap);
+	if (pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
+			PIC32_I2CSTAT_ACKSTAT)
+		return -EIO;
+	return 0;
+}
+
+static int sead3_i2c_read(struct pic32_i2c_platform_data *adap,
+		unsigned char *buf, unsigned int len)
+{
+	u32 data;
+	int i;
+
+	i = 0;
+	while (i < len) {
+		data = pic32_i2c_master_read(adap);
+		buf[i++] = data;
+		if (i < len)
+			pic32_i2c_ack(adap);
+		else
+			pic32_i2c_nack(adap);
+	}
+
+	pic32_i2c_stop(adap);
+	pic32_i2c_idle(adap);
+	return 0;
+}
+
+static int sead3_i2c_write(struct pic32_i2c_platform_data *adap,
+		unsigned char *buf, unsigned int len)
+{
+	int i;
+	u32 data;
+
+	i = 0;
+	while (i < len) {
+		data = buf[i];
+		if (pic32_i2c_master_write(adap, data))
+			return -EIO;
+		pic32_i2c_idle(adap);
+		if (pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
+					PIC32_I2CSTAT_ACKSTAT)
+			return -EIO;
+		i++;
+	}
+
+	pic32_i2c_stop(adap);
+	pic32_i2c_idle(adap);
+	return 0;
+}
+
+static int sead3_pic32_platform_xfer(struct i2c_adapter *i2c_adap,
+		struct i2c_msg *msgs, int num)
+{
+	struct pic32_i2c_platform_data *adap = i2c_adap->algo_data;
+	struct i2c_msg *p;
+	int i, err = 0;
+
+	for (i = 0; i < num; i++) {
+#define __BUFSIZE 80
+		int ii;
+		static char buf[__BUFSIZE];
+		char *b = buf;
+
+		p = &msgs[i];
+		b += sprintf(buf, " [%d bytes]", p->len);
+		if ((p->flags & I2C_M_RD) == 0) {
+			for (ii = 0; ii < p->len; ii++) {
+				if (b < &buf[__BUFSIZE-4]) {
+					b += sprintf(b, " %02x", p->buf[ii]);
+				} else {
+					strcat(b, "...");
+					break;
+				}
+			}
+		}
+	}
+
+	for (i = 0; !err && i < num; i++) {
+		p = &msgs[i];
+		err = pic32_i2c_address(adap, p->addr, p->flags & I2C_M_RD);
+		if (err || !p->len)
+			continue;
+		if (p->flags & I2C_M_RD)
+			err = sead3_i2c_read(adap, p->buf, p->len);
+		else
+			err = sead3_i2c_write(adap, p->buf, p->len);
+	}
+
+	/* Return the number of messages processed, or the error code. */
+	if (err == 0)
+		err = num;
+
+	return err;
+}
+
+static u32 sead3_pic32_platform_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm sead3_platform_algo = {
+	.master_xfer	= sead3_pic32_platform_xfer,
+	.functionality	= sead3_pic32_platform_func,
+};
+
+static void sead3_i2c_platform_setup(struct pic32_i2c_platform_data *priv)
+{
+	pic32_bus_writel(500, priv->base + PIC32_I2CxBRG);
+	pic32_bus_writel(PIC32_I2CCON_ON, priv->base + PIC32_I2CxCONCLR);
+	pic32_bus_writel(PIC32_I2CCON_ON, priv->base + PIC32_I2CxCONSET);
+	pic32_bus_writel(PIC32_I2CSTAT_BCL | PIC32_I2CSTAT_IWCOL,
+		priv->base + PIC32_I2CxSTATCLR);
+}
+
+static int sead3_i2c_platform_probe(struct platform_device *pdev)
+{
+	struct pic32_i2c_platform_data *priv;
+	struct resource *r;
+	int ret;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	priv = kzalloc(sizeof(struct pic32_i2c_platform_data), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	priv->base = r->start;
+	if (!priv->base) {
+		ret = -EBUSY;
+		goto out_mem;
+	}
+
+	priv->xfer_timeout = 200;
+	priv->ack_timeout = 200;
+	priv->ctl_timeout = 200;
+
+	priv->adap.nr = pdev->id;
+	priv->adap.algo = &sead3_platform_algo;
+	priv->adap.algo_data = priv;
+	priv->adap.dev.parent = &pdev->dev;
+	strlcpy(priv->adap.name, "SEAD3 PIC32", sizeof(priv->adap.name));
+
+	sead3_i2c_platform_setup(priv);
+
+	ret = i2c_add_numbered_adapter(&priv->adap);
+	if (ret == 0) {
+		platform_set_drvdata(pdev, priv);
+		return 0;
+	}
+
+out_mem:
+	kfree(priv);
+out:
+	return ret;
+}
+
+static int sead3_i2c_platform_remove(struct platform_device *pdev)
+{
+	struct pic32_i2c_platform_data *priv = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+	i2c_del_adapter(&priv->adap);
+	kfree(priv);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sead3_i2c_platform_suspend(struct platform_device *pdev,
+		pm_message_t state)
+{
+	dev_dbg(&pdev->dev, "i2c_platform_disable\n");
+	return 0;
+}
+
+static int sead3_i2c_platform_resume(struct platform_device *pdev)
+{
+	struct pic32_i2c_platform_data *priv = platform_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "sead3_i2c_platform_setup\n");
+	sead3_i2c_platform_setup(priv);
+
+	return 0;
+}
+#else
+#define sead3_i2c_platform_suspend	NULL
+#define sead3_i2c_platform_resume	NULL
+#endif
+
+static struct platform_driver sead3_i2c_platform_driver = {
+	.driver = {
+		.name	= "sead3-i2c",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sead3_i2c_platform_probe,
+	.remove		= sead3_i2c_platform_remove,
+	.suspend	= sead3_i2c_platform_suspend,
+	.resume		= sead3_i2c_platform_resume,
+};
+
+static int __init sead3_i2c_platform_init(void)
+{
+	return platform_driver_register(&sead3_i2c_platform_driver);
+}
+module_init(sead3_i2c_platform_init);
+
+static void __exit sead3_i2c_platform_exit(void)
+{
+	platform_driver_unregister(&sead3_i2c_platform_driver);
+}
+module_exit(sead3_i2c_platform_exit);
+
+MODULE_AUTHOR("Chris Dearman, MIPS Technologies INC.");
+MODULE_DESCRIPTION("SEAD3 PIC32 I2C driver");
+MODULE_LICENSE("GPL");
