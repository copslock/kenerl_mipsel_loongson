Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KNFEj31962
	for linux-mips-outgoing; Wed, 20 Feb 2002 15:15:14 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KNF8931958
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 15:15:09 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id DBFD87FA; Wed, 20 Feb 2002 23:14:41 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
	id 6FE0A1A2C7; Wed, 20 Feb 2002 23:15:07 +0100 (CET)
Date: Wed, 20 Feb 2002 23:15:07 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Robert Rusek <robru@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Latest kernel?
Message-ID: <20020220221507.GC29624@paradigm.rfc822.org>
References: <000d01c1ba5a$083b1fc0$6701a8c0@computer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <000d01c1ba5a$083b1fc0$6701a8c0@computer>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2002 at 02:00:36PM -0800, Robert Rusek wrote:
> Where can I obtain the latest stable build of the kernel.  I need it to w=
ork
> on my SGI IP22.  If possible I do not want to use CSV since I do not have=
 a
> high speed internet connection.  Any help would be greatly appreciated.

I dont think there are regular tarballs - Take the pain once - checkout
the kernel and before modifying make a tarball. Then you can just

cvs -z3 update -Pd=20

Your tarball all the time. BTW: You should checkout -r linux_2_4 as
i dont think 2.5 has success reports on mips already.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8dB/rUaz2rXW+gJcRAgfdAJ4ltnzDlHK7sE91tPl+Xxt3jW/X4ACg0Nhf
zrbHlkNfmRLglhJx/Mgaveg=
=Aaiy
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
