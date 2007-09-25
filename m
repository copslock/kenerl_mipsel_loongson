Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 16:10:25 +0100 (BST)
Received: from smtp1.int-evry.fr ([157.159.10.44]:9693 "EHLO smtp1.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S20023250AbXIYPKX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2007 16:10:23 +0100
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 4C6998E6EF3
	for <linux-mips@linux-mips.org>; Tue, 25 Sep 2007 17:06:13 +0200 (CEST)
Received: from [157.159.47.53] (unknown [157.159.47.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id DED40D0E315
	for <linux-mips@linux-mips.org>; Tue, 25 Sep 2007 17:06:12 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	linux-mips@linux-mips.org
Subject: [PATCH] 0/3 MTX1 fixes for PCI and USB
Date:	Tue, 25 Sep 2007 17:07:10 +0200
User-Agent: KMail/1.9.7
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1209105.DjSXaW58Vk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200709251707.12925.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart1209105.DjSXaW58Vk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Ralf,

This patchset fixes various MTX-1 problems :

Patch1 will fix the wrong ifdef in the MTX-1 code causing the USB switch no=
t=20
to be powered.

Patch 2 fixes the Au1000 PCI resource declaration

Patch 3 fixes the Au1000 controller base for IOs.
=2D-=20
Cordialement, Florian Fainelli
=2D-----------------------------

--nextPart1209105.DjSXaW58Vk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBG+SQgmx9n1G/316sRAmTKAJ9t1JHG9QtLbF++BZ5El8LetAqnoQCeLoM5
qK6L9Od/tkuc2Lmd4aizrHU=
=MZvI
-----END PGP SIGNATURE-----

--nextPart1209105.DjSXaW58Vk--
