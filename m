Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 15:41:14 +0100 (BST)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:40609 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8226872AbVGSOkv>;
	Tue, 19 Jul 2005 15:40:51 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id 5154CF0078; Tue, 19 Jul 2005 16:42:30 +0200 (CEST)
Date:	Tue, 19 Jul 2005 16:42:30 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	linux-mips@linux-mips.org
Subject: Re: Updating RTC with date command
Message-ID: <20050719144230.GE20065@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <CBD77117272E1249BFDC21E33D555FDC06018D@dbde01.ent.ti.com> <20050719143110.GD3108@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <20050719143110.GD3108@linux-mips.org>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-07-19 10:31:10 -0400, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jul 19, 2005 at 03:34:01PM +0530, Nori, Soma Sekhar wrote:
> > However, when I try to update the time using date -s <time string>=20
> > the RTC does not get updated. (shows the old time when I boot-up again)

Right, expected. date -s  sets the time of the running system, not the
system's HW time.

> > In arch\mips\kernel\time.c the timer_interrupt calls rtc_set_mmss,
> > but that call is made only when STA_UNSYNC is _not_ set in time_status
> > variable. do_settimeofday/sys_stime _set_ this flag so the timer=20
> > interrupt does not call rtc_set_mmss. =09

Right. HW clock updating is somewhat supposed to work IFF ntp is
running.

> > Can somebody please help me understand how the RTC is supposed to be
> > updated after user changes the time using the date command?
>=20
> Not at all.  Try man hwclock.

hwclock is the userspace utility to manually once set the time. In
normal operation, this should only be called _once_, after the system is
switched on for the very first time.

During lifetime, ntpd should execute and thus the system's current time
will be written to the HW clock every now and then. Additionally, most
distributions seem to also update the HW clock at system shutdown time.

So the correct solution to your problem is to either shutdown once
(workaround) or keep ntpd running (the solution[tm]).

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC3RFWHb1edYOZ4bsRAjQ+AJ4krygs9PqCkNdxEgfUiTZV3Au4WwCgjUrr
yJIMZ8CnATfboZAjak1yIDU=
=aS7c
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
