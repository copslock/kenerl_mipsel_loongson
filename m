Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2007 23:57:01 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:41639 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S28643747AbXAOX44 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Jan 2007 23:56:56 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id D82E38D168F;
	Tue, 16 Jan 2007 00:55:42 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH] Add support for Cobalt Server front LED
Date:	Tue, 16 Jan 2007 00:56:00 +0100
User-Agent: KMail/1.9.5
Cc:	linux-mips@linux-mips.org
References: <200701151936.57738.florian.fainelli@int-evry.fr> <20070116074205.0428449d.yoichi_yuasa@tripeaks.co.jp> <200701160033.10947.florian.fainelli@int-evry.fr>
In-Reply-To: <200701160033.10947.florian.fainelli@int-evry.fr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4482606.En2iAhNvg2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701160056.00748.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--nextPart4482606.En2iAhNvg2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Yoichi,

Answering back to myself, since I fixed the stuff using the COBALT_LED_PORT=
,=20
here the corrected patch. Can you queue this patch for a commit if it sound=
s=20
acceptable to you ?

Thank you very much in advance.

diff -urN linux-2.6.19.1/drivers/leds/leds-cobalt.c=20
linux-2.6.19.1.led/drivers/leds/leds-cobalt.c
=2D-- linux-2.6.19.1/drivers/leds/leds-cobalt.c =A0 1970-01-01 01:00:00.000=
000000=20
+0100
+++ linux-2.6.19.1.led/drivers/leds/leds-cobalt.c =A0 =A0 =A0 2007-01-16=20
00:49:20.000000000 +0100
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
+ =A0 =A0 =A0 switch (brightness) {
+ =A0 =A0 =A0 case LED_OFF:
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 COBALT_LED_PORT =3D 0;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
+ =A0 =A0 =A0 case LED_FULL:
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 COBALT_LED_PORT =3D COBALT_LED_BAR_LEFT | COB=
ALT_LED_BAR_RIGHT;
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

Le mardi 16 janvier 2007 00:33, Florian Fainelli a =E9crit=A0:
> Hi Yoichi,
>
> I first used the COBALT_LED_PORT address but it did not work for a reason=
 I
> ignore. If I use the COBALT_LED_BASE as defined, which is taken from the
> CoLo code, it works fine.
>
> Do know you what could explain this difference ? Can you test it on your
> boxes ?
>
> Thank you very much in advance for your answer.
>
> Le lundi 15 janvier 2007 23:42, Yoichi Yuasa a =E9crit=A0:
> > Hi,
> >
> > On Mon, 15 Jan 2007 19:36:52 +0100
> >
> > Florian Fainelli <florian.fainelli@int-evry.fr> wrote:
> > > Hi all,
> > >
> > > This patch adds support for controlling the front LED on Cobalt Serve=
r.
> > > It has been tested on Qube 2 with either no default trigger, or the
> > > IDE-activity trigger. Both work fine. Please comment and test !
> > >
> > > Thanks
> > >
> > > Florian
> > >
> > > Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
> > >
> > > diff -urN linux-2.6.19.1/include/asm-mips/mach-cobalt/cobalt.h
> > > linux-2.6.19.1.led/include/asm-mips/mach-cobalt/cobalt.h
> > > --- linux-2.6.19.1/include/asm-mips/mach-cobalt/cobalt.h
> > > 2006-12-11 20:32:53.000000000 +0100
> > > +++ linux-2.6.19.1.led/include/asm-mips/mach-cobalt/cobalt.h
> > > 2007-01-15 19:29:07.000000000 +0100
> > > @@ -97,6 +97,7 @@
> > >                 (PCI_FUNC (devfn) << 8) | (where)),
> > > GT_PCI0_CFGADDR_OFS)
> > >
> > >  #define COBALT_LED_PORT                (*(volatile unsigned char *)
> > > CKSEG1ADDR(0x1c000000))
> > > +#define COBALT_LED_BASE         0xbc000000
> >
> > You don't need COBALT_LED_BASE.
> > Because COBALT_LED_PORT is already defined.
> >
> > Yoichi

=2D-=20
Cordialement, Florian Fainelli
=2D--------------------------------------------
5, rue Charles Fourier
Chambre 1202
91011 Evry
http://www.alphacore.net
(+33) 01 60 76 64 21
(+33) 06 09 02 64 95
=2D--------------------------------------------
Association MiNET
http://www.minet.net
=2D--------------------------------------------
Institut National des T=E9l=E9communication
http://www.int-evry.fr/telecomint
=2D--------------------------------------------

--nextPart4482606.En2iAhNvg2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFrBSQQ/Yr6D8A81kRAvWYAJsGeIspEpyCy9a/dDHbDjA8txnkigCeJcFd
wG36aAGDNG/YFWz1Y+BG1VE=
=1+gq
-----END PGP SIGNATURE-----

--nextPart4482606.En2iAhNvg2--
