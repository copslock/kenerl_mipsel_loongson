Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3DN2L8d001074
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 13 Apr 2002 16:02:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3DN2Lin001073
	for linux-mips-outgoing; Sat, 13 Apr 2002 16:02:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3DN258d001061
	for <linux-mips@oss.sgi.com>; Sat, 13 Apr 2002 16:02:06 -0700
Received: (qmail 28674 invoked by uid 0); 13 Apr 2002 19:29:48 -0000
Received: from pd9e4155d.dip.t-dialin.net (HELO bogon.ms20.nix) (217.228.21.93)
  by mail.gmx.net (mp002-rz3) with SMTP; 13 Apr 2002 19:29:48 -0000
Received: by bogon.ms20.nix (Postfix, from userid 1000)
	id 9F69537130; Sat, 13 Apr 2002 21:28:12 +0200 (CEST)
Date: Sat, 13 Apr 2002 21:28:11 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Subject: head.S and init_task.c vs addinitrd
Message-ID: <20020413192811.GA25750@bogon.ms20.nix>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--JYK4vJDZwFMowpUq
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
short:=20
The attached patch modifies head.S/init_task.c to restore the old habit
of merging all sections(besides .reginfo) into one segment which lets
elf2ecoff/addinitrd work again.

long:
some of the recent head.S/init_task.c changes break addinitrd. In 2.4.16
we had two segments which allowed elf2ecoff to put everything (besides
bss) into one text section (dropping REGINFO) in the ecoff image leaving
the data section emtpy. Addinitrd then later merged the initial ramdisk
into that empty data section.

ELF kernel:
Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  REGINFO        0x1c2ae0 0x881c3ae0 0x881c3ae0 0x00018 0x00018 R   0x4
  LOAD           0x001000 0x88002000 0x88002000 0x1e8000 0x1ff560 RWE 0x1000

 Section to Segment mapping:
  Segment Sections...
   00     .reginfo=20
   01     .text .fixup .kstrtab __ex_table __ksymtab .text.init .data.init =
.setup.init .initcall.init .data.cacheline_aligned .reginfo .data .bss

ECOFF kernel:
Sections:
Idx Name          Size      VMA               LMA               File off  A=
lgn
  0 .text         001e8000  0000000088002000  0000000088002000  000000d0  2=
**4
                  CONTENTS, ALLOC, LOAD, CODE
  1 .data         00000000  00000000881ea000  00000000881ea000  001e80d0  2=
**4
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00017560  00000000881ea000  00000000881ea000  001e80d0  2=
**4
                  CONTENTS, ALLOC, NEVER_LOAD

Now as of 2.4.17+ we have three segments described in the program
header:

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  REGINFO        0x1c4ae0 0x881c5ae0 0x881c5ae0 0x00018 0x00018 R   0x4
  LOAD           0x001000 0x88002000 0x88002000 0x1ab140 0x1ab140 R E 0x1000
  LOAD           0x1ad000 0x881ae000 0x881ae000 0x43000 0x5a560 RWE 0x1000

 Section to Segment mapping:
  Segment Sections...
   00     .reginfo=20
   01     .text .fixup .kstrtab __ex_table __ksymtab=20
   02     .data.init_task .text.init .data.init .setup.init .initcall.init =
.data.cacheline_aligned .reginfo .data .bss

so there's no emtpy section left in the ecoff image for the initial
ramdisk. What was the reasoning for the above change? And why exactly
does this change cause a splitting into data and text segment where as
of 2.4.16 there was only a "data" segment?
Regards,
 -- Guido

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="init_task-2002-04-13.diff"
Content-Transfer-Encoding: quoted-printable

diff --exclude=3D*.orig --exclude=3D.* -Naur ../../kernel-source-2.4.17/arc=
h/mips/kernel/head.S arch/mips/kernel/head.S
--- ../../kernel-source-2.4.17/arch/mips/kernel/head.S	Thu Mar  7 22:49:57 =
2002
+++ arch/mips/kernel/head.S	Sat Apr 13 14:09:31 2002
@@ -178,10 +178,15 @@
 	.type	\name, @object
 	.endm
=20
-	.data
-	.align	12
+	.text
=20
 	page	swapper_pg_dir, PGD_ORDER
 	page	empty_bad_page, 0
 	page	empty_bad_page_table, 0
 	page	invalid_pte_table, 0
+
+/*
+ * Align to 8kb boundary for init_task_union which follows in the
+ * .text segment.
+ */
+	.align	13
diff --exclude=3D*.orig --exclude=3D.* -Naur ../../kernel-source-2.4.17/arc=
h/mips/kernel/init_task.c arch/mips/kernel/init_task.c
--- ../../kernel-source-2.4.17/arch/mips/kernel/init_task.c	Thu Mar  7 22:4=
9:57 2002
+++ arch/mips/kernel/init_task.c	Sat Apr 13 14:09:31 2002
@@ -20,5 +20,5 @@
  * The things we do for performance..
  */
 union task_union init_task_union
-	__attribute__((__section__(".data.init_task"))) =3D
+	__attribute__((__section__(".text"))) =3D
 		{ INIT_TASK(init_task_union.task) };

--T4sUOijqQbZv57TR--

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8uIbLn88szT8+ZCYRAqXlAJ0W0hSSELN8/a+scajZDfl3ULObwACfZF4Y
8dTrKLlqWXRplOeDlqr9o2U=
=xpP9
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
