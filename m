Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 21:41:06 +0100 (BST)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:32954 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8225201AbUJEUlC>;
	Tue, 5 Oct 2004 21:41:02 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id B4D944A951; Tue,  5 Oct 2004 22:40:08 +0200 (CEST)
Date: Tue, 5 Oct 2004 22:40:08 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: mips linux glibc-2.3.3 build - Assembler errors in rtld.c
Message-ID: <20041005204008.GU5033@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <41626E7D.2070405@procsys.com> <20041005.191608.59649656.nemoto@toshiba-tops.co.jp> <Pine.LNX.4.58L.0410051152440.20503@blysk.ds.pg.gda.pl> <20041005121713.GH5033@lug-owl.de> <Pine.LNX.4.58L.0410052114230.26193@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b6rSbt24+kIAbQdu"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0410052114230.26193@blysk.ds.pg.gda.pl>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--b6rSbt24+kIAbQdu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-10-05 21:15:14 +0100, Maciej W. Rozycki <macro@linux-mips.org>
wrote in message <Pine.LNX.4.58L.0410052114230.26193@blysk.ds.pg.gda.pl>:
> On Tue, 5 Oct 2004, Jan-Benedict Glaw wrote:
> > > > Also, you might have to pass -fno-unit-at-a-time to gcc 3.4.  (at
> > > > least glibc 2.3.2 requires it).
> > >=20
> > >  Which is also fixed in the CVS. ;-)
> >=20
> > So that inline mess is also gone? Find... Or is that about a different
> > thing?
>=20
>  Could you please elaborate?  What current glibc does is adding=20
> -fno-unit-at-a-time where appropriate.

Some weeks ago, I had a build error (gcc+glibc head) which was because
of some function being first forced to be inline, then it's address was
taken... Didn't work :-)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--b6rSbt24+kIAbQdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQFBYwaoHb1edYOZ4bsRAs0XAJ0agM3Y5rmBz/dnUmvRhOqQqdkS+wCXasK8
EgrlwcTezXuCSkP009Xemg==
=//DH
-----END PGP SIGNATURE-----

--b6rSbt24+kIAbQdu--
