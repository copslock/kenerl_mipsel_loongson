Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8GMd2g20175
	for linux-mips-outgoing; Sun, 16 Sep 2001 15:39:02 -0700
Received: from straylight.cyberhqz.com (root@h24-76-98-250.vc.shawcable.net [24.76.98.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8GMcwe20172
	for <linux-mips@oss.sgi.com>; Sun, 16 Sep 2001 15:38:58 -0700
Received: (from rmurray@localhost)
	by straylight.cyberhqz.com (8.9.3/8.9.3/Debian 8.9.3-21) id PAA26266
	for linux-mips@oss.sgi.com; Sun, 16 Sep 2001 15:38:57 -0700
From: Ryan Murray <rmurray@cyberhqz.com>
Date: Sun, 16 Sep 2001 15:38:57 -0700
To: linux-mips@oss.sgi.com
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010916153857.H22750@cyberhqz.com>
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn> <20010917000719.B25531@false.linpro.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010917000719.B25531@false.linpro.no>; from pere@hungry.com on Mon, Sep 17, 2001 at 12:07:19AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2001 at 12:07:19AM +0200, Petter Reinholdtsen wrote:
> [Wilbern Cobb]
> > This is a `feature' of the MIPS toolchain. Global and static items <=3D=
 n
> > bytes are placed into the small data or small bss sections instead of
> > the normal data or bss sections as an optimization. Excess items would
> > cause these linker errors.
> >=20
> > Pass the compiler the -Gn flag (default is 8 bytes), ie. -G4 should work
> > for most purposes.
>=20
> I tried -G4, -G2 and -G1 without any luck.  Even with -G1 there are still

I don't think -G is the problem here.  The problem is that the GOT
needs to be bigger than a 16 bit value.  The only way to do this is to
recompile everything that is going to be linked in statically
(libc_noshared.a and libgcc.a included) with -Wa,-xgot This problem
currently affects openh323 and mozilla, among other things.

--=20
Ryan Murray, Debian Developer (rmurray@cyberhqz.com, rmurray@debian.org)
The opinions expressed here are my own.

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7pSoAN2Dbz/1mRasRAld1AJ9zTGYw5aL2aw8tvcmI6Vf747N1SQCfSkld
N3Mn6YLaQYsi6JEqsZ6MeYs=
=ES7e
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
