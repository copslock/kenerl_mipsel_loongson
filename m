Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2009 21:32:48 +0100 (WEST)
Received: from crux.i-cable.com ([203.83.115.104]:37508 "HELO crux.i-cable.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20024083AbZFJUcH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jun 2009 21:32:07 +0100
Received: (qmail 6671 invoked by uid 107); 10 Jun 2009 20:31:56 -0000
Received: from 203.83.114.121 by crux (envelope-from <robert.zhangle@gmail.com>, uid 104) with qmail-scanner-2.01 
 (clamdscan: 0.94.2/9149. spamassassin: 2.63.   
 Clear:RC:1(203.83.114.121):SA:0(2.6/5.0):. 
 Processed in 7.688976 secs); 10 Jun 2009 20:31:56 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 10 Jun 2009 20:31:48 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n5AKVY9D027720;
	Thu, 11 Jun 2009 04:31:34 +0800 (HKT)
Date:	Thu, 11 Jun 2009 04:31:24 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Wu Zhangjin <wuzj@lemote.com>,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: Re: [loongson-dev] Re: [loongson-PATCH-v3 17/25] add a machtype
	kernel command line argument
Message-ID: <20090610203123.GA20906@adriano.hkcable.com.hk>
Mail-Followup-To: wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Wu Zhangjin <wuzj@lemote.com>,
	Yan Hua <yanh@lemote.com>, Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>, Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
References: <cover.1244120575.git.wuzj@lemote.com> <d1f4caa360114f843459dc71827b1175232a24be.1244120575.git.wuzj@lemote.com> <20090610154032.GB21877@adriano.hkcable.com.hk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20090610154032.GB21877@adriano.hkcable.com.hk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

So this is the patch. I should say this patch is a bit intrusive againt your
verion. But I think I could justify the changes.

1. MACHNAME macro seems to be a little over engineered. And with MACHNAME,
   system type becomes "lemote-fuloong-2f-unknowninch" which does not make =
much
   sense. So I removed it. As a result, include/asm/mach-loongson/machtype.=
h is
   not needed anymore. I also modified loongson/yeeloong-2f/{init,reset}.c,
   because _89INCH and _7INCH no longer exist.

2. 3 machine names are defined twice, once in loongson/common/machtype.c, o=
nce
   in include/asm/mach-loongson/machine.h. In my patch, all the system type=
s are
   defined in loongson/common/machtype.c, as an array called system_types. =
Other
   loongson based machine, like Gdium, could add their system type to this =
array.

3. I defined symbolic names for the system_types array's index. In
   include/asm/mach-loongson/machine.h, I defined macro MACHTYPE using these
   symbolic names, so that we can get system type from system_types array
   using MACHTYPE as index.

4. Add NULL to the end of system_types array, so MACHTYPE_TOTAL is not need=
ed.

5. mips_machtype already has initial value MACH_UNKNOWN, so MACHTYPE_DEFAUL=
T is
   not needed.

6. modified the for loop in machtype_setup accordingly.

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 arch/mips/include/asm/bootinfo.h               |   11 +++++
 arch/mips/include/asm/mach-loongson/machine.h  |    8 ++--
 arch/mips/include/asm/mach-loongson/machtype.h |   32 ---------------
 arch/mips/loongson/common/machtype.c           |   50 ++++++++++----------=
---
 arch/mips/loongson/yeeloong-2f/init.c          |    3 +-
 arch/mips/loongson/yeeloong-2f/reset.c         |    7 ++-
 6 files changed, 42 insertions(+), 69 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson/machtype.h

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/booti=
nfo.h
index 610fe3a..0d9c7ff 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -7,6 +7,7 @@
  * Copyright (C) 1995, 1996 Andreas Busse
  * Copyright (C) 1995, 1996 Stoned Elipot
  * Copyright (C) 1995, 1996 Paul M. Antoine.
+ * Copyright (C) 2009       Zhang Le
  */
 #ifndef _ASM_BOOTINFO_H
 #define _ASM_BOOTINFO_H
@@ -57,6 +58,16 @@
 #define	MACH_MIKROTIK_RB532	0	/* Mikrotik RouterBoard 532 	*/
 #define MACH_MIKROTIK_RB532A	1	/* Mikrotik RouterBoard 532A 	*/
=20
+/*
+ * Valid machtype for group Loongson
+ */
+#define MACH_LOONGSON_UNKNOWN	0
+#define MACH_LEMOTE_FL2E	1
+#define MACH_LEMOTE_FL2F	2
+#define MACH_LEMOTE_YL2F89	3
+#define MACH_LEMOTE_YL2F7	4
+#define MACH_LOONGSON_END	5
+
 #define CL_SIZE			COMMAND_LINE_SIZE
=20
 extern char *system_type;
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/incl=
ude/asm/mach-loongson/machine.h
index 8109a9e..e168625 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -2,6 +2,7 @@
  * board-specific header file
  *
  * Copyright (c) 2009 Wu Zhangjin <wuzj@lemote.com>
+ * Copyright (c) 2009 Zhang Le <r0bertz@gentoo.org>
  *
  * This program is free software; you can redistribute it
  * and/or modify it under the terms of the GNU General
@@ -15,7 +16,7 @@
=20
 #ifdef CONFIG_LEMOTE_FULOONG2E
=20
-#define MACH_NAME	MACHNAME(LEMOTE, FULOONG, LOONGSON_2E, UNKNOWN)
+#define MACHTYPE	MACH_LEMOTE_FL2E
=20
 #define LOONGSON_UART_BASE		(LOONGSON_PCIIO_BASE + 0x3f8)
 #define	LOONGSON_UART_BAUD		1843200
@@ -29,7 +30,7 @@
=20
 #elif defined(CONFIG_LEMOTE_FULOONG2F)
=20
-#define MACH_NAME	MACHNAME(LEMOTE, FULOONG, LOONGSON_2F, UNKNOWN)
+#define MACHTYPE	MACH_LEMOTE_FL2F
=20
 #define LOONGSON_UART_BASE		(LOONGSON_PCIIO_BASE + 0x2f8)
 #define LOONGSON_UART_BAUD		1843200
@@ -37,8 +38,7 @@
=20
 #else /* CONFIG_CPU_YEELOONG2F */
=20
-/* by default, set it as 8.9INCH? or UNKNOWN? */
-#define MACH_NAME	MACHNAME(LEMOTE, YEELOONG, LOONGSON_2F, _89INCH)
+#define MACHTYPE	MACH_LEMOTE_YL2F89
=20
 /* yeeloong use the CPU serial port of Loongson2F */
 #define LOONGSON_UART_BASE		(LOONGSON_LIO1_BASE + 0x3f8)
diff --git a/arch/mips/include/asm/mach-loongson/machtype.h b/arch/mips/inc=
lude/asm/mach-loongson/machtype.h
deleted file mode 100644
index 9f96926..0000000
--- a/arch/mips/include/asm/mach-loongson/machtype.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * machine type header file
- */
-
-#ifndef _MACHTYPE_H
-#define _MACHTYPE_H
-
-#define UNKNOWN		"unknown"
-
-/* company */
-#define LEMOTE		"lemote"
-#define DEXOON		"dexoon"
-
-/* product */
-#define FULOONG		"fuloong"
-#define YEELOONG	"yeeloong"
-#define	GDIUM		"gdium"
-
-/* cpu revision */
-#define LOONGSON_2E			"2e"
-#define LOONGSON_2F 		"2f"
-
-/* size */
-#define _7INCH			"7"
-#define	_89INCH			"8.9"
-
-#define MACHNAME_LEN	50
-
-#define MACHNAME(company, product, cpu, size) \
-	(company "-" product "-" cpu "-" size "inch\0")
-
-#endif /* ! _MACHTYPE_H */
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/comm=
on/machtype.c
index d469dc7..34417cf 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -2,6 +2,8 @@
  * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
  * Author: Wu Zhangjin, wuzj@lemote.com
  *
+ * Copyright (c) 2009 Zhang Le <r0bertz@gentoo.org>
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -10,49 +12,41 @@
=20
 #include <linux/errno.h>
 #include <asm/cpu.h>
-
 #include <asm/bootinfo.h>
=20
 #include <loongson.h>
-#include <machtype.h>
 #include <machine.h>
=20
-static char machname[][MACHNAME_LEN] =3D {
-	MACHNAME(LEMOTE, FULOONG, LOONGSON_2E, UNKNOWN),
-	MACHNAME(LEMOTE, FULOONG, LOONGSON_2F, UNKNOWN),
-	MACHNAME(LEMOTE, YEELOONG, LOONGSON_2F, _89INCH),
-	MACHNAME(LEMOTE, YEELOONG, LOONGSON_2F, _7INCH),
+static const char *system_types[] =3D {
+	[MACH_LOONGSON_UNKNOWN]		"unknown loongson machine",
+	[MACH_LEMOTE_FL2E]		"lemote-fuloong-2e-box",
+	[MACH_LEMOTE_FL2F]		"lemote-fuloong-2f-box",
+	[MACH_LEMOTE_YL2F89]		"lemote-yeeloong-2f-8.9inches",
+	[MACH_LEMOTE_YL2F7]		"lemote-yeeloong-2f-7inches",
+	[MACH_LOONGSON_END]		NULL,
 };
=20
-#define MACHTYPE_TOTAL	(sizeof(machname)/MACHNAME_LEN)
-#define MACHTYPE_DEFAULT	-1
-
 const char *get_system_type(void)
 {
-	if (mips_machtype =3D=3D MACHTYPE_DEFAULT)
-		return MACH_NAME;
-	else
-		return machname[mips_machtype];
+	if (mips_machtype =3D=3D MACH_UNKNOWN)
+		mips_machtype =3D MACHTYPE;
+
+	return system_types[mips_machtype];
 }
=20
-static __init int machname_setup(char *str)
+static __init int machtype_setup(char *str)
 {
-	int index;
+	int machtype =3D MACH_LEMOTE_FL2E;
=20
 	if (!str)
-			return -EINVAL;
-
-	mips_machtype =3D MACHTYPE_DEFAULT;
+		return -EINVAL;
=20
-	for (index =3D 0;
-	     index < MACHTYPE_TOTAL;
-	     index++) {
-		if (strstr(str, machname[index]) !=3D NULL) {
-			mips_machtype =3D index;
-			return 0;
+	for (; system_types[machtype]; machtype++)
+		if (strstr(str, system_types[machtype])) {
+			mips_machtype =3D machtype;
+			break;
 		}
-	}
-	return -1;
+	return 0;
 }
=20
-__setup("machtype=3D", machname_setup);
+__setup("machtype=3D", machtype_setup);
diff --git a/arch/mips/loongson/yeeloong-2f/init.c b/arch/mips/loongson/yee=
loong-2f/init.c
index 80f8c5e..5d16e66 100644
--- a/arch/mips/loongson/yeeloong-2f/init.c
+++ b/arch/mips/loongson/yeeloong-2f/init.c
@@ -18,7 +18,6 @@
 #include <asm/bootinfo.h>
=20
 #include <cs5536/cs5536.h>
-#include <machtype.h>
=20
 void __init mach_prom_init_cmdline(void)
 {
@@ -77,6 +76,6 @@ void __init mach_prom_init_cmdline(void)
=20
 	if ((strstr(arcs_cmdline, "vga") =3D=3D NULL)
 			&& (strstr(arcs_cmdline, "machtype") !=3D NULL)
-				&& (strstr(arcs_cmdline, _7INCH) !=3D NULL))
+				&& (strstr(arcs_cmdline, "7inch") !=3D NULL))
 		strcat(arcs_cmdline, " vga=3D800x480x24");
 }
diff --git a/arch/mips/loongson/yeeloong-2f/reset.c b/arch/mips/loongson/ye=
eloong-2f/reset.c
index 124cf99..46394c2 100644
--- a/arch/mips/loongson/yeeloong-2f/reset.c
+++ b/arch/mips/loongson/yeeloong-2f/reset.c
@@ -15,7 +15,6 @@
=20
 #include <loongson.h>
 #include <machine.h>
-#include <machtype.h>
=20
 /*
  * The following registers are determined by the EC index configuration.
@@ -59,12 +58,14 @@ void mach_prepare_reboot(void)
=20
 void mach_prepare_shutdown(void)
 {
-	if (strstr(get_system_type(), _89INCH)) {
+	char *system_type =3D get_system_type();
+
+	if (strstr(system_type, "8.9inch")) {
 		/* cpu-gpio0 output low */
 		LOONGSON_GPIODATA &=3D ~0x00000001;
 		/* cpu-gpio0 as output */
 		LOONGSON_GPIOIE &=3D ~0x00000001;
-	} else if (strstr(get_system_type(), _7INCH)) {
+	} else if (strstr(system_type, "7inch")) {
 		u8 val;
 		u64 i;
=20
--=20
1.6.3.1


--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkowGBsACgkQvFHICB5OKXOWyQCdHmh4WmqVGbbq9yOtDqzzDR1X
JUMAn19Hf3wPbSGUbdsev2fSUOqMFtE/
=KZ/p
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
