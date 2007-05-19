Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2007 20:52:49 +0100 (BST)
Received: from smtp2.int-evry.fr ([157.159.10.45]:63162 "EHLO
	smtp2.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20024072AbXESTwr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 19 May 2007 20:52:47 +0100
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 18129307C0
	for <linux-mips@linux-mips.org>; Sat, 19 May 2007 21:52:40 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	linux-mips@linux-mips.org
Subject: [PATCH 0/2] Add generic GPIO support to Au1x00
Date:	Sat, 19 May 2007 21:51:25 +0200
User-Agent: KMail/1.9.6
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3969847.GF0YBdutRz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200705192151.29840.florian.fainelli@telecomint.eu>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-MCPCheck: 
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart3969847.GF0YBdutRz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patchset adds support for the generic GPIO API introduced with 2.6.21 =
and=20
ARM boards.

=46irst patch adds the needed MIPS generic definitions to implement archite=
cture=20
specific GPIO wrappers for other targets

Second patch adds support for the generic GPIO API to the Au1x00 boards.
=2D-=20

--nextPart3969847.GF0YBdutRz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iD8DBQBGT1VBmx9n1G/316sRAkn+AKDaKxBAsEqonbSkroulxzRZo906vgCeJc8y
nssKnc0vnAt/mweWJ4vxG+A=
=l3wO
-----END PGP SIGNATURE-----

--nextPart3969847.GF0YBdutRz--
