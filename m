Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 13:23:24 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:5351 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133496AbWEBMXP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 May 2006 13:23:15 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1FatuE-0005vj-00; Tue, 02 May 2006 14:23:06 +0200
Date:	Tue, 2 May 2006 14:23:06 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Michele Carla` <goldfinger@member.fsf.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: ip27 not working
Message-ID: <20060502122306.GC20543@gundam.enneenne.com>
References: <1146567955.3112.5.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <1146567955.3112.5.camel@localhost>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2006 at 01:05:55PM +0200, Michele Carla` wrote:
> Yesterday I have tried last 2.6 from git on a Origin-2000, I have
> xcompiled it with gcc-3.4, and booted it via tftpd with:
> "bootp(): console=3DttyS0 root=3D/dev/sda1", but after downloading the
> kernel, it doesn't print anything and freeze ! any idea ?

Maybe you have my same (old) problem. Please, consider to take a look
at thread =ABtrouble on serial console for au1100=BB.

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEV08qQaTCYNJaVjMRAjILAJ9m5aQRWjeqc40i3AK6516FjugzLQCbB/6o
/4rVj3xh12amYnX9A4hUDuI=
=g8/q
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
