Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4DIsXc28095
	for linux-mips-outgoing; Sun, 13 May 2001 11:54:33 -0700
Received: from straylight.cyberhqz.com (root@h24-78-251-235.vc.shawcable.net [24.78.251.235])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4DIsVF28092
	for <linux-mips@oss.sgi.com>; Sun, 13 May 2001 11:54:31 -0700
Received: (from rmurray@localhost)
	by straylight.cyberhqz.com (8.9.3/8.9.3/Debian 8.9.3-21) id LAA00363
	for linux-mips@oss.sgi.com; Sun, 13 May 2001 11:54:31 -0700
Date: Sun, 13 May 2001 11:54:31 -0700
From: Ryan Murray <rmurray@debian.org>
To: linux-mips@oss.sgi.com
Subject: backwards compatible ld.so patch
Message-ID: <20010513115431.A342@cyberhqz.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Attached is a patch that changes the MAP_BASE_ADDR macro to one that Dan
mentioned in his question about a backwards-compatible change to ld.so
that allows both new and old shlibs to run.

This seems to work -- I've run perl (with an old-binutils libperl.so), with
a new-binutils built ld.so and libc.so, and it works fine.  The comment abo=
ve
the change should probably be updated to indicate the new state of things,
as well...

Comments?

--=20
Ryan Murray, Debian Developer (rmurray@cyberhqz.com, rmurray@debian.org)
The opinions expressed here are my own.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6/thmN2Dbz/1mRasRAl4VAJ9wvDpaAHxnkfF6rZ9bXgpXAmIcrwCg1dwE
dmIRs4J/3WVnpXNpAannvm8=
=EGvf
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
