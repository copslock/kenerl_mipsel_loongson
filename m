Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1OCAe426505
	for linux-mips-outgoing; Sun, 24 Feb 2002 04:10:40 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1OCAZ926501
	for <linux-mips@oss.sgi.com>; Sun, 24 Feb 2002 04:10:35 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 801FE84F; Sun, 24 Feb 2002 12:10:09 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
	id F2A231A2DF; Sun, 24 Feb 2002 12:10:38 +0100 (CET)
Date: Sun, 24 Feb 2002 12:10:38 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Robert Rusek <robru@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Working kernel 2.4.x for IP22
Message-ID: <20020224111038.GB30796@paradigm.rfc822.org>
References: <001501c1bd03$6ca133e0$6601a8c0@delllaptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <001501c1bd03$6ca133e0$6601a8c0@delllaptop>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2002 at 11:18:13PM -0800, Robert Rusek wrote:
> Does anyone know of a 2.4.x working kernel for IP22?  If so where do I
> get the source or the binary?  I am currently using 2.4.3, but it seems
> to have a bug, that if you are doing heavy IO operations on a filesystem
> other then the root, the machine completely locks up. =20

The 2.4 branch in the oss.sgi.com cvs works as far as i used it. 2.4.16
and 2.4.17 have been running here.

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

iD8DBQE8eMouUaz2rXW+gJcRAqDDAKCP2RXwHhAoJTXyC689+DYonfzwOgCeIGwF
WZokkGLBu/IheoptvO4w8rs=
=l5sN
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
