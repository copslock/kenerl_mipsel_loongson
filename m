Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 16:12:33 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([IPv6:::ffff:81.174.11.161]:61385 "EHLO
	zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8225313AbVGVPMS>; Fri, 22 Jul 2005 16:12:18 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DvzDu-00062H-00; Fri, 22 Jul 2005 17:14:02 +0200
Date:	Fri, 22 Jul 2005 17:14:02 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Clark Williams <williams@redhat.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Battery status
Message-ID: <20050722151402.GG21044@enneenne.com>
References: <20050722142205.GE21044@enneenne.com> <1122044036.10743.5.camel@riff>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TOmSpbqtysumMR8M"
Content-Disposition: inline
In-Reply-To: <1122044036.10743.5.camel@riff>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--TOmSpbqtysumMR8M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 22, 2005 at 09:53:56AM -0500, Clark Williams wrote:
> You might want to look at how acpi is presented in the /proc interface.
> You could hook your battery status routines into the acpi entries:
>=20
> 	/proc/acpi/battery/BAT0/{alarm,info,status}=20

I see... but in =ABdrivers/acpi/Kconfig=BB I notice that this driver
depends on =ABIA64 || X86=BB. Do you think I can activate it even for MIPS
arch? :-o

Thanks,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--TOmSpbqtysumMR8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC4Q06QaTCYNJaVjMRAky6AJsEeyTxVAhBTVcfQLhY1Wy776sLDQCfUvzI
yCHIiJa/pEoVgN3CwFBs9Ko=
=u6nX
-----END PGP SIGNATURE-----

--TOmSpbqtysumMR8M--
