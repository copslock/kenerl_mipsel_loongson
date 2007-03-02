Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2007 21:12:54 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:28083 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20039622AbXCBVKl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Mar 2007 21:10:41 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 215FC8D1698
	for <linux-mips@linux-mips.org>; Fri,  2 Mar 2007 22:09:49 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	linux-mips@linux-mips.org
Subject: [PATCH 6/7] I2C via MTX-1 GPIO lines
Date:	Fri, 2 Mar 2007 22:08:05 +0100
User-Agent: KMail/1.9.6
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2IJ6FD92LqAwZM/"
Message-Id: <200703022208.06018.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--Boundary-00=_2IJ6FD92LqAwZM/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch adds support for an I2C bus using GPIO devices. It is preconfigured 
to use the MTX-1 GPIO lines dedicated to I2C.

Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
-- 

--Boundary-00=_2IJ6FD92LqAwZM/
Content-Type: text/plain;
  charset="us-ascii";
  name="010-au100_gpio_i2c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="010-au100_gpio_i2c.patch"

diff -urN linux-2.6.19/drivers/i2c/busses/Kconfig linux-2.6.19.new/drivers/i2c/busses/Kconfig
--- linux-2.6.19/drivers/i2c/busses/Kconfig	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19.new/drivers/i2c/busses/Kconfig	2006-12-28 17:04:34.000000000 +0100
@@ -84,6 +84,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-au1550.
 
+config I2C_AU1X00GPIO
+	tristate "Au1x00 i2c using GPIO pins"
+	depends on I2C
+	select I2C_ALGOBIT
+	help
+	  If you say yest to this option, support will be included for the
+	  Au1x00 GPIO interface.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-au1x00gpio.
+
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
 	depends on I2C && ISA && BROKEN_ON_SMP
diff -urN linux-2.6.19/drivers/i2c/busses/Makefile linux-2.6.19.new/drivers/i2c/busses/Makefile
--- linux-2.6.19/drivers/i2c/busses/Makefile	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19.new/drivers/i2c/busses/Makefile	2006-12-28 03:07:37.000000000 +0100
@@ -9,6 +9,7 @@
 obj-$(CONFIG_I2C_AMD756_S4882)	+= i2c-amd756-s4882.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
