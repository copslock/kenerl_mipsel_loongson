Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g61HNjnC012599
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 10:23:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g61HNjCs012598
	for linux-mips-outgoing; Mon, 1 Jul 2002 10:23:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g61HNZnC012584
	for <linux-mips@oss.sgi.com>; Mon, 1 Jul 2002 10:23:36 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id DC6D8133AB; Mon,  1 Jul 2002 19:27:25 +0200 (CEST)
Date: Mon, 1 Jul 2002 19:27:25 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: [Oops] Indy R4600 Oops(es) w/ 2.4.19-rc1
Message-ID: <20020701172725.GW17216@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020701151359.GR17216@lug-owl.de> <200207011725.TAA16476@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ddJi1IsAv4W/kcDl"
Content-Disposition: inline
In-Reply-To: <200207011725.TAA16476@sparta.research.kpn.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--ddJi1IsAv4W/kcDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-07-01 19:24:59 +0200, Karel van Houten <vhouten@kpn.com>
wrote in message <200207011725.TAA16476@sparta.research.kpn.com>:
> > On Mon, 2002-07-01 16:28:13 +0200, Maciej W. Rozycki <macro@ds2.pg.gda.=
pl>
> > wrote in message
> > <Pine.GSO.3.96.1020701161009.7601E-100000@delta.ds2.pg.gda.pl>:
> > > On Mon, 1 Jul 2002, Jan-Benedict Glaw wrote:
> > >  Feel free to use the change privately.  Otherwise please code a real=
 fix,
> > > i.e. a set of buggy-R4600-specific functions, as CONFIG_CPU_R4X00 mea=
ns
> > > other processors as well, e.g. R4000 or R4400 which are fine here.=20
> > >=20
> > >  Actually blocking interrupts for over 0.01s as it used to be done is
> >=20
> > Ah. That would explain the huge time drifts when the box is under
> > load...
>=20
> Indeed, I'm now running 2.4.18, and for the first time my DS5000/260 and
> DS5000/200 can keep exact time, even under heavy load.
> Btw, I use a R4400SC CPU.

Oh. Lucke you, unlucky /me...

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--ddJi1IsAv4W/kcDl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9IJD8Hb1edYOZ4bsRAm8DAJ4zZ1wFo0FQl4JXzAV1M1shfQEphACePsdB
D8kx5PORf14pTBE85b1g6H8=
=PWwx
-----END PGP SIGNATURE-----

--ddJi1IsAv4W/kcDl--
