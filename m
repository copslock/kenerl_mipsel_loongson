Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBV08Qt22269
	for linux-mips-outgoing; Sun, 30 Dec 2001 16:08:26 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBV05tg22252
	for <linux-mips@oss.sgi.com>; Sun, 30 Dec 2001 16:08:19 -0800
Received: from straylight.cyberhqz.com (h24-83-212-254.sbm.shawcable.net [24.83.212.254]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA07574
	for <linux-mips@oss.sgi.com>; Thu, 27 Dec 2001 21:07:58 -0800 (PST)
	mail_from (rmurray@cyberhqz.com)
Received: (from rmurray@localhost)
	by straylight.cyberhqz.com (8.9.3/8.9.3/Debian 8.9.3-21) id VAA22686;
	Thu, 27 Dec 2001 21:06:00 -0800
From: Ryan Murray <rmurray@cyberhqz.com>
Date: Thu, 27 Dec 2001 21:06:00 -0800
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com, config-patches@gnu.org
Subject: Re: config.guess changs
Message-ID: <20011227210600.G29645@cyberhqz.com>
Mail-Followup-To: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
	config-patches@gnu.org
References: <20011227020844.U29645@cyberhqz.com> <20011227095306.A16072@lucon.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncX6roZrNNHXnAbh"
Content-Disposition: inline
In-Reply-To: <20011227095306.A16072@lucon.org>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--ncX6roZrNNHXnAbh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 27, 2001 at 09:53:06AM -0800, H . J . Lu wrote:
> > The config.guess rework of 12/12/2001 doesn't work on big endian machin=
es,
> > as the preprocessor defines "mips" to be " 1", so the cpp -E output ends
> > up being "CPU=3D 1".
>=20
> Try this patch.
>=20
>=20
> H.J.
> ----
> 2001-12-27  H.J. Lu  <hjl@gnu.org>
>=20
> 	* config.guess (mips:Linux:*:*): Undefine CPU, mips and mipsel
> 	first.
>=20
> --- config.guess	Wed Dec 12 19:53:12 2001
> +++ config.guess	Thu Dec 27 09:51:18 2001
> @@ -770,6 +770,9 @@ EOF
>      mips:Linux:*:*)
>  	eval $set_cc_for_build
>  	sed 's/^	//' << EOF >$dummy.c
> +	#undef CPU
> +	#undef mips
> +	#undef mipsel
>  	#if defined(__MIPSEL__) || defined(__MIPSEL) || defined(_MIPSEL) || def=
ined(MIPSEL)=20
>  	CPU=3Dmipsel=20
>  	#else

That fixes the problem here.

--=20
Ryan Murray, Debian Developer (rmurray@cyberhqz.com, rmurray@debian.org)
The opinions expressed here are my own.

--ncX6roZrNNHXnAbh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8K/24N2Dbz/1mRasRAh5+AKDeuY3E1QFqISMuWZCD/R5xXhuAtACeJkej
mg7kVkPQVPq+Ff/ns2d/VTI=
=nmc4
-----END PGP SIGNATURE-----

--ncX6roZrNNHXnAbh--
