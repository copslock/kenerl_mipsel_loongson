Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2003 19:21:45 +0000 (GMT)
Received: from mail3.efi.com ([IPv6:::ffff:192.68.228.90]:16911 "HELO
	fcexgw03.efi.internal") by linux-mips.org with SMTP
	id <S8225208AbTCZTVo>; Wed, 26 Mar 2003 19:21:44 +0000
Received: from 10.3.12.13 by fcexgw03.efi.internal (InterScan E-Mail VirusWall NT); Wed, 26 Mar 2003 11:21:36 -0800
Received: by fcexbh02.efi.com with Internet Mail Service (5.5.2656.59)
	id <GY2SA7SF>; Wed, 26 Mar 2003 11:21:36 -0800
Message-ID: <D9F6B9DABA4CAE4B92850252C52383AB07968265@ex-eng-corp.efi.com>
From: Ranjan Parthasarathy <ranjanp@efi.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: [PATCH 2.4] : setup.c start_pfn wrong with CONFIG_EMBEDDED_RAMDIS
	K enabled
Date: Wed, 26 Mar 2003 11:21:33 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C2F3CC.E9673BD0"
Return-Path: <ranjanp@efi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ranjanp@efi.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C2F3CC.E9673BD0
Content-Type: text/plain;
	charset="iso-8859-1"

> I would like to submit the following change to arch/mips/kernel/setup.c.
> The start_pfn is not correct in case CONFIG_EMBEDDED_RAMDISK is slected.
> The ramdisk pages are added twice.
> 
> The diff -Naur output is attached to the mail.
> 
> Thanks
> 
> Ranjan
> 
>  <<diff.output.txt>> 

------_=_NextPart_000_01C2F3CC.E9673BD0
Content-Type: text/plain;
	name="diff.output.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="diff.output.txt"

diff -Naur linux-dev/arch/mips/kernel/setup.c =
linux-dev-patch/arch/mips/kernel/setup.c=0A=
--- linux-dev/arch/mips/kernel/setup.c	Wed Dec 18 15:40:14 2002=0A=
+++ linux-dev-patch/arch/mips/kernel/setup.c	Mon Mar 24 16:13:07 =
2003=0A=
@@ -255,6 +255,16 @@=0A=
 	int i;=0A=
 =0A=
 #ifdef CONFIG_BLK_DEV_INITRD=0A=
+#ifdef CONFIG_EMBEDDED_RAMDISK=0A=
+	/*=0A=
+	 * Embedded ramdisk -> _end after the ramdisk so no need to add =
these=0A=
+	 * pages again=0A=
+	 *=0A=
+	 * Partially used pages are not usable - thus=0A=
+	 * we are rounding upwards.=0A=
+	 */=0A=
+	start_pfn =3D PFN_UP(__pa(&_end));=0A=
+#else=0A=
 	tmp =3D (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8;=0A=
 	if (tmp < (unsigned long)&_end)=0A=
 		tmp +=3D PAGE_SIZE;=0A=
@@ -264,6 +274,7 @@=0A=
 		initrd_end =3D initrd_start + initrd_header[1];=0A=
 	}=0A=
 	start_pfn =3D PFN_UP(__pa((&_end)+(initrd_end - initrd_start) + =
PAGE_SIZE));=0A=
+#endif=0A=
 #else=0A=
 	/*=0A=
 	 * Partially used pages are not usable - thus=0A=

------_=_NextPart_000_01C2F3CC.E9673BD0--
