Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 15:08:58 +0000 (GMT)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:24082 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225192AbUKWPIx>;
	Tue, 23 Nov 2004 15:08:53 +0000
Received: from ip6-localhost ([193.170.141.4]) by grey.subnet.at ; Tue, 23 Nov 2004 16:08:51 +0100
From: Bruno Randolf <bruno.randolf@4g-systems.biz>
To: linux-mips@linux-mips.org
Subject: patch: mtx-1 irqmap
Date: Tue, 23 Nov 2004 16:01:25 +0100
User-Agent: KMail/1.7.1
Organization: 4G Systems
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1677233.5Gci3FehXx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411231601.29837.bruno.randolf@4g-systems.biz>
X-Rcpt-To: <linux-mips@linux-mips.org>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

--nextPart1677233.5Gci3FehXx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hello!

the following patch fixes the interrupt table for the mtx-1 (meshcube), ple=
ase=20
apply it to the 2.4 branch.

thanks,
bruno

diff -Nurb linux-mips-2.4.27/arch/mips/au1000/mtx-1/irqmap.c=20
linux/arch/mips/au1000/mtx-1/irqmap.c
=2D-- linux-mips-2.4.27/arch/mips/au1000/mtx-1/irqmap.c 2004-04-02=20
11:04:00.000000000 +0200
+++ linux/arch/mips/au1000/mtx-1/irqmap.c 2004-11-22 14:15:56.000000000 +01=
00
@@ -72,10 +72,10 @@
   * A       B       C       D
   */
  {
=2D  {INTA, INTB, INTC, INTD},   /* IDSEL 0 */
=2D  {INTA, INTB, INTC, INTD},   /* IDSEL 1 */
=2D  {INTA, INTB, INTC, INTD},   /* IDSEL 2 */
=2D  {INTA, INTB, INTC, INTD},   /* IDSEL 3 */
+  {INTA, INTB, INTX, INTX},   /* IDSEL 0 */
+  {INTB, INTA, INTX, INTX},   /* IDSEL 1 */
+  {INTC, INTD, INTX, INTX},   /* IDSEL 2 */
+  {INTD, INTC, INTX, INTX},   /* IDSEL 3 */
  };
  const long min_idsel =3D 0, max_idsel =3D 3, irqs_per_slot =3D 4;
  return PCI_IRQ_TABLE_LOOKUP;

--nextPart1677233.5Gci3FehXx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBo1DJfg2jtUL97G4RAk+ZAJ9kKhGadAEiGuJT7apYauEUWoAcAACffR9Z
Ctn0XOfIJX7LXD8r2+RKo1s=
=NoCD
-----END PGP SIGNATURE-----

--nextPart1677233.5Gci3FehXx--
