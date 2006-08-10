Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2006 14:30:00 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:51394 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20043421AbWHJN36 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Aug 2006 14:29:58 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GB9cM-0007Y8-5p; Thu, 10 Aug 2006 14:26:30 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1GBAcn-0001uL-AJ; Thu, 10 Aug 2006 15:31:01 +0200
Date:	Thu, 10 Aug 2006 15:31:01 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Message-ID: <20060810133101.GY342@enneenne.com>
References: <20060809210927.GD13145@enneenne.com> <44DB31FB.8010806@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hNtiuZBcYkRjyNT4"
Content-Disposition: inline
In-Reply-To: <44DB31FB.8010806@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: [PATCH] 3/7 AU1100 MMC support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--hNtiuZBcYkRjyNT4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2006 at 05:17:47PM +0400, Sergei Shtylyov wrote:
>=20
>    I guess the MMC patches should go to the appropriate maintainer, Russe=
l=20
> King <rmk+mmc@arm.linux.org.uk>.

Ok, I'll send them to him too.

>    Could also use pr_debug() here. If DEBUG is #defined, it'll print what=
=20
>    you need, if not then no.

I see, but I'd prefere connect these messages with CONFIG_MMC_DEBUG...

>    Are you sure KERN_DEBUG fits best for error messages, not KERN_ERR?

Yes. You are right. Fixed. :)

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--hNtiuZBcYkRjyNT4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFE2zUVQaTCYNJaVjMRAld/AKCwSaZU8sK2dNn73WNWGhakVmLNYACdFP56
i9bNhWw38BMWHath5kpAxM0=
=uIrZ
-----END PGP SIGNATURE-----

--hNtiuZBcYkRjyNT4--
