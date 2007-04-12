Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Apr 2007 09:44:05 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:29151 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20022346AbXDLIoC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Apr 2007 09:44:02 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A814F200A1EA
	for <linux-mips@linux-mips.org>; Thu, 12 Apr 2007 10:43:13 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 01214-01-16 for <linux-mips@linux-mips.org>;
	Thu, 12 Apr 2007 10:43:11 +0200 (CEST)
Received: from [192.168.27.65] (6.240.216.81.static.lk.siwnet.net [81.216.240.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id B1258200A1E5
	for <linux-mips@linux-mips.org>; Thu, 12 Apr 2007 10:43:11 +0200 (CEST)
Message-ID: <461DF11F.404@27m.se>
Date:	Thu, 12 Apr 2007 10:43:11 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Icedove 1.5.0.10 (X11/20070329)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] EMMA2RH I2C driver
X-Enigmail-Version: 0.94.2.0
Content-Type: multipart/mixed;
 boundary="------------010904020106040805010500"
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010904020106040805010500
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

As Ralf pointed out in march I've been polishing the IIC-driver for
EMMA2RH.

I've shaped up the I2C-driver to be a platform-device-driver and added
accurately memory-mapping/unmapping and irq-request/free.

There was a datastructure missing which was pretty straight forward to
figure out how to rebuild (i.e. i2c_algo_emma_data).

The patch (for the patch) is attached.

//Markus

- --
_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)73 718 72 80
Diskettgatan 11, SE-583 35 Linköping, Sweden
www.27m.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGHfEc6I0XmJx2NrwRCMZ8AJ0QgruqOX2y+MxF/+RbpTbSciUsGwCfcH7M
efI4rmnlkfxNezQbOWENjRY=
=rJPp
-----END PGP SIGNATURE-----


--------------010904020106040805010500
Content-Type: text/x-patch;
 name="i2c-emma2rh.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="i2c-emma2rh.patch"

--- drivers/i2c/algos/i2c-algo-emma2rh.c.orig	2007-03-15 13:32:35.000000000 +0100
+++ drivers/i2c/algos/i2c-algo-emma2rh.c	2007-04-12 10:08:58.000000000 +0200
@@ -14,7 +14,7 @@
      Copyright (C) 1995-1997 Simon G. Vogl
                    1998-2000 Hans Berglund
 
-    With some changes from KyÃ¶sti MÃ¤lkki <kmalkki@cc.hut.fi> and
+    With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and
     Frodo Looijaard <frodol@dds.nl> ,and also from Martin Bailey
     <mbailey@littlefeet-inc.com>
 
@@ -51,13 +51,11 @@
 #include <linux/interrupt.h>
 
 #include <linux/i2c.h>
-#include <linux/i2c-algo-emma2rh.h>
-
-#include <asm/emma2rh/emma2rh.h>
+#include "i2c-algo-emma2rh.h"
 
 #ifdef DEBUG
 #define i2c_emma2rh_debug(level,op) do { if (i2c_debug>=(level)) { op; } } while (0)
-static int i2c_debug;
+static int i2c_debug = 9;
 module_param(i2c_debug, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(i2c_debug,
                 "debug level - 0 off; 1 normal; 2,3 more verbose; 9 i2c-protocol");
@@ -73,13 +71,15 @@
 #define EMMA2RH_I2C_RETRIES 3
 #define EMMA2RH_I2C_TIMEOUT 100
 
-/* --- setting states on the bus with the right timing: --------------- */
+/* --- setting states on the bus with the right timing: ---------------        
+*/
 #define set_emma(adap, ctl, val) adap->setemma(adap->data, ctl, val)
 #define get_emma(adap, ctl) adap->getemma(adap->data, ctl)
 #define get_own(adap) adap->getown(adap->data)
 #define get_clock(adap) adap->getclock(adap->data)
 
-/* --- other auxiliary functions -------------------------------------- */
+/* --- other auxiliary functions --------------------------------------        
+*/
 
 static void i2c_start(struct i2c_algo_emma_data *adap)
 {
@@ -168,7 +168,8 @@
                udelay(adap->udelay);
        }
        DEB2(if (i)
-            printk(KERN_DEBUG "%s: needed %d retries for %d\n", __FUNCTION__, i, addr)) ;
+            printk(KERN_DEBUG "%s: needed %d retries for %d\n", __FUNCTION__, 
+i, addr)) ;
        return ret;
 }
 
