Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2005 08:38:06 +0100 (BST)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:57015 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8225489AbVDAHhu>;
	Fri, 1 Apr 2005 08:37:50 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id A41AA1901AC; Fri,  1 Apr 2005 09:37:42 +0200 (CEST)
Date:	Fri, 1 Apr 2005 09:37:42 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	moreau francis <francis_moreau2000@yahoo.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: How to keep uptodate a mips-linux port
Message-ID: <20050401073742.GO21175@lug-owl.de>
Mail-Followup-To: moreau francis <francis_moreau2000@yahoo.fr>,
	linux-mips@linux-mips.org
References: <20050401073405.46077.qmail@web25102.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aiCxlS1GuupXjEh3"
Content-Disposition: inline
In-Reply-To: <20050401073405.46077.qmail@web25102.mail.ukl.yahoo.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--aiCxlS1GuupXjEh3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-01 09:34:05 +0200, moreau francis <francis_moreau2000@yahoo=
=2Efr>
wrote in message <20050401073405.46077.qmail@web25102.mail.ukl.yahoo.com>:

> Now, let say I would like to update my customized
> "linux-2.6.10-rc2-mips" to "Linux 2.6.11-mips".
> What is the best approach ?

The best approach is to cleanly break out all your changes into
semantical patches and submit them to the prople who care about the
individual files. The MIPS-specific patches go to this list.

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

--aiCxlS1GuupXjEh3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCTPpGHb1edYOZ4bsRAulmAKCF7cs3SJkjcRY+h5qx3jCarOnLYwCbBf8a
gsboQor9qYA1n7shxG40Wf4=
=SP14
-----END PGP SIGNATURE-----

--aiCxlS1GuupXjEh3--
