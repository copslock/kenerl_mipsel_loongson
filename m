Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Jun 2003 17:10:10 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:3845 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8224827AbTFAQKI>; Sun, 1 Jun 2003 17:10:08 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id BCD6E4ABAB; Sun,  1 Jun 2003 18:10:06 +0200 (CEST)
Date: Sun, 1 Jun 2003 18:10:06 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030601161006.GB6935@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20030601120750Z8225197-1272+2136@linux-mips.org> <20030601142553.GA6935@lug-owl.de> <20030601155629.GA26900@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EZN6irWB3fS+DSGO"
Content-Disposition: inline
In-Reply-To: <20030601155629.GA26900@linux-mips.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--EZN6irWB3fS+DSGO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-06-01 17:56:29 +0200, Ralf Baechle <ralf@linux-mips.org>
wrote in message <20030601155629.GA26900@linux-mips.org>:
> On Sun, Jun 01, 2003 at 04:25:53PM +0200, Jan-Benedict Glaw wrote:
>=20
> > MfG, JBG
> > PS: Thinking about feeding arch with Linus' tree, the parisc one and
> > l-m.org's CVS tree just to evaluate if the holy merge can be done at all
> > (cf. http://www.lug-owl.de/~jbglaw/linux-ports/ ).
>=20
> Please don't feed anything that's maintained on linux-mips.org to Linus.
> Having to sort out what of all the patches flowing forward and backward
> is bogus and not would become a huge pain for me.

I do know that and I'm for sure far away from pushing patches upwards.
_But_ I want to pull things. This way, I can *early* unhide problems
some archs imply to common code and thus I can ask their maintainers to
not let major (upcoming) problems out of their eyes...

> > Currently, I'm thinking about a 2.5.<x>-port<n> tree which I basically
> > plan to feed by CVS/bk/... log mails. While at it, I'm asking for a list
> > which gets complete log incl. patch sent to.
>=20
> An item on my to do list since a long time ...

Here's even some requestor! That'd help me a lot, I think.

Ralf, you've been a fire fighter, right? I'm near over-heating just
right now...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--EZN6irWB3fS+DSGO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+2iVeHb1edYOZ4bsRAsw4AJ9PiswzkpaeVwCeJhZzZ8BgkPi4WQCcC31d
hPS2EPjY2Q3lZIFrRe0IR+8=
=Qa89
-----END PGP SIGNATURE-----

--EZN6irWB3fS+DSGO--
