Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g61HIXnC012247
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 10:18:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g61HIW2c012246
	for linux-mips-outgoing; Mon, 1 Jul 2002 10:18:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g61HIPnC012233
	for <linux-mips@oss.sgi.com>; Mon, 1 Jul 2002 10:18:25 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 374CD13373; Mon,  1 Jul 2002 19:22:15 +0200 (CEST)
Date: Mon, 1 Jul 2002 19:22:15 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: [Oops] Indy R4600 Oops(es) w/ 2.4.19-rc1
Message-ID: <20020701172215.GU17216@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020701151359.GR17216@lug-owl.de> <Pine.GSO.3.96.1020701185152.7601J-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RGwttE/plSABi47o"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020701185152.7601J-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--RGwttE/plSABi47o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-07-01 19:02:38 +0200, Maciej W. Rozycki <macro@ds2.pg.gda.pl>
wrote in message <Pine.GSO.3.96.1020701185152.7601J-100000@delta.ds2.pg.gda=
.pl>:
> On Mon, 1 Jul 2002, Jan-Benedict Glaw wrote:
> > I'm not really familiar w/ cache and interrupt handling/masking, and I
> > don't (yet) exactly know how to check for the buggy old R4600, but I
> > think I'll have to become an expert around that:-O
>=20
>  The check is already in place -- see setup_noscache_funcs() in
> arch/mips/mm/c-r4k.c, only the implementation is incomplete which started
> biting after interrupts became active.

Hmmm... I think Ill have to read some heavy MIPS books first:-)

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--RGwttE/plSABi47o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9II/GHb1edYOZ4bsRAuRjAKCJdshLt93XOuDo0ssio30B6JPfZACfZNqj
UBJz8X7++n+Syp96bm3o1Uo=
=zHV1
-----END PGP SIGNATURE-----

--RGwttE/plSABi47o--
