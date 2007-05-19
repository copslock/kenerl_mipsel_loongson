Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2007 20:53:50 +0100 (BST)
Received: from smtp2.int-evry.fr ([157.159.10.45]:52943 "EHLO
	smtp2.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20024086AbXESTx1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 19 May 2007 20:53:27 +0100
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	by smtp2.int-evry.fr (Postfix) with ESMTP id BA2072FFA9
	for <linux-mips@linux-mips.org>; Sat, 19 May 2007 21:52:49 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	linux-mips@linux-mips.org
Subject: [PATCH 2/2] Add GPIO wrappers to Au1x00 boards
Date:	Sat, 19 May 2007 21:51:39 +0200
User-Agent: KMail/1.9.6
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5338215.TgM35d8zRI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200705192151.39752.florian.fainelli@telecomint.eu>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-MCPCheck: 
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart5338215.TgM35d8zRI
Content-Type: multipart/mixed;
  boundary="Boundary-01=_LV1TGqvvUT25/UN"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_LV1TGqvvUT25/UN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch adds Au1x00 specific GPIO wrappers to the GPIO API. It also remo=
ves=20
the exported symbols that are not used anywhere else.
=2D-=20
Signed-off-by: Florian Fainelli <florian@telecomint.eu>

--Boundary-01=_LV1TGqvvUT25/UN
Content-Type: text/plain;
  charset="us-ascii";
  name="gpio-au1000.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="gpio-au1000.patch"

diff -urN linux-2.6.21.1/arch/mips/au1000/common/gpio.c linux-2.6.21.1.new/=
arch/mips/au1000/common/gpio.c
=2D-- linux-2.6.21.1/arch/mips/au1000/common/gpio.c	2007-04-27 23:49:26.000=
000000 +0200
+++ linux-2.6.21.1.new/arch/mips/au1000/common/gpio.c	2007-05-19 21:34:38.0=
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
@@ -18,101 +21,77 @@
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
+#include <asm/mach-au1x00/au1xxx_gpio.h>
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
+#endif /* !defined(CONFIG_SOC_AU1000) */
=20
=2Dvoid au1xxx_gpio2_tristate(int signal)
+static int au1xxx_gpio1_read(unsigned gpio)
 {
=2D	signal -=3D 200;
=2D	gpio2->dir &=3D ~(0x01 << signal); 	/* Set GPIO to input */
+	return ((gpio1->pinstaterd >> gpio) & 0x01);
 }
=2D#endif
=20
=2Dint au1xxx_gpio1_read(int signal)
=2D{
=2D/*	gpio1->trioutclr |=3D (0x01 << signal); */
=2D	return ((gpio1->pinstaterd >> signal) & 0x01);
=2D}
=2D
=2Dvoid au1xxx_gpio1_write(int signal, int value)
+static void au1xxx_gpio1_write(unsigned gpio, int value)
 {
 	if(value)
=2D		gpio1->outputset =3D (0x01 << signal);
+		gpio1->outputset =3D (0x01 << gpio);
 	else
=2D		gpio1->outputclr =3D (0x01 << signal);	/* Output a Zero */
=2D}
=2D
=2Dvoid au1xxx_gpio1_tristate(int signal)
=2D{
=2D	gpio1->trioutclr =3D (0x01 << signal);		/* Tristate signal */
+		/* Output a zero */
+		gpio1->outputclr =3D (0x01 << gpio);
 }
=20
=2D
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
=2D
=2Dvoid au1xxx_gpio_tristate(int signal)
=2D{
=2D	if(signal >=3D 200)
=2D#if defined(CONFIG_SOC_AU1000)
=2D		;
=2D#else
=2D		au1xxx_gpio2_tristate(signal);
=2D#endif
=2D	else
=2D		au1xxx_gpio1_tristate(signal);
=2D}
=2D
=2Dvoid au1xxx_gpio1_set_inputs(void)
=2D{
=2D	gpio1->pininputen =3D 0;
=2D}
=2D
=2DEXPORT_SYMBOL(au1xxx_gpio1_set_inputs);
=2DEXPORT_SYMBOL(au1xxx_gpio_tristate);
=2DEXPORT_SYMBOL(au1xxx_gpio_write);
=2DEXPORT_SYMBOL(au1xxx_gpio_read);
diff -urN linux-2.6.21.1/include/asm-mips/mach-au1x00/au1xxx_gpio.h linux-2=
=2E6.21.1.new/include/asm-mips/mach-au1x00/au1xxx_gpio.h
=2D-- linux-2.6.21.1/include/asm-mips/mach-au1x00/au1xxx_gpio.h	2007-04-27 =
23:49:26.000000000 +0200
+++ linux-2.6.21.1.new/include/asm-mips/mach-au1x00/au1xxx_gpio.h	2007-05-1=
9 21:34:27.000000000 +0200
@@ -1,10 +1,7 @@
=2D#ifndef __AU1XXX_GPIO_H
=2D#define __AU1XXX_GPIO_H
+#ifndef _AU1XXX_GPIO_H_
+#define _AU1XXX_GPIO_H_
=20
=2Dvoid au1xxx_gpio1_set_inputs(void);
=2Dvoid au1xxx_gpio_tristate(int signal);
=2Dvoid au1xxx_gpio_write(int signal, int value);
=2Dint  au1xxx_gpio_read(int signal);
+#define AU1XXX_GPIO_BASE	200
=20
 typedef volatile struct
 {
@@ -17,4 +14,47 @@
=20
 } AU1X00_GPIO2;
=20
=2D#endif //__AU1XXX_GPIO_H
+extern int au1xxx_gpio_get_value(unsigned gpio);
+extern void au1xxx_gpio_set_value(unsigned gpio, int value);
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
+extern int gpio_direction_input(unsigned gpio);
+extern int gpio_direction_output(unsigned gpio, int value);
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

--Boundary-01=_LV1TGqvvUT25/UN--

--nextPart5338215.TgM35d8zRI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iD8DBQBGT1VLmx9n1G/316sRAqC2AKDXc1SI4OZBEXWEPqc67bB9lan6FgCeMJ6j
qme5tprDOyMukZWtSsaiQAs=
=y8Ly
-----END PGP SIGNATURE-----

--nextPart5338215.TgM35d8zRI--
