Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBEIhqJ05680
	for linux-mips-outgoing; Fri, 14 Dec 2001 10:43:52 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBEIhlo05676
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 10:43:47 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0FA5284E; Fri, 14 Dec 2001 18:43:36 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D14674241; Fri, 14 Dec 2001 18:43:04 +0100 (CET)
Date: Fri, 14 Dec 2001 18:43:04 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Ian Chilton <ian@ichilton.co.uk>
Cc: linux-mips@oss.sgi.com
Subject: Re: Current Kernel in CVS Broken
Message-ID: <20011214174304.GA7510@paradigm.rfc822.org>
References: <20011214172739.A28669@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20011214172739.A28669@woody.ichilton.co.uk>
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2001 at 05:27:39PM +0000, Ian Chilton wrote:
> 2.4 cvs broken
>=20
> mips-linux-gcc -I /home/ian/tmp/i2/linux/include/asm/gcc -D__KERNEL__
> -I/home/ian/tmp/i2/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
> -fno-common -G 0 -mno-abicalls -fno-pic -mcpu=3Dr4600 -mips2 -Wa,--trap
> -pipe    -c -o ip22-setup.o ip22-setup.c
> ip22-setup.c: In function `sgi_request_irq':
> ip22-setup.c:64: `SGI_KEYBD_IRQ' undeclared (first use in this
> function)
> ip22-setup.c:64: (Each undeclared identifier is reported only once
> ip22-setup.c:64: for each function it appears in.)
> make[1]: *** [ip22-setup.o] Error 1
> make[1]: Leaving directory `/home/ian/tmp/i2/linux/arch/mips/sgi-ip22'
> make: *** [_dir_arch/mips/sgi-ip22] Error 2

You already have the fix in your inbox for a couple of hours which is a
one liner.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8GjooUaz2rXW+gJcRAuvDAKCI/nEabjYWuX2k7THqDq97UMNP7wCaAzgs
rb611oJZ4RxbA8BDTQcZ3Os=
=CQfy
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
