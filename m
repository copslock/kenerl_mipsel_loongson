Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f86CZcQ15656
	for linux-mips-outgoing; Thu, 6 Sep 2001 05:35:38 -0700
Received: from ns.snowman.net (ns.snowman.net [63.80.4.34])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f86CZZd15653
	for <linux-mips@oss.sgi.com>; Thu, 6 Sep 2001 05:35:35 -0700
Received: (from sfrost@localhost)
	by ns.snowman.net (8.9.3/8.9.3/Debian 8.9.3-21) id IAA05145;
	Thu, 6 Sep 2001 08:34:45 -0400
Date: Thu, 6 Sep 2001 08:34:45 -0400
From: Stephen Frost <sfrost@snowman.net>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: linux 2.4.8: The DECstation 5000/2x0 NVRAM module driver
Message-ID: <20010906083444.W11136@ns>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@fnet.fr, linux-mips@oss.sgi.com
References: <Pine.GSO.3.96.1010906141756.28792A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rnwvb/07397jTJIO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010906141756.28792A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Sep 06, 2001 at 02:31:45PM +0200
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 8:32am  up 385 days, 10:50, 13 users,  load average: 2.03, 2.01, 2.00
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--rnwvb/07397jTJIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Maciej W. Rozycki (macro@ds2.pg.gda.pl) wrote:
> Hi,
>=20
>  I've prepared a syntactic update to the DECstation 5000/2x0 NVRAM module
> driver for linux 2.4.8.  There are no functional changes at the moment.=
=20
> The driver patch and supplementary changes are available at:
> 'ftp://ftp.ds2.pg.gda.pl/pub/macro/drivers/ms02-nv/'. =20
>=20
>  I'm looking for a tester with a DECstation 5000/200 and a MS02 NVRAM
> module.  I'm going to improve the module detection code in the next
> version to make it less firmware-dependent.  This is needed to support
> multiple modules as well as single modules in non-standard slots.  I need
> to make sure I can rely on bus error exceptions just like in the /240.=20

	Welp, I've got a DECstation 5000/200 but no clue what (if any)
	NVRAM module it has.  How can I find out? :)  I havn't booted
	the thing up in quite a while so I'm not even sure it's exactly
	functional, but I've been looking for an excuse to play with it.

		Stephen

--rnwvb/07397jTJIO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7l21krzgMPqB3kigRAmUNAJ0bKJ71n47W+QOjzZy3t+FYdHrLzACeL6QN
2hX8NzRQB1nZxiZ4XDDNCpw=
=ZbvL
-----END PGP SIGNATURE-----

--rnwvb/07397jTJIO--
