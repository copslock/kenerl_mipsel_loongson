Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g19FFDP21238
	for linux-mips-outgoing; Sat, 9 Feb 2002 07:15:13 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g19FF8A21235
	for <linux-mips@oss.sgi.com>; Sat, 9 Feb 2002 07:15:08 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D62CE843; Sat,  9 Feb 2002 16:14:46 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id E646F4291; Sat,  9 Feb 2002 16:01:55 +0100 (CET)
Date: Sat, 9 Feb 2002 16:01:55 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: gcc include strangeness
Message-ID: <20020209150155.GA853@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i just stumbled when i tried to compile a program (bootloader) with
gcc which uses varargs. I got the error that "sgidefs.h" was missing.
sgidefs.h is contained in the glibc which gets included by va-mips.h
from stdarg.h - I dont think this is correct as i should be able
to compile programs without glibc.

Shouldnt sgidefs.h or its content be included in the gcc ?

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ZTnjUaz2rXW+gJcRAuTkAJ9H+sVgYOSbtXMKkXJAVyY/YcX98ACgvrws
ZXWEY67msOME7XupO4kAhzE=
=qKjo
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
