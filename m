Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2011 15:48:32 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4901 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491197Ab1FWNs2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2011 15:48:28 +0200
X-TM-IMSS-Message-ID: <22cc10ad000b2fa3@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 22cc10ad000b2fa3 ; Thu, 23 Jun 2011 06:47:20 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 23 Jun 2011 06:49:10 -0700
Date:   Thu, 23 Jun 2011 19:21:03 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ganesanr@netlogicmicro.com
Subject: [PATCH] i2c: Support for Netlogic XLR/XLS on-chip I2C controller.
Message-ID: <20110623135057.GA26772@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 23 Jun 2011 13:49:10.0768 (UTC) FILETIME=[54703F00:01CC31AC]
X-archive-position: 30493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19170

From: Ganesan Ramalingam <ganesanr@netlogicmicro.com>

- platform.c : add i2c platform device
- i2c-xlr.c : algorithm and i2c adaptor
- Kconfig/Makefile: add CONFIG_I2C_XLR option

Signed-off-by: Ganesan Ramalingam <ganesanr@netlogicmicro.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/configs/nlm_xlr_defconfig |    4 +
 arch/mips/netlogic/xlr/platform.c   |   29 +++
 drivers/i2c/busses/Kconfig          |   11 ++
 drivers/i2c/busses/Makefile         |    1 +
 drivers/i2c/busses/i2c-xlr.c        |  335 +++++++++++++++++++++++++++++++++++
 5 files changed, 380 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-xlr.c

diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index e4b399f..6431fd3 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -365,6 +365,10 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_TIMERIOMEM=m
 CONFIG_RAW_DRIVER=m
+CONFIG_I2C=y
+CONFIG_I2C_XLR=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1374=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_HID_SUPPORT is not set
diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
index 609ec25..2cd2d3c 100644
--- a/arch/mips/netlogic/xlr/platform.c
+++ b/arch/mips/netlogic/xlr/platform.c
@@ -14,6 +14,7 @@
 #include <linux/resource.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
+#include <linux/i2c.h>
 
 #include <asm/netlogic/xlr/iomap.h>
 #include <asm/netlogic/xlr/pic.h>
@@ -66,6 +67,34 @@ void nlm_xlr_uart_out(struct uart_port *p, int offset, int value)
 		.serial_out	= nlm_xlr_uart_out,	\
 	}
 
+#ifdef CONFIG_I2C
+static struct i2c_board_info nlm_i2c_info1[] __initdata = {
+	/* All XLR boards have this RTC and Max6657 Temp Chip */
+	{"ds1374",          0, 0x68, 0, 0, 0},
+	{"lm90",            0, 0x4c, 0, 0, 0},
+};
+
+static struct platform_device nlm_xlr_i2c_1 = {
+	.name           = "xlr_i2cbus",
+	.id             = 1,
+};
+
+static int __init nlm_i2c_init(void)
+{
+	int err = 0;
+
+	platform_device_register(&nlm_xlr_i2c_1);
+
+	err = i2c_register_board_info(1, nlm_i2c_info1,
+				ARRAY_SIZE(nlm_i2c_info1));
+	if (err < 0)
+		pr_err("nlm-i2c: cannot register board I2C devices\n");
+	return err;
+}
+
+arch_initcall(nlm_i2c_init);
+#endif
+
 static struct plat_serial8250_port xlr_uart_data[] = {
 	PORT(PIC_UART_0_IRQ),
 	PORT(PIC_UART_1_IRQ),
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 646068e..a75af78 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -309,6 +309,17 @@ config I2C_AU1550
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-au1550.
 
+config I2C_XLR
+	tristate "XLR I2C support"
+	depends on I2C && CPU_XLR
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
index e6cf294..14e7a76 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_I2C_TEGRA)		+= i2c-tegra.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
 obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
+obj-$(CONFIG_I2C_XLR)           += i2c-xlr.o
 obj-$(CONFIG_I2C_EG20T)         += i2c-eg20t.o
 
 # External I2C/SMBus adapter drivers
diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
new file mode 100644
index 0000000..ac3d989
--- /dev/null
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -0,0 +1,335 @@
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
+#include <asm/netlogic/xlr/iomap.h>
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
+struct xlr_i2c_private {
+	struct i2c_adapter adap;
+	u32 *iobase_i2c_regs;
+};
+static struct xlr_i2c_private  xlr_i2c_priv;
+
+u32 *get_i2c_base(unsigned short bus)
+{
+	nlm_reg_t *mmio = 0;
+
+	if (bus == 0)
+		mmio = netlogic_io_mmio(NETLOGIC_IO_I2C_0_OFFSET);
+	else
+		mmio = netlogic_io_mmio(NETLOGIC_IO_I2C_1_OFFSET);
+
+	return (u32 *)mmio;
+}
+
+static void xlr_i2c_write(u32 *iobase_i2c_regs, int reg, int val)
+{
+	netlogic_write_reg(iobase_i2c_regs, reg, val);
+}
+
+static u32 xlr_i2c_read(u32 *iobase_i2c_regs, int reg)
+{
+	u32 retVal = netlogic_read_reg(iobase_i2c_regs, reg);
+	return retVal;
+}
+
+static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
+		u8 *buf, u16 addr, u8 offset)
+{
+	u32 i2c_status = 0x00;
+	u8 nb;
+	int pos;
+
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_ADDR, offset);
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_DEVADDR, addr);
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_CFG, XLR_I2C_CFG_ADDR);
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_BYTECNT, len - 1);
+
+retry:
+	pos = 0;
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_DATAOUT, buf[pos]);
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_STARTXFR,
+			XLR_I2C_STARTXFR_WR);
+
+	while (1) {
+		i2c_status = xlr_i2c_read(priv->iobase_i2c_regs,
+				XLR_I2C_STATUS);
+
+		if (i2c_status & XLR_I2C_SDOEMPTY) {
+			pos++;
+			nb = (pos < len) ? buf[pos] : 0;
+			xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_DATAOUT,
+					nb);
+		}
+
+		if (i2c_status & XLR_I2C_ARB_STARTERR)
+			goto retry;
+
+		if (i2c_status & XLR_I2C_ACK_ERR) {
+			dev_err(&priv->adap.dev, "ACK ERR\n");
+			return -1;
+		}
+
+		if (i2c_status & XLR_I2C_BUS_BUSY)
+			continue;
+
+		if (pos >= len)
+			break;
+	}
+
+	return 0;
+}
+
+static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len,
+		u8 *buf, u16 addr, u8 offset)
+{
+	u32 i2c_status = 0x00;
+	int pos = 0;
+	int timeOut = 0;
+	struct i2c_adapter *adap = &priv->adap;
+
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_ADDR, offset);
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_DEVADDR, addr);
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_CFG, XLR_I2C_CFG_ADDR);
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_BYTECNT, 0);
+
+retry_nd:
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_STARTXFR,
+			XLR_I2C_STARTXFR_ND);
+	while (1) {
+		if (timeOut++ > 0x1000) {
+			dev_err(&adap->dev, "XLR_I2C_STARTXFR_ND Rx Timeout\n");
+			return -1;
+		}
+
+		i2c_status = xlr_i2c_read(priv->iobase_i2c_regs,
+				XLR_I2C_STATUS);
+		if (i2c_status & XLR_I2C_ARB_STARTERR)
+			goto retry_nd;
+
+		if (i2c_status & XLR_I2C_ACK_ERR) {
+			dev_err(&adap->dev, "XLR_I2C_STARTXFR_ND ACK ERR\n");
+			return -1;
+		}
+		if ((i2c_status & XLR_I2C_BUS_BUSY) == 0)
+			break;
+		udelay(1);
+	}
+
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_CFG, XLR_I2C_CFG_NOADDR);
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_BYTECNT, len-1);
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_ADDR, offset);
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_DEVADDR, addr);
+	timeOut = 0;
+
+retry:
+	xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_STARTXFR,
+			XLR_I2C_STARTXFR_RD);
+
+	while (1) {
+		if (timeOut++ > 0x1000) {
+			dev_err(&adap->dev, "XLR_I2C_STARTXFR_RD Rx Timeout\n");
+			return -1;
+		}
+
+		i2c_status = xlr_i2c_read(priv->iobase_i2c_regs,
+				XLR_I2C_STATUS);
+		if (i2c_status & XLR_I2C_RXRDY) {
+			buf[pos++] = (u8)xlr_i2c_read(priv->iobase_i2c_regs,
+					XLR_I2C_DATAIN);
+		}
+
+		if (i2c_status & XLR_I2C_ARB_STARTERR)
+			goto retry;
+
+		if (i2c_status & XLR_I2C_ACK_ERR) {
+			dev_err(&adap->dev, "XLR_I2C_STARTXFR_ND ACK ERR\n");
+			return -1;
+		}
+
+		if (i2c_status & XLR_I2C_BUS_BUSY) {
+			udelay(1);
+			continue;
+		}
+			break;
+	}
+	return 0;
+}
+
+static int smbus_xfer(struct i2c_adapter *i2c_adap,
+		u16		addr,
+		unsigned short	flags,
+		char		read_write,
+		u8		command,
+		int		protocol,
+		union i2c_smbus_data *data)
+{
+	struct xlr_i2c_private *priv = i2c_adap->algo_data;
+	int err;
+	int len;
+
+	switch (protocol) {
+	case I2C_SMBUS_BYTE:
+		if (read_write == I2C_SMBUS_READ)
+			err = xlr_i2c_rx(priv, 1, &data->byte, addr, command);
+		else
+			err = xlr_i2c_tx(priv, 1, &data->byte, addr, command);
+
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		if (read_write == I2C_SMBUS_READ)
+			err = xlr_i2c_rx(priv, 1, &data->byte, addr, command);
+		else
+			err = xlr_i2c_tx(priv, 1, &data->byte, addr, command);
+		break;
+
+	case I2C_SMBUS_WORD_DATA:
+	case I2C_SMBUS_PROC_CALL:
+		if (read_write == I2C_SMBUS_READ)
+			err = xlr_i2c_rx(priv, 2, (u8 *)&data->word,
+					addr, command);
+		else
+			err = xlr_i2c_tx(priv, 2, (u8 *)&data->word,
+					addr, command);
+
+		break;
+	case I2C_FUNC_SMBUS_BLOCK_DATA:
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		len = (data->block[0] > I2C_SMBUS_BLOCK_MAX) ?
+			I2C_SMBUS_BLOCK_MAX : data->block[0];
+		if (read_write == I2C_SMBUS_READ)
+			err = xlr_i2c_rx(priv, len, &data->block[1],
+					addr, command);
+		else
+			err = xlr_i2c_tx(priv, len, &data->block[1],
+					addr, command);
+
+		break;
+	default:
+		err = -1;
+	}
+	return err;
+}
+
+static u32 xlr_func(struct i2c_adapter *adap)
+{
+	/* We emulate SMBUS over I2C */
+	return I2C_FUNC_SMBUS_EMUL;
+}
+
+static struct i2c_algorithm xlr_i2c_algo = {
+	.smbus_xfer	= smbus_xfer,
+	.functionality	= xlr_func,
+};
+
+int xlr_i2c_add_bus(struct xlr_i2c_private *priv)
+{
+	priv->adap.owner	= THIS_MODULE;
+	priv->adap.algo_data	= priv;
+	priv->adap.nr		= 1;
+	priv->adap.algo		= &xlr_i2c_algo;
+	priv->adap.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	snprintf(priv->adap.name, sizeof(priv->adap.name),
+			"SMBus XLR I2C Adapter");
+
+	/* register new adapter to i2c module... */
+	if (i2c_add_numbered_adapter(&priv->adap))
+		return -1;
+
+	return 0;
+}
+
+int xlr_i2c_del_bus(struct i2c_adapter *adap)
+{
+	return i2c_del_adapter(adap);
+}
+
+static int __devinit xlr_i2c_probe(struct platform_device *pd)
+{
+	xlr_i2c_priv.iobase_i2c_regs = get_i2c_base(pd->id);
+
+	xlr_i2c_priv.adap.dev.parent = &pd->dev;
+	if (xlr_i2c_add_bus(&xlr_i2c_priv) < 0) {
+		dev_err(&xlr_i2c_priv.adap.dev, "Failed to add i2c bus\n");
+		goto out;
+	} else
+		dev_info(&xlr_i2c_priv.adap.dev, "Added I2C Bus.\n");
+
+	return 0;
+out:
+	return -ENODEV;
+}
+
+static int __devexit xlr_i2c_remove(struct platform_device *pd)
+{
+	return xlr_i2c_del_bus(&xlr_i2c_priv.adap);
+}
+
+static struct platform_driver xlr_i2c_driver = {
+	.probe  = xlr_i2c_probe,
+	.remove = __devexit_p(xlr_i2c_remove),
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "xlr_i2cbus",
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
+MODULE_AUTHOR("Netlogic Microsystems Inc.");
+MODULE_DESCRIPTION("XLR I2C SMBus driver");
+MODULE_LICENSE("GPL");
+
+module_init(xlr_i2c_init);
+module_exit(xlr_i2c_exit);
-- 
1.7.4.1
