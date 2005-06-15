Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2005 15:36:20 +0100 (BST)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:55310 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225954AbVFOOgF>;
	Wed, 15 Jun 2005 15:36:05 +0100
Received: from ip6-localhost ([193.170.141.4]) by grey.subnet.at ; Wed, 15 Jun 2005 16:36:02 +0200
From:	Bruno Randolf <bruno.randolf@4g-systems.biz>
To:	linux-mips@linux-mips.org
Subject: au1xxx MTD with 2.6
Date:	Wed, 15 Jun 2005 16:35:48 +0200
User-Agent: KMail/1.7.2
Organization: 4G Systems
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1733115.dtjvy5rAhf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506151635.52261.bruno.randolf@4g-systems.biz>
X-Rcpt-To: <linux-mips@linux-mips.org>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

--nextPart1733115.dtjvy5rAhf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi!

speaking of linux 2.6 on the meshcube: the last major problem i have with 2=
=2E6=20
support is MTD: the flash size is not recognized correctly.

i added=20

+#ifdef CONFIG_MIPS_MTX1
+#define BOARD_MAP_NAME "MTX-1 Flash"
+#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */
+#define BOARD_FLASH_WIDTH 4 /* 32-bits */
+#endif

to drivers/mtd/maps/alchemy-flash.c, which is about the aequivalent of what=
=20
was necessary for the 2.4 kernel.

but now flash is not recognized correctly anymore, it seems only half of it=
 is=20
recognized. here is the output (with some debugging printk's from me):

MTX-1 Flash: probing 32-bit flash bus
1e000000 2000000
bla be000000
*** map_info size: 2000000
MTX-1 Flash: Found 1 x32 devices at 0x0 in 32-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
Using buffer write method
MTX-1 Flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
*** mtd_info size: 1000000
Creating 4 MTD partitions on "MTX-1 Flash":
0x00000000-0x01c00000 : "User FS"
mtd: partition "User FS" extends beyond the end of device "MTX-1 Flash" --=
=20
size truncated to 0x1000000
mtd: Giving out device 0 to User FS
0x01c00000-0x01d00000 : "YAMON"
mtd: partition "YAMON" is out of reach -- disabled
mtd: Giving out device 1 to YAMON
0x01d00000-0x01fc0000 : "raw kernel"
mtd: partition "raw kernel" is out of reach -- disabled
mtd: Giving out device 2 to raw kernel
0x01fc0000-0x02000000 : "YAMON env"
mtd: partition "YAMON env" is out of reach -- disabled
mtd: Giving out device 3 to YAMON env
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2

since we have two AMDL128ML flash chips (which are 16bit) on board, i also=
=20
tried it with BOARD_FLASH_WIDTH 2, but this leads to the same errors.

does the alchemy-flash mapping work for the other au1xxx users? any ideas w=
hat=20
might be the problem?

thanks for any hints,
bruno

--nextPart1733115.dtjvy5rAhf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCsDzIfg2jtUL97G4RAkauAJ9Rxs71nxxOJA7FMGJE9LMAnWRLEACgrZcA
9o8azdLhPC8KCtSDbj+Y/mg=
=pAr5
-----END PGP SIGNATURE-----

--nextPart1733115.dtjvy5rAhf--
