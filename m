Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBRB8o909479
	for linux-mips-outgoing; Thu, 27 Dec 2001 03:08:50 -0800
Received: from straylight.cyberhqz.com (root@h24-83-212-254.sbm.shawcable.net [24.83.212.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBRB8kX09476
	for <linux-mips@oss.sgi.com>; Thu, 27 Dec 2001 03:08:46 -0800
Received: (from rmurray@localhost)
	by straylight.cyberhqz.com (8.9.3/8.9.3/Debian 8.9.3-21) id CAA13967
	for linux-mips@oss.sgi.com; Thu, 27 Dec 2001 02:08:44 -0800
Date: Thu, 27 Dec 2001 02:08:44 -0800
From: Ryan Murray <rmurray@debian.org>
To: linux-mips@oss.sgi.com
Subject: config.guess changs
Message-ID: <20011227020844.U29645@cyberhqz.com>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8jNwmpfkpox/fiJK"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--8jNwmpfkpox/fiJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The config.guess rework of 12/12/2001 doesn't work on big endian machines,
as the preprocessor defines "mips" to be " 1", so the cpp -E output ends
up being "CPU=3D 1".

--=20
Ryan Murray, Debian Developer (rmurray@cyberhqz.com, rmurray@debian.org)
The opinions expressed here are my own.

--8jNwmpfkpox/fiJK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8KvMrN2Dbz/1mRasRAl76AKCC6x6vox77iELnlC8ABUxkQ5gOZACglOkM
+usrqAxSCXR2T2NLn5PGbsg=
=zYV6
-----END PGP SIGNATURE-----

--8jNwmpfkpox/fiJK--
