Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2006 08:35:00 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:458 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133388AbWF0Hev (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jun 2006 08:34:51 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1Fv85k-0000ZX-00; Tue, 27 Jun 2006 09:34:36 +0200
Date:	Tue, 27 Jun 2006 09:34:36 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: au1000_lowlevel_probe on au1000_eth.c
Message-ID: <20060627073436.GA25309@gundam.enneenne.com>
References: <20060626221441.GA10595@enneenne.com> <200606270836.09057.eckhardt@satorlaser.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <200606270836.09057.eckhardt@satorlaser.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2006 at 08:36:08AM +0200, Ulrich Eckhardt wrote:
>=20
> What is the _right_ thing is difficult to answer, but the reasons for the=
 oops=20
> are simple (at least they were on the platform I used): you have more tha=
n=20
> one device connected to the same system bus. In my case, it was the boot-=
PROM=20
> and (I think) the PCMCIA memory. So, in practice one could only access on=
e of=20
> the two and you had to toggle between them. I'm not sure it is worth the=
=20
> hassle of toggling (and doing so in an orderly fashion!), I'd rather pars=
e=20
> the PROM once and then store the results in RAM.

I see. But maybe the =ABbest=BB thing to do is just to skip these settings
during wake up after a sleep since they are magniful only during boot
time...

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEoN+MQaTCYNJaVjMRAhVbAJ0VKal56hi3jO7k97CQCgKRQ556sQCeLd4T
IyJSJJ55mWVJwfz5Q44HpQk=
=Cf5V
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
