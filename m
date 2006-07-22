Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jul 2006 13:37:40 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:53168 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133526AbWGVMhb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Jul 2006 13:37:31 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1G4Gex-0001KG-00; Sat, 22 Jul 2006 14:32:43 +0200
Date:	Sat, 22 Jul 2006 14:32:43 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Daniel Mack <daniel@yoobay.net>
Cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] AU1100 I2C support
Message-ID: <20060722123243.GA4543@gundam.enneenne.com>
References: <20060719180204.GK25330@enneenne.com> <20060722091342.GA22158@ipxXXXXX>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20060722091342.GA22158@ipxXXXXX>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 22, 2006 at 11:13:42AM +0200, Daniel Mack wrote:
>=20
> Is there any reason why it is limited to this very processor and
> should not work with all au1xxx types?

To be honest I don't know exacly... I don't know so well other
processors in this family. However I think at least au1000 and au1200
should be compatible.

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEwhrrQaTCYNJaVjMRAruZAJ4p9PLCoUBCEmIT9SU6ya84xJho+ACgolBA
HhQKmiw1Rz9YlRPkx/G7EoM=
=pAEW
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
