Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2005 18:03:46 +0100 (BST)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:2565 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225411AbVHXRDZ>;
	Wed, 24 Aug 2005 18:03:25 +0100
Received: from ip6-localhost ([193.170.141.4]) by grey.subnet.at ; Wed, 24 Aug 2005 19:08:54 +0200
From:	Bruno Randolf <bruno.randolf@4g-systems.biz>
To:	linux-mips@linux-mips.org
Subject: au1000 pci_ops clear errors
Date:	Wed, 24 Aug 2005 19:05:44 +0200
User-Agent: KMail/1.8.1
Organization: 4G Systems
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4374168.4qLdzKYEyK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508241905.48376.bruno.randolf@4g-systems.biz>
X-Rcpt-To: <linux-mips@linux-mips.org>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

--nextPart4374168.4qLdzKYEyK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hello!

what do you think about the following patch to clear PCI errors in config=20
accesses on the au1000 CPUs? if an error like "parity error" occurred and t=
he=20
error is not cleared, all following config accesses will be reported as=20
errors (0xffffffff) too.

the diff is against 2.4.27 but the same thing is missing in 2.6 as well, i=
=20
believe.

greetings,
bruno

=2D-- linux/arch/mips/au1000/common/pci_ops.c.orig        2005-08-24=20
17:36:25.000000000 +0200
+++ linux/arch/mips/au1000/common/pci_ops.c     2005-08-24 17:37:38.0000000=
00=20
+0200
@@ -259,7 +259,11 @@
                *data =3D 0xffffffff;
                error =3D -1;
        } else if ((status >> 28) & 0xf) {
=2D               DBG("PCI ERR detected: status %x\n", status);
+               DBG("PCI ERR detected: device %d, status %x\n", device,=20
((status >> 28) & 0xf));
+
+               /* clear errors */
+               au_writel(status & 0xf000ffff, Au1500_PCI_STATCMD);
+
                *data =3D 0xffffffff;
                error =3D -1;
        }

--nextPart4374168.4qLdzKYEyK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDDKjsfg2jtUL97G4RApjqAJ48rMR+Cb7LP1v4AgYt3J92+9u7zwCgoi0z
M2UdauI0GT+aRwOc/Iq+1rQ=
=JMtW
-----END PGP SIGNATURE-----

--nextPart4374168.4qLdzKYEyK--
