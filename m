Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2006 19:02:31 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:21410 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S3561480AbWGSSCU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Jul 2006 19:02:20 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1G3FOH-0006qK-Cb; Wed, 19 Jul 2006 18:59:18 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1G3GN2-00028n-T4; Wed, 19 Jul 2006 20:02:04 +0200
Date:	Wed, 19 Jul 2006 20:02:04 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	i2c@lm-sensors.org
Cc:	linux-mips@linux-mips.org
Message-ID: <20060719180204.GK25330@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DN8g+DOX2TxGxleI"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] AU1100 I2C support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

here a patch to add I2C support to AU1100 processors by using two
GPIOs.

Ciao,

Rodolfo

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-i2c-gpio-support
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 884320e..222c7fc 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -419,6 +419,18 @@ config SCx200_ACB
 	  This support is also available as a module.  If so, the module=20
 	  will be called scx200_acb.
=20
+config AU1100_I2C
+	tristate "Au1100 I2C using GPIO pins"
+	depends on SOC_AU1100
+	select I2C_ALGOBIT
+	help
+	  Enable the use of two GPIO pins of a Au1100 processor as an I2C bus.
+
+	  If you don't know what to do here, say N.
+
+	  This support is also available as a module.  If so, the module=20
+	  will be called i2c-au1100.
+
 config I2C_SIS5595
 	tristate "SiS 5595"
 	depends on I2C && PCI
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index ac56df5..adb7576 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_I2C_VIAPRO)	+=3D i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)	+=3D i2c-voodoo3.o
 obj-$(CONFIG_SCx200_ACB)	+=3D scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+=3D scx200_i2c.o
+obj-$(CONFIG_AU1100_I2C)	+=3D i2c-au1100.o
=20
 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
 EXTRA_CFLAGS +=3D -DDEBUG
diff --git a/drivers/i2c/busses/i2c-au1100.c b/drivers/i2c/busses/i2c-au110=
0.c
new file mode 100644
index 0000000..e010cf8
--- /dev/null
+++ b/drivers/i2c/busses/i2c-au1100.c
@@ -0,0 +1,139 @@
+/*=20
+   i2c-au1100.c - I2C support for Au1100
+
+   Copyright (c) 2006 Rodolfo Giometti <giometti@linux.it>
+   Copyright (c) 2006 Eurotech S.p.A. <info@eurotech.it>
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+  =20
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+  =20
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		    =20
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <asm/io.h>
+
+#include <asm/mach-au1x00/au1000.h>
+
+#define NAME "au1100_i2c"
+
+#if 0
+	/* put here the per-board settings */
+#else
+/* The default GPIOs */
+static int scl =3D 31;
+static int sda =3D 30;
+#endif
+
+module_param(scl, int, 0);
+MODULE_PARM_DESC(scl, "GPIO line for SCL");
+module_param(sda, int, 0);
+MODULE_PARM_DESC(sda, "GPIO line for SDA");
+
+/* --- Local functions ---------------------------------------------------=
-- */
+
+static inline void au1100_gpio_set(int gpio, int state)
+{
+	if (state)
+		au_writel(1<<gpio, SYS_OUTPUTSET);
+	else
+		au_writel(1<<gpio, SYS_OUTPUTCLR);
+	au_sync();
+}
+
+static inline int au1100_gpio_get(int gpio)
+{
+	au_writel(1<<gpio, SYS_PININPUTEN);
+	udelay(100);
+	return au_readl(SYS_PINSTATERD)&(1<<gpio) ? 1 : 0;
+}
+
+/* --- I2C operations ----------------------------------------------------=
-- */
+
+static void au1100_i2c_setscl(void *data, int state)
+{
+	au1100_gpio_set(scl, state);
+}
+
+static void au1100_i2c_setsda(void *data, int state)
+{
+	au1100_gpio_set(sda, state);
+}=20
+
+static int au1100_i2c_getscl(void *data)
+{
+	return au1100_gpio_get(scl);
+}
+
+static int au1100_i2c_getsda(void *data)
+{
+	return au1100_gpio_get(sda);
+}
+
+static struct i2c_algo_bit_data au1100_i2c_data =3D {
+	NULL,
+	au1100_i2c_setsda,
+	au1100_i2c_setscl,
+	au1100_i2c_getsda,
+	au1100_i2c_getscl,
+	10, 10, 100,		/* waits, timeout */
+};
+
+static struct i2c_adapter au1100_i2c_ops =3D {
+	.owner		=3D THIS_MODULE,
+	.algo_data	=3D &au1100_i2c_data,
+	.name		=3D "Au1100 I2C",
+};
+
+/* --- Module stuff ------------------------------------------------------=
-- */
+
+static int au1100_i2c_init(void)
+{
+	pr_debug(NAME ": SCL=3DGPIO%02u, SDA=3DGPIO%02u\n", scl, sda);
+
+	if (scl < 0 || sda < 0 || scl > 31 || sda > 31 || scl =3D=3D sda) {
+		printk(KERN_ERR NAME ": invalid \"scl\" and \"sda\" values\n");
+		return -EINVAL;
+	}
+
+	/* Configure GPIOs as outputs */
+	au1100_gpio_set(scl, 1);
+	au1100_gpio_set(sda, 1);
+
+	if (i2c_bit_add_bus(&au1100_i2c_ops) < 0) {
+		printk(KERN_ERR NAME ": adapter \"%s\" registration failed\n",=20
+		       au1100_i2c_ops.name);
+		return -ENODEV;
+	}
+
+	pr_info(NAME ": Au1100 I2C Driver enabled\n");
+=09
+	return 0;
+}
+
+static void au1100_i2c_cleanup(void)
+{
+	i2c_bit_del_bus(&au1100_i2c_ops);
+}
+
+module_init(au1100_i2c_init);
+module_exit(au1100_i2c_cleanup);
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
+MODULE_DESCRIPTION("Au1100 I2C Driver");
+MODULE_LICENSE("GPL");

--DN8g+DOX2TxGxleI--
