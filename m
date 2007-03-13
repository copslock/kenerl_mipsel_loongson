Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 17:59:57 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:50073 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20022312AbXCMR7w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 17:59:52 +0000
Received: from [192.168.1.112] (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 872668810; Tue, 13 Mar 2007 21:59:19 +0400 (SAMT)
Subject: [PATCH] EMMA2RH I2C driver
From:	dmitry pervushin <dpervushin@ru.mvista.com>
Reply-To: dpervushin@ru.mvista.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070308145948.GA4235@linux-mips.org>
References: <20070308145948.GA4235@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Organization: MontaVista RU
Date:	Tue, 13 Mar 2007 20:59:51 +0300
Message-Id: <1173808791.4948.10.camel@diimka>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2 
Content-Transfer-Encoding: 8bit
Return-Path: <dpervushin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dpervushin@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Below is patch to support I2C controller on NEC EMMA2RH board

Signed-off: dmitry pervushin <dpervushin@ru.mvista.com>

 drivers/i2c/algos/Kconfig            |    5 
 drivers/i2c/algos/Makefile           |    1 
 drivers/i2c/algos/i2c-algo-emma2rh.c |  426 +++++++++++++++++++++++++++++++++++
 drivers/i2c/algos/i2c-algo-emma2rh.h |  105 ++++++++
 drivers/i2c/busses/Kconfig           |    7 
 drivers/i2c/busses/Makefile          |    1 
 drivers/i2c/busses/i2c-emma2rh.c     |  253 ++++++++++++++++++++
 7 files changed, 798 insertions(+)

Index: linux-2.6.20/drivers/i2c/algos/Kconfig
===================================================================
--- linux-2.6.20.orig/drivers/i2c/algos/Kconfig
+++ linux-2.6.20/drivers/i2c/algos/Kconfig
@@ -49,5 +49,10 @@ config I2C_ALGO_SGI
 	  Supports the SGI interfaces like the ones found on SGI Indy VINO
 	  or SGI O2 MACE.
 
+config I2C_ALGO_EMMA2RH
+	tristate "I2C EMMA2RH interfaces"
+	depends on I2C && MARKEINS
+	help
+	  NEC EMMA2RH I2C Algorithm
 endmenu
 
Index: linux-2.6.20/drivers/i2c/algos/Makefile
===================================================================
--- linux-2.6.20.orig/drivers/i2c/algos/Makefile
+++ linux-2.6.20/drivers/i2c/algos/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bi
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
 obj-$(CONFIG_I2C_ALGOPCA)	+= i2c-algo-pca.o
 obj-$(CONFIG_I2C_ALGO_SGI)	+= i2c-algo-sgi.o
+obj-$(CONFIG_I2C_ALGO_EMMA2RH)	+= i2c-algo-emma2rh.o
 
 ifeq ($(CONFIG_I2C_DEBUG_ALGO),y)
 EXTRA_CFLAGS += -DDEBUG
Index: linux-2.6.20/drivers/i2c/algos/i2c-algo-emma2rh.c
===================================================================
--- /dev/null
+++ linux-2.6.20/drivers/i2c/algos/i2c-algo-emma2rh.c
@@ -0,0 +1,426 @@
+/*
+   -------------------------------------------------------------------------
+   i2c-algo-emma2rh.c i2c driver algorithms for NEC EMMA2RH I2C adapters
+   -------------------------------------------------------------------------
+
+    Copyright (C) NEC Electronics Corporation 2005-2006
+
+    Changes made to support the I2C peripheral on the NEC EMMA2RH
+
+   -------------------------------------------------------------------------
+    This file was highly leveraged from i2c-algo-pcf.c, which was created
+    by Simon G. Vogl and Hans Berglund:
+
+     Copyright (C) 1995-1997 Simon G. Vogl
+                   1998-2000 Hans Berglund
+
+    With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and
+    Frodo Looijaard <frodol@dds.nl> ,and also from Martin Bailey
+    <mbailey@littlefeet-inc.com>
+
+    Partially rewriten by Oleg I. Vdovikin <vdovikin@jscc.ru> to handle multiple
+    messages, proper stop/repstart signaling during receive,
+    added detect code
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+   -------------------------------------------------------------------------
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-emma2rh.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+#ifdef DEBUG
+#define i2c_emma2rh_debug(level,op) do { if (i2c_debug>=(level)) { op; } } while (0)
+static int i2c_debug;
+module_param(i2c_debug, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(i2c_debug,
+		 "debug level - 0 off; 1 normal; 2,3 more verbose; 9 i2c-protocol");
+#else
+#define i2c_emma2rh_debug(level,op) /* nothing */
+#endif
+
+#define DEB(x) i2c_emma2rh_debug(1, x)
+#define DEB2(x) i2c_emma2rh_debug(2, x)
+#define DEB3(x) i2c_emma2rh_debug(3, x)
+#define DEBPROTO(x) i2c_emma2rh_debug(9,x)
+
+#define EMMA2RH_I2C_RETRIES 3
+#define EMMA2RH_I2C_TIMEOUT 100
+
+/* --- setting states on the bus with the right timing: ---------------	*/
+#define set_emma(adap, ctl, val) adap->setemma(adap->data, ctl, val)
+#define get_emma(adap, ctl) adap->getemma(adap->data, ctl)
+#define get_own(adap) adap->getown(adap->data)
+#define get_clock(adap) adap->getclock(adap->data)
+
+/* --- other auxiliary functions --------------------------------------	*/
+
+static void i2c_start(struct i2c_algo_emma_data *adap)
+{
+	DEBPROTO(printk("S "));
+	set_emma(adap, I2C_EMMA_CNT, I2C_EMMA_START);
+}
+
+static void i2c_repstart(struct i2c_algo_emma_data *adap)
+{
+	DEBPROTO(printk(" Sr "));
+	set_emma(adap, I2C_EMMA_CNT, I2C_EMMA_REPSTART);
+}
+
+static void i2c_stop(struct i2c_algo_emma_data *adap)
+{
+	DEBPROTO(printk("P\n"));
+	set_emma(adap, I2C_EMMA_CNT, I2C_EMMA_STOP);
+}
+
+static inline void emma_sleep(unsigned long timeout)
+{
+	schedule_timeout(timeout * HZ);
+}
+
+static int wait_for_pin(struct i2c_algo_emma_data *adap, int *status)
+{
+	adap->waitforpin(adap->data);
+	*status = get_emma(adap, I2C_EMMA_STA);
+	return 0;
+}
+
+static int emma_init(struct i2c_algo_emma_data *adap)
+{
+	unsigned char temp;
+
+	/* serial interface off */
+	set_emma(adap, I2C_EMMA_CNT, 0);
+
+	/* load clock register CS */
+	set_emma(adap, I2C_EMMA_CSEL, get_clock(adap));
+	udelay(20);		/* wait awhile */
+	/* check it's realy written, the only 4 lowest bits does matter */
+	if (((temp = get_emma(adap, I2C_EMMA_CSEL)) & 0x8f) != get_clock(adap)) {
+		DEB2(printk
+		     (KERN_ERR
+		      "%s: EMMA detection failed -- can't set I2C_EMMA_CSEL (0x%02x).\n",
+		      __FUNCTION__, temp));
+		return -ENXIO;
+	}
+
+	/* initialize interrupt mask */
+	set_emma(adap, I2C_EMMA_INT, 0);
+	set_emma(adap, I2C_EMMA_INTM, INTE0);
+
+	/* Enable serial interface */
+	set_emma(adap, I2C_EMMA_CNT, IICE);
+
+	/* generate a STOP condition, first of all */
+	i2c_stop(adap);
+
+	return 0;
+}
+
+static int emma_exit(struct i2c_algo_emma_data *adap)
+{
+	set_emma(adap, I2C_EMMA_INTM, 0);
+}
+
+/* --- Utility functions ---------------------------------------------- */
+
+static inline int try_address(struct i2c_algo_emma_data *adap,
+			      unsigned char addr, int retries)
+{
+	int i, status, ret = -1;
+
+	for (i = 0; i < retries; i++) {
+		i2c_start(adap);
+		set_emma(adap, I2C_EMMA_SHR, addr);
+		if (wait_for_pin(adap, &status) >= 0)
+			if (status & ACKD) {
+				i2c_stop(adap);
+				ret = 1;
+				break;	/* success! */
+			}
+		i2c_stop(adap);
+		udelay(adap->udelay);
+	}
+	DEB2(if (i)
+	     printk(KERN_DEBUG "%s: needed %d retries for %d\n", __FUNCTION__, i, addr)) ;
+	return ret;
+}
+
+static int emma_sendbytes(struct i2c_adapter *i2c_adap, const char *buf,
+			  int count, int last)
+{
+	struct i2c_algo_emma_data *adap = i2c_adap->algo_data;
+	int wrcount, status, timeout;
+
+	set_emma(adap, I2C_EMMA_CNT, IICE | WTIM);
+	for (wrcount = 0; wrcount < count; wrcount++) {
+		set_emma(adap, I2C_EMMA_INT, 0);
+		set_emma(adap, I2C_EMMA_SHR, buf[wrcount] & SR);
+		timeout = wait_for_pin(adap, &status);
+		if (timeout) {
+			i2c_stop(adap);
+			printk(KERN_ERR "%s i2c_write: "
+			       "error - timeout.\n", i2c_adap->name);
+			return -EREMOTEIO;	/* got a better one ?? */
+		}
+		if (!(status & ACKD)) {
+			i2c_stop(adap);
+			printk(KERN_ERR "%s i2c_write: "
+			       "error - no ack.\n", i2c_adap->name);
+			return -EREMOTEIO;	/* got a better one ?? */
+		}
+	}
+
+	if (last)
+		i2c_stop(adap);
+	else
+		i2c_repstart(adap);
+
+	return (wrcount);
+}
+
+static int emma_readbytes(struct i2c_adapter *i2c_adap, char *buf,
+			  int count, int last)
+{
+	struct i2c_algo_emma_data *adap = i2c_adap->algo_data;
+	int rdcount, status, timeout;
+
+	for (rdcount = 0; rdcount < count; rdcount++) {
+
+		/* we will suffer from unexpected interrupts if we
+		 * use 8-clock-wait.
+		 */
+
+		set_emma(adap, I2C_EMMA_INT, 0);
+		if (rdcount == count - 1)
+			/* last byte */
+			set_emma(adap, I2C_EMMA_CNT, IICE | WREL | WTIM);
+		else
+			set_emma(adap, I2C_EMMA_CNT, IICE | WREL | WTIM | ACKE);
+
+		timeout = wait_for_pin(adap, &status);
+		if (timeout) {
+			i2c_stop(adap);
+			printk(KERN_ERR
+			       "i2c-algo-emma.o: emma_readbytes timed out.\n");
+			return (-1);
+		}
+		if (!(status & ACKD) && (rdcount != count - 1)) {
+			i2c_stop(adap);
+			printk(KERN_ERR
+			       "i2c-algo-emma.o: i2c_read: i2c_inb, No ack.\n");
+			return (-1);
+		}
+		buf[rdcount] = get_emma(adap, I2C_EMMA_SHR);
+	}
+
+	if (last)
+		i2c_stop(adap);
+	else
+		i2c_repstart(adap);
+
+	return (rdcount);
+}
+
+static inline int emma_doAddress(struct i2c_algo_emma_data *adap,
+				 struct i2c_msg *msg, int retries)
+{
+	unsigned short flags = msg->flags;
+	unsigned int addr;
+	int ret;
+
+	set_emma(adap, I2C_EMMA_INT, 0);
+
+	if (flags & I2C_M_TEN) {
+		/* a ten bit address */
+		addr = 0xf0 | ((msg->addr >> 7) & 0x03);
+		DEB2(printk(KERN_DEBUG "addr0: %d\n", addr));
+
+		/* try extended address code... */
+		ret = try_address(adap, addr, retries);
+		if (ret != 1) {
+			printk(KERN_ERR "died at extended address code.\n");
+			return -EREMOTEIO;
+		}
+		/* the remaining 8 bit address */
+		/* ...TBD */
+		printk(KERN_ERR"10 bit addresses are not supported in this driver.\n");
+		return -EREMOTEIO;
+	} else {		/* normal 7bit address  */
+		addr = (msg->addr << 1);
+		if (flags & I2C_M_RD)
+			addr |= 1;
+		if (flags & I2C_M_REV_DIR_ADDR)
+			addr ^= 1;
+		set_emma(adap, I2C_EMMA_SHR, addr);
+	}
+	return 0;
+}
+
+static int emma_xfer(struct i2c_adapter *i2c_adap,
+		     struct i2c_msg msgs[], int num)
+{
+	struct i2c_algo_emma_data *adap = i2c_adap->algo_data;
+	struct i2c_msg *pmsg;
+	int i;
+	int ret = 0, timeout, status;
+
+	for (i = 0; ret >= 0 && i < num; i++) {
+		pmsg = &msgs[i];
+
+		DEB2(printk
+		     (KERN_DEBUG
+		      "Doing %s %d bytes to 0x%02x - %d of %d messages\n",
+		      pmsg->flags & I2C_M_RD ? "read" : "write", pmsg->len,
+		      pmsg->addr, i + 1, num));
+
+		/* Send START */
+		if (i == 0)
+			i2c_start(adap);
+
+		ret = emma_doAddress(adap, pmsg, i2c_adap->retries);
+
+		/* Wait for PIN (pending interrupt NOT) */
+		timeout = wait_for_pin(adap, &status);
+		if (timeout) {
+			i2c_stop(adap);
+			DEB2(printk(KERN_ERR "Timeout waiting "
+				    "for PIN(1) in emma_xfer\n"));
+			return (-EREMOTEIO);
+		}
+
+		/* Check LRB (last rcvd bit - slave ack) */
+		if (!(status & ACKD)) {
+			i2c_stop(adap);
+			DEB2(printk
+			     (KERN_ERR
+			      "No LRB(1) in emma_xfer\n"));
+			return (-EREMOTEIO);
+		}
+
+		DEB3(printk
+		     (KERN_DEBUG
+		      "i2c-algo-emma.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
+		      i, msgs[i].addr, msgs[i].flags, msgs[i].len));
+
+		if (pmsg->flags & I2C_M_RD)
+			/* read bytes into buffer */
+			ret = emma_readbytes(i2c_adap, pmsg->buf, pmsg->len,
+					     (i + 1 == num));
+		 else 	/* Write */
+			ret = emma_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
+					     (i + 1 == num));
+
+		DEB2( printk( KERN_DEBUG "transferred %d bytes of %d -- %s\n",
+					ret, pmsg->len, ret != pmsg->len ? "FAIL" : "succeeded"));
+	}
+
+	return (i);
+}
+
+static int algo_control(struct i2c_adapter *adapter,
+			unsigned int cmd, unsigned long arg)
+{
+	return 0;
+}
+
+static u32 emma_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
+}
+
+/* --- exported algorithm data ---------------------------------------- */
+
+static struct i2c_algorithm emma_algo = {
+	.master_xfer = emma_xfer,
+	.smbus_xfer = NULL,
+	.algo_control = algo_control,	/* ioctl */
+	.functionality = emma_func,	/* functionality */
+};
+
+/*
+ * registering functions to load algorithms at routine
+ */
+int i2c_emma_add_bus(struct i2c_adapter *adap)
+{
+	int i;
+	struct i2c_algo_emma_data *emma_adap = adap->algo_data;
+
+	DEB2(printk
+	     (KERN_DEBUG "hw routines for %s registered.\n",
+	      adap->name));
+
+	/* register new adapter to i2c module... */
+	adap->algo = &emma_algo;
+
+	adap->timeout = EMMA2RH_I2C_TIMEOUT;	/* default values, should */
+	adap->retries = EMMA2RH_I2C_RETRIES;	/* be replaced by defines */
+
+	if ((i = emma_init(emma_adap)))
+		return i;
+
+	i2c_add_adapter(adap);
+
+	return 0;
+}
+
+int i2c_emma_del_bus(struct i2c_adapter *adap)
+{
+	int res;
+	struct i2c_algo_emma_data *emma_adap = adap->algo_data;
+
+	emma_exit(emma_adap);
+
+	if ((res = i2c_del_adapter(adap)) < 0)
+		return res;
+	DEB2(printk(KERN_DEBUG "adapter unregistered: %s\n",
+		    adap->name));
+
+	return 0;
+}
+
+int __init i2c_algo_emma_init(void)
+{
+	return 0;
+}
+
+void i2c_algo_emma_exit(void)
+{
+	return;
+}
+
+EXPORT_SYMBOL_GPL(i2c_emma_add_bus);
+EXPORT_SYMBOL_GPL(i2c_emma_del_bus);
+
+MODULE_AUTHOR("NEC Electronics Corporation <www.necel.com>");
+MODULE_DESCRIPTION("NEC EMMA2RH I2C-Bus algorithm");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_algo_emma_init);
+module_exit(i2c_algo_emma_exit);
Index: linux-2.6.20/drivers/i2c/algos/i2c-algo-emma2rh.h
===================================================================
--- /dev/null
+++ linux-2.6.20/drivers/i2c/algos/i2c-algo-emma2rh.h
@@ -0,0 +1,105 @@
+/* -------------------------------------------------------------------- */
+/* i2c-algo-emma2rh.h: NEC EMMA2RH global defines                       */
+/* -------------------------------------------------------------------- */
+/*
+    Copyright (C) NEC Electronics Corporation 2005-2006
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA*/
+/* --------------------------------------------------------------------	*/
+
+#ifndef I2C_EMMA2RH_H
+#define I2C_EMMA2RH_H
+
+/*---------------------------------------------------------------------------*/
+/* CNT - Control register (00H R/W)                                          */
+/*---------------------------------------------------------------------------*/
+#define SPT         0x00000001
+#define STT         0x00000002
+#define ACKE        0x00000004
+#define WTIM        0x00000008
+#define SPIE        0x00000010
+#define WREL        0x00000020
+#define LREL        0x00000040
+#define IICE        0x00000080
+#define CNT_RESERVED    0x000000ff	/* reserved bit 0 */
+
+#define I2C_EMMA_START      (IICE | STT)
+#define I2C_EMMA_STOP       (IICE | SPT)
+#define I2C_EMMA_REPSTART   I2C_EMMA_START
+
+/*---------------------------------------------------------------------------*/
+/* STA - Status register (10H Read)                                          */
+/*---------------------------------------------------------------------------*/
+#define MSTS        0x00000080
+#define ALD         0x00000040
+#define EXC         0x00000020
+#define COI         0x00000010
+#define TRC         0x00000008
+#define ACKD        0x00000004
+#define STD         0x00000002
+#define SPD         0x00000001
+
+/*---------------------------------------------------------------------------*/
+/* CSEL - Clock select register (20H R/W)                                    */
+/*---------------------------------------------------------------------------*/
+#define FCL         0x00000080
+#define ND50        0x00000040
+#define CLD         0x00000020
+#define DAD         0x00000010
+#define SMC         0x00000008
+#define DFC         0x00000004
+#define CL          0x00000003
+#define CSEL_RESERVED   0x000000ff	/* reserved bit 0 */
+
+#define FAST397     0x0000008b
+#define FAST297     0x0000008a
+#define FAST347     0x0000000b
+#define FAST260     0x0000000a
+#define FAST130     0x00000008
+#define STANDARD108 0x00000083
+#define STANDARD83  0x00000082
+#define STANDARD95  0x00000003
+#define STANDARD73  0x00000002
+#define STANDARD36  0x00000001
+#define STANDARD71  0x00000000
+
+/*---------------------------------------------------------------------------*/
+/* SVA - Slave address register (30H R/W)                                    */
+/*---------------------------------------------------------------------------*/
+#define SVA         0x000000fe
+
+/*---------------------------------------------------------------------------*/
+/* SHR - Shift register (40H R/W)                                            */
+/*---------------------------------------------------------------------------*/
+#define SR          0x000000ff
+
+/*---------------------------------------------------------------------------*/
+/* INT - Interrupt register (50H R/W)                                        */
+/* INTM - Interrupt mask register (60H R/W)                                  */
+/*---------------------------------------------------------------------------*/
+#define INTE0       0x00000001
+
+/***********************************************************************
+ * I2C registers
+ ***********************************************************************
+ */
+#define I2C_EMMA_CNT            0x00
+#define I2C_EMMA_STA            0x10
+#define I2C_EMMA_CSEL           0x20
+#define I2C_EMMA_SVA            0x30
+#define I2C_EMMA_SHR            0x40
+#define I2C_EMMA_INT            0x50
+#define I2C_EMMA_INTM           0x60
+#endif				/* I2C_EMMA2RH_H */
Index: linux-2.6.20/drivers/i2c/busses/Kconfig
===================================================================
--- linux-2.6.20.orig/drivers/i2c/busses/Kconfig
+++ linux-2.6.20/drivers/i2c/busses/Kconfig
@@ -573,4 +573,11 @@ config I2C_PNX
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-pnx.
 
