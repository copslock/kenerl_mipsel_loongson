Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2006 11:35:08 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:43984 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133803AbWGXKe7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Jul 2006 11:34:59 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1G4wn3-0003N7-4a; Mon, 24 Jul 2006 11:31:53 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1G4xmA-0006EZ-8c; Mon, 24 Jul 2006 12:35:02 +0200
Date:	Mon, 24 Jul 2006 12:35:02 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Daniel Mack <daniel@caiaq.de>
Cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org
Message-ID: <20060724103502.GZ9129@enneenne.com>
References: <20060719180204.GK25330@enneenne.com> <20060722091342.GA22158@ipxXXXXX> <20060722123243.GA4543@gundam.enneenne.com> <133FC0BA-B375-46D4-916E-773996425F57@caiaq.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OJWLbGElk4npXSe3"
Content-Disposition: inline
In-Reply-To: <133FC0BA-B375-46D4-916E-773996425F57@caiaq.de>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: [PATCH] AU1100 I2C support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--OJWLbGElk4npXSe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2006 at 12:30:42PM +0200, Daniel Mack wrote:
>=20
> I think so, too. Since you only call the generic au_* functions for
> the GPIO access, all members of this processor family should be
> supported. I propose to change the patch accordingly.

Do you think I should change strings (functions' name, etc.) from
"au1100" to "au1xxx"?

If so, do you prefere a new patch or I can just send you a
patch-to-the-patch? :D

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--OJWLbGElk4npXSe3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFExKJWQaTCYNJaVjMRAqEaAJ92M+eR794+xnPw8b0ua+sEzJpPsQCcCtpC
MsZylU0C7cuLPoYjF9hlXE8=
=RjD2
-----END PGP SIGNATURE-----

--OJWLbGElk4npXSe3--
