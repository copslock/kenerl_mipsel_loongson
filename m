Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB4A12j19720
	for linux-mips-outgoing; Tue, 4 Dec 2001 02:01:02 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB4A0uo19710
	for <linux-mips@oss.sgi.com>; Tue, 4 Dec 2001 02:00:56 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id BBD0D89F; Tue,  4 Dec 2001 10:00:47 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id F36E44162; Tue,  4 Dec 2001 09:59:51 +0100 (CET)
Date: Tue, 4 Dec 2001 09:59:51 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
Cc: Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: 2.4.16 success on Indy (was Re: 2.4.16 success on Decstation 5000/150)
Message-ID: <20011204095951.A27343@paradigm.rfc822.org>
References: <20011203192543.A10394@paradigm.rfc822.org> <Pine.LNX.4.21.0112040829360.12262-100000@hlubocky.del.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0112040829360.12262-100000@hlubocky.del.cz>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2001 at 08:41:40AM +0100, Ladislav Michl wrote:
> On Mon, 3 Dec 2001, Florian Lohoff wrote:
>=20
> > Ok - the IRQ8 get enabled because i have CONFIG_RTC set and in
> > drivers/char/rtc.c around line 730 it requests:
> >=20
> > if(request_irq(RTC_IRQ, rtc_interrupt, SA_INTERRUPT, "rtc", NULL))
>=20
> ehh, you compiled MC146818 driver for Indy... that's not good idea - IP22
> uses Dallas DS1286 RAMified Watcgdog Timekeeper. Enable CONFIG_SGI_DS1286
> if you want RTC driver.

CONFIG_RTC is set by "Enhanced Real Time Clock Support" - It seems
there is something broken in the config system then ...

tristate 'Enhanced Real Time Clock Support' CONFIG_RTC
if [ "$CONFIG_IA64" =3D "y" ]; then
   bool 'EFI Real Time Clock Services' CONFIG_EFI_RTC
fi
if [ "$CONFIG_OBSOLETE" =3D "y" -a "$CONFIG_ALPHA_BOOK1" =3D "y" ]; then
   bool 'Tadpole ANA H8 Support'  CONFIG_H8
fi

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8DJCHUaz2rXW+gJcRAqQ3AKDDOIGHmctmsWzKduac/lMUpog7TACgp4+E
xInQCMt10+TCDaAkOU8CYsc=
=ZQJq
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
