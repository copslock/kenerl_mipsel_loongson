Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 09:06:06 +0100 (BST)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:35211 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20023478AbXGMIGE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jul 2007 09:06:04 +0100
Received: from [192.168.10.156] (mla78-1-82-240-17-188.fbx.proxad.net [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id EE1E28D1693;
	Fri, 13 Jul 2007 10:05:56 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Alchemy driver sediments to be deleted?
Date:	Fri, 13 Jul 2007 10:05:58 +0200
User-Agent: KMail/1.9.7
Cc:	linux-mips@linux-mips.org
References: <20070712180445.GA22748@linux-mips.org>
In-Reply-To: <20070712180445.GA22748@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2981164.FTAqaWMUtM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200707131006.02010.florian.fainelli@telecomint.eu>
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart2981164.FTAqaWMUtM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Ralf,

You can safely remove the au1000_gpio file because au1000 will now use the=
=20
generic GPIO implementation.

Instead of removing the touchscreen driver, I would move it to=20
drivers/input/touchscreen for now. There is probably some work to do to mak=
e=20
the ads7846 driver be usable with au1000.

=46lorian=20

Le jeudi 12 juillet 2007, Ralf Baechle a =E9crit=A0:
> So there are these two drivers
>
>  b/drivers/char/au1000_gpio.c                                 |  262 +
>  b/drivers/char/au1000_ts.c                                   |  677 +++
>
> sitting in the lmo kernel tree since ages.  au1000_ts isn't even
> wired up in the Makefile since years, so unless somebody yells "stop",
> I'm going to kill it.
>
> Also, is there anybody still interested in the au1000_gpio driver?
>
>   Ralf

--nextPart2981164.FTAqaWMUtM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQBGlzJpmx9n1G/316sRAu83AJ0Q5mBhmC2oBD8L6nm9okMiSQiMCgCgmJkY
q7JbP4/tedJjoCMX9N6jCHo=
=WtPt
-----END PGP SIGNATURE-----

--nextPart2981164.FTAqaWMUtM--
