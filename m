Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KE7XEC027529
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 07:07:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KE7XIA027528
	for linux-mips-outgoing; Tue, 20 Aug 2002 07:07:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KE7JEC027503
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 07:07:19 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id CF6E31339C; Tue, 20 Aug 2002 16:10:13 +0200 (CEST)
Date: Tue, 20 Aug 2002 16:10:13 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: [PATCH] Bring back R4600 V1.7 support
Message-ID: <20020820141013.GC10730@lug-owl.de>
Mail-Followup-To: SGI MIPS list <linux-mips@oss.sgi.com>
References: <20020820113329.GZ10730@lug-owl.de> <Pine.GSO.3.96.1020820152046.8700E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80KdhljSN0pKc7w4"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020820152046.8700E-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--80KdhljSN0pKc7w4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-08-20 15:30:22 +0200, Maciej W. Rozycki <macro@ds2.pg.gda.pl>
wrote in message <Pine.GSO.3.96.1020820152046.8700E-100000@delta.ds2.pg.gda=
.pl>:
> On Tue, 20 Aug 2002, Jan-Benedict Glaw wrote:
>=20
> > Please accept the patch (from my previous mail). I'm using it now for
> > two days, and I've got one mail telling me that it works for its sender.
>=20
>  Ugh, this should be a separate set of functions selected at the run time=
.=20
> It should be fairly trivial to rewrite it this way (best done with
> processor-specific functions expanded from common templates for ease of

Actually, I had written all that using separate functions before, but
neither I nor Ralf liked this approach (because it adds hundreds LOC to
=2E../c-r4k.c). Ralf then suggested writing it using macros, so I did.

-*- Proposal -*-
There are IMHO two goals, one for near future, one for following day
(after first goal has reached):

	1. There are many (equally looking) functions in c-r4k.c . It
	   would be nice to not have the (more-or-less) function body 10
	   times there.
	2. it would be nice to not have like 50 functions around, but to
	   better have a flexible way to do what needs to be done.
	   Something like an (initdata) array containing PRId and
	   function pointers (or other info) on "what needs to be
	   done".

The first one seems quite easy. Looking eg. at Alphas, they have a macro
defining a whole function (which inserts a correct function name by
supplied arguments etc.). This way,=20

static inline void r4k_flush_cache_all_s128d16i16(void)
static inline void r4k_flush_cache_all_s32d32i32(void)
static inline void r4k_flush_cache_all_s64d32i32(void)
=2E.

could go away by: (there _will_ be bugs. 100% untested, and I'm a bad
preprocessor coder:-)

#define FUNC_R4K_FLUSH_CACHE_ALL(NAME, SC, DC, IC)		\
	static inline void					\
	r4k_flush_cache_all_##NAME(void)			\
	{							\
		blast_dcache##DC();				\
		blast_icache##IC();				\
		blase_scache##SC();				\
	}

and then writing:

FUNC_R4K_FLUSH_CACHE_ALL(s128d16i16, 128, 16, 16)
FUNC_R4K_FLUSH_CACHE_ALL(s32d32i32,   32, 32, 32)
FUNC_R4K_FLUSH_CACHE_ALL(s64d32i32,   64, 32, 32)
=2E..

instead. The __save_and_cli()/__restore_flags() functions could be done
as well as all the remaining others. That would pollute namespace like
it does today, but the .c file will be 80% smaller or so:

$ wc -l c-r4k.c=20
   2422 c-r4k.c


MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--80KdhljSN0pKc7w4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Yk3FHb1edYOZ4bsRAjMHAJ9n5L+w82+67jTGSpBbLdf3PDN9lgCff6DL
ajHt9ZDyUlQJTh6Vb0M2DjY=
=A53v
-----END PGP SIGNATURE-----

--80KdhljSN0pKc7w4--
