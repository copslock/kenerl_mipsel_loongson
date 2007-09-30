Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2007 10:55:14 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:64767 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20025704AbXI3JzG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2007 10:55:06 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id l8U9swE4009331;
	Sun, 30 Sep 2007 02:54:58 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Sep 2007 02:54:57 -0700
Received: from [128.224.162.179] ([128.224.162.179]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Sep 2007 02:54:57 -0700
Message-ID: <46FF7262.9060802@windriver.com>
Date:	Sun, 30 Sep 2007 17:54:42 +0800
From:	Mark Zhan <rongkai.zhan@windriver.com>
User-Agent: Thunderbird 1.5.0.13 (X11/20070824)
MIME-Version: 1.0
To:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
CC:	ralf@linux-mips.org, a.zummo@towertech.it,
	rongkai.zhan@windriver.com
Subject: [PATCH 1/4] i2c sibyte adapter driver is rewritten with 2.6.x style
 binding model
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2007 09:54:57.0686 (UTC) FILETIME=[F5869B60:01C80347]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

This patch re-writes the sibyte i2c adapter driver with 2.6.x style
binding model.

Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
---
  drivers/i2c/busses/i2c-sibyte.c |  150 ++++++++++++++--------------------------
  1 file changed, 55 insertions(+), 95 deletions(-)

--- a/drivers/i2c/busses/i2c-sibyte.c
+++ b/drivers/i2c/busses/i2c-sibyte.c
@@ -1,4 +1,5 @@
  /*
+ * Copyright (C) 2007 Wind River Inc. Mark Zhan <rongkai.zhan@windriver.com>
   * Copyright (C) 2004 Steven J. Hill
   * Copyright (C) 2001,2002,2003 Broadcom Corporation
   * Copyright (C) 1995-2000 Simon G. Vogl
@@ -22,34 +23,18 @@
  #include <linux/module.h>
  #include <linux/init.h>
  #include <linux/i2c.h>
-#include <asm/io.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
  #include <asm/sibyte/sb1250_regs.h>
  #include <asm/sibyte/sb1250_smbus.h>

+#define SMB_REG_BASE(p_adap)	(CKSEG1 + A_SMB_BASE(p_adap->nr))
+#define SMB_CSR(p_adap,r)	((long)(SMB_REG_BASE(p_adap) + r))

-struct i2c_algo_sibyte_data {
-	void *data;		/* private data */
-	int   bus;		/* which bus */
-	void *reg_base;		/* CSR base */
-};
-
-/* ----- global defines ----------------------------------------------- */
-#define SMB_CSR(a,r) ((long)(a->reg_base + r))
-
-/* ----- global variables --------------------------------------------- */
-
-/* module parameters:
- */
-static int bit_scan;	/* have a look at what's hanging 'round */
-module_param(bit_scan, int, 0);
-MODULE_PARM_DESC(bit_scan, "Scan for active chips on the bus");
-
-
-static int smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr,
-		      unsigned short flags, char read_write,
-		      u8 command, int size, union i2c_smbus_data * data)
+static int sibyte_smbus_xfer(struct i2c_adapter *adap, u16 addr,
+			unsigned short flags, char read_write,
+			u8 command, int size, union i2c_smbus_data * data)
  {
-	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
  	int data_bytes = 0;
  	int error;

@@ -93,11 +78,9 @@ static int smbus_xfer(struct i2c_adapter
  				  SMB_CSR(adap, R_SMB_START));
  			data_bytes = 2;
  		} else {
-			csr_out32(V_SMB_LB(data->word & 0xff),
-				  SMB_CSR(adap, R_SMB_DATA));
-			csr_out32(V_SMB_MB(data->word >> 8),
+			csr_out32(V_SMB_LB(data->word & 0xff) | V_SMB_MB(data->word >> 8),
  				  SMB_CSR(adap, R_SMB_DATA));
-			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_WR2BYTE),
+			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_WR3BYTE),
  				  SMB_CSR(adap, R_SMB_START));
  		}
  		break;
@@ -123,99 +106,76 @@ static int smbus_xfer(struct i2c_adapter
  	return 0;
  }

-static u32 bit_func(struct i2c_adapter *adap)
+static u32 sibyte_functionality(struct i2c_adapter *adap)
  {
  	return (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
  		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA);
  }

