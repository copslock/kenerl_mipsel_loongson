Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 15:07:18 +0000 (GMT)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:22546 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225073AbUKWPHN>;
	Tue, 23 Nov 2004 15:07:13 +0000
Received: from ip6-localhost ([193.170.141.4]) by grey.subnet.at ; Tue, 23 Nov 2004 16:07:03 +0100
From: Bruno Randolf <bruno.randolf@4g-systems.biz>
To: linux-mips@linux-mips.org
Subject: patch: mtx-1 board reset
Date: Tue, 23 Nov 2004 15:59:35 +0100
User-Agent: KMail/1.7.1
Organization: 4G Systems
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2714420.R27U2b5AYi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411231559.41620.bruno.randolf@4g-systems.biz>
X-Rcpt-To: <linux-mips@linux-mips.org>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

--nextPart2714420.R27U2b5AYi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hello!

the following patch defines the necessary board_reset function for the mtx-=
1=20
(meshcube), please apply it to the 2.4 branch.

thanks,
bruno

=2D-- linux/arch/mips/au1000/mtx-1/board_setup.c.orig 2004-10-13=20
19:05:15.340583632 +0200
+++ linux/arch/mips/au1000/mtx-1/board_setup.c 2004-10-13 19:01:03.40288398=
4=20
+0200
@@ -48,6 +48,12 @@
=20
 extern struct rtc_ops no_rtc_ops;
=20
+void board_reset (void)
+{
+ /* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
+ au_writel(0x00000000, 0xAE00001C);
+}
+
 void __init board_setup(void)
 {
  rtc_ops =3D &no_rtc_ops;

--nextPart2714420.R27U2b5AYi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBo1Bdfg2jtUL97G4RAndCAJ4yMFNuGWkOvs/X9M+abo8D9xzgdwCgguj1
9DwOYpKDkrucqWN8uHLNkw8=
=yEbX
-----END PGP SIGNATURE-----

--nextPart2714420.R27U2b5AYi--
