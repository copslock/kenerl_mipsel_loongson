Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5A45tk11182
	for linux-mips-outgoing; Sat, 9 Jun 2001 21:05:55 -0700
Received: from straylight.cyberhqz.com (root@h24-78-251-235.vc.shawcable.net [24.78.251.235])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5A45sV11179
	for <linux-mips@oss.sgi.com>; Sat, 9 Jun 2001 21:05:54 -0700
Received: (from rmurray@localhost)
	by straylight.cyberhqz.com (8.9.3/8.9.3/Debian 8.9.3-21) id VAA32615
	for linux-mips@oss.sgi.com; Sat, 9 Jun 2001 21:05:54 -0700
From: Ryan Murray <rmurray@cyberhqz.com>
Date: Sat, 9 Jun 2001 21:05:54 -0700
To: linux-mips@oss.sgi.com
Subject: Re: gcc 3.0 sig11
Message-ID: <20010609210554.A12904@cyberhqz.com>
References: <20010609205641.A27425@foobazco.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010609205641.A27425@foobazco.org>; from wesolows@foobazco.org on Sat, Jun 09, 2001 at 08:56:41PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 09, 2001 at 08:56:41PM -0700, Keith M Wesolowski wrote:
> For the past few weeks (0422 is ok, 0528 and 0609 are not) gcc built
> for mips-linux takes sig11 during build.  Specifically at
> /s/crossdev-build/src/gcc-3.0-20010609/gcc/unwind-dw2-fde.c:1001:
> Internal error: Segmentation fault.
>=20
> I know at least one other person has seen this.  Anybody produced a
> patch or done any debugging on this?

I filed a bug and got the response that they do have successful build logs,
so they think it is fixed.

--=20
Ryan Murray, Debian Developer (rmurray@cyberhqz.com, rmurray@debian.org)
The opinions expressed here are my own.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7IvIhN2Dbz/1mRasRAsM5AKCu4l9OsaTXYif/7GGprYbLPnqegACgqYO1
YJVYjYVAP4Uqr+A0sDFwymQ=
=39se
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
