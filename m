Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2002 03:14:14 +0100 (CET)
Received: from jeeves.momenco.com ([64.169.228.99]:23560 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1123920AbSKGCOL>; Thu, 7 Nov 2002 03:14:11 +0100
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id gA72E4N01406;
	Wed, 6 Nov 2002 18:14:04 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: "Linux-MIPS" <linux-mips@linux-mips.org>
Subject: PATCH: fix a .cvsignore for 2.5
Date: Wed, 6 Nov 2002 18:14:04 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIIECOCKAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001F_01C285C0.4A438830"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_001F_01C285C0.4A438830
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

The attached patch updates the .cvsignore file in
linux/arch/mips/momenco/ocelot_g/ to something reasonable for 2.5

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

------=_NextPart_000_001F_01C285C0.4A438830
Content-Type: application/octet-stream;
	name="patch20021106c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch20021106c"

? arch/mips/ld.script=0A=
? arch/mips/boot/addinitrd=0A=
? arch/mips/boot/vmlinux.ecoff=0A=
? arch/mips/tools/offset.h=0A=
? scripts/mkdep=0A=
Index: arch/mips/momentum/ocelot_g/.cvsignore=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/momentum/ocelot_g/.cvsignore,v=0A=
retrieving revision 1.1=0A=
diff -u -u -r1.1 .cvsignore=0A=
--- arch/mips/momentum/ocelot_g/.cvsignore	7 Nov 2002 00:02:47 -0000	1.1=0A=
+++ arch/mips/momentum/ocelot_g/.cvsignore	7 Nov 2002 02:12:39 -0000=0A=
@@ -1,2 +1,2 @@=0A=
-.depend=0A=
+.*.cmd=0A=
 .*.flags=0A=

------=_NextPart_000_001F_01C285C0.4A438830--
