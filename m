Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 01:47:45 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:27154 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122987AbSIQXro>; Wed, 18 Sep 2002 01:47:44 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g8HNlT604122;
	Tue, 17 Sep 2002 16:47:31 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@uni-koblenz.de>,
	"Linux-MIPS" <linux-mips@linux-mips.org>
Subject: PATCH: new MTD probe addresses for Ocelot and Ocelot-G
Date: Tue, 17 Sep 2002 16:47:29 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAICEAJCJAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0014_01C25E69.E9307800"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0014_01C25E69.E9307800
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

The attached patch updates the probe addresses for the Ocelot and
Ocelot-G boards for the MTD driver.

This is actually a resend.  This patch was skipped the first time.

Ralf, please apply to both 2.4 and 2.5 branches.

Matthew Dharm

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

------=_NextPart_000_0014_01C25E69.E9307800
Content-Type: application/octet-stream;
	name="patch20020903"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch20020903"

Index: drivers/mtd/devices/docprobe.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/drivers/mtd/devices/docprobe.c,v=0A=
retrieving revision 1.3=0A=
diff -u -u -r1.3 docprobe.c=0A=
--- drivers/mtd/devices/docprobe.c	2001/11/05 20:15:52	1.3=0A=
+++ drivers/mtd/devices/docprobe.c	2002/09/03 21:37:19=0A=
@@ -88,6 +88,9 @@=0A=
 	0xe4000000,=0A=
 #elif defined(CONFIG_MOMENCO_OCELOT)=0A=
 	0x2f000000,=0A=
+	0xff000000,=0A=
+#elif defined(CONFIG_MOMENCO_OCELOT_G)=0A=
+	0xff000000,=0A=
 #else=0A=
 #warning Unknown architecture for DiskOnChip. No default probe =
locations defined=0A=
 #endif=0A=

------=_NextPart_000_0014_01C25E69.E9307800--