-
-/* -----exported algorithm data: -------------------------------------	*/
-
-static const struct i2c_algorithm i2c_sibyte_algo = {
-	.smbus_xfer	= smbus_xfer,
-	.functionality	= bit_func,
+static const struct i2c_algorithm sibyte_i2c_algo = {
+	.smbus_xfer	= sibyte_smbus_xfer,
+	.functionality	= sibyte_functionality,
  };

-/*
- * registering functions to load algorithms at runtime
- */
-int i2c_sibyte_add_bus(struct i2c_adapter *i2c_adap, int speed)
+static int __devinit sibyte_i2c_probe(struct platform_device *pdev)
  {
-	int i;
-	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
+	struct i2c_adapter *adap;

-	/* register new adapter to i2c module... */
-	i2c_adap->algo = &i2c_sibyte_algo;
+	adap = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
+	if (!adap)
+		return -ENOMEM;
+
+	memcpy(adap->name, pdev->name, strlen(pdev->name));
+	adap->id = I2C_HW_SIBYTE;
+	adap->class = I2C_CLASS_HWMON;
+	adap->owner = THIS_MODULE;
+	adap->nr = pdev->id;
+	adap->algo = &sibyte_i2c_algo;
+	adap->algo_data = NULL;

-	/* Set the frequency to 100 kHz */
-	csr_out32(speed, SMB_CSR(adap,R_SMB_FREQ));
-	csr_out32(0, SMB_CSR(adap,R_SMB_CONTROL));
+	platform_set_drvdata(pdev, adap);

-	/* scan bus */
-	if (bit_scan) {
-		union i2c_smbus_data data;
-		int rc;
-		printk(KERN_INFO " i2c-algo-sibyte.o: scanning bus %s.\n",
-		       i2c_adap->name);
-		for (i = 0x00; i < 0x7f; i++) {
-			/* XXXKW is this a realistic probe? */
-			rc = smbus_xfer(i2c_adap, i, 0, I2C_SMBUS_READ, 0,
-					I2C_SMBUS_BYTE_DATA, &data);
-			if (!rc) {
-				printk("(%02x)",i);
-			} else
-				printk(".");
-		}
-		printk("\n");
-	}
+	/* Set the frequency to 100 kHz */
+	if (adap->nr == 0)
+		csr_out32(K_SMB_FREQ_100KHZ, SMB_CSR(adap, R_SMB_FREQ));
+	else
+		csr_out32(K_SMB_FREQ_400KHZ, SMB_CSR(adap, R_SMB_FREQ));
+	csr_out32(0, SMB_CSR(adap, R_SMB_CONTROL));

-	return i2c_add_adapter(i2c_adap);
+	pr_debug("%s %d registered\n", adap->name, adap->nr);
+	return i2c_add_numbered_adapter(adap);
  }

+static int __devexit sibyte_i2c_remove(struct platform_device *pdev)
+{
+	struct i2c_adapter *adap = platform_get_drvdata(pdev);

-static struct i2c_algo_sibyte_data sibyte_board_data[2] = {
-	{ NULL, 0, (void *) (CKSEG1+A_SMB_BASE(0)) },
-	{ NULL, 1, (void *) (CKSEG1+A_SMB_BASE(1)) }
-};
+	platform_set_drvdata(pdev, NULL);
+	i2c_del_adapter(adap);
+	return 0;
+}

-static struct i2c_adapter sibyte_board_adapter[2] = {
-	{
-		.owner		= THIS_MODULE,
-		.id		= I2C_HW_SIBYTE,
-		.class		= I2C_CLASS_HWMON,
-		.algo		= NULL,
-		.algo_data	= &sibyte_board_data[0],
-		.name		= "SiByte SMBus 0",
-	},
-	{
-		.owner		= THIS_MODULE,
-		.id		= I2C_HW_SIBYTE,
-		.class		= I2C_CLASS_HWMON,
-		.algo		= NULL,
-		.algo_data	= &sibyte_board_data[1],
-		.name		= "SiByte SMBus 1",
+static struct platform_driver sibyte_i2c_driver = {
+	.probe		= sibyte_i2c_probe,
+	.remove		= __devexit_p(sibyte_i2c_remove),
+	.driver		= {
+		.name	= "i2c-sibyte",
+		.owner	= THIS_MODULE,
  	},
  };

-static int __init i2c_sibyte_init(void)
+static int __init sibyte_i2c_init(void)
  {
-	printk("i2c-swarm.o: i2c SMBus adapter module for SiByte board\n");
-	if (i2c_sibyte_add_bus(&sibyte_board_adapter[0], K_SMB_FREQ_100KHZ) < 0)
-		return -ENODEV;
-	if (i2c_sibyte_add_bus(&sibyte_board_adapter[1], K_SMB_FREQ_400KHZ) < 0)
-		return -ENODEV;
-	return 0;
+	return platform_driver_register(&sibyte_i2c_driver);
  }

-static void __exit i2c_sibyte_exit(void)
+static void __exit sibyte_i2c_exit(void)
  {
-	i2c_del_adapter(&sibyte_board_adapter[0]);
-	i2c_del_adapter(&sibyte_board_adapter[1]);
+	platform_driver_unregister(&sibyte_i2c_driver);
  }

-module_init(i2c_sibyte_init);
-module_exit(i2c_sibyte_exit);
+module_init(sibyte_i2c_init);
+module_exit(sibyte_i2c_exit);

  MODULE_AUTHOR("Kip Walker (Broadcom Corp.), Steven J. Hill <sjhill@realitydiluted.com>");
  MODULE_DESCRIPTION("SMBus adapter routines for SiByte boards");
