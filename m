Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 10:59:17 +0100 (BST)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:8621 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8224974AbVINJ7A>;
	Wed, 14 Sep 2005 10:59:00 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id 7D5BFF0070; Wed, 14 Sep 2005 11:58:58 +0200 (CEST)
Date:	Wed, 14 Sep 2005 11:58:58 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	linux-mips@linux-mips.org
Subject: Re: Git
Message-ID: <20050914095858.GD23161@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20050913124544.GC3224@linux-mips.org> <20050913133126.GO23161@lug-owl.de> <20050913152038.GE3224@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MRlEjvj2/M31Nfs"
Content-Disposition: inline
In-Reply-To: <20050913152038.GE3224@linux-mips.org>
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
X-archive-position: 8936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--3MRlEjvj2/M31Nfs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-09-13 16:20:38 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Sep 13, 2005 at 03:31:26PM +0200, Jan-Benedict Glaw wrote:
> > I'm also on the way
> > getting familiar with GIT, doing my very first steps. It would be nice
> > if we'd present what we know in Oldenburg (I already offered to do so,
> > Joey planed it for Saturday).
>=20
> Sounds like a plan.  And maybe present some of the other alternatives
> to CVS as well?

I'm not sure if it's worth it. Linus decided against all other SCMs. I
did use (for small test projects) monotone, darcs and arch. (I think
all other alternatives aren't.)

monotone
	Is quite nice'n'easy to use for CVS users, you'll have quite a
	fast start. The network sync protocol can be a bit lengthy at
	a time, but it works. It's acceptable in speed, but not
	exactly "fast". Written in C, code can easily be read and
	hacked.

darcs
	Is easy to use, too, and quite some helpful. Network
	operations are a bit slower than those of monotone, but the
	real point is that it's merging algorithms are awfully slow.
	Also, it's written in Haskell (and getting a working compiler
	isn't exactly trivial), so the code is hard to read (for a C
	person), mostly because Haskell's concept are so different
	(it's a function programming language, after all.)

arch
	Arch can do almost everything; it's network sync protocol is
	quite fast (can use several transports and will make use of
	caches). However, it's not exactly easy to use because of it's
	thousands of commands and it's project name conventions are,
	um, ugly. It has very good merging capabilities, but it's
	heavy use of local caches forces you to have loads of free HDD
	space.

CVS
	Um, we all know the problems, don't we?

SVN
	Not distributed, easy to use.  Though there's a different
	frontend with distribution capabilities. Personally, SVN feels
	like CVS with it's major conceptual problems fixed.

More SCM questions?

So my famous last words are:  I don't think it's worth really
presenting all the other alternatives (except probably reading down
the above text).

To get fixes/port updates/subsystem updates upstream to Linus, GIT is
the way[tm] to go, so we'd try to get familiar with it.

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

--3MRlEjvj2/M31Nfs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDJ/RiHb1edYOZ4bsRAphJAJ4kg6Zmku1DbRaBICtFmqCBMvLEugCfdeHi
/EhSSaMF0g6ThNwdCaOUieQ=
=EHvR
-----END PGP SIGNATURE-----

--3MRlEjvj2/M31Nfs--
