Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2005 15:44:30 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([IPv6:::ffff:81.174.11.161]:11427 "EHLO
	zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8226777AbVGPOoJ>; Sat, 16 Jul 2005 15:44:09 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1Dtnv0-0005Jf-00; Sat, 16 Jul 2005 16:45:30 +0200
Date:	Sat, 16 Jul 2005 16:45:30 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Dan Malek <dan@embeddededge.com>
Cc:	Rodolfo Giometti <giometti@linux.it>, linux-mips@linux-mips.org
Subject: Re: power management status for au1100
Message-ID: <20050716144530.GD26127@enneenne.com>
References: <20050712142202.GB9234@gundam.enneenne.com> <20050712181013.GC9234@gundam.enneenne.com> <a2882b70a3d6c0f32728086e0c63764c@embeddededge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2E/hm+v6kSLEYT3h"
Content-Disposition: inline
In-Reply-To: <a2882b70a3d6c0f32728086e0c63764c@embeddededge.com>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--2E/hm+v6kSLEYT3h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 12, 2005 at 11:52:30AM -0700, Dan Malek wrote:
> Now that you know the reason for the change, perhaps we
> should try to make it work properly :-)

Ok. :)

When trying to compile the PM support I noticed that function
calibrate_delay() into =ABarch/mips/au1000/common/power.c=BB overrides the
same function into =ABinit/calibrate.c=BB.

Can be a problem? Which one is the right function to be used?

Thanks,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--2E/hm+v6kSLEYT3h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC2R2KQaTCYNJaVjMRAhnhAJ4zD4CUD6dFIddttiTaze/yVCdfSgCg4oj5
KA77yryS0TbGE6Lfi0Fmc00=
=BesP
-----END PGP SIGNATURE-----

--2E/hm+v6kSLEYT3h--
