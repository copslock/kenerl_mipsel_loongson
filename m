Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2011 18:55:29 +0100 (CET)
Received: from smtpgw1.netlogicmicro.com ([12.203.210.53]:55875 "EHLO
        smtpgw1.netlogicmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903725Ab1KORzV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Nov 2011 18:55:21 +0100
Received: from pps.filterd (smtpgw1 [127.0.0.1])
        by smtpgw1.netlogicmicro.com (8.14.4/8.14.4) with SMTP id pAFHqIWQ006509;
        Tue, 15 Nov 2011 09:54:59 -0800
Received: from hqcas02.netlogicmicro.com (hqcas02.netlogicmicro.com [10.65.50.15])
        by smtpgw1.netlogicmicro.com with ESMTP id 113d7111na-1
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 15 Nov 2011 09:54:58 -0800
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     <linux-i2c@vger.kernel.org>
CC:     <ben-linux@fluff.org>, <linux-mips@linux-mips.org>,
        Ganesan Ramalingam <ganesanr@netlogicmicro.com>,
        Jayachandran C <jayachandranc@netlogicmicro.com>
Subject: [PATCH] i2c: Support for Netlogic XLR/XLS I2C controller.
Date:   Tue, 15 Nov 2011 23:24:45 +0530
Message-ID: <1321379685-475-1-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.7.0.77]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.5.7110,1.0.211,0.0.0000
 definitions=2011-11-15_06:2011-11-15,2011-11-15,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 suspectscore=1
 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=6.0.2-1012030000 definitions=main-1111150171
X-archive-position: 31610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12653

From: Ganesan Ramalingam <ganesanr@netlogicmicro.com>

Add support for the intergrated I2C controller on Netlogic
XLR/XLS MIPS SoC.

The changes are to add a new file i2c/buses/i2c-xlr.c, containing the
i2c bus implementation, and to update i2c/buses/{Kconfig,Makefile} to
add the CONFIG_I2C_XLR option.

Signed-off-by: Ganesan Ramalingam <ganesanr@netlogicmicro.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---

Changes from the last version is to remove the custom IO functions from
netlogic headers and use __raw_readl/__raw_writel

This has been sent out too many times now, please let me know if there 
are any comments.

 drivers/i2c/busses/Kconfig   |   11 ++
 drivers/i2c/busses/Makefile  |    1 +
 drivers/i2c/busses/i2c-xlr.c |  318 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 330 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-xlr.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index a3afac4..c9f3db3 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -308,6 +308,17 @@ config I2C_AU1550
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-au1550.
 
+config I2C_XLR
+	tristate "XLR I2C support"
+	depends on CPU_XLR
+	help
+	  This driver enables support for the on-chip I2C interface of
+	  the Netlogic XLR/XLS MIPS processors.
+
+	  Say yes to this option if you have a Netlogic XLR/XLS based
+	  board and you need to access the I2C devices (typically the
+	  RTC, sensors, EEPROM) connected to this interface.
+
 config I2C_BLACKFIN_TWI
 	tristate "Blackfin TWI I2C support"
 	depends on BLACKFIN
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index fba6da6..4372dee 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_I2C_TEGRA)		+= i2c-tegra.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
 obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
+obj-$(CONFIG_I2C_XLR)           += i2c-xlr.o
 obj-$(CONFIG_I2C_EG20T)         += i2c-eg20t.o
 
 # External I2C/SMBus adapter drivers
diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
new file mode 100644
index 0000000..cc2f0a5
--- /dev/null
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -0,0 +1,318 @@
+/*
+ * Copyright 2011, Netlogic Microsystems Inc.
+ * Copyright 2004, Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+/* XLR I2C REGISTERS */
+#define XLR_I2C_CFG		0x00
+#define XLR_I2C_CLKDIV		0x01
+#define XLR_I2C_DEVADDR		0x02
+#define XLR_I2C_ADDR		0x03
+#define XLR_I2C_DATAOUT		0x04
+#define XLR_I2C_DATAIN		0x05
+#define XLR_I2C_STATUS		0x06
+#define XLR_I2C_STARTXFR	0x07
+#define XLR_I2C_BYTECNT		0x08
+#define XLR_I2C_HDSTATIM	0x09
+
+/* XLR I2C REGISTERS FLAGS */
+#define XLR_I2C_BUS_BUSY	0x01
+#define XLR_I2C_SDOEMPTY	0x02
+#define XLR_I2C_RXRDY		0x04
+#define XLR_I2C_ACK_ERR		0x08
+#define XLR_I2C_ARB_STARTERR	0x30
+
+/* Register Programming Values!! Change as required */
+#define XLR_I2C_CFG_ADDR	0xF8    /* 8-Bit dev Addr + POR Values */
+#define XLR_I2C_CFG_NOADDR	0xFA    /* 8-Bit reg Addr + POR Values */
+#define XLR_I2C_STARTXFR_ND	0x02    /* No data , only addr */
+#define XLR_I2C_STARTXFR_RD	0x01    /* Read */
+#define XLR_I2C_STARTXFR_WR	0x00    /* Write */
+#define XLR_I2C_CLKDIV_DEF	0x14A   /* 0x00000052 */
+#define XLR_I2C_HDSTATIM_DEF	0x107   /* 0x00000000 */
+
+#define XLR_I2C_IO_SIZE		0x1000
+
+
+/* 
+ * Need un-swapped IO for the SoC I2C registers, use __raw_ IO
+ */
+static inline void xlr_i2c_wreg(u32 __iomem *base, unsigned int reg, u32 val)
+{
+	base += reg;
+	__raw_writel(val, base);
+}
+
+static inline u32 xlr_i2c_rdreg(u32 __iomem *base, unsigned int reg)
+{
+	base += reg;
+	return __raw_readl(base);
+}
+
+struct xlr_i2c_private {
+	struct i2c_adapter adap;
+	u32 __iomem *iobase;
+};
+
+static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
+		u8 *buf, u16 addr)
+{
+	u32 i2c_status = 0x00;
+	u8 nb;
+	int pos, timeout = 0;
+	struct i2c_adapter *adap = &priv->adap;
+	u8 offset = buf[0];
+
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_ADDR, offset);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_ADDR);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len-1);
+
+retry:
+	timeout = 0;
+	pos = 1;
+	if (len == 1) {
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
+				XLR_I2C_STARTXFR_ND);
+	} else {
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, buf[pos]);
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
+				XLR_I2C_STARTXFR_WR);
+	}
+
+	while (1) {
+		if (timeout++ > 0x1000) {
+			dev_err(&adap->dev, "XLR_I2C_STARTXFR_RD Rx Timeout\n");
+			return -ETIMEDOUT;
+		}
+
+		i2c_status = xlr_i2c_rdreg(priv->iobase,
+				XLR_I2C_STATUS);
+
+		if (i2c_status & XLR_I2C_SDOEMPTY) {
+			pos++;
+			nb = (pos < len) ? buf[pos] : 0;
+			xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, nb);
+		}
+
+		if (i2c_status & XLR_I2C_ARB_STARTERR)
+			goto retry;
+
+		if (i2c_status & XLR_I2C_ACK_ERR) {
+			return -EIO;
+		}
+
+		if (i2c_status & XLR_I2C_BUS_BUSY) {
+			udelay(1);
+			continue;
+		}
+
+		if (pos >= len)
+			break;
+	}
+
+	return 0;
+}
+
+static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len,
+		u8 *buf, u16 addr)
+{
+	u32 i2c_status = 0x00;
+	int pos = 0;
+	int timeout = 0;
+	struct i2c_adapter *adap = &priv->adap;
+
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_NOADDR);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
+
+retry:
+	timeout = 0;
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
+			XLR_I2C_STARTXFR_RD);
+
+	while (1) {
+		if (timeout++ > 0x1000) {
+			dev_err(&adap->dev, "XLR_I2C_STARTXFR_RD Rx Timeout\n");
+			return -ETIMEDOUT;
+		}
+
+		i2c_status = xlr_i2c_rdreg(priv->iobase,
+				XLR_I2C_STATUS);
+		if (i2c_status & XLR_I2C_RXRDY) {
+			buf[pos++] = (u8)xlr_i2c_rdreg(priv->iobase,
+					XLR_I2C_DATAIN);
+		}
+
+		if (i2c_status & XLR_I2C_ARB_STARTERR)
+			goto retry;
+
+		if (i2c_status & XLR_I2C_ACK_ERR) {
+			dev_err(&adap->dev, "XLR_I2C_STARTXFR_RD ACK ERR\n");
+			return -EIO;
+		}
+
+		if ((i2c_status & XLR_I2C_BUS_BUSY) == 0)
+			break;
+		udelay(1);
+	}
+	return 0;
+}
+
+static int xlr_i2c_xfer(struct i2c_adapter *adap,
+		struct i2c_msg *msgs, int num)
+{
+	struct i2c_msg *msg;
+	int i;
+	int ret = 0;
+	struct xlr_i2c_private *priv = i2c_get_adapdata(adap);
+
+	for (i = 0; ret == 0 && i < num; i++) {
+		msg = &msgs[i];
+		if (msg->flags & I2C_M_RD)
+			ret = xlr_i2c_rx(priv, msg->len, &msg->buf[0],
+					msg->addr);
+		else
+			ret = xlr_i2c_tx(priv, msg->len, &msg->buf[0],
+					msg->addr);
+	}
+
+	return (ret != 0) ? ret : num;
+}
+
+static u32 xlr_func(struct i2c_adapter *adap)
+{
+	/* Emulate SMBUS over I2C */
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;
+}
+
+static struct i2c_algorithm xlr_i2c_algo = {
+	.master_xfer	= xlr_i2c_xfer,
+	.functionality	= xlr_func,
+};
+
+static int xlr_i2c_add_bus(struct xlr_i2c_private *priv)
+{
+	priv->adap.owner	= THIS_MODULE;
+	priv->adap.algo_data	= priv;
+	priv->adap.nr		= 1;
+	priv->adap.algo		= &xlr_i2c_algo;
+	priv->adap.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	snprintf(priv->adap.name, sizeof(priv->adap.name),
+			"SMBus XLR I2C Adapter");
+	i2c_set_adapdata(&priv->adap, priv);
+	/* register new adapter to i2c module... */
+	if (i2c_add_numbered_adapter(&priv->adap))
+		return -1;
+
+	return 0;
+}
+
+static int __devinit xlr_i2c_probe(struct platform_device *pdev)
+{
+	struct xlr_i2c_private  *priv;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res) {
+		ret = -ENXIO;
+		goto err1;
+	}
+
+	if (!request_mem_region(res->start, XLR_I2C_IO_SIZE, pdev->name)) {
+		dev_err(&pdev->dev, "request_mem_region failed\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	priv = kzalloc(sizeof(struct xlr_i2c_private), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	priv->adap.dev.parent = &pdev->dev;
+	priv->iobase = (u32 *)ioremap(res->start, XLR_I2C_IO_SIZE);
+	if (!priv->iobase) {
+		ret = -ENOMEM;
+		goto err3;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	ret = xlr_i2c_add_bus(priv);
+
+	if (ret < 0) {
+		dev_err(&priv->adap.dev, "Failed to add i2c bus\n");
+		ret = -ENXIO;
+		goto err4;
+	} else
+		dev_info(&priv->adap.dev, "Added I2C Bus.\n");
+
+	return 0;
+err4:
+	iounmap(priv->iobase);
+	platform_set_drvdata(pdev, NULL);
+err3:
+	kfree(priv);
+err2:
+	release_mem_region(res->start, IORESOURCE_MEM);
+err1:
+	return ret;
+}
+
+static int __devexit xlr_i2c_remove(struct platform_device *pdev)
+{
+	struct xlr_i2c_private *priv = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	i2c_del_adapter(&priv->adap);
+	iounmap(priv->iobase);
+	kfree(priv);
+	release_mem_region(res->start, IORESOURCE_MEM);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct platform_driver xlr_i2c_driver = {
+	.probe  = xlr_i2c_probe,
+	.remove = __devexit_p(xlr_i2c_remove),
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "xlr-i2cbus",
+	},
+};
+
+static int __init xlr_i2c_init(void)
+{
+	return platform_driver_register(&xlr_i2c_driver);
+}
+
+static void __exit xlr_i2c_exit(void)
+{
+	platform_driver_unregister(&xlr_i2c_driver);
+}
+
+MODULE_AUTHOR("Ganesan Ramalingam <ganesanr@netlogicmicro.com>");
+MODULE_DESCRIPTION("XLR I2C SMBus driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:xlr-i2cbus");
+
+module_init(xlr_i2c_init);
+module_exit(xlr_i2c_exit);
-- 
1.7.5.4
