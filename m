Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 15:24:34 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:49627 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133728AbWC2OYY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Mar 2006 15:24:24 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FObj1-0003SR-Vl; Wed, 29 Mar 2006 16:32:44 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FObmC-0008MI-0Q; Wed, 29 Mar 2006 16:36:00 +0200
Date:	Wed, 29 Mar 2006 16:36:00 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	dan@embeddededge.com
Cc:	Linux MIPS <linux-mips@linux-mips.org>
Message-ID: <20060329143559.GS10460@enneenne.com>
References: <20051216153203.GK14341@gundam.enneenne.com> <43A2EBC9.5040502@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+epxrXWOh++2HLjY"
Content-Disposition: inline
In-Reply-To: <43A2EBC9.5040502@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: Freezing & Unfreezing the au11000
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--+epxrXWOh++2HLjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2005 at 07:31:05PM +0300, Sergei Shtylylov wrote:
> Rodolfo Giometti wrote:
>=20
> >in order to restore the scratch registers contents as descibed into
> >file "linux/arch/mips/au1000/common/sleeper.S":
>=20
>    If you're talking about 2.6, the code in that file seems very incorrec=
t=20
>    in regard to how it deals wiht the stack frame, since it effectively=
=20
> trashes regs $1 and $2 reusing their slots for saving CP0 Status and=20
> Context regs. 2.4 branch has more sane variant.

I'm trying to use code into sleeper.S from kernel 2.4 but I still have
a problem. The system corrctly wake up and linux restart but the
problem is that after about 600-800mS the system hangs! I've just the
time to press 2 or three times the enter key and see the console
prompt.

I've checked also the interrupts from TOY and I noticed that it stop
working!

Has anybody used the sleep mode for Au1xxx processor? Which version of
sleeper.S file has been used?

Thanks in advance,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--+epxrXWOh++2HLjY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEKptPQaTCYNJaVjMRAsVKAJ9375dPyS2RfUsL/RVAIhJ5SwOQwwCgjmRR
PTKgiOUTFmNLm1+v/uAF4Gs=
=mrwU
-----END PGP SIGNATURE-----

--+epxrXWOh++2HLjY--
