Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 09:06:36 +0100 (BST)
Received: from smtp1.int-evry.fr ([157.159.10.44]:64419 "EHLO
	smtp1.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20021917AbXHBIGd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 09:06:33 +0100
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 67B438E6588;
	Thu,  2 Aug 2007 10:05:42 +0200 (CEST)
Received: from ibook.lan (mla78-1-82-240-17-188.fbx.proxad.net [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 3E5B2D0E315;
	Thu,  2 Aug 2007 10:05:42 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH][MIPS] fix au1xxx_gpio_direction_* return value
Date:	Thu, 2 Aug 2007 10:05:39 +0200
User-Agent: KMail/1.9.7
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
References: <200708020348.l723m0jQ001528@po-mbox300.hop.2iij.net>
In-Reply-To: <200708020348.l723m0jQ001528@po-mbox300.hop.2iij.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13039651.UYDCJJmYjm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200708021005.40371.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: n'est pas un polluriel,
	SpamAssassin (pas en cache, score=-0.305, requis 4.01, AWL -0.30)
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart13039651.UYDCJJmYjm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Yoichi,

Thanks for fixing this.

Le jeudi 2 ao=FBt 2007, Yoichi Yuasa a =E9crit=A0:
> Fix au1xxx_gpio_direction_* return value.
>
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
>
Acked-by: Florian Fainelli <florian.fainelli@telecomint.eu>

--nextPart13039651.UYDCJJmYjm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQBGsZBUmx9n1G/316sRAtB6AKCNCOdD3LorAHBoU0u6jYhZ2V6OJQCeJkVe
I3EoCIWIywqes5fiDQeUO7A=
=XPGn
-----END PGP SIGNATURE-----

--nextPart13039651.UYDCJJmYjm--
