Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2007 15:04:03 +0100 (BST)
Received: from lug-owl.de ([195.71.106.12]:14312 "EHLO lug-owl.de")
	by ftp.linux-mips.org with ESMTP id S20025610AbXFAOEC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Jun 2007 15:04:02 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id 42637F0057; Fri,  1 Jun 2007 16:03:31 +0200 (CEST)
Date:	Fri, 1 Jun 2007 16:03:31 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] zs: Move to the serial subsystem
Message-ID: <20070601140331.GH2649@lug-owl.de>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	linux-mips@linux-mips.org
References: <Pine.LNX.4.64N.0705291258390.14456@blysk.ds.pg.gda.pl> <20070530165842.GL29894@sith.mimuw.edu.pl> <Pine.LNX.4.64N.0705301802570.27697@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0705301802570.27697@blysk.ds.pg.gda.pl>
X-Operating-System: Linux mail 2.6.18-4-686 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-30 18:25:46 +0100, Maciej W. Rozycki <macro@linux-mips.org>=
 wrote:
> On Wed, 30 May 2007, Jan Rekorajski wrote:
> > Any chance to get LK201/401 keyboard and vsxxxaa mouse working with thi=
s?
>=20
>  For the time being a solution is the patch below and then:
>=20
> CONFIG_INPUT=3Dy
> CONFIG_INPUT_KEYBOARD=3Dy
> CONFIG_KEYBOARD_LKKBD=3Dy
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_VSXXXAA=3Dy
> CONFIG_SERIO=3Dy
> CONFIG_SERIO_SERPORT=3Dy
> CONFIG_VT=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
>=20
> plus your framebuffer of choice.  To activate the keyboard you have to ru=
n=20
> the following program:
>=20
> #include <fcntl.h>
> #include <sys/ioctl.h>
> #include <unistd.h>
>=20
> #define SPIOCSTYPE _IOW('q', 0x01, unsigned long)
> #define SERIO_LKKBD 0x28
>=20
> int main(void)
> {
> 	int fd, ldisc =3D N_MOUSE, type =3D SERIO_LKKBD;
> 	char buf;
>=20
> 	fd =3D open("/dev/ttyS2", O_RDWR | O_NONBLOCK);
> 	ioctl(fd, TIOCSETD, &ldisc);
> 	ioctl(fd, SPIOCSTYPE, &type);
> 	read(fd, &buf, 1);
> 	close(fd);
>=20
> 	return 0;
> }

Another way would be to use the `inputattach' program, which is
shipped with the `joystick' package (sic) and also does line speed
setting etc. for you.

MfG, JBG

>  I am looking into a solution that would make it automatic without the=20
> need of involving userland which just does not seem right here -- you do=
=20
> want to run your kernel with "init=3D/bin/bash" or suchlike and have your=
=20
> virtual terminal console usable.  I will remove the old lk201 bits then.

IIRC the serial port needs to register a serio device, set correct
baud/cstopb/... settings and set VSXXXAA/LKKBD identity on the two
serio ports. I *hope* the rest happens automatically then. (Another
way would be to look into how the Sun guys get their keyboards
up'n'running...)

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of: 23:53 <@jbglaw> So, ich kletter' jetzt mal ins Bett.
the second  : 23:57 <@jever2> .oO( kletter ..., hat er noch Gitter vorm Bet=
t, wie fr=C3=BCher meine Kinder?)
              00:00 <@jbglaw> jever2: *patsch*
              00:01 <@jever2> *aua*, wof=C3=BCr, Gedanken sind frei!
              00:02 <@jbglaw> Nee, freie Gedanken, die sind seit 1984 doch =
aus!
              00:03 <@jever2> 1984? ich bin erst seit 1985 verheiratet!

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGYCczHb1edYOZ4bsRAiuTAKCStrSWG2GfdCeIX3jjKmIXGPdtMACfZQ5J
LovqjD15JqjBCnCG0rLuGE4=
=GI1u
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--
