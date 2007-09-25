Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 16:08:31 +0100 (BST)
Received: from smtp1.int-evry.fr ([157.159.10.44]:64445 "EHLO
	smtp1.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20023256AbXIYPI2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 16:08:28 +0100
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 780158E6874;
	Tue, 25 Sep 2007 17:06:29 +0200 (CEST)
Received: from [157.159.47.53] (unknown [157.159.47.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 80BF5D0E315;
	Tue, 25 Sep 2007 17:06:29 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	linux-mips@linux-mips.org, blogic@openwrt.org, nbd@openwrt.org
Subject: [PATCH 3/3] Au1000 : set the PCI controller IO base
Date:	Tue, 25 Sep 2007 17:07:30 +0200
User-Agent: KMail/1.9.7
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1922573.nNVhlbXleH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200709251707.30915.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart1922573.nNVhlbXleH
Content-Type: multipart/mixed;
  boundary="Boundary-01=_yQS+GNOlShf4oH6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_yQS+GNOlShf4oH6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The PCI controller IO base was not set in the au1000 pci code.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
=2D-=20

--Boundary-01=_yQS+GNOlShf4oH6
Content-Type: text/plain;
  charset="us-ascii";
  name="pci-io.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pci-io.patch"

diff --git a/arch/mips/au1000/common/pci.c b/arch/mips/au1000/common/pci.c
index 6c25e6c..9be99a6 100644
=2D-- a/arch/mips/au1000/common/pci.c
+++ b/arch/mips/au1000/common/pci.c
@@ -74,6 +74,7 @@ static int __init au1x_pci_setup(void)
 		printk(KERN_ERR "Unable to ioremap pci space\n");
 		return 1;
 	}
+	au1x_controller.io_map_base =3D virt_io_addr;
=20
 #ifdef CONFIG_DMA_NONCOHERENT
 	{

--Boundary-01=_yQS+GNOlShf4oH6--

--nextPart1922573.nNVhlbXleH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBG+SQymx9n1G/316sRAhNsAJ9KjUkoXdUqTPgnoVfrXqGb7PM6XQCgzZvq
TOuqCslPJcCwcykx0fCMB/s=
=J0bT
-----END PGP SIGNATURE-----

--nextPart1922573.nNVhlbXleH--
