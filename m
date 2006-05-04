Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 14:24:34 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:49804 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133767AbWEDNYU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 14:24:20 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1FbdoT-000730-00; Thu, 04 May 2006 15:24:13 +0200
Date:	Thu, 4 May 2006 15:24:13 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Physical addresses fix for au1x00 serial driver
Message-ID: <20060504132413.GD19913@gundam.enneenne.com>
References: <20060504101112.GC19913@gundam.enneenne.com> <4459F72D.4010408@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <4459F72D.4010408@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2006 at 04:44:29PM +0400, Sergei Shtylyov wrote:
>
>    I have already noticed and fixed this. The fix is in Andrew Morton's=
=20
>    tree (unpublished yet). See this msg for the patch:
>=20
> http://www.linux-mips.org/archives/linux-mips/2006-04/msg00029.html

I see. :)

>    This is not quite correct. The UARTs take up 1 MB of memory each.

Yes, in my patch is missing this part:

           switch (up->port.iotype) {
   +       case UPIO_AU:
   +               size =3D 0x100000;
   +               /* fall thru */
           case UPIO_MEM:
                   if (!up->port.mapbase)

Are you already working on 8250_early for au1x00? I'm quite ready for
the patch. :)

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEWgB9QaTCYNJaVjMRAhmAAJ4g2r+R2UAZkQSZfa3ZO5rQbmsGBgCgmAAu
q2iDVQHJdYzBUObGT43daU8=
=tmEV
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
