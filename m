Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2002 00:51:41 +0100 (CET)
Received: from jeeves.momenco.com ([64.169.228.99]:4872 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1123920AbSKFXvl>; Thu, 7 Nov 2002 00:51:41 +0100
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id gA6NpWN00589;
	Wed, 6 Nov 2002 15:51:32 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: "Linux-MIPS" <linux-mips@linux-mips.org>
Subject: PATCH: Small Ocelot-G cleanups
Date: Wed, 6 Nov 2002 15:51:32 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIKECKCKAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0010_01C285AC.60FC1EC0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0010_01C285AC.60FC1EC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Here is a patch against the 2.4 branch.  It cleans up some dead code,
and allows the ethernet driver to get a real MAC address.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

------=_NextPart_000_0010_01C285AC.60FC1EC0
Content-Type: application/octet-stream;
	name="patch20021106"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch20021106"

Index: arch/mips/momentum/ocelot_g/ocelot_pld.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/momentum/ocelot_g/ocelot_pld.h,v=0A=
retrieving revision 1.1.2.1=0A=
diff -u -r1.1.2.1 ocelot_pld.h=0A=
--- arch/mips/momentum/ocelot_g/ocelot_pld.h	2 Sep 2002 16:11:44 -0000	=
1.1.2.1=0A=
+++ arch/mips/momentum/ocelot_g/ocelot_pld.h	6 Nov 2002 23:46:13 -0000=0A=
@@ -8,11 +8,7 @@=0A=
 #ifndef __MOMENCO_OCELOT_PLD_H__=0A=
 #define __MOMENCO_OCELOT_PLD_H__=0A=
 =0A=
-#if 0=0A=
-#define OCELOT_CS0_ADDR (0xe0020000)=0A=
-#else=0A=
 #define OCELOT_CS0_ADDR (0xfc000000)=0A=
-#endif=0A=
 =0A=
 #define OCELOT_REG_BOARDREV (0)=0A=
 #define OCELOT_REG_PLD1_ID (1)=0A=
Index: arch/mips/momentum/ocelot_g/pci.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/momentum/ocelot_g/pci.c,v=0A=
retrieving revision 1.1.2.2=0A=
diff -u -r1.1.2.2 pci.c=0A=
--- arch/mips/momentum/ocelot_g/pci.c	2 Sep 2002 22:14:42 -0000	1.1.2.2=0A=
+++ arch/mips/momentum/ocelot_g/pci.c	6 Nov 2002 23:46:13 -0000=0A=
@@ -405,7 +405,7 @@=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-int pcibios_enable_device(struct pci_dev *dev)=0A=
+int pcibios_enable_device(struct pci_dev *dev, int mask)=0A=
 {=0A=
 	return pcibios_enable_resources(dev);=0A=
 }=0A=
Index: arch/mips/momentum/ocelot_g/setup.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/momentum/ocelot_g/setup.c,v=0A=
retrieving revision 1.1.2.2=0A=
diff -u -r1.1.2.2 setup.c=0A=
--- arch/mips/momentum/ocelot_g/setup.c	2 Sep 2002 22:14:42 -0000	1.1.2.2=0A=
+++ arch/mips/momentum/ocelot_g/setup.c	6 Nov 2002 23:46:13 -0000=0A=
@@ -70,6 +70,10 @@=0A=
 =0A=
 extern struct rtc_ops no_rtc_ops;=0A=
 =0A=
+#ifdef CONFIG_GALILLEO_GT64240_ETH=0A=
+extern unsigned char prom_mac_addr_base[6];=0A=
+#endif=0A=
+=0A=
 unsigned long gt64240_base;=0A=
 =0A=
 /* These functions are used for rebooting or halting the machine*/=0A=
@@ -138,6 +142,11 @@=0A=
 =0A=
 	/* do handoff reconfiguration */=0A=
 	PMON_v2_setup();=0A=
+=0A=
+#ifdef CONFIG_GALILLEO_GT64240_ETH=0A=
+	/* get the mac addr */=0A=
+	memcpy(prom_mac_addr_base, (void*)0xfc807cf2, 6);=0A=
+#endif=0A=
 =0A=
 	/* Turn off the Bit-Error LED */=0A=
 	OCELOT_PLD_WRITE(0x80, INTCLR);=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ arch/mips/momentum/ocelot_g/.cvsignore	Thu Sep 12 19:32:20 2002=0A=
@@ -0,0 +1,2 @@=0A=
+.depend=0A=
+.*.flags=0A=

------=_NextPart_000_0010_01C285AC.60FC1EC0--
