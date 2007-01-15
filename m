Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2007 18:46:23 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:30421 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S28643080AbXAOSqS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Jan 2007 18:46:18 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 4FD938D168F
	for <linux-mips@linux-mips.org>; Mon, 15 Jan 2007 19:45:04 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Add support for Cobalt Server front LED
Date:	Mon, 15 Jan 2007 19:36:52 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3049338.yGKx3zGaik";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701151936.57738.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--nextPart3049338.yGKx3zGaik
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

This patch adds support for controlling the front LED on Cobalt Server. It =
has=20
been tested on Qube 2 with either no default trigger, or the IDE-activity=20
trigger. Both work fine. Please comment and test !

Thanks

=46lorian

Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>

diff -urN linux-2.6.19.1/include/asm-mips/mach-cobalt/cobalt.h=20
linux-2.6.19.1.led/include/asm-mips/mach-cobalt/cobalt.h
=2D-- linux-2.6.19.1/include/asm-mips/mach-cobalt/cobalt.h        2006-12-1=
1=20
20:32:53.000000000 +0100
+++ linux-2.6.19.1.led/include/asm-mips/mach-cobalt/cobalt.h    2007-01-15=
=20
19:29:07.000000000 +0100
@@ -97,6 +97,7 @@
                (PCI_FUNC (devfn) << 8) | (where)), GT_PCI0_CFGADDR_OFS)

 #define COBALT_LED_PORT                (*(volatile unsigned char *)=20
CKSEG1ADDR(0x1c000000))
+#define COBALT_LED_BASE         0xbc000000
 # define COBALT_LED_BAR_LEFT   (1 << 0)        /* Qube */
 # define COBALT_LED_BAR_RIGHT  (1 << 1)        /* Qube */
 # define COBALT_LED_WEB                (1 << 2)        /* RaQ */
diff -urN linux-2.6.19.1/drivers/leds/Kconfig=20
linux-2.6.19.1.led/drivers/leds/Kconfig
=2D-- linux-2.6.19.1/drivers/leds/Kconfig 2006-12-11 20:32:53.000000000 +01=
00
+++ linux-2.6.19.1.led/drivers/leds/Kconfig     2007-01-15 19:22:00.0000000=
00=20
+0100
@@ -76,6 +76,12 @@
          This option enables support for the Soekris net4801 and net4826=20
error
          LED.

+config LEDS_COBALT
+       tristate "LED Support for Cobalt Server front LED"
+       depends on LEDS_CLASS && MIPS_COBALT
+       help
+         This option enables support for the front LED on Cobalt Server
+
 comment "LED Triggers"

 config LEDS_TRIGGERS
diff -urN linux-2.6.19.1/drivers/leds/leds-cobalt.c=20
linux-2.6.19.1.led/drivers/leds/leds-cobalt.c
=2D-- linux-2.6.19.1/drivers/leds/leds-cobalt.c   1970-01-01 01:00:00.00000=
0000=20
+0100
+++ linux-2.6.19.1.led/drivers/leds/leds-cobalt.c       2007-01-15=20
19:28:09.000000000 +0100
@@ -0,0 +1,55 @@
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/leds.h>
+#include <asm/mach-cobalt/cobalt.h>
+
+/* Copyright 2006 - Florian Fainelli <florian@openwrt.org>
+ *
+ * This driver let you control the Cobalt Qube/RaQ front LED
+ *
+ * 255 (max brightness) -> turn the led on
+ * 0 -> turn the led off
+ *
+ * If you want the LED to be blinking on IDE activity, select the IDE trig=
ger
+ */
+
+void cobalt_led_set(struct led_classdev *led_cdev, enum led_brightness=20
brightness)
+{
+       switch (brightness) {
+       case LED_OFF:
+               *(volatile uint8_t *) COBALT_LED_BASE =3D 0;
+               break;
+       case LED_FULL:
+               *(volatile uint8_t *) COBALT_LED_BASE =3D COBALT_LED_BAR_LE=
=46T |=20
COBALT_LED_BAR_RIGHT;
+               break;
+       default:
+               return;
+       }
+}
+
+static struct led_classdev cobalt_led =3D {
+       .name =3D "cobalt-front-led",
+       .brightness_set =3D cobalt_led_set,
+#ifdef CONFIG_LEDS_TRIGGER_IDE_DISK
+       .default_trigger =3D "ide-disk",
+#endif
+};
+
+static int __init cobalt_led_init(void)
+{
+       return led_classdev_register(NULL, &cobalt_led);
+}
+
+static void __exit cobalt_led_exit(void)
+{
+       led_classdev_unregister(&cobalt_led);
+}
+
+module_init(cobalt_led_init);
+module_exit(cobalt_led_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Front LED support for Cobalt Server");
+MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
diff -urN linux-2.6.19.1/drivers/leds/Makefile=20
linux-2.6.19.1.led/drivers/leds/Makefile
=2D-- linux-2.6.19.1/drivers/leds/Makefile        2006-12-11 20:32:53.00000=
0000=20
+0100
+++ linux-2.6.19.1.led/drivers/leds/Makefile    2007-01-15 19:22:18.0000000=
00=20
+0100
@@ -13,6 +13,7 @@
 obj-$(CONFIG_LEDS_S3C24XX)             +=3D leds-s3c24xx.o
 obj-$(CONFIG_LEDS_AMS_DELTA)           +=3D leds-ams-delta.o
 obj-$(CONFIG_LEDS_NET48XX)             +=3D leds-net48xx.o
+obj-$(CONFIG_LEDS_COBALT)              +=3D leds-cobalt.o

 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)       +=3D ledtrig-timer.o

--nextPart3049338.yGKx3zGaik
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFq8nJQ/Yr6D8A81kRAhxtAJ0fAqQT1eCle6UNpz2tLwMNhmb3SwCfUKJn
WFM92oygkJo+ZA54kGbnbfw=
=sOts
-----END PGP SIGNATURE-----

--nextPart3049338.yGKx3zGaik--
