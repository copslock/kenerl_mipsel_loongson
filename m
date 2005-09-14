Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 12:47:09 +0100 (BST)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:2516 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8224978AbVINLqv>;
	Wed, 14 Sep 2005 12:46:51 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id 61150F0070; Wed, 14 Sep 2005 13:46:50 +0200 (CEST)
Date:	Wed, 14 Sep 2005 13:46:50 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Git
Message-ID: <20050914114650.GF23161@lug-owl.de>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
References: <20050913124544.GC3224@linux-mips.org> <20050913133126.GO23161@lug-owl.de> <20050913152038.GE3224@linux-mips.org> <20050914095858.GD23161@lug-owl.de> <Pine.LNX.4.62.0509141322540.1923@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r6fxLKBTHCmC166Z"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509141322540.1923@numbat.sonytel.be>
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
X-archive-position: 8940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--r6fxLKBTHCmC166Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-09-14 13:23:22 +0200, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
> On Wed, 14 Sep 2005, Jan-Benedict Glaw wrote:
> > On Tue, 2005-09-13 16:20:38 +0100, Ralf Baechle <ralf@linux-mips.org> w=
rote:
> > > On Tue, Sep 13, 2005 at 03:31:26PM +0200, Jan-Benedict Glaw wrote:
> > > > I'm also on the way
> > > > getting familiar with GIT, doing my very first steps. It would be n=
ice
> > > > if we'd present what we know in Oldenburg (I already offered to do =
so,
> > > > Joey planed it for Saturday).
> > >=20
> > > Sounds like a plan.  And maybe present some of the other alternatives
> > > to CVS as well?
> >=20
> > I'm not sure if it's worth it. Linus decided against all other SCMs. I
> > did use (for small test projects) monotone, darcs and arch. (I think
> > all other alternatives aren't.)
>=20
> Have you tried mercurial?

Nope. I've only used it's web frontend on http://www.kernel.org/hg/ .

Mercurial's author claims that it scales even better than git, esp. on
its network transfer. However, I'm not aware how it scales there right
now, since git got its "packs" implemented.

> > To get fixes/port updates/subsystem updates upstream to Linus, GIT is
> > the way[tm] to go, so we'd try to get familiar with it.
>=20
> Still using plain patches and email...

=2E..which is a nice and actually working scheme, too. At least, it
doesn't require to learn working with a new SCM :-P  Though I think
it's a good idea.

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

--r6fxLKBTHCmC166Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDKA2qHb1edYOZ4bsRAsv6AJ42sSLsP/2n9JA8FZZGU3AQp+vqrACfYe4H
YJZ9W8LyyJoBACge88TLmP8=
=P9RP
-----END PGP SIGNATURE-----

--r6fxLKBTHCmC166Z--
