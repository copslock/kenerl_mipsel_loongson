Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARGdhW23379
	for linux-mips-outgoing; Tue, 27 Nov 2001 08:39:43 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARGdTo23364
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 08:39:29 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 285658D9; Tue, 27 Nov 2001 16:39:22 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A68253F47; Tue, 27 Nov 2001 16:38:54 +0100 (CET)
Date: Tue, 27 Nov 2001 16:38:54 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: debian-mips@lists.debian.org, debian-boot@lists.debian.org,
   linux-mips@oss.sgi.com
Subject: Re: failed installation debian-mipsel (Decstation 5000/150)
Message-ID: <20011127163854.D9282@paradigm.rfc822.org>
References: <20011127134930.A7022@paradigm.rfc822.org> <Pine.GSO.3.96.1011127150516.440F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1011127150516.440F-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2001 at 03:33:42PM +0100, Maciej W. Rozycki wrote:
> On Tue, 27 Nov 2001, Florian Lohoff wrote:
>=20
> > The decstation fails to answer ARP requests while downloading. From
> > kernel 2.2 on the arp entries expire faster which lets the tftp download
> > fail somewhere in the middle.
>=20
>  I see.  I haven't used TFTP on the DECstation ever.  I think the default
> timeout is too low anyway.  RFC826 does not specify any timeouts but
> keeping them below 2 minutes is pointless IMO.  If an interface assigned
> to an IP address changes its MAC address, it will start to use the new one
> for ARP requests immetiately and all caches in the LAN will have a chance
> to get updated.

IIRC the kernel refreshes the timeout on communication - But only on
TCP not UDP ...

> > It didnt - I at least let the machine wait for 15-20 Minutes while
> > digging the code...
>=20
>  Weird -- the read should time out after 10000 loops...  It definitely
> needs to be checked.=20

Did this change lately - The kernel of the boot-floppies is a little
old.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8A7OOUaz2rXW+gJcRAgX+AKC4tMtRilCY7J2S9GuvEoYBiLxAfwCeOwIL
Ur8PZObdj+Bl1TSHxyM7XNM=
=cl+M
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
