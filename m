Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 16:18:41 +0100 (BST)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:35038 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8226884AbVGSPSX>;
	Tue, 19 Jul 2005 16:18:23 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id A1B67F0075; Tue, 19 Jul 2005 17:20:08 +0200 (CEST)
Date:	Tue, 19 Jul 2005 17:20:08 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	linux-mips@linux-mips.org
Subject: Re: Updating RTC with date command
Message-ID: <20050719152008.GG20065@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <CBD77117272E1249BFDC21E33D555FDC06018D@dbde01.ent.ti.com> <20050719143110.GD3108@linux-mips.org> <20050719144230.GE20065@lug-owl.de> <Pine.LNX.4.61L.0507191555360.10363@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507191555360.10363@blysk.ds.pg.gda.pl>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--m972NQjnE83KvVa/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-07-19 16:06:21 +0100, Maciej W. Rozycki <macro@linux-mips.org>=
 wrote:
> On Tue, 19 Jul 2005, Jan-Benedict Glaw wrote:
>=20
> > hwclock is the userspace utility to manually once set the time. In
> > normal operation, this should only be called _once_, after the system is
> > switched on for the very first time.
>=20
>  Well, `hwclock' should normally be used to update the RTC every time=20
> after a manual system clock update.

Which of course should only be done once. Ever :)

> > During lifetime, ntpd should execute and thus the system's current time
> > will be written to the HW clock every now and then. Additionally, most
>=20
>  Note that ntpd only updates minutes and seconds and then only if the=20
> difference is small -- to account for the existence of time zones and a=
=20
> system-specific relation between the time recoreded by the system and one=
=20
> handled by the RTC.  Also the feature is broken by design -- ntpd=20
> shouldn't do that at all in principle and in practice it leads to the=20
> system time being corrupted on some machines using an RTC interrupt for=
=20
> the system timer tick.

Aren't we expected to keep UTC time inside the HW clock? So there's no
problem with timezones.  Also, if your timer interrupt source it that
broken that ntpd cannot track it, then you're having more servere
problems...

> > distributions seem to also update the HW clock at system shutdown time.
>=20
>  Which is where it should really happen.

I disagree. IFF there's a known good time, it's acceptable to write it
into a backing HW clock. In case there isn't (any longer), it's probably
better to not write to the HW clock at all. Probably it's contents is
better than a wrongly manually adjusted local date setting...

I do trust ntpd, but do I trust someone who looks at it's watch?

> > So the correct solution to your problem is to either shutdown once
> > (workaround) or keep ntpd running (the solution[tm]).
>=20
>  I think you've got the figures reversed (well, it's useful to have ntpd=
=20
> running, but it should not fiddle with the RTC).

Well, I stated my oppinion. Maybe ntpd shouldn't set the clock (or make
the kernel set it internally), but for sure I don't want the HW clock
being set by hand (except very first power-up of the system) and by no
means if local time came up from a manual process.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
fuer einen Freien Staat voll Freier Buerger" | im Internet! |   im Irak!   =
O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC3RooHb1edYOZ4bsRArUpAJ0WbflH/Vn45E4CRaiaIwD6gDy9KgCfaq5V
xd2zhvQVYbp842YFF4jhY3Q=
=sbhH
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--
