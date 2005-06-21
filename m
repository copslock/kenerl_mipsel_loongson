Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2005 12:07:48 +0100 (BST)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:15794 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8225005AbVFULHb>;
	Tue, 21 Jun 2005 12:07:31 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id 7E3E5F002E; Tue, 21 Jun 2005 13:07:29 +0200 (CEST)
Date:	Tue, 21 Jun 2005 13:07:29 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	linux-mips@linux-mips.org
Subject: Re: Using a hal lib in Linux.
Message-ID: <20050621110729.GP4498@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20050621091429.55712.qmail@web25806.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xexMVKTdXPhpRiVT"
Content-Disposition: inline
In-Reply-To: <20050621091429.55712.qmail@web25806.mail.ukl.yahoo.com>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--xexMVKTdXPhpRiVT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-06-21 11:14:28 +0200, moreau francis <francis_moreau2000@yahoo=
=2Efr> wrote:
> I've got a mips board provided with a library that deals with hardware
> management.
> This library have been compiled with "sde-lite" gcc. I'm thinking of usin=
g this
> lib into my linux drivers to speed up developement process. Has anyone ma=
de
> kernel
> modifications (specially in Makefiles) in order to link such hal lib into
> kernel
> code ?

Well, usually consensus is to avoid HAL layers or libraries at about any
price because they typically add speed penalties and binary-only code,
which are both unacceptable.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--xexMVKTdXPhpRiVT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCt/TxHb1edYOZ4bsRAvSrAJ4jVk/hGx9B7wOQipk6ecg6BfcFRwCfdHLJ
Rn1xZ8OD8THaaDgjsmtqNwQ=
=7Oa3
-----END PGP SIGNATURE-----

--xexMVKTdXPhpRiVT--
