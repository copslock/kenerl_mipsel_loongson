Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2007 09:11:33 +0100 (BST)
Received: from smtp1.int-evry.fr ([157.159.10.44]:8332 "EHLO smtp1.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S20022614AbXHVILb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Aug 2007 09:11:31 +0100
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 122398E84F0;
	Wed, 22 Aug 2007 10:10:48 +0200 (CEST)
Received: from ibook.lan (mla78-1-82-240-16-241.fbx.proxad.net [82.240.16.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 73CFED0E336;
	Wed, 22 Aug 2007 10:10:47 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Matteo Croce <technoboy85@gmail.com>
Subject: Re: [PATCH 1/1] AR7 port
Date:	Wed, 22 Aug 2007 10:10:03 +0200
User-Agent: KMail/1.9.7
Cc:	linux-mips@linux-mips.org
References: <200708201704.11529.technoboy85@gmail.com>
In-Reply-To: <200708201704.11529.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7919594.qhZgkiqAbv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200708221010.04274.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: n'est pas un polluriel (inscrit sur la liste blanche),
	SpamAssassin (pas en cache, score=-1.467, requis 4.01,
	autolearn=not spam, AWL 1.00, BAYES_00 -2.60, FORGED_RCVD_HELO 0.14)
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart7919594.qhZgkiqAbv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Matteo,

I see some things to take into account for a review to be easier :

=2D split the patch into parts : linux-mips, netdev, watchdog, mtd, led=20
subsystems with the appropriate lists/maintainers in copy
=2D add the other authors in the Signed-off-by line : Eugene Konev, Felix=20
=46ietkau, Nicolas Thill
=2D use a linux-mips git snapshot and rediff against it

Thank you very much for your efforts.

Le lundi 20 ao=FBt 2007, Matteo Croce a =E9crit=A0:
> Hi,
> I made a diff for the AR7 port, hoping that it will go in the mainstream
> kernel.
> I cared about don't including buggy or non free drivers and code.
> Also we have to surround the code in arch/mips/kernel/traps.c by some
> #ifdef since
> the actual code will break other archs.
> The code was taken from the OpenWrt project, is quite good, many people
> uses it daily.
>
> Cheers



=2D-=20
Cordialement, Florian Fainelli
=2D-----------------------------

--nextPart7919594.qhZgkiqAbv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.6 (GNU/Linux)

iD8DBQBGy+9cmx9n1G/316sRAgdjAJ9qkaSGcXzPnHnDGdTzkSQX4yz0OwCfaxrG
t5+AjlmuHUMv4rD4zPVpHHs=
=6OJL
-----END PGP SIGNATURE-----

--nextPart7919594.qhZgkiqAbv--