@@ -352,7 +353,7 @@
 
 static u32 emma_func(struct i2c_adapter *adap)
 {
-       return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
+       return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
 }
 
 /* --- exported algorithm data ---------------------------------------- */
--- drivers/i2c/algos/i2c-algo-emma2rh.h.orig	2007-03-15 13:32:50.000000000 +0100
+++ drivers/i2c/algos/i2c-algo-emma2rh.h	2007-04-12 10:08:18.000000000 +0200
@@ -17,7 +17,8 @@
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA*/
-/* -------------------------------------------------------------------- */
+/* --------------------------------------------------------------------        
+*/
 
 #ifndef I2C_EMMA2RH_H
 #define I2C_EMMA2RH_H
@@ -102,4 +103,19 @@
 #define I2C_EMMA_SHR            0x40
 #define I2C_EMMA_INT            0x50
 #define I2C_EMMA_INTM           0x60
+
+struct i2c_algo_emma_data {
+        void *data;             /* private data for lolevel routines    */
+        void (*setemma) (void *data, int ctl, int val);
+        int  (*getemma) (void *data, int ctl);
+        int  (*getown) (void *data);
+        int  (*getclock) (void *data);
+        void (*waitforpin) (void *data);
+
+        /* local settings */
+        int udelay;
+        int timeout;
+
+};
+
 #endif                         /* I2C_EMMA2RH_H */
--- drivers/i2c/busses/i2c-emma2rh.c.orig	2007-03-15 13:33:45.000000000 +0100
+++ drivers/i2c/busses/i2c-emma2rh.c	2007-04-12 10:06:48.000000000 +0200
@@ -14,7 +14,7 @@
      Copyright (C) 1995-97 Simon G. Vogl
                    1998-99 Hans Berglund
 
-    With some changes from KyÃ¶sti MÃ¤lkki <kmalkki@cc.hut.fi> and even
+    With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
     Frodo Looijaard <frodol@dds.nl>
 
     Partialy rewriten by Oleg I. Vdovikin for mmapped support of
@@ -47,17 +47,17 @@
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/i2c-id.h>
-#include <linux/i2c-algo-emma2rh.h>
 #include <linux/platform_device.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/atomic.h>
-#include <asm/emma2rh/emma2rh.h>
 
-#define I2C_EMMA2RH "emma2rh-iic"
+#include "../algos/i2c-algo-emma2rh.h"
+
 static int i2c_debug = 0;
 
-/* ----- global defines ----------------------------------------------- */
+/* ----- global defines -----------------------------------------------        
+*/
 #define DEB(x) if (i2c_debug>=1) x
 #define DEB2(x) if (i2c_debug>=2) x
 #define DEB3(x) if (i2c_debug>=3) x
@@ -75,7 +75,8 @@
        wait_queue_head_t wait;
 };
 
-/* ----- local functions ----------------------------------------------*/
+/* ----- local functions ----------------------------------------------        
+*/
 static void i2c_emma_setbyte(void *data, int ctl, int val)
 {
        int address = ((struct i2c_drvdata *)data)->base + ctl;
@@ -148,9 +149,8 @@
                udelay(100);
 }
 
