Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2003 18:44:02 +0000 (GMT)
Received: from stork.mail.pas.earthlink.net ([IPv6:::ffff:207.217.120.188]:18591
	"EHLO stork.mail.pas.earthlink.net") by linux-mips.org with ESMTP
	id <S8225455AbTKLSna>; Wed, 12 Nov 2003 18:43:30 +0000
Received: from [207.215.131.7] (helo=jaco)
	by stork.mail.pas.earthlink.net with asmtp (Exim 3.33 #1)
	id 1AJzxf-0000Uz-00; Wed, 12 Nov 2003 10:43:28 -0800
Subject: Patch for ALI15x3 - Linux-MIPS kernel 2.4.22-rc3
From: Jack Miller <jvmiller@earthlink.net>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-XMwbFPDN0Ikw4P9BYAnN"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 12 Nov 2003 10:43:03 -0800
Message-Id: <1068662598.2185.2.camel@jaco>
Mime-Version: 1.0
X-ELNK-Trace: 00c7b4e377e67b8a1aa676d7e74259b7b3291a7d08dfec79a2dd1171d5a8c90bc7f803517eebc3bf350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
Return-Path: <jvmiller@earthlink.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jvmiller@earthlink.net
Precedence: bulk
X-list: linux-mips


--=-XMwbFPDN0Ikw4P9BYAnN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

  Ralf,
    Please apply this patch for the file drivers/ide/pci/alim15x3.c.  It
fixes the LBA addressing mode for chip revisions <= 0xC4.  Thank-You.

  Regards,
    Jack




--=-XMwbFPDN0Ikw4P9BYAnN
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=patch; charset=ISO-8859-15

--- alim15x3.c.orig	2003-11-12 10:32:04.000000000 -0800
+++ alim15x3.c	2003-11-12 08:18:08.000000000 -0800
@@ -760,7 +760,7 @@
 	hwif->speedproc =3D &ali15x3_tune_chipset;
=20
 	/* Don't use LBA48 on ALi devices before rev 0xC5 */
-	hwif->addressing =3D (m5229_revision <=3D 0xC4) ? 1 : 0;
+	hwif->addressing =3D (m5229_revision <=3D 0xC4) ? 0 : 1;
=20
 	if (!hwif->dma_base) {
 		hwif->drives[0].autotune =3D 1;

--=-XMwbFPDN0Ikw4P9BYAnN--
