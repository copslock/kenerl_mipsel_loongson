Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g171MSK05135
	for linux-mips-outgoing; Wed, 6 Feb 2002 17:22:28 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g171MAA05115
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 17:22:10 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g171LtR10473;
	Wed, 6 Feb 2002 17:21:56 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@uni-koblenz.de>
Cc: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: PATCH: Momentum Ocelot (CP7000) fixes
Date: Wed, 6 Feb 2002 17:21:55 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIAEFJCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0016_01C1AF32.C66555C0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_0016_01C1AF32.C66555C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Ralf --

Attached to this message is a patch to make the Momentum Computer
Ocelot (CP7000) SBC port of Linux work.  I made this patch against a
recent (2 days ago) CVS snapshot.  Please apply it to the CVS
repository.

It turns out that the existing code only worked for boards with 512MiB
of SDRAM.  This patch makes all memory configurations work.  While
discontiguous memory configurations seemed to work, there was some
"unusual" behavior.  This patch uses a contiguous memory approach,
which seems much more stable.

BTW, did you ever wind up in the same place as the board we sent you?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

------=_NextPart_000_0016_01C1AF32.C66555C0
Content-Type: application/octet-stream;
	name="patch20020204"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch20020204"

? a.out=0A=
? arch/mips/boot/elf2ecoff=0A=
? arch/mips/boot/vmlinux.ecoff=0A=
? arch/mips/boot/addinitrd=0A=
Index: arch/mips/gt64120/momenco_ocelot/setup.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/gt64120/momenco_ocelot/setup.c,v=0A=
retrieving revision 1.5=0A=
diff -u -r1.5 setup.c=0A=
--- arch/mips/gt64120/momenco_ocelot/setup.c	2001/11/25 09:25:53	1.5=0A=
+++ arch/mips/gt64120/momenco_ocelot/setup.c	2002/02/05 02:24:48=0A=
@@ -2,11 +2,12 @@=0A=
  * setup.c=0A=
  *=0A=
  * BRIEF MODULE DESCRIPTION=0A=
- * Galileo Evaluation Boards - board dependent boot routines=0A=
+ * Momentum Computer Ocelot (CP7000) - board dependent boot routines=0A=
  *=0A=
  * Copyright (C) 1996, 1997, 2001  Ralf Baechle=0A=
  * Copyright (C) 2000 RidgeRun, Inc.=0A=
  * Copyright (C) 2001 Red Hat, Inc.=0A=
+ * Copyright (C) 2002 Momentum Computer=0A=
  *=0A=
  * Author: RidgeRun, Inc.=0A=
  *   glonnon@ridgerun.com, skranz@ridgerun.com, stevej@ridgerun.com=0A=
@@ -116,8 +117,7 @@=0A=
 =0A=
 	/* Also a temporary entry to let us talk to the Ocelot PLD and NVRAM=0A=
 	   in the CS[012] region. We can't use ioremap() yet. The NVRAM=0A=
-	   appears to be one of the variants of ST M48T35 - see =0A=
-	   =
http://www.st.com/stonline/bin/sftab.exe?table=3D172&filter0=3DM48T35=0A=
+	   is a ST M48T37Y, which includes NVRAM, RTC, and Watchdog functions.=0A=
 =0A=
 		Ocelot PLD (CS0)	0x2c000000	0xe0020000=0A=
 		NVRAM			0x2c800000	0xe0030000=0A=
@@ -155,6 +155,7 @@=0A=
 	GT_WRITE(GT_PCI1M0LD_OFS, 0x32000000 >> 21);=0A=
 	GT_WRITE(GT_PCI1M1LD_OFS, 0x34000000 >> 21);=0A=
 =0A=
+	/* For the initial programming, we assume 512MB configuration */=0A=
 	/* Relocate the CPU's view of the RAM... */=0A=
 	GT_WRITE(GT_SCS10LD_OFS, 0);=0A=
 	GT_WRITE(GT_SCS10HD_OFS, 0x0fe00000 >> 21);=0A=
