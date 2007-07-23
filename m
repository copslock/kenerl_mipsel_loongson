Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2007 21:06:42 +0100 (BST)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:36517 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20022745AbXGWUGk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jul 2007 21:06:40 +0100
Received: from localhost (anaconda.int-evry.fr [157.159.15.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 3A0A8D0E317
	for <linux-mips@linux-mips.org>; Mon, 23 Jul 2007 22:06:04 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	linux-mips@linux-mips.org
Subject: PCI resource conflict with Au1000
Date:	Mon, 23 Jul 2007 22:05:59 +0200
User-Agent: KMail/1.9.7
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3562217.2MErxZDiPB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200707232206.00150.florian.fainelli@telecomint.eu>
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart3562217.2MErxZDiPB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I tried running a 2.6.22.1 kernel on the Accesscube, and it looks like ther=
e=20
is an error with the PCI code/resource declaration causing the MIPS pci cod=
e=20
to output this message : Skipping PCI bus scan due to resource conflict

The problem is because request_region fails at arch/mips/pci.c:80. Looking =
at=20
the au1000 pci code does not make it far different from the other boards,=20
where it does not fail.

If any of you has an idea why this message shows up, I will take it ;-) ?=20
Hint : it worked up to 2.6.19.2 (last version I tested with the board).

Thank you very much in advance for your answer.
=2D-=20
Best regards, Florian

--nextPart3562217.2MErxZDiPB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQBGpQoomx9n1G/316sRAuYPAKCZqgWOfk9WxsUoJnGb7x7m6T7N0gCfYWIj
S6K1KzOyE0dqDC4k9juPHeg=
=dtUA
-----END PGP SIGNATURE-----

--nextPart3562217.2MErxZDiPB--