+obj-$(CONFIG_I2C_AU1X00GPIO)	+= i2c-au1x00gpio.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
diff -urN linux-2.6.19/drivers/i2c/busses/i2c-au1x00gpio.c linux-2.6.19.new/drivers/i2c/busses/i2c-au1x00gpio.c
--- linux-2.6.19/drivers/i2c/busses/i2c-au1x00gpio.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19.new/drivers/i2c/busses/i2c-au1x00gpio.c	2006-12-28 17:02:10.000000000 +0100
@@ -0,0 +1,406 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-au1x00gpio.c i2c-hw access for Au1x00 GPIO pins.                      */
+/* ------------------------------------------------------------------------- */
+/*   Copyright (C) 1995-2000 Michael Stickel
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
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
+/* ------------------------------------------------------------------------- */ 
+
+/* With some changes from Ky�stialkki <kmalkki@cc.hut.fi> and even
+   Frodo Looijaard <frodol@dds.nl>
+   Simon G. Vogl
+*/
+
+/* $Id: i2c-au1x00gpio.c,v 1.1.1.2 2004/01/22 15:35:47 br1 Exp $ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/stddef.h>
+#include <linux/ioport.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm-mips/mach-au1x00/au1000.h>
+#include <asm-mips/mach-au1x00/au1000_gpio.h>
+
+#include <linux/slab.h>
+#include <linux/mm.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+struct i2c_au1x00gpio
+{
+	struct i2c_au1x00gpio *next;
+
+	short  scl_gpio;
+	short  sda_gpio;
+
+	unsigned long scl_mask;
+	unsigned long sda_mask;
+
+	struct i2c_adapter adapter;
+	struct i2c_algo_bit_data bit_au1x00gpio_data;
+};
+
+static struct i2c_au1x00gpio *adapter_list;
+
+
+
+/* ----- global defines -----------------------------------------------	*/
+#define DEB(x)		/* should be reasonable open, close &c. 	*/
+#define DEB2(x) 	/* low level debugging - very slow 		*/
+#define DEBE(x)	x	/* error messages 				*/
+
+/* ----- printer port defines ------------------------------------------*/
+
+/* ----- local functions ----------------------------------------------	*/
+
+
+//-- Primary GPIO
+static void bit_au1x00gpio_setscl(void *data, int state)
+{
+  struct i2c_au1x00gpio * adapter = (struct i2c_au1x00gpio *)data;
+  if (state)
+    au_writel(adapter->scl_mask, SYS_TRIOUTCLR); // Disable Driver: Switch off Transistor => 1
+  else
+    au_writel(adapter->scl_mask, SYS_OUTPUTCLR); // Clear Output and switch on Transistor => 0
+}
+
+
+static void bit_au1x00gpio_setsda(void *data, int state)
+{
+  struct i2c_au1x00gpio * adapter = (struct i2c_au1x00gpio *)data;
+  if (state)
+    au_writel(adapter->sda_mask, SYS_TRIOUTCLR);
+  else
+    au_writel(adapter->sda_mask, SYS_OUTPUTCLR);
+}
+
+
+static int bit_au1x00gpio_getscl(void *data)
+{
+  struct i2c_au1x00gpio * adapter = (struct i2c_au1x00gpio *)data;
+  return (au_readl(SYS_PINSTATERD) & adapter->scl_mask) ? 1 : 0;
+}
+
+
+static int bit_au1x00gpio_getsda(void *data)
+{
+  struct i2c_au1x00gpio * adapter = (struct i2c_au1x00gpio *)data;
+  return (au_readl(SYS_PINSTATERD) & adapter->sda_mask) ? 1 : 0;
+}
+
+
+
+
+/*--
+ *-- Functions for accessing GPIO-2
+ *--
+ */
+static void bit_au1x00gpio2_setscl(void *data, int state)
+{
+  struct i2c_au1x00gpio * adapter = (struct i2c_au1x00gpio *)data;
+  if (state)
+    {
+      au_writel(au_readl(GPIO2_DIR) & ~adapter->scl_mask, GPIO2_DIR);
+    }
+  else
+    {
+      au_writel(au_readl(GPIO2_OUTPUT) & ~adapter->scl_mask, GPIO2_OUTPUT);
+      au_writel(au_readl(GPIO2_DIR) | adapter->scl_mask, GPIO2_DIR);
+    }
+}
+
+static void bit_au1x00gpio2_setsda(void *data, int state)
+{
+  struct i2c_au1x00gpio * adapter = (struct i2c_au1x00gpio *)data;
+  if (state)
+    {
+      au_writel(au_readl(GPIO2_DIR) & ~adapter->sda_mask, GPIO2_DIR);
+    }
+  else
+    {
+      au_writel(au_readl(GPIO2_OUTPUT) & ~adapter->sda_mask, GPIO2_OUTPUT);
+      au_writel(au_readl(GPIO2_DIR) | adapter->sda_mask, GPIO2_DIR);
+    }
+}
+
+static int bit_au1x00gpio2_getscl(void *data)
+{
+  struct i2c_au1x00gpio * adapter = (struct i2c_au1x00gpio *)data;
+  return (au_readl(GPIO2_PINSTATE) & adapter->scl_mask) ? 1 : 0;
+}
+
+static int bit_au1x00gpio2_getsda(void *data)
+{
+  struct i2c_au1x00gpio * adapter = (struct i2c_au1x00gpio *)data;
+  return (au_readl(GPIO2_PINSTATE) & adapter->sda_mask) ? 1 : 0;
+}
+
+
+
+static int check_i2c_au1x00gpio_adapter(struct i2c_au1x00gpio *adapter)
+{
+  int state = 0;
+
+  adapter->bit_au1x00gpio_data.setsda (adapter, 1);
+  adapter->bit_au1x00gpio_data.setscl (adapter, 1);
+
+  if (adapter->bit_au1x00gpio_data.getsda(adapter)==0)
+    {
+      printk ("i2c-au1x00gpio: sda line should read 1 but reads 0\n");
+      state = -1;
+    }
+  if (adapter->bit_au1x00gpio_data.getscl(adapter)==0)
+    {
+      printk ("i2c-au1x00gpio: scl line should read 1 but reads 0\n");
+      state = -1;
+    }
+
+
+  adapter->bit_au1x00gpio_data.setsda (adapter, 0);
+  adapter->bit_au1x00gpio_data.setscl (adapter, 0);
+
+  if (adapter->bit_au1x00gpio_data.getsda(adapter)==1)
+    {
+      printk ("i2c-au1x00gpio: sda line should read 0 but reads 1\n");
+      state = -1;
+    }
+  if (adapter->bit_au1x00gpio_data.getscl(adapter)==1)
+    {
+      printk ("i2c-au1x00gpio: scl line should read 0 but reads 1\n");
+      state = -1;
+    }
+
+  if (state==0)
+    printk ("i2c-au1x00gpio: adapter with scl=GPIO%d,sda=GPIO%d is working\n",
+	    adapter->scl_gpio, adapter->sda_gpio
+	    );
+  return state;
+}
+
+
+
+#if 0
+static int bit_au1x00gpio_reg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static int bit_au1x00gpio_unreg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static void bit_au1x00gpio_inc_use(struct i2c_adapter *adap)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void bit_au1x00gpio_dec_use(struct i2c_adapter *adap)
+{
+	MOD_DEC_USE_COUNT;
+}
+#endif
+ 
+
+
+static struct i2c_algo_bit_data bit_au1x00gpio_data = {
+	.data = NULL,
+	.setsda = bit_au1x00gpio_setsda,
+	.setscl = bit_au1x00gpio_setscl,
+	.getsda = bit_au1x00gpio_getsda,
+	.getscl = bit_au1x00gpio_getscl,
+	.udelay = 80,
+	.timeout = HZ,
+}; 
+
+
+static struct i2c_adapter bit_au1x00gpio_ops = {
+        .owner          = THIS_MODULE,
+        .name           = "Au1x00 GPIO I2C adapter",
+        .id             = I2C_HW_B_AU1x00GPIO,
+};
+
+
+
+/*
+ * scl_gpio:
+ *   0..31 for primary GPIO's
+ *   200..215 for secondary GPIO's
+ *
+ * sda_gpio:
+ *   0..31 for primary GPIO's
+ *   200..215 for secondary GPIO's
+ *
+ * You can even mix primary and secondary GPIO's.
+ * E.g.:  i2c_au1x00gpio_create(4,206);
+ */
+
+static int i2c_au1x00gpio_create (int scl_gpio, int sda_gpio)
+{
+  if ((scl_gpio < 32 || (scl_gpio >= 200 && scl_gpio <= 215)) &&
+      (scl_gpio < 32 || (scl_gpio >= 200 && scl_gpio <= 215)))
+    {
+	struct i2c_au1x00gpio *adapter = kmalloc(sizeof(struct i2c_au1x00gpio),
+					  GFP_KERNEL);
+	if (!adapter) {
+		printk(KERN_ERR "i2c-au1x00-gpio: Unable to malloc.\n");
+		return -1;
+	}
+
+	printk(KERN_DEBUG "i2c-au1x00-gpio.o: attaching to SCL=GPIO%d, SDA=GPIO%d\n",
+	       scl_gpio, sda_gpio);
+
+	memset (adapter, 0, sizeof(struct i2c_au1x00gpio));
+
+	adapter->adapter = bit_au1x00gpio_ops;
+
+	adapter->adapter.algo_data = &adapter->bit_au1x00gpio_data;
+	adapter->bit_au1x00gpio_data = bit_au1x00gpio_data;
+	adapter->bit_au1x00gpio_data.data = adapter;
+
+	adapter->bit_au1x00gpio_data.data = adapter;
+
+	adapter->scl_gpio = scl_gpio;
+	adapter->sda_gpio = sda_gpio;
+
+        if (sda_gpio < 32)
+          {
+	    adapter->bit_au1x00gpio_data.setsda = bit_au1x00gpio_setsda;
+	    adapter->bit_au1x00gpio_data.getsda = bit_au1x00gpio_getsda;
+            adapter->sda_mask = 1<<sda_gpio;
+          }
+        else if (sda_gpio >= 200 && sda_gpio <= 215)
+          {
+	    adapter->bit_au1x00gpio_data.setsda = bit_au1x00gpio2_setsda;
+	    adapter->bit_au1x00gpio_data.getsda = bit_au1x00gpio2_getsda;
+            adapter->sda_mask = 1<<(sda_gpio-200);
+          }
+
+
+        if (scl_gpio < 32)
+          {
+	    adapter->bit_au1x00gpio_data.setscl = bit_au1x00gpio_setscl;
+	    adapter->bit_au1x00gpio_data.getscl = bit_au1x00gpio_getscl;
+            adapter->scl_mask = 1<<scl_gpio;
+          }
+        else if (scl_gpio >= 200 && scl_gpio <= 215)
+          {
+ 	    adapter->bit_au1x00gpio_data.setscl = bit_au1x00gpio2_setscl;
+	    adapter->bit_au1x00gpio_data.getscl = bit_au1x00gpio2_getscl;
+            adapter->scl_mask = 1<<(scl_gpio-200);
+          }
+
+	au_writel(0L, SYS_PININPUTEN);
+	if (check_i2c_au1x00gpio_adapter(adapter)==0)
+	  {
+	    adapter->bit_au1x00gpio_data.setsda (adapter, 1);
+	    adapter->bit_au1x00gpio_data.setscl (adapter, 1);
+
+	    if (i2c_bit_add_bus(&adapter->adapter) < 0)
+	      {
+		printk(KERN_ERR "i2c-au1x00-gpio: Unable to register with I2C.\n");
+		kfree(adapter);
+		return -1;		/* No good */
+	      }
+	    
+	    adapter->next = adapter_list;
+	    adapter_list = adapter;
+	    return 0;
+	  }
+    }
+  else
+    printk(KERN_ERR "i2c-au1x00-gpio: Invalid argument scl_gpio=%d, sda_gpio=%d.\n", scl_gpio, sda_gpio);
+  return -1;
+}
+
+
+
+static void i2c_au1x00gpio_delete (int scl_gpio, int sda_gpio)
+{
+	struct i2c_au1x00gpio *adapter, *prev = NULL;
+
+	for (adapter = adapter_list; adapter; adapter = adapter->next)
+	{
+		if (adapter->scl_gpio == scl_gpio &&
+		    adapter->sda_gpio == sda_gpio)
+		{
+			i2c_bit_del_bus(&adapter->adapter);
+			if (prev)
+				prev->next = adapter->next;
+			else
+				adapter_list = adapter->next;
+			kfree(adapter);
+			return;
+		}
+		prev = adapter;
+	}
+}
+
+
+
+
+
+#ifndef CONFIG_I2C_AU1X00GPIO_SCL
+#define CONFIG_I2C_AU1X00GPIO_SCL (210)
+#endif
+
+#ifndef CONFIG_I2C_AU1X00GPIO_SDA
+#define CONFIG_I2C_AU1X00GPIO_SDA (9)
+#endif
+
+static int au1x00gpiopin_scl = CONFIG_I2C_AU1X00GPIO_SCL;
+static int au1x00gpiopin_sda = CONFIG_I2C_AU1X00GPIO_SDA;
+
+
+
+static int __init i2c_bit_au1x00gpio_init(void)
+{
+  printk(KERN_INFO "i2c-au1x00gpio.o: i2c Au1x00 GPIO adapter module version\n");
+
+  if (i2c_au1x00gpio_create (au1x00gpiopin_scl, au1x00gpiopin_sda) == 0)
+    {
+      printk(KERN_INFO "i2c-au1x00gpio.o: registered I2C-Bus for GPIO%d,GPIO%d\n",
+            au1x00gpiopin_scl, au1x00gpiopin_sda
+            );
+      return 0;
+    }
+  printk(KERN_INFO "i2c-au1x00gpio.o: failed to register I2C-Bus for GPIO%d,GPIO%d\n",
+            au1x00gpiopin_scl, au1x00gpiopin_sda
+        );
+  return -1;
+}
+
+
+static void __exit i2c_bit_au1x00gpio_exit(void)
+{
+  i2c_au1x00gpio_delete (au1x00gpiopin_scl, au1x00gpiopin_sda);
+}
+
+module_param(au1x00gpiopin_scl, int, 0644);
+MODULE_PARM_DESC(au1x00gpiopin_scl, "GPIO pin number used for SCL pin.");
+
+module_param(au1x00gpiopin_sda, int, 0644);
+MODULE_PARM_DESC(au1x00gpiopin_sda, "GPIO pin number used for SDA pin.");
+
+MODULE_AUTHOR("Michael Stickel <michael@cubic.org>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for Au1x00 GPIO adapter.");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_bit_au1x00gpio_init);
+module_exit(i2c_bit_au1x00gpio_exit);
diff -urN linux-2.6.19/include/linux/i2c-id.h linux-2.6.19.new/include/linux/i2c-id.h
--- linux-2.6.19/include/linux/i2c-id.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19.new/include/linux/i2c-id.h	2006-12-28 03:12:15.000000000 +0100
@@ -231,6 +231,9 @@
 /* --- Au1550 PSC adapters adapters					*/
 #define I2C_HW_AU1550_PSC	0x1b0000
 
+/* --- Au1x00 i2c GPIO adapter						*/
+#define I2C_HW_B_AU1x00GPIO 0x1b
+
 /* --- SMBus only adapters						*/
 #define I2C_HW_SMBUS_PIIX4	0x040000
 #define I2C_HW_SMBUS_ALI15X3	0x040001

--Boundary-00=_2IJ6FD92LqAwZM/--
