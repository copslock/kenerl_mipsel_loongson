Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HKrfb30438
	for linux-mips-outgoing; Thu, 17 Jan 2002 12:53:41 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HKraP30435
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 12:53:36 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id CB3F8838; Thu, 17 Jan 2002 20:53:21 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 09E834395; Thu, 17 Jan 2002 20:49:14 +0100 (CET)
Date: Thu, 17 Jan 2002 20:49:13 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
Cc: karsten@excalibur.cologne.de, linux-mips@oss.sgi.com
Subject: Re: DECStation debian CD's
Message-ID: <20020117194913.GB26395@paradigm.rfc822.org>
References: <200201170937.KAA28900@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <200201170937.KAA28900@sparta.research.kpn.com>
User-Agent: Mutt/1.3.25i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2002 at 10:37:30AM +0100, Houten K.H.C. van (Karel) wrote:
> - delo doesn't work in combination with th 5000/200 PROM ???
>   (the systems just resets)

Thats correct - The /200 should ne a REX (non-REX?) prom which is
basically not supported yet - I havent got a running /200=20

loader/main.c
     30         /* FIXME We only check for REX but dont handle it right
now */
     31         if (magic =3D=3D DEC_REX_MAGIC) {
     32                 /* Store Call Vector */
     33                 callv=3Dcv;
     34                 rex_prom=3D1;
     35         }

Somebody would need to actually tune a bit for the prom calls for
read/write of disks and the command line parameters.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Ryq5Uaz2rXW+gJcRAgISAKDVzm6l4fRzHzzLhbhEbuf+Oa8tNgCgsgNq
GFmE8TbF/xdX6ua7PsKfXxI=
=eV/x
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
