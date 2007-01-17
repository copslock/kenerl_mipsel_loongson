Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2007 18:39:21 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:60905 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S28576103AbXAQSjA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Jan 2007 18:39:00 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id E93758D1690;
	Wed, 17 Jan 2007 19:37:43 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Add support for Cobalt Server front LED
Date:	Wed, 17 Jan 2007 19:37:57 +0100
User-Agent: KMail/1.9.5
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips@linux-mips.org
References: <200701151936.57738.florian.fainelli@int-evry.fr> <200701171904.28281.florian.fainelli@int-evry.fr> <20070117182914.GA5733@linux-mips.org>
In-Reply-To: <20070117182914.GA5733@linux-mips.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_F0mrFCJaluNnsdZ"
Message-Id: <200701171937.57932.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--Boundary-00=_F0mrFCJaluNnsdZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Ralf,

Sorry for the line wrapping :)

Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>

Le mercredi 17 janvier 2007 19:29, Ralf Baechle a =E9crit=A0:
> On Wed, Jan 17, 2007 at 07:04:23PM +0100, Florian Fainelli wrote:
> > This should take into account everything that has been said before.
>
> It does (thanks!) - but it arrived in my mailbox is nicely line wrapped
> ASCII jibberish, no longer a valid patch ...
>
>   Ralf

--Boundary-00=_F0mrFCJaluNnsdZ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="leds-cobalt.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="leds-cobalt.patch"

diff -urN linux-2.6.19.1/drivers/leds/Kconfig linux-2.6.19.1.led/drivers/le=
ds/Kconfig
=2D-- linux-2.6.19.1/drivers/leds/Kconfig	2006-12-11 20:32:53.000000000 +01=
00
+++ linux-2.6.19.1.led/drivers/leds/Kconfig	2007-01-15 19:22:00.000000000 +=
0100
@@ -76,6 +76,12 @@
 	  This option enables support for the Soekris net4801 and net4826 error
 	  LED.
=20
+config LEDS_COBALT
+	tristate "LED Support for Cobalt Server front LED"
+	depends on LEDS_CLASS && MIPS_COBALT
+	help
+	  This option enables support for the front LED on Cobalt Server
+
 comment "LED Triggers"
=20
 config LEDS_TRIGGERS
diff -urN linux-2.6.19.1/drivers/leds/leds-cobalt.c linux-2.6.19.1.led/driv=
ers/leds/leds-cobalt.c
=2D-- linux-2.6.19.1/drivers/leds/leds-cobalt.c	1970-01-01 01:00:00.0000000=
00 +0100
+++ linux-2.6.19.1.led/drivers/leds/leds-cobalt.c	2007-01-17 19:35:15.00000=
0000 +0100
@@ -0,0 +1,55 @@
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/leds.h>
+#include <asm/mach-cobalt/cobalt.h>
+
+/* Copyright 2006 - Florian Fainelli <florian@openwrt.org>
+ *=20
+ * This driver let you control the Cobalt Qube/RaQ front LED
+ *
+ * 255 (max brightness) -> turn the led on
+ * 0 -> turn the led off
+ *
+ * If you want the LED to be blinking on IDE activity, select the IDE trig=
ger
+ */
+
+static void cobalt_led_set(struct led_classdev *led_cdev, enum led_brightn=
ess brightness)
+{
+	switch (brightness) {
+	case LED_OFF:
+		COBALT_LED_PORT =3D 0;
+		break;
+	case LED_FULL:
+		COBALT_LED_PORT =3D COBALT_LED_BAR_LEFT | COBALT_LED_BAR_RIGHT;
+		break;
+	default:
+		return;
+	}
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
+	return led_classdev_register(NULL, &cobalt_led);
+}
+
+static void __exit cobalt_led_exit(void)
+{
+	led_classdev_unregister(&cobalt_led);
+}
+
+module_init(cobalt_led_init);
+module_exit(cobalt_led_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Front LED support for Cobalt Server");
+MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
diff -urN linux-2.6.19.1/drivers/leds/Makefile linux-2.6.19.1.led/drivers/l=
eds/Makefile
=2D-- linux-2.6.19.1/drivers/leds/Makefile	2006-12-11 20:32:53.000000000 +0=
100
+++ linux-2.6.19.1.led/drivers/leds/Makefile	2007-01-15 19:22:18.000000000 =
+0100
@@ -13,6 +13,7 @@
 obj-$(CONFIG_LEDS_S3C24XX)		+=3D leds-s3c24xx.o
 obj-$(CONFIG_LEDS_AMS_DELTA)		+=3D leds-ams-delta.o
 obj-$(CONFIG_LEDS_NET48XX)		+=3D leds-net48xx.o
+obj-$(CONFIG_LEDS_COBALT)		+=3D leds-cobalt.o
=20
 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+=3D ledtrig-timer.o

--Boundary-00=_F0mrFCJaluNnsdZ--
