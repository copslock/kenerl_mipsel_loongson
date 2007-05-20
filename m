Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 00:31:07 +0100 (BST)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:62949 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20024282AbXETXbF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 May 2007 00:31:05 +0100
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 1C7568D1694;
	Mon, 21 May 2007 01:30:15 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 2/2] Add GPIO wrappers to Au1x00 boards
Date:	Mon, 21 May 2007 01:30:13 +0200
User-Agent: KMail/1.9.6
Cc:	linux-mips@linux-mips.org
References: <200705192151.39752.florian.fainelli@telecomint.eu> <20070521.002642.108739229.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070521.002642.108739229.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3506442.MYBnrZOfqH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200705210130.17957.florian.fainelli@telecomint.eu>
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart3506442.MYBnrZOfqH
Content-Type: multipart/mixed;
  boundary="Boundary-01=_FoNUGTyPMCODmKr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_FoNUGTyPMCODmKr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Atsushi,

Thank you very much for your comments. Here is an updated version which=20
includes implementation for input/output directions and should take your=20
comments into account.

Le dimanche 20 mai 2007, Atsushi Nemoto a =E9crit=A0:
> On Sat, 19 May 2007 21:51:39 +0200, Florian Fainelli=20
<florian.fainelli@telecomint.eu> wrote:
> > diff -urN linux-2.6.21.1/include/asm-mips/mach-au1x00/au1xxx_gpio.h
> > linux-2.6.21.1.new/include/asm-mips/mach-au1x00/au1xxx_gpio.h ---
> > linux-2.6.21.1/include/asm-mips/mach-au1x00/au1xxx_gpio.h	2007-04-27
> > 23:49:26.000000000 +0200 +++
> > linux-2.6.21.1.new/include/asm-mips/mach-au1x00/au1xxx_gpio.h	2007-05-19
> > 21:34:27.000000000 +0200 @@ -1,10 +1,7 @@
>
> ...
>
> > +/* Wrappers for the arch-neutral GPIO API */
> > +
> > +static inline int gpio_request(unsigned gpio, const char *label)
> > +{
> > +	/* Not yet implemented */
> > +	return 0;
> > +}
> > +
> > +static inline void gpio_free(unsigned gpio)
> > +{
> > +	/* Not yet implemented */
> > +}
> > +
> > +extern int gpio_direction_input(unsigned gpio);
> > +extern int gpio_direction_output(unsigned gpio, int value);
> > +
> > +static inline int gpio_get_value(unsigned gpio)
> > +{
> > +	return au1xxx_gpio_get_value(gpio);
> > +}
> > +
> > +static inline void gpio_set_value(unsigned gpio, int value)
> > +{
> > +	au1xxx_gpio_set_value(gpio, value);
> > +}
> > +
> > +static inline int gpio_to_irq(unsigned gpio)
> > +{
> > +	return gpio;
> > +}
> > +
> > +static inline int irq_to_gpio(unsigned irq)
> > +{
> > +	return irq;
> > +}
> > +
> > +/* For cansleep */
> > +#include <asm-generic/gpio.h>
> > +
> > +#endif /* _AU1XXX_GPIO_H_ */
>
> These APIs should be usable by "#include <asm/gpio.h>".  So move
> mach-au1x00/au1xxx_gpio.h to mach-au1x00/gpio.h and include it by
> include/asm-mips/gpio.h (as Youichi said).
>
> And it seems gpio_direction_input()/gpio_direction_output() are not
> implemented.  A user of the GPIO API _should_ use these interfaces.
>
> ---
> Atsushi Nemoto



=2D-=20
Cordialement, Florian Fainelli
=2D--------------------------------------------

--Boundary-01=_FoNUGTyPMCODmKr
Content-Type: text/plain;
  charset="iso-8859-1";
  name="au1x00-gpio.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="au1x00-gpio.patch"

