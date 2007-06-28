Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2007 18:45:59 +0100 (BST)
Received: from lug-owl.de ([195.71.106.12]:58270 "EHLO lug-owl.de")
	by ftp.linux-mips.org with ESMTP id S20022694AbXF1Rpw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 Jun 2007 18:45:52 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id C4873F0055; Thu, 28 Jun 2007 19:45:21 +0200 (CEST)
Date:	Thu, 28 Jun 2007 19:45:21 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Generating patches and using checkpatch.pl
Message-ID: <20070628174521.GD27862@lug-owl.de>
Mail-Followup-To: Daniel Laird <daniel.j.laird@nxp.com>,
	linux-mips@linux-mips.org
References: <4683C792.4000100@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gRZ38brEgCoUohoa"
Content-Disposition: inline
In-Reply-To: <4683C792.4000100@nxp.com>
X-Operating-System: Linux mail 2.6.18-4-686 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--gRZ38brEgCoUohoa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-06-28 15:37:06 +0100, Daniel Laird <daniel.j.laird@nxp.com> wr=
ote:
> I ran checkpatch.pl as Ralf suggested before.
[...]
> - Line over 80 chars
> - printk must have KERN_ debug level
> - must have a space after this (, or *)
> - use tabs not spaces
> - Do not use C99 comments.
> To name but a few
>=20
> My question is:
> If you do a patch and find all these errors is it expected that I fix=20
> all these problems, or I just make sure my changes do not make it worse!

General rules of thumb:

  * Keep the coding style of the file if you're only doing minor
    patching. Don't introduce leading whitespace, leading tabs before
    spaces. Maybe keep the comment and indention style.

  * If it's more like a rewrite, fix it entirely.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                 Gib Dein Bestes. Dann =C3=BCbertriff Dich sel=
bst!
the second  :

--gRZ38brEgCoUohoa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGg/OxHb1edYOZ4bsRApQkAJ0e4AwuQ+WPb535lMH3DytjkwAm4ACeKDaa
Uisoh0mYq5eNk3QMimh9pH4=
=fhcJ
-----END PGP SIGNATURE-----

--gRZ38brEgCoUohoa--
