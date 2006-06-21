Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2006 11:26:05 +0100 (BST)
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:22030 "HELO
	kraid.nerim.net") by ftp.linux-mips.org with SMTP id S8133459AbWFUKZz
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Jun 2006 11:25:55 +0100
Received: from arrakis.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by kraid.nerim.net (Postfix) with SMTP id 56CD541053;
	Wed, 21 Jun 2006 12:25:54 +0200 (CEST)
Date:	Wed, 21 Jun 2006 12:25:59 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	linux-mips@linux-mips.org
Cc:	Linux I2C <i2c@lm-sensors.org>
Subject: [PATCH] i2c-algo-sibyte: Cleanups
Message-Id: <20060621122559.8dbff204.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi all,

Could someone please test this patch? I can't. Also note that I plan to
merge i2c-algo-sibyte into i2c-sibyte as it is hardware dependent and
not a reusable implementation as i2c algorithms are supposed to be.

Thanks.


Cleanups to the i2c-algo-sibyte driver:

* Delete empty algo_control implementation.
* Simplify i2c_sibyte_del_bus.
* Delete empty module init and cleanup functions.
* Drop useless #ifdef MODULE construct.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/algos/i2c-algo-sibyte.c |   32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

--- linux-2.6.17-git.orig/drivers/i2c/algos/i2c-algo-sibyte.c	2006-06-18 15:56:15.000000000 +0200
+++ linux-2.6.17-git/drivers/i2c/algos/i2c-algo-sibyte.c	2006-06-21 12:10:07.000000000 +0200
@@ -119,12 +119,6 @@
         return 0;
 }
 
-static int algo_control(struct i2c_adapter *adapter, 
-	unsigned int cmd, unsigned long arg)
-{
-	return 0;
-}
-
 static u32 bit_func(struct i2c_adapter *adap)
 {
 	return (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
@@ -136,7 +130,6 @@
 
 static struct i2c_algorithm i2c_sibyte_algo = {
 	.smbus_xfer	= smbus_xfer,
-	.algo_control	= algo_control, /* ioctl */
 	.functionality	= bit_func,
 };
 
@@ -181,37 +174,14 @@
 
 int i2c_sibyte_del_bus(struct i2c_adapter *adap)
 {
-	int res;
-
-	if ((res = i2c_del_adapter(adap)) < 0)
-		return res;
-
-	return 0;
-}
-
-int __init i2c_algo_sibyte_init (void)
-{
-	printk("i2c-algo-sibyte.o: i2c SiByte algorithm module\n");
-	return 0;
+	return i2c_del_adapter(adap);
 }
 
-
 EXPORT_SYMBOL(i2c_sibyte_add_bus);
 EXPORT_SYMBOL(i2c_sibyte_del_bus);
 
-#ifdef MODULE
 MODULE_AUTHOR("Kip Walker, Broadcom Corp.");
 MODULE_DESCRIPTION("SiByte I2C-Bus algorithm");
 module_param(bit_scan, int, 0);
 MODULE_PARM_DESC(bit_scan, "Scan for active chips on the bus");
 MODULE_LICENSE("GPL");
-
-int init_module(void) 
-{
-	return i2c_algo_sibyte_init();
-}
-
-void cleanup_module(void) 
-{
-}
-#endif


-- 
Jean Delvare