diff -urN linux-2.6.21.1/include/asm-mips/mach-au1x00/au1xxx_gpio.h linux-2=
=2E6.21.1.new/include/asm-mips/mach-au1x00/au1xxx_gpio.h
=2D-- linux-2.6.21.1/include/asm-mips/mach-au1x00/au1xxx_gpio.h	2007-04-27 =
23:49:26.000000000 +0200
+++ linux-2.6.21.1.new/include/asm-mips/mach-au1x00/au1xxx_gpio.h	1970-01-0=
1 01:00:00.000000000 +0100
@@ -1,20 +0,0 @@
=2D#ifndef __AU1XXX_GPIO_H
=2D#define __AU1XXX_GPIO_H
=2D
=2Dvoid au1xxx_gpio1_set_inputs(void);
=2Dvoid au1xxx_gpio_tristate(int signal);
=2Dvoid au1xxx_gpio_write(int signal, int value);
=2Dint  au1xxx_gpio_read(int signal);
=2D
=2Dtypedef volatile struct
=2D{
=2D	u32 dir;
=2D	u32 reserved;
=2D	u32 output;
=2D	u32 pinstate;
=2D	u32 inten;
=2D	u32 enable;
=2D
=2D} AU1X00_GPIO2;
=2D
=2D#endif //__AU1XXX_GPIO_H
diff -urN linux-2.6.21.1/include/asm-mips/mach-au1x00/gpio.h linux-2.6.21.1=
=2Enew/include/asm-mips/mach-au1x00/gpio.h
=2D-- linux-2.6.21.1/include/asm-mips/mach-au1x00/gpio.h	1970-01-01 01:00:0=
0.000000000 +0100
+++ linux-2.6.21.1.new/include/asm-mips/mach-au1x00/gpio.h	2007-05-21 01:10=
:22.000000000 +0200
@@ -0,0 +1,69 @@
+#ifndef _AU1XXX_GPIO_H_
+#define _AU1XXX_GPIO_H_
+
+#define AU1XXX_GPIO_BASE	200
+
+typedef volatile struct
+{
+	u32 dir;
+	u32 reserved;
+	u32 output;
+	u32 pinstate;
+	u32 inten;
+	u32 enable;
+
+} AU1X00_GPIO2;
+
+extern int au1xxx_gpio_get_value(unsigned gpio);
+extern void au1xxx_gpio_set_value(unsigned gpio, int value);
+extern int au1xxx_gpio_direction_input(unsigned gpio);
+extern int au1xxx_gpio_direction_output(unsigned gpio, int value);
+
+
+/* Wrappers for the arch-neutral GPIO API */
+
+static inline int gpio_request(unsigned gpio, const char *label)
+{
+	/* Not yet implemented */
+	return 0;
+}
+
+static inline void gpio_free(unsigned gpio)
+{
+	/* Not yet implemented */
+}
+
+static inline int gpio_direction_input(unsigned gpio)
+{
+	return au1xxx_gpio_direction_input(gpio);
+}
+
+static inline int gpio_direction_output(unsigned gpio, int value)
+{
+	return au1xxx_gpio_direction_output(gpio, value);
+}
+
+static inline int gpio_get_value(unsigned gpio)
+{
+	return au1xxx_gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value(unsigned gpio, int value)
+{
+	au1xxx_gpio_set_value(gpio, value);
+}
+
+static inline int gpio_to_irq(unsigned gpio)
+{
+	return gpio;
+}
+
+static inline int irq_to_gpio(unsigned irq)
+{
+	return irq;
+}
+
+/* For cansleep */
+#include <asm-generic/gpio.h>
+
+#endif /* _AU1XXX_GPIO_H_ */
diff -urN linux-2.6.21.1/arch/mips/au1000/common/gpio.c linux-2.6.21.1.new/=
arch/mips/au1000/common/gpio.c
=2D-- linux-2.6.21.1/arch/mips/au1000/common/gpio.c	2007-04-27 23:49:26.000=
000000 +0200
+++ linux-2.6.21.1.new/arch/mips/au1000/common/gpio.c	2007-05-21 01:27:53.0=
00000000 +0200
@@ -1,4 +1,7 @@
 /*
+ *  Copyright (C) 2007, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
+ *  	Architecture specific GPIO support
+ *
  *  This program is free software; you can redistribute	 it and/or modify =
it
  *  under  the terms of	 the GNU General  Public License as published by t=
he
  *  Free Software Foundation;  either version 2 of the	License, or (at your
@@ -18,101 +21,128 @@
  *  You should have received a copy of the  GNU General Public License alo=
ng
  *  with this program; if not, write  to the Free Software Foundation, Inc=
=2E,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *  Notes :
+ * 	au1000 SoC have only one GPIO line : GPIO1
+ * 	others have a second one : GPIO2
  */
+
+#include <linux/autoconf.h>
+#include <linux/init.h>
+#include <linux/types.h>
 #include <linux/module.h>
=2D#include <au1000.h>
=2D#include <au1xxx_gpio.h>
+
+#include <asm/addrspace.h>
+#include <asm/io.h>
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/gpio.h>
=20
 #define gpio1 sys
 #if !defined(CONFIG_SOC_AU1000)
 static AU1X00_GPIO2 * const gpio2 =3D (AU1X00_GPIO2 *)GPIO2_BASE;
+#define GPIO2_OUTPUT_ENABLE_MASK 	0x00010000
=20
=2D#define GPIO2_OUTPUT_ENABLE_MASK 0x00010000
=2D
=2Dint au1xxx_gpio2_read(int signal)
+static int au1xxx_gpio2_read(unsigned gpio)
 {
=2D	signal -=3D 200;
=2D/*	gpio2->dir &=3D ~(0x01 << signal);						//Set GPIO to input */
=2D	return ((gpio2->pinstate >> signal) & 0x01);
+	gpio -=3D AU1XXX_GPIO_BASE;
+	return ((gpio2->pinstate >> gpio) & 0x01);
 }
=20
=2Dvoid au1xxx_gpio2_write(int signal, int value)
+static void au1xxx_gpio2_write(unsigned gpio, int value)
 {
=2D	signal -=3D 200;
+	gpio -=3D AU1XXX_GPIO_BASE;
=20
=2D	gpio2->output =3D (GPIO2_OUTPUT_ENABLE_MASK << signal) |
=2D		(value << signal);
+	gpio2->output =3D (GPIO2_OUTPUT_ENABLE_MASK << gpio) |
+	                (value << gpio);
 }
=20
=2Dvoid au1xxx_gpio2_tristate(int signal)
+static int au1xxx_gpio2_direction_input(unsigned gpio)
 {
=2D	signal -=3D 200;
=2D	gpio2->dir &=3D ~(0x01 << signal); 	/* Set GPIO to input */
+	gpio -=3D AU1XXX_GPIO_BASE;
+	gpio2->dir &=3D ~(0x01 << gpio);
+	return 0;
 }
=2D#endif
=20
=2Dint au1xxx_gpio1_read(int signal)
+static int au1xxx_gpio2_direction_output(unsigned gpio, int value)
 {
=2D/*	gpio1->trioutclr |=3D (0x01 << signal); */
=2D	return ((gpio1->pinstaterd >> signal) & 0x01);
+	gpio -=3D AU1XXX_GPIO_BASE;
+	gpio2->dir =3D (0x01 << gpio) | (value << gpio);
+	return 0;
 }
=20
=2Dvoid au1xxx_gpio1_write(int signal, int value)
+#endif /* !defined(CONFIG_SOC_AU1000) */
+
+static int au1xxx_gpio1_read(unsigned gpio)
+{
+	return ((gpio1->pinstaterd >> gpio) & 0x01);
+}
+
+static void au1xxx_gpio1_write(unsigned gpio, int value)
 {
 	if(value)
=2D		gpio1->outputset =3D (0x01 << signal);
+		gpio1->outputset =3D (0x01 << gpio);
 	else
=2D		gpio1->outputclr =3D (0x01 << signal);	/* Output a Zero */
+		/* Output a zero */
+		gpio1->outputclr =3D (0x01 << gpio);
 }
=20
=2Dvoid au1xxx_gpio1_tristate(int signal)
+static int au1xxx_gpio1_direction_input(unsigned gpio)
 {
=2D	gpio1->trioutclr =3D (0x01 << signal);		/* Tristate signal */
+	gpio1->pininputen =3D 0;;
+	return 0;
 }
=20
+static int au1xxx_gpio1_direction_output(unsigned gpio, int value)
+{
+	gpio1->trioutclr =3D (0x01 & gpio);
+	return 0;
+}
=20
=2Dint au1xxx_gpio_read(int signal)
+int au1xxx_gpio_get_value(unsigned gpio)
 {
=2D	if(signal >=3D 200)
+	if(gpio >=3D AU1XXX_GPIO_BASE)
 #if defined(CONFIG_SOC_AU1000)
 		return 0;
 #else
=2D		return au1xxx_gpio2_read(signal);
+		return au1xxx_gpio2_read(gpio);
 #endif
 	else
=2D		return au1xxx_gpio1_read(signal);
+		return au1xxx_gpio1_read(gpio);
 }
=20
=2Dvoid au1xxx_gpio_write(int signal, int value)
+void au1xxx_gpio_set_value(unsigned gpio, int value)
 {
=2D	if(signal >=3D 200)
+	if(gpio >=3D AU1XXX_GPIO_BASE)
 #if defined(CONFIG_SOC_AU1000)
 		;
 #else
=2D		au1xxx_gpio2_write(signal, value);
+		au1xxx_gpio2_write(gpio, value);
 #endif
 	else
=2D		au1xxx_gpio1_write(signal, value);
+		au1xxx_gpio1_write(gpio, value);
 }
=20
=2Dvoid au1xxx_gpio_tristate(int signal)
+int au1xxx_gpio_direction_input(unsigned gpio)
 {
=2D	if(signal >=3D 200)
+	if (gpio >=3D AU1XXX_GPIO_BASE)
 #if defined(CONFIG_SOC_AU1000)
 		;
 #else
=2D		au1xxx_gpio2_tristate(signal);
+		return au1xxx_gpio2_direction_input(gpio);
 #endif
 	else
=2D		au1xxx_gpio1_tristate(signal);
+		return au1xxx_gpio1_direction_input(gpio);
 }
=20
=2Dvoid au1xxx_gpio1_set_inputs(void)
+int au1xxx_gpio_direction_output(unsigned gpio, int value)
 {
=2D	gpio1->pininputen =3D 0;
+	if (gpio >=3D AU1XXX_GPIO_BASE)
+#if defined(CONFIG_SOC_AU1000)
+		;
+#else
+		return au1xxx_gpio2_direction_output(gpio, value);
+#endif
+	else
+		return au1xxx_gpio1_direction_output(gpio, value);
 }
=2D
=2DEXPORT_SYMBOL(au1xxx_gpio1_set_inputs);
=2DEXPORT_SYMBOL(au1xxx_gpio_tristate);
=2DEXPORT_SYMBOL(au1xxx_gpio_write);
=2DEXPORT_SYMBOL(au1xxx_gpio_read);

--Boundary-01=_FoNUGTyPMCODmKr--

--nextPart3506442.MYBnrZOfqH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iD8DBQBGUNoJmx9n1G/316sRAr47AJ42Nn43EBAJBgxJIycmXgdxwYQ7zwCg1tCm
x8hy3xLfpyvKDNg81CTFUoE=
=WhcG
-----END PGP SIGNATURE-----

--nextPart3506442.MYBnrZOfqH--
