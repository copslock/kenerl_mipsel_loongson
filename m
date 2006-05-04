Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 17:33:24 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:10184 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133518AbWEDQdH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 17:33:07 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1FbglB-00044M-00; Thu, 04 May 2006 18:33:01 +0200
Date:	Thu, 4 May 2006 18:33:01 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 8250_early console support for au1x00
Message-ID: <20060504163301.GH19913@gundam.enneenne.com>
References: <20060504134509.GE19913@gundam.enneenne.com> <445A114B.4040404@ru.mvista.com> <20060504152048.GG19913@gundam.enneenne.com> <445A225F.7090300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline
In-Reply-To: <445A225F.7090300@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2006 at 07:48:47PM +0400, Sergei Shtylyov wrote:
>=20
>    Yes. But the error msg emmitted by your patch would look this way, i.e=
=2E=20
> AU, not MMIO. No symmetry. :-)

Ah! Now I see... ok, I'll fix it! :)

>    Wouldn't hurt, just useless. So, I think no special checks are needed =
to=20
> avoid it. :-)

If don't hurt I think we should use the physical address instead of
KSEG1...

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEWiy9QaTCYNJaVjMRAhXAAJ9VMKjO+nzc0X9sZUOKh6DPg0XN8QCfUB8M
NNVeAQUmNB2n7EE5OfWtiYA=
=pscU
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--