@@ -207,17 +208,66 @@=0A=
 	switch(tmpword &3) {=0A=
 	case 3:=0A=
 		/* 512MiB */=0A=
-		add_memory_region(256<<20, 256<<20, BOOT_MEM_RAM);=0A=
+		/* Decoders are allready set -- just add the=0A=
+		 * appropriate region */=0A=
+		add_memory_region( 0x40<<20,  0xC0<<20, BOOT_MEM_RAM);=0A=
+		add_memory_region(0x100<<20, 0x100<<20, BOOT_MEM_RAM);=0A=
+		break;=0A=
 	case 2:=0A=
-		/* 256MiB */=0A=
-		/* FIXME: Is it actually here, or at 0x10000000? */=0A=
-		add_memory_region(128<<20, 128<<20, BOOT_MEM_RAM);=0A=
+		/* 256MiB -- two banks of 128MiB */=0A=
+		GT_WRITE(GT_SCS10HD_OFS, 0x07e00000 >> 21);=0A=
+		GT_WRITE(GT_SCS32LD_OFS, 0x08000000 >> 21);=0A=
+		GT_WRITE(GT_SCS32HD_OFS, 0x0fe00000 >> 21);=0A=
+=0A=
+		GT_WRITE(GT_SCS0HD_OFS, 0x7f);=0A=
+		GT_WRITE(GT_SCS2LD_OFS, 0x80);=0A=
+		GT_WRITE(GT_SCS2HD_OFS, 0xff);=0A=
+=0A=
+		/* reconfigure the PCI0 interface view of memory */=0A=
+		GT_WRITE(GT_PCI0_CFGADDR_OFS, 0x80000014);=0A=
+		GT_WRITE(GT_PCI0_CFGDATA_OFS, 0x08000000);=0A=
+		GT_WRITE(GT_PCI0_BS_SCS10_OFS, 0x0ffff000);=0A=
+		GT_WRITE(GT_PCI0_BS_SCS32_OFS, 0x0ffff000);=0A=
+=0A=
+		add_memory_region(0x40<<20, 0x40<<20, BOOT_MEM_RAM);=0A=
+		add_memory_region(0x80<<20, 0x80<<20, BOOT_MEM_RAM);=0A=
+		break;=0A=
 	case 1:=0A=
-		/* 128MiB */=0A=
-		add_memory_region(64<<20, 64<<20, BOOT_MEM_RAM);=0A=
+		/* 128MiB -- 64MiB per bank */=0A=
+		GT_WRITE(GT_SCS10HD_OFS, 0x03e00000 >> 21);=0A=
+		GT_WRITE(GT_SCS32LD_OFS, 0x04000000 >> 21);=0A=
+		GT_WRITE(GT_SCS32HD_OFS, 0x07e00000 >> 21);=0A=
+=0A=
+		GT_WRITE(GT_SCS0HD_OFS, 0x3f);=0A=
+		GT_WRITE(GT_SCS2LD_OFS, 0x40);=0A=
+		GT_WRITE(GT_SCS2HD_OFS, 0x7f);=0A=
+=0A=
+		/* reconfigure the PCI0 interface view of memory */=0A=
+		GT_WRITE(GT_PCI0_CFGADDR_OFS, 0x80000014);=0A=
+		GT_WRITE(GT_PCI0_CFGDATA_OFS, 0x04000000);=0A=
+		GT_WRITE(GT_PCI0_BS_SCS10_OFS, 0x03fff000);=0A=
+		GT_WRITE(GT_PCI0_BS_SCS32_OFS, 0x03fff000);=0A=
+=0A=
+		/* add the appropriate region */=0A=
+		add_memory_region(0x40<<20, 0x40<<20, BOOT_MEM_RAM);=0A=
+		break;=0A=
 	case 0:=0A=
 		/* 64MiB */=0A=
-		;=0A=
+		GT_WRITE(GT_SCS10HD_OFS, 0x01e00000 >> 21);=0A=
+		GT_WRITE(GT_SCS32LD_OFS, 0x02000000 >> 21);=0A=
+		GT_WRITE(GT_SCS32HD_OFS, 0x03e00000 >> 21);=0A=
+=0A=
+		GT_WRITE(GT_SCS0HD_OFS, 0x1f);=0A=
+		GT_WRITE(GT_SCS2LD_OFS, 0x20);=0A=
+		GT_WRITE(GT_SCS2HD_OFS, 0x3f);=0A=
+=0A=
+		/* reconfigure the PCI0 interface view of memory */=0A=
+		GT_WRITE(GT_PCI0_CFGADDR_OFS, 0x80000014);=0A=
+		GT_WRITE(GT_PCI0_CFGDATA_OFS, 0x04000000);=0A=
+		GT_WRITE(GT_PCI0_BS_SCS10_OFS, 0x01fff000);=0A=
+		GT_WRITE(GT_PCI0_BS_SCS32_OFS, 0x01fff000);=0A=
+=0A=
+		break;=0A=
 	}=0A=
 =0A=
 	/* Fix up the DiskOnChip mapping */=0A=

------=_NextPart_000_0016_01C1AF32.C66555C0--