+config I2C_EMMA2RH
+	tristate "EMMA2RH I2C adapter"
+	depends on I2C && MARKEINS
+	select I2C_ALGO_EMMA2RH
+	help
+ 	  Support for NEC EMMA2RH I2C Adapter
+
 endmenu
Index: linux-2.6.20/drivers/i2c/busses/Makefile
===================================================================
--- linux-2.6.20.orig/drivers/i2c/busses/Makefile
+++ linux-2.6.20/drivers/i2c/busses/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_I2C_EMMA2RH)	+= i2c-emma2rh.o
 
 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
 EXTRA_CFLAGS += -DDEBUG
Index: linux-2.6.20/drivers/i2c/busses/i2c-emma2rh.c
===================================================================
--- /dev/null
+++ linux-2.6.20/drivers/i2c/busses/i2c-emma2rh.c
@@ -0,0 +1,253 @@
+/*
+   -------------------------------------------------------------------------
+   i2c-emma2rh.c i2c-hw access for the I2C peripheral on the NEC EMMA2RH
+   -------------------------------------------------------------------------
+
+    Copyright (C) NEC Electronics Corporation 2005-2006
+
+    Changes made to support the I2C peripheral on the NEC EMMA2RH
+
+   -------------------------------------------------------------------------
+    This file was highly leveraged from i2c-elektor.c, which was created
+    by Simon G. Vogl and Hans Berglund:
+
+     Copyright (C) 1995-97 Simon G. Vogl
+                   1998-99 Hans Berglund
+
+    With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
+    Frodo Looijaard <frodol@dds.nl>
+
+    Partialy rewriten by Oleg I. Vdovikin for mmapped support of
+    for Alpha Processor Inc. UP-2000(+) boards
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+   -------------------------------------------------------------------------
+*/
+
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/i2c-algo-emma2rh.h>
+#include <linux/platform_device.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/atomic.h>
+#include <asm/emma2rh/emma2rh.h>
+
+#define I2C_EMMA2RH "emma2rh-iic"
+static int i2c_debug = 0;
+
+/* ----- global defines -----------------------------------------------	*/
+#define DEB(x)	if (i2c_debug>=1) x
+#define DEB2(x) if (i2c_debug>=2) x
+#define DEB3(x) if (i2c_debug>=3) x
+#define DEBE(x)	x		/* error messages */
+
+struct i2c_drvdata {
+	struct i2c_algo_emma_data alg;
+	struct i2c_adapter adap;
+	spinlock_t lock;
+	atomic_t pending;
+	u32 base;
+	int irq;
+	int clock;
+	int own;
+	wait_queue_head_t wait;
+};
+
+/* ----- local functions ----------------------------------------------	*/
+static void i2c_emma_setbyte(void *data, int ctl, int val)
+{
+	int address = ((struct i2c_drvdata *)data)->base + ctl;
+
+	DEB3(printk
+	     (KERN_DEBUG "i2c_emma_setbyte: Write 0x%08x 0x%08x\n", address,
+	      val));
+	__raw_writel(val, (void *)address);
+}
+
+static int i2c_emma_getbyte(void *data, int ctl)
+{
+	int address = ((struct i2c_drvdata *)data)->base + ctl;
+	int val = __raw_readl((void *)address);
+
+	DEB3(printk
+	     (KERN_DEBUG "i2c_emma_getbyte: Read 0x%08x 0x%08x\n", address,
+	      val));
+	return (val);
+}
+
+static int i2c_emma_getown(void *data)
+{
+	return (((struct i2c_drvdata *)data)->own);
+}
+
+static int i2c_emma_getclock(void *data)
+{
+	return (((struct i2c_drvdata *)data)->clock);
+}
+
+
+
+static int i2c_emma_reg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static int i2c_emma_unreg(struct i2c_client *client)
+{
+	return 0;
+}
+
+
+static irqreturn_t i2c_emma_handler(int this_irq, void *dev_id)
+{
+	struct i2c_drvdata *dd = dev_id;
+
+	DEB2(printk("i2c_emma_handler: status = 0x%08x\n",
+		    __raw_readl((void *)(dd->base + I2C_EMMA_INT))));
+	/* clear interrupt */
+	__raw_writel(0, (void *)(dd->base + I2C_EMMA_INT));
+
+	atomic_set(&dd->pending, 1);
+	wake_up(&dd->wait);
+	return IRQ_HANDLED;
+}
+
+static void i2c_emma_waitforpin(void *data)
+{
+	int timeout = 2;
+	struct i2c_drvdata *dd = data;
+
+	if (dd->irq >=0) {
+		timeout = wait_event_timeout(dd->wait,
+					     atomic_read(&dd->pending),
+					     timeout * HZ);
+		atomic_set(&dd->pending,0);
+	} else
+		udelay(100);
+}
+
+static int __devinit i2c_emma_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct i2c_drvdata *dd;
+	int err = 0;
+	struct resource *r;
+
+	dd = kzalloc (sizeof *dd, GFP_KERNEL);
+	if (dd == NULL) {
+		err = -ENOMEM;
+		goto out;
+	}
+	dd->alg.data = dd;
+	dd->alg.setemma = i2c_emma_setbyte;
+	dd->alg.getemma = i2c_emma_getbyte;
+	dd->alg.getown = i2c_emma_getown;
+	dd->alg.getclock = i2c_emma_getclock;
+	dd->alg.waitforpin = i2c_emma_waitforpin;
+	dd->alg.udelay = 80;
+	dd->alg.mdelay = 80;
+	dd->alg.timeout = 200;
+
+	strcpy(dd->adap.name, dev->bus_id);
+	dd->adap.id = 0x00;
+	dd->adap.algo = NULL;
+	dd->adap.algo_data = &dd->alg;
+	dd->adap.client_register = i2c_emma_reg;
+	dd->adap.client_unregister = i2c_emma_unreg;
+
+	spin_lock_init(&dd->lock);
+
+	atomic_set(&dd->pending,0);
+	init_waitqueue_head(&dd->wait);
+
+	dev_set_drvdata(dev, dd);
+
+	r = platform_get_resource(pdev, 0, 0);
+	/* get resource of type '0' with #0 */
+
+	if (!r) {
+		printk("Cannot get resource\n");
+		err = -ENODEV;
+		goto out_free;
+	}
+	dd->base = r->start;
+
+	dd->irq = platform_get_irq(pdev,0);
+	dd->clock = FAST397;
+	dd->own = 0x40 + pdev->id * 4;
+
+	err = request_irq(dd->irq, i2c_emma_handler, 0, dev->bus_id, dd);
+	if (err < 0)
+		goto out_free;
+
+	if ((err = i2c_emma_add_bus(&dd->adap)) < 0)
+		goto out_irq;
+
+	return 0;
+out_irq:
+	free_irq(dd->irq, dev->bus_id);
+out_free:
+	kfree(dd);
+out:
+	return err;
+}
+
+static int __devexit i2c_emma_remove (struct device *dev)
+{
+	struct i2c_drvdata* dd = dev_get_drvdata(dev);
+
+	if (dd) {
+		disable_irq(dd->irq);
+		free_irq(dd->irq, dev->bus_id);
+		i2c_emma_del_bus(&dd->adap);
+		kfree(dd);
+	}
+	return 0;
+}
+
+static struct device_driver i2c_emma_driver = {
+	.bus = &platform_bus_type,
+	.name = I2C_EMMA2RH,
+	.probe = i2c_emma_probe,
+	.remove = i2c_emma_remove,
+};
+
+static int __init i2c_emma_init(void)
+{
+	return driver_register(&i2c_emma_driver);
+}
+
+static void __exit i2c_emma_exit(void)
+{
+	driver_unregister(&i2c_emma_driver);
+}
+
+MODULE_AUTHOR("NEC Electronics Corporation <www.necel.com>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for EMMA2RH I2C bus adapter");
+MODULE_LICENSE("GPL");
+
+module_param(i2c_debug, int, S_IRUGO | S_IWUSR);
+module_init(i2c_emma_init);
+module_exit(i2c_emma_exit);
