Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2005 09:12:55 +0100 (BST)
Received: from lug-owl.de ([195.71.106.12]:41168 "EHLO lug-owl.de")
	by ftp.linux-mips.org with ESMTP id S8133564AbVI0IMh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2005 09:12:37 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id C5415F0056; Tue, 27 Sep 2005 10:12:31 +0200 (CEST)
Date:	Tue, 27 Sep 2005 10:12:31 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	linux-mips@linux-mips.org
Subject: Re: linux-mips Vs kernel.org
Message-ID: <20050927081231.GZ5743@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <OFDDFCB8DC.1BFCCB3E-ONC1257089.002AE830-C1257089.002B3D8D@sagem.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T0u6oYl84yPn00Od"
Content-Disposition: inline
In-Reply-To: <OFDDFCB8DC.1BFCCB3E-ONC1257089.002AE830-C1257089.002B3D8D@sagem.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--T0u6oYl84yPn00Od
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-09-27 09:52:01 +0200, Florian DELIZY <florian.delizy@sagem.com=
> wrote:
> We currently working with the 2.6.12 kernel, and wondering which from=20
> linux-mips or kernel.org version we should use,
> in a more general manner, what are the differences between linux-mips and=
=20
> kernel.org kernel source code, is one the
> mirror of the other, or is there one that frequently merge with the other=
=20

Use the linux-mips.org tree to do any work.

To find out about the differences, just download a kernel.org kernel
and run a 'diff -Nurp' against what you find on linux-mips.org.

Up to now, merges happened every now-and-then, but not on a very
regular basis. However, there's hope for more timely merges since Ralf
is on the way to move the souce base over to GIT, which should ease
further merges...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--T0u6oYl84yPn00Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDOP7vHb1edYOZ4bsRAmptAJ0bHFKfzgNHqfbb8pKuHavPO9dSUACfS/3r
ilrlLndROTxvCpEP2/2h95A=
=2MzK
-----END PGP SIGNATURE-----

--T0u6oYl84yPn00Od--
