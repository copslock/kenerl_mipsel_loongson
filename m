Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2004 23:38:37 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:12677 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225363AbUFSWic>; Sat, 19 Jun 2004 23:38:32 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 167C54B7D4; Sun, 20 Jun 2004 00:38:30 +0200 (CEST)
Date: Sun, 20 Jun 2004 00:38:30 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: Dummy keyboard driver
Message-ID: <20040619223829.GD20632@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040619200923.GA22409@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AH02zKoZ2h96gqbS"
Content-Disposition: inline
In-Reply-To: <20040619200923.GA22409@linux-mips.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--AH02zKoZ2h96gqbS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-19 22:09:23 +0200, Ralf Baechle <ralf@linux-mips.org>
wrote in message <20040619200923.GA22409@linux-mips.org>:
> Is there still a need for the dummy keyboard driver?  Right now DUMMY_KEYB
> is being set for a bunch of platforms without having any effect so I take
> to mean we can remove dummy_keyb.c.

I (vax 2.6.x tree) don't even have that file, and there shouldn't be no
need for any kind of dummy keyboard. Either there's at least one
keyboard attached (multiple are fine, though), you get input. No
keyboard (driver), no input. Simple.

Just drop it.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--AH02zKoZ2h96gqbS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1MBlHb1edYOZ4bsRAgabAJ9rQiz4+C2BHwCPsNimi38sMG00gQCbBNgo
TCUOvzla71YB9ffpNqtJzyQ=
=gTWq
-----END PGP SIGNATURE-----

--AH02zKoZ2h96gqbS--
