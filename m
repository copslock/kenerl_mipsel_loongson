Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAT5Ef521184
	for linux-mips-outgoing; Wed, 28 Nov 2001 21:14:41 -0800
Received: from MVista.COM (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAT5EZo21177;
	Wed, 28 Nov 2001 21:14:35 -0800
Received: (from pmundt@localhost)
	by MVista.COM (8.11.3/8.11.3/SuSE Linux 8.11.1-0.5) id fAT4EXx30656;
	Wed, 28 Nov 2001 20:14:33 -0800
Date: Wed, 28 Nov 2001 20:14:33 -0800
From: Paul Mundt <pmundt@MVista.COM>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: James Simmons <jsimmons@transvirtual.com>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] const mips_io_port_base !?
Message-ID: <20011128201433.A30490@mvista.com>
References: <20011128091655.A20264@lucon.org> <Pine.LNX.4.10.10111280921550.11130-100000@www.transvirtual.com> <20011129145513.D638@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011129145513.D638@dea.linux-mips.net>; from ralf@oss.sgi.com on Thu, Nov 29, 2001 at 02:55:13PM +1100
Organization: MontaVista Software, Inc.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2001 at 02:55:13PM +1100, Ralf Baechle wrote:
> > Ralph please apply this patch to arch/mips/kernel/setup.c. Some compile=
rs
> > don't like the conflict of definition in io.h and setup.c. Thanks.
>=20
> Will do.  For curiosity's sake, which compilers do complain?
>=20
GCC 3.0.2 was the one that complained for me.. 2.95.3 had no problems.

Regards,

--=20
Paul Mundt <pmundt@mvista.com>
MontaVista Software, Inc.


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjwFtigACgkQYLvqhoOEA4GoRQCgh3ds8mcxe+wG43T6z9Ui+MEt
7EQAn1fpjX2JffN6a0CA6HIz17fHLu2q
=UzNu
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
