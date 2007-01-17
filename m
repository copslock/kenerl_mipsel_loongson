Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2007 18:05:31 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:60606 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20042581AbXAQSF0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Jan 2007 18:05:26 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id D52F28D1693;
	Wed, 17 Jan 2007 19:04:08 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Add support for Cobalt Server front LED
Date:	Wed, 17 Jan 2007 19:04:23 +0100
User-Agent: KMail/1.9.5
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips@linux-mips.org
References: <200701151936.57738.florian.fainelli@int-evry.fr> <200701160056.00748.florian.fainelli@int-evry.fr> <20070117164610.GA1200@linux-mips.org>
In-Reply-To: <20070117164610.GA1200@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2142788.HERbmlOEkF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701171904.28281.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--nextPart2142788.HERbmlOEkF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Ralf,

This should take into account everything that has been said before.

Thanks.

Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>

diff -urN linux-2.6.19.1/drivers/leds/Kconfig=20
linux-2.6.19.1.led/drivers/leds/Kconfig
=2D-- linux-2.6.19.1/drivers/leds/Kconfig 2006-12-11 20:32:53.000000000 +01=
00
+++ linux-2.6.19.1.led/drivers/leds/Kconfig =A0 =A0 2007-01-15 19:22:00.000=
000000=20
+0100
@@ -76,6 +76,12 @@
=A0 =A0 =A0 =A0 =A0 This option enables support for the Soekris net4801 and=
 net4826=20
error
=A0 =A0 =A0 =A0 =A0 LED.

+config LEDS_COBALT
+ =A0 =A0 =A0 tristate "LED Support for Cobalt Server front LED"
+ =A0 =A0 =A0 depends on LEDS_CLASS && MIPS_COBALT
+ =A0 =A0 =A0 help
+ =A0 =A0 =A0 =A0 This option enables support for the front LED on Cobalt S=
erver
+
=A0comment "LED Triggers"

=A0config LEDS_TRIGGERS
diff -urN linux-2.6.19.1/drivers/leds/leds-cobalt.c=20
linux-2.6.19.1.led/drivers/leds/leds-cobalt.c
=2D-- linux-2.6.19.1/drivers/leds/leds-cobalt.c =A0 1970-01-01 01:00:00.000=
000000=20
+0100
+++ linux-2.6.19.1.led/drivers/leds/leds-cobalt.c =A0 =A0 =A0 2007-01-15=20
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
+static void cobalt_led_set(struct led_classdev *led_cdev, enum led_brightn=
ess=20
brightness)
+{
+ =A0 =A0 =A0 switch (brightness) {
+ =A0 =A0 =A0 case LED_OFF:
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(volatile uint8_t *) COBALT_LED_BASE =3D 0;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
+ =A0 =A0 =A0 case LED_FULL:
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(volatile uint8_t *) COBALT_LED_BASE =3D COB=
ALT_LED_BAR_LEFT |=20
COBALT_LED_BAR_RIGHT;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
+ =A0 =A0 =A0 default:
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
+ =A0 =A0 =A0 }
+}
+
+static struct led_classdev cobalt_led =3D {
+ =A0 =A0 =A0 .name =3D "cobalt-front-led",
+ =A0 =A0 =A0 .brightness_set =3D cobalt_led_set,
+#ifdef CONFIG_LEDS_TRIGGER_IDE_DISK
+ =A0 =A0 =A0 .default_trigger =3D "ide-disk",
+#endif
+};
+
+static int __init cobalt_led_init(void)
+{
+ =A0 =A0 =A0 return led_classdev_register(NULL, &cobalt_led);
+}
+
+static void __exit cobalt_led_exit(void)
+{
+ =A0 =A0 =A0 led_classdev_unregister(&cobalt_led);
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
=2D-- linux-2.6.19.1/drivers/leds/Makefile =A0 =A0 =A0 =A02006-12-11 20:32:=
53.000000000=20
+0100
+++ linux-2.6.19.1.led/drivers/leds/Makefile =A0 =A02007-01-15 19:22:18.000=
000000=20
+0100
@@ -13,6 +13,7 @@
=A0obj-$(CONFIG_LEDS_S3C24XX) =A0 =A0 =A0 =A0 =A0 =A0 +=3D leds-s3c24xx.o
=A0obj-$(CONFIG_LEDS_AMS_DELTA) =A0 =A0 =A0 =A0 =A0 +=3D leds-ams-delta.o
=A0obj-$(CONFIG_LEDS_NET48XX) =A0 =A0 =A0 =A0 =A0 =A0 +=3D leds-net48xx.o
+obj-$(CONFIG_LEDS_COBALT) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D leds-cobalt.o

=A0# LED Triggers
=A0obj-$(CONFIG_LEDS_TRIGGER_TIMER) =A0 =A0 =A0 +=3D ledtrig-timer.o


Le mercredi 17 janvier 2007 17:46, Ralf Baechle a =E9crit=A0:
> On Tue, Jan 16, 2007 at 12:56:00AM +0100, Florian Fainelli wrote:
> > Answering back to myself, since I fixed the stuff using the
> > COBALT_LED_PORT, here the corrected patch. Can you queue this patch for=
 a
> > commit if it sounds acceptable to you ?
> >
> > Thank you very much in advance.
>
> Signed-off???
>
> > +void cobalt_led_set(struct led_classdev *led_cdev, enum led_brightness
> > brightness)
>
> This function is only used locally so should be static.
>
>   Ralf

--nextPart2142788.HERbmlOEkF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFrmUsQ/Yr6D8A81kRAmzKAJ9kmfdoMsAFbTZ+BcR5SC+BvWxDrQCgjtYd
1ef/0HtECtir4vwwnAGW2VY=
=s/gs
-----END PGP SIGNATURE-----

--nextPart2142788.HERbmlOEkF--
