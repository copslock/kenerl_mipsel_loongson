Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f86An9J13714
	for linux-mips-outgoing; Thu, 6 Sep 2001 03:49:09 -0700
Received: from animal.pace.co.uk (gateway.pace.co.uk [195.44.197.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f86An5d13710
	for <linux-mips@oss.sgi.com>; Thu, 6 Sep 2001 03:49:05 -0700
Received: from exchange1.cam.pace.co.uk (exchange1.cam.pace.co.uk [136.170.131.80])
	by animal.pace.co.uk (8.10.2/8.10.2) with ESMTP id f86Amw717335
	for <linux-mips@oss.sgi.com>; Thu, 6 Sep 2001 11:48:58 +0100
Received: by exchange1.cam.pace.co.uk with Internet Mail Service (5.5.2650.21)
	id <S2BF7YJW>; Thu, 6 Sep 2001 11:48:30 +0100
Message-ID: <54045BFDAD47D5118A850002A5095CC30AC57E@exchange1.cam.pace.co.uk>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Patch to allow current CVS to compile
Date: Thu, 6 Sep 2001 11:48:29 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C136C1.7721EE68"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C136C1.7721EE68
Content-Type: text/plain;
	charset="iso-8859-1"

The attached patch to kernel/setup.c is needed to get the current CVS to
compile.

Phil


------_=_NextPart_000_01C136C1.7721EE68
Content-Type: application/octet-stream;
	name="setup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setup.patch"

--- setup.c.orig	Thu Sep  6 11:40:31 2001=0A=
+++ setup.c	Thu Sep  6 11:40:54 2001=0A=
@@ -367,12 +367,12 @@=0A=
 				mips_cpu.options |=3D MIPS_CPU_FPU;=0A=
 			mips_cpu.scache.flags =3D MIPS_CACHE_NOT_PRESENT;=0A=
 			break;=0A=
-#endif /* CONFIG_CPU_MIPS32 */=0A=
 		default:=0A=
 			mips_cpu.cputype =3D CPU_UNKNOWN;=0A=
 			break;=0A=
 		}=0A=
 		break;=0A=
+#endif /* CONFIG_CPU_MIPS32 */=0A=
 	case PRID_COMP_SIBYTE:=0A=
 		switch (mips_cpu.processor_id & 0xff00) {=0A=
 		case PRID_IMP_SB1:=0A=

------_=_NextPart_000_01C136C1.7721EE68--
