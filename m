Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4DJNQk28661
	for linux-mips-outgoing; Sun, 13 May 2001 12:23:26 -0700
Received: from straylight.cyberhqz.com (root@h24-78-251-235.vc.shawcable.net [24.78.251.235])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4DJNPF28658
	for <linux-mips@oss.sgi.com>; Sun, 13 May 2001 12:23:25 -0700
Received: (from rmurray@localhost)
	by straylight.cyberhqz.com (8.9.3/8.9.3/Debian 8.9.3-21) id MAA00509
	for linux-mips@oss.sgi.com; Sun, 13 May 2001 12:23:21 -0700
Date: Sun, 13 May 2001 12:23:21 -0700
From: Ryan Murray <rmurray@debian.org>
To: linux-mips@oss.sgi.com
Subject: Re: backwards compatible ld.so patch
Message-ID: <20010513122321.B342@cyberhqz.com>
References: <20010513115431.A342@cyberhqz.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010513115431.A342@cyberhqz.com>; from rmurray@debian.org on Sun, May 13, 2001 at 11:54:31AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--w7PDEPdKQumQfZlR
Content-Type: multipart/mixed; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And, of course, the actual patch....:)

--=20
Ryan Murray, Debian Developer (rmurray@cyberhqz.com, rmurray@debian.org)
The opinions expressed here are my own.

--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mips-shlib.patch"
Content-Transfer-Encoding: quoted-printable

--- sysdeps/mips/dl-machine.h	Sun May 13 22:25:35 2001
+++ sysdeps/mips/dl-machine.h	Sun May 13 22:28:14 2001
@@ -71,12 +71,7 @@
  * libraries have their base address at 0x5ffe0000.  This needs to be
  * fixed before we can safely get rid of this MIPSism.
  */
-#if 0
-#define MAP_BASE_ADDR(l) ((l)->l_info[DT_MIPS(BASE_ADDRESS)] ? \
-			  (l)->l_info[DT_MIPS(BASE_ADDRESS)]->d_un.d_ptr : 0)
-#else
-#define MAP_BASE_ADDR(l) 0x5ffe0000
-#endif
+#define MAP_BASE_ADDR(l) ((l)->l_addr >=3D 0x5ffe0000 ? 0x5ffe0000 : 0)
=20
 /* If there is a DT_MIPS_RLD_MAP entry in the dynamic section, fill it in
    with the run-time address of the r_debug structure  */

--Y7xTucakfITjPcLV--

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6/t8pN2Dbz/1mRasRAvy0AKCBEcysCs7ewhIamLl79BeZ7e6zHwCfeWvQ
BD8Iu9Ei6eEmpQf7kAzxM0g=
=bTJi
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
