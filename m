Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 18:22:02 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:7309 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133518AbWEDRVj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 18:21:39 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1FbhW7-0005WE-00; Thu, 04 May 2006 19:21:31 +0200
Date:	Thu, 4 May 2006 19:21:31 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Porting Au1x000 USB host controller on u-boot
Message-ID: <20060504172131.GF7357@gundam.enneenne.com>
References: <20060504095341.GB19913@gundam.enneenne.com> <445A347A.5050507@ru.mvista.com> <445A36E3.4010809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y/WcH0a6A93yCHGr"
Content-Disposition: inline
In-Reply-To: <445A36E3.4010809@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--Y/WcH0a6A93yCHGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2006 at 09:16:19PM +0400, Sergei Shtylyov wrote:
>=20
>    AND make sure every buffer/TD/ED is written back / invalidated from=20
>    cache before the OHCI accesses them since the cache coherency on Au1xx=
0 is=20
> b0rken!

Mmm... good suggestion! :) How can I invalidated the cache? Can you
please show me some example code?

Thanks _a lot_!

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--Y/WcH0a6A93yCHGr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEWjgbQaTCYNJaVjMRArzZAKDbR9h/h07zo5VhM54zg1hX55l7yQCg3H3y
qHeyoBwXiUpZnX9SDR4Ce60=
=bXLh
-----END PGP SIGNATURE-----

--Y/WcH0a6A93yCHGr--
