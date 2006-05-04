Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 16:21:02 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:47288 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133705AbWEDPUx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 16:20:53 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1FbfdI-00023N-00; Thu, 04 May 2006 17:20:48 +0200
Date:	Thu, 4 May 2006 17:20:48 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 8250_early console support for au1x00
Message-ID: <20060504152048.GG19913@gundam.enneenne.com>
References: <20060504134509.GE19913@gundam.enneenne.com> <445A114B.4040404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <445A114B.4040404@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2006 at 06:35:55PM +0400, Sergei Shtylyov wrote:
>=20
>    The following 2 fragments are kind of contradictory:

I see, but I decided to keep it different since the kernel message is:

   Adding console on ttyS0 at MMIO 0x11100000 (options '115200')

and setting it as:

   Adding console on ttyS0 at AU 0x11100000 (options '115200')

sounds bad to me. :)

> And, as I said. there's not much sense in calling iomap() on Alchemy UART=
,=20
> UPIO_IOREMAP flag wasn't really needed...

Mmm... to be =ABcoherent=BB I think it should be done...

>    You propably meant "known bugs"? :-)

Yes. :)

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEWhvQQaTCYNJaVjMRAkK5AJ99/hmRiOCZn0oRqYcOHl9E68FARQCfc1jb
lr22cJFb+HqnkL3ee+d5WME=
=xLQ8
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
