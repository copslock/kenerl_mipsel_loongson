Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB52Ft000760
	for linux-mips-outgoing; Tue, 4 Dec 2001 18:15:55 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB52Foo00745
	for <linux-mips@oss.sgi.com>; Tue, 4 Dec 2001 18:15:50 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 627968AC; Wed,  5 Dec 2001 02:15:41 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 992F042AD; Wed,  5 Dec 2001 02:10:51 +0100 (CET)
Date: Wed, 5 Dec 2001 02:10:51 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
Cc: Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: 2.4.16 success on Indy (was Re: 2.4.16 success on Decstation 5000/150)
Message-ID: <20011205021051.A1882@paradigm.rfc822.org>
References: <20011204095951.A27343@paradigm.rfc822.org> <Pine.LNX.4.21.0112041008090.12262-100000@hlubocky.del.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0112041008090.12262-100000@hlubocky.del.cz>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2001 at 10:18:45AM +0100, Ladislav Michl wrote:
> look to the drivers/sgi/Config.in instead
>=20
> comment 'SGI devices'
> bool 'SGI Zilog85C30 serial support' CONFIG_SGI_SERIAL
> if [ "$CONFIG_SGI_SERIAL" =3D "y" ]; then
>    bool '  Support for console on serial port' CONFIG_SERIAL_CONSOLE
> fi
> bool 'SGI DS1286  RTC support' CONFIG_SGI_DS1286

I know that - I had that enabled too ...

> i know... we have special driver for SGI, special driver for some ARM
> based boards, for some ...(a lot of clocks to list :-)). but, that's
> living ;-) search linux-mips archives, there was long debate about this
> month ago. personaly i don't like way how it works now, but i haven't time
> nor knowledges to change it without breaking anything, so i'm happy that
> it works somehow.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8DXQbUaz2rXW+gJcRAm/AAKCDraeSv6Sfcp1FCONNTnlcrcHCgACfVvNw
UkSYWh2XVx3HyFma8h18L8k=
=07Py
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
