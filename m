Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 14:58:54 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:18111 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133530AbWEDN6p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 14:58:45 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1FbeLl-00083P-00; Thu, 04 May 2006 15:58:37 +0200
Date:	Thu, 4 May 2006 15:58:37 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Physical addresses fix for au1x00 serial driver
Message-ID: <20060504135837.GF19913@gundam.enneenne.com>
References: <20060504101112.GC19913@gundam.enneenne.com> <4459F72D.4010408@ru.mvista.com> <20060504132413.GD19913@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <20060504132413.GD19913@gundam.enneenne.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2006 at 03:24:13PM +0200, Rodolfo Giometti wrote:
> >    This is not quite correct. The UARTs take up 1 MB of memory each.

The patch:

   diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
   index 8365d5b..3473e7a 100644
   --- a/drivers/serial/8250.c
   +++ b/drivers/serial/8250.c
   @@ -1935,8 +1935,10 @@ static int serial8250_request_std_resour
    	int ret =3D 0;
   =20
    	switch (up->port.iotype) {
   -	case UPIO_MEM:
    	case UPIO_AU:
   +		size =3D 0x100000;
   +		/* fall thru */
   +	case UPIO_MEM:
    		if (!up->port.mapbase)
    			break;
     =20
I'll merge this patch with my previous one ASAP...

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEWgiNQaTCYNJaVjMRAoKWAJ9DcU/sqJGWcku2Uf+iGivN8IwFggCfdt8V
COLBKskHQHm3cE20wdnnwEw=
=fh/K
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
