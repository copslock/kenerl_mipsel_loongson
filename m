Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARElE418206
	for linux-mips-outgoing; Tue, 27 Nov 2001 06:47:14 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAREl6o18199
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 06:47:06 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 3C429848; Tue, 27 Nov 2001 14:47:00 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 483BB3F47; Tue, 27 Nov 2001 13:49:30 +0100 (CET)
Date: Tue, 27 Nov 2001 13:49:30 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: debian-mips@lists.debian.org, debian-boot@lists.debian.org,
   linux-mips@oss.sgi.com
Subject: Re: failed installation debian-mipsel (Decstation 5000/150)
Message-ID: <20011127134930.A7022@paradigm.rfc822.org>
References: <20011126234617.D13081@paradigm.rfc822.org> <Pine.GSO.3.96.1011127132516.440C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1011127132516.440C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2001 at 01:43:10PM +0100, Maciej W. Rozycki wrote:
> > At least this should be mentioned:
> >=20
> > echo 4096 >/proc/sys/net/ipv4/neigh/eth0/retrans_time
>=20
>  Is it needed for TFTP?  What for?

The decstation fails to answer ARP requests while downloading. From
kernel 2.2 on the arp entries expire faster which lets the tftp download
fail somewhere in the middle.

> > and something along that you need to set a console as the kernel is not
> > able to autodetect the console.
>=20
>  You mean the serial console?  Well, that's surely not detectable, but the
> console on the VT seems to be detected fine.

It might be detected from the prom env var "osconsole".

> > The kernel hangs for me at the detection of the LK Keyboard (which
> > is not attached)
>=20
>  Yep, the timeouts are definitely too large even for the patient... ;-)=
=20
> If you waited for a few minutes, it should boot anyway.  I'll prepare a
> fix.=20

It didnt - I at least let the machine wait for 15-20 Minutes while
digging the code...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8A4vaUaz2rXW+gJcRAm+DAKCfwqV7gF52Q+WjGjopIVre07SRtwCfUCvz
M/oeS/+CVgtcLGDbr0Q1Tew=
=UIMV
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
