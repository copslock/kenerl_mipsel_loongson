Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 15:17:25 +0100 (BST)
Received: from smtp1.int-evry.fr ([157.159.10.44]:2215 "EHLO smtp1.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S20021926AbXITORQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2007 15:17:16 +0100
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id BEE608E755E;
	Thu, 20 Sep 2007 16:16:29 +0200 (CEST)
Received: from [157.159.47.53] (unknown [157.159.47.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id AE4BBD0E317;
	Thu, 20 Sep 2007 16:16:29 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH][1/6] led: rename leds-cobalt
Date:	Thu, 20 Sep 2007 16:17:09 +0200
User-Agent: KMail/1.9.7
Cc:	Richard Purdie <rpurdie@rpsys.net>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
References: <20070920230204.0ad15513.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070920230204.0ad15513.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1630951.IxmG0x1RPe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200709201617.12773.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart1630951.IxmG0x1RPe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le jeudi 20 septembre 2007, Yoichi Yuasa a =E9crit=A0:
> The leds-cobalt driver only supports the Coable Qube series
> (not included in Cobalt Raq series).
> This patch has fixed Kconfig and renamed the driver.
>
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
>
Acked-by: Florian Fainelli <florian.fainelli@telecomint.eu>

Thanks Yoichi !


=2D-=20
Cordialement, Florian Fainelli
=2D-----------------------------

--nextPart1630951.IxmG0x1RPe
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBG8oDomx9n1G/316sRAmjYAJ4r8GNTcg1BQzi1Hy7ZrIwdm8/WHwCg2+o0
Y0wdQFgleO2v67nE0K+Uxms=
=yeux
-----END PGP SIGNATURE-----

--nextPart1630951.IxmG0x1RPe--
