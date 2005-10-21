Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2005 14:29:10 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:16816 "EHLO
	zaigor.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133444AbVJUN2y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Oct 2005 14:28:54 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1ESwx3-000657-00
	for <linux-mips@linux-mips.org>; Fri, 21 Oct 2005 15:28:53 +0200
Resent-From: giometti@enneenne.com
Resent-Date: Fri, 21 Oct 2005 15:28:53 +0200
Resent-Message-ID: <20051021132853.GA23374@enneenne.com>
Resent-To: linux-mips@linux-mips.org
Date:	Fri, 21 Oct 2005 15:26:50 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	"Hamilton, Ian" <Ian.Hamilton@xerox.com>
Cc:	ppopov@embeddedalley.com, linnux-mips@linux-mips.org
Subject: Re: au1x00 usb device status
Message-ID: <20051021132650.GC26890@enneenne.com>
References: <DAF42D2FFC65A146BAB240719E4AD214C212B7@gbrwgceumf02.eu.xerox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E0GIYtSzp7Op5bZW"
Content-Disposition: inline
In-Reply-To: <DAF42D2FFC65A146BAB240719E4AD214C212B7@gbrwgceumf02.eu.xerox.net>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@enneenne.com
Precedence: bulk
X-list: linux-mips


--E0GIYtSzp7Op5bZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 21, 2005 at 02:12:17PM +0100, Hamilton, Ian wrote:
> We have code running under a 2.4 kernel working on this board, and I'm
> currently porting the code to a 2.6 kernel.
>=20
> The USB device port seems to work OK for us with the 2.4 kernel.

Are you implemented any Gadget support? Or are you just using the
tty/raw emulation?

> Rodolfo,
>=20
> Have you done any more work on this, or are you giving it up as a lost
> cause?

For the moment I sespended the developing in order to better
understand the timing problem, but I can restart immediately if some
new good news will came. :)

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--E0GIYtSzp7Op5bZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDWOyaQaTCYNJaVjMRAknlAKCMwsQnqeJziXVdWdH3eY74ZmQuWwCeOvuL
jrj6sSzN0VbE/Yw4eCFiDK0=
=fb0s
-----END PGP SIGNATURE-----

--E0GIYtSzp7Op5bZW--