-static int __devinit i2c_emma_probe(struct device *dev)
+static int __devinit i2c_emma_probe(struct platform_device *pdev)
 {
-       struct platform_device *pdev = to_platform_device(dev);
        struct i2c_drvdata *dd;
        int err = 0;
        struct resource *r;
@@ -167,81 +167,108 @@
        dd->alg.getclock = i2c_emma_getclock;
        dd->alg.waitforpin = i2c_emma_waitforpin;
        dd->alg.udelay = 80;
-       dd->alg.mdelay = 80;
        dd->alg.timeout = 200;
 
-       strcpy(dd->adap.name, dev->bus_id);
+       strcpy(dd->adap.name, pdev->name);
        dd->adap.id = 0x00;
        dd->adap.algo = NULL;
        dd->adap.algo_data = &dd->alg;
        dd->adap.client_register = i2c_emma_reg;
        dd->adap.client_unregister = i2c_emma_unreg;
 
-       spin_lock_init(&dd->lock);
-
-       atomic_set(&dd->pending,0);
-       init_waitqueue_head(&dd->wait);
-
-       dev_set_drvdata(dev, dd);
-
-       r = platform_get_resource(pdev, 0, 0);
-       /* get resource of type '0' with #0 */
 
+       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);/* get resource of type '0' with #0 */
+       
        if (!r) {
                printk("Cannot get resource\n");
                err = -ENODEV;
                goto out_free;
-       }
-       dd->base = r->start;
-
+	}
+	
+	if (!request_mem_region(r->start, r->end - r->start + 1, pdev->name)) {
+		printk("Memory region busy\n");
+		err = -EBUSY;
+		goto out_mem_region;
+	}
+	
+	dd->base = ioremap_nocache(r->start, r->end - r->start);
+	if (!dd->base) {
+		printk("Unable to map registers\n");
+		err = -EIO;
+		goto out_ioremap;
+	}
+	
        dd->irq = platform_get_irq(pdev,0);
        dd->clock = FAST397;
        dd->own = 0x40 + pdev->id * 4;
 
-       err = request_irq(dd->irq, i2c_emma_handler, 0, dev->bus_id, dd);
+       err = request_irq(dd->irq, i2c_emma_handler, 0, pdev->name, dd);
        if (err < 0)
                goto out_free;
+       
+       spin_lock_init(&dd->lock);
 
+       atomic_set(&dd->pending,0);
+       init_waitqueue_head(&dd->wait);
+
+       platform_set_drvdata(pdev, dd);
+       
        if ((err = i2c_emma_add_bus(&dd->adap)) < 0)
                goto out_irq;
 
        return 0;
+
 out_irq:
-       free_irq(dd->irq, dev->bus_id);
+	free_irq(dd->irq, dd);
+out_ioremap:
+	iounmap(dd->base);
+out_mem_region:
+	release_mem_region(r->start, r->end - r->start + 1);
 out_free:
-       kfree(dd);
+	kfree(dd);
 out:
-       return err;
+	return err;
 }
 
-static int __devexit i2c_emma_remove (struct device *dev)
+static int __devexit i2c_emma_remove (struct platform_device *pdev)
 {
-       struct i2c_drvdata* dd = dev_get_drvdata(dev);
-
-       if (dd) {
-               disable_irq(dd->irq);
-               free_irq(dd->irq, dev->bus_id);
-               i2c_emma_del_bus(&dd->adap);
-               kfree(dd);
-       }
-       return 0;
-}
-
-static struct device_driver i2c_emma_driver = {
-       .bus = &platform_bus_type,
-       .name = I2C_EMMA2RH,
-       .probe = i2c_emma_probe,
-       .remove = i2c_emma_remove,
+	struct i2c_drvdata* dd = platform_get_drvdata(pdev);
+	struct resource *r;
+	
+	i2c_emma_del_bus(&dd->adap);
+	platform_set_drvdata(pdev, NULL);
+	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if(r)
+		free_irq(r->start, dd);
+
+	iounmap(dd->base);
+	
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if(r)
+		release_mem_region(r->start, r->end - r->start + 1);
+	kfree(dd);
+
+	return 0;
+}
+
+static struct platform_driver i2c_emma_driver = {
+	.probe = i2c_emma_probe,
+	.remove = __devexit_p(i2c_emma_remove),
+	.driver = {
+		.owner = THIS_MODULE,
+		.bus = &platform_bus_type,
+		.name = "emma2rh-iic",
+	}
 };
 
 static int __init i2c_emma_init(void)
 {
-       return driver_register(&i2c_emma_driver);
+       return platform_driver_register(&i2c_emma_driver);
 }
 
 static void __exit i2c_emma_exit(void)
 {
-       driver_unregister(&i2c_emma_driver);
+       platform_driver_unregister(&i2c_emma_driver);
 }
 
 MODULE_AUTHOR("NEC Electronics Corporation <www.necel.com>");

--------------010904020106040805010500--
