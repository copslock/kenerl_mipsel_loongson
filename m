Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MEeXRw024876
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 07:40:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MEeXpB024875
	for linux-mips-outgoing; Mon, 22 Jul 2002 07:40:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MEeORw024864
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 07:40:25 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 47DF31357D; Mon, 22 Jul 2002 16:41:15 +0200 (CEST)
Date: Mon, 22 Jul 2002 16:41:15 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: [uHOWTO] Booting a DECstation via MOP
Message-ID: <20020722144115.GW8891@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020720183919.GV8891@lug-owl.de> <Pine.GSO.3.96.1020722161247.2373H-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/9WPmgm2v60RN0g"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020722161247.2373H-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--9/9WPmgm2v60RN0g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-07-22 16:27:00 +0200, Maciej W. Rozycki <macro@ds2.pg.gda.pl>
wrote in message <Pine.GSO.3.96.1020722161247.2373H-100000@delta.ds2.pg.gda=
.pl>:
> On Sat, 20 Jul 2002, Jan-Benedict Glaw wrote:
> > Instead of apt-get'ing a mopd, go to

> > ftp://ftp.ds2.pg.gda.pl/pub/macro/mopd/ and download all of the files in

>  Thanks for appreciating my effort.  It's nice too see it's useful for the
> others as well.

Are you still maintaining it? I see that *one* (really useful) mopd gets
more and more important (DECstations, VAXen, ...), but there are so
many of them.

	- One is from you (which is nicely working)
	- One is on linux-vax.sourceforge.net (IIRC)
	- One is 'apt-get install'able
	- One is referenced on decstation.unix-ag.org (IIRC)
	- Mayby others (smells like Lance implementations...)

Some of them seem to be forked off each other, so it would be a nice
thing to unify them again. Anybody interested in having _one_ mopd?
Anybody willing to do the job? I'll have to ask the VAX people also...

Except VAX and DECstations - who does also use MOP for booting?

MfG, JBG


--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--9/9WPmgm2v60RN0g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9PBmKHb1edYOZ4bsRArg4AJ9vifbqQ6Iff4NBs6bUi5Oik6Q2VwCcDAkp
330cAfphmhZs4d9akDKWtco=
=ntwQ
-----END PGP SIGNATURE-----

--9/9WPmgm2v60RN0g--
