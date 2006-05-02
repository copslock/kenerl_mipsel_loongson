Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 13:24:10 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:5863 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133706AbWEBMXk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 May 2006 13:23:40 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1Fatsx-0005vQ-00; Tue, 02 May 2006 14:21:47 +0200
Date:	Tue, 2 May 2006 14:21:47 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	Freddy Spierenburg <freddy@dusktilldawn.nl>,
	linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: trouble on serial console for au1100
Message-ID: <20060502122147.GB20543@gundam.enneenne.com>
References: <20060427154948.GI32278@enneenne.com> <20060428111933.GY11097@dusktilldawn.nl> <20060428171923.GG3314@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <20060428171923.GG3314@cosmic.amd.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2006 at 11:19:23AM -0600, Jordan Crouse wrote:
>=20
> CCing the serial list too.  It could use more testing, but this seems
> like it might be the answer to the myriad of serial issues that have=20
> been reported in the last month or so.=20
>=20
> I'm ashamed to admit I have no idea if this patch is even in the system or
> not.  If not, I'm sure somebody
> can clean it up and send it in the proper style.

Here:

   http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-au1x00-seria=
l-fix

the patch against =ABlinux-2.6.16-stable=BB branch for serial support
tested with an au1100 based board.

Here:

   http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-au1x00-seria=
l-real-interrupt

my suggestion to get real interrupts from the serial line (I have
redefined the function =ABis_real_interrupt()=BB for the au1x00 CPUs into
the platform =ABserial.h=BB file).

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEV07bQaTCYNJaVjMRAo7nAKCycQAd19UVDR7mQvyXlrZ26QrJPQCcCjNp
ZVB8gE1hN5SzzEpV9nxZre0=
=GIkD
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
