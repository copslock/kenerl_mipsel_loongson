Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2006 16:11:37 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:43226 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S3686521AbWF2PL2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Jun 2006 16:11:28 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1Fvy69-0005DJ-3N; Thu, 29 Jun 2006 17:06:29 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FvyB0-0004Je-9P; Thu, 29 Jun 2006 17:11:30 +0200
Date:	Thu, 29 Jun 2006 17:11:30 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Message-ID: <20060629151130.GM7471@enneenne.com>
References: <20060626221441.GA10595@enneenne.com> <20060627155914.GD10595@enneenne.com> <44A3EBD7.8090408@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OxpYUbrsx40GOZXC"
Content-Disposition: inline
In-Reply-To: <44A3EBD7.8090408@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: au1000_lowlevel_probe on au1000_eth.c
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--OxpYUbrsx40GOZXC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2006 at 07:03:51PM +0400, Sergei Shtylyov wrote:
>=20
>    This is against your rewrite, if I don't mistake?

Yes.

>    Hrm, wouldn't it be better to put this stuff into a separate function=
=20
>    then?

Maybe, but I considered that these stuff are dignificative only during
boot time so I decided to do not consider them during wake up. Is that
wrong?

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--OxpYUbrsx40GOZXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEo+2iQaTCYNJaVjMRAtoCAKDdVDCxz0elNeqtA0x4DvZshY1VTQCfQI82
GS1M1TPV2qmIraPLDIvCB54=
=i/zV
-----END PGP SIGNATURE-----

--OxpYUbrsx40GOZXC--
