Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2005 17:18:30 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([IPv6:::ffff:81.174.11.161]:654 "EHLO
	zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8226831AbVGRQSP>; Mon, 18 Jul 2005 17:18:15 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DuYLN-0002ri-00; Mon, 18 Jul 2005 18:19:49 +0200
Date:	Mon, 18 Jul 2005 18:19:49 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Support for (au1100) 64-bit physical address space broken on 2.6.12?
Message-ID: <20050718161949.GB28995@enneenne.com>
References: <20050716124205.GA26127@enneenne.com> <1121528575.27121.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <1121528575.27121.3.camel@localhost.localdomain>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 16, 2005 at 08:42:55AM -0700, Pete Popov wrote:
> I fixed this is the latest tree a couple of days ago.

Something is still wrong... I just downloaded the whole linux-mips
tree from the CVS (to avoid conflics with my local reporitory) and
after the commands:

   # make pb1100_defconfig
   # make

I get:

   arch/mips/mm/ioremap.c: In function `__ioremap':
   include/asm-mips/mach-au1x00/ioremap.h:15: sorry, unimplemented: inlinin=
g failed in call to '__fixup_bigphys_addr': function body not available
   arch/mips/mm/ioremap.c:28: sorry, unimplemented: called from here
   make[1]: *** [arch/mips/mm/ioremap.o] Error 1
   make: *** [arch/mips/mm] Error 2

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC29alQaTCYNJaVjMRAnI2AJ9vIhAHnIxKYovhNOueRA+CERCrvACdHldM
kTClGe9evDdiRnkS377oZaU=
=v0ub
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
