Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 23:59:08 +0100 (BST)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:29352 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8226909AbVGSW6t>;
	Tue, 19 Jul 2005 23:58:49 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id 614FDF0071; Wed, 20 Jul 2005 01:00:32 +0200 (CEST)
Date:	Wed, 20 Jul 2005 01:00:32 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	linux-mips@linux-mips.org
Subject: Re: Updating RTC with date command
Message-ID: <20050719230032.GB24635@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <CBD77117272E1249BFDC21E33D555FDC06018D@dbde01.ent.ti.com> <20050719143110.GD3108@linux-mips.org> <20050719144230.GE20065@lug-owl.de> <Pine.LNX.4.61L.0507191555360.10363@blysk.ds.pg.gda.pl> <20050719152008.GG20065@lug-owl.de> <Pine.LNX.4.61L.0507191645510.10363@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507191645510.10363@blysk.ds.pg.gda.pl>
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
X-archive-position: 8568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--s9fJI615cBHmzTOP
Content-Type: multipart/mixed; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-07-19 17:40:48 +0100, Maciej W. Rozycki <macro@linux-mips.org>=
 wrote:
> On Tue, 19 Jul 2005, Jan-Benedict Glaw wrote:
> > >  Note that ntpd only updates minutes and seconds and then only if the=
=20
> > > difference is small -- to account for the existence of time zones and=
 a=20
> > > system-specific relation between the time recoreded by the system and=
 one=20
> > > handled by the RTC.  Also the feature is broken by design -- ntpd=20
> > > shouldn't do that at all in principle and in practice it leads to the=
=20
> > > system time being corrupted on some machines using an RTC interrupt f=
or=20
> > > the system timer tick.
> >=20
> > Aren't we expected to keep UTC time inside the HW clock? So there's no
>=20
>  It's a good idea, but whether it's feasible or not is unfortunately=20
> system-specific.

The base year may change, but for the rest, aren't there Windows boxes
on one hand (using local time in RTC) and all other OSses using UTC in
there?

> > problem with timezones.  Also, if your timer interrupt source it that
> > broken that ntpd cannot track it, then you're having more servere
> > problems...
>=20
>  Huh?  The time source is correct if let to run freely, but modifying the=
=20
> time stored in RTC may disturb it.  This is e.g. the case with the=20
> Motorola MC146818 and its clones which are rather common chips -- any=20
> system using their periodic interrupt for the system clock tick suffers=
=20
> from this problem.

The main problem is that there are several time sources in a modern
machine, and these are somewhat unsynchronized. Pick one and correct it,
the others will look fucked up. ...or keep correcting them all. There's
just a difference of usage. Some time sources are used only every now
and then (like the HW clock), others all the time (like the calculated
time, tick'ed by the timer interrupt) or only in very specific
situations (in-processor cycle counters). Some systems won't even
generate timer interrupts at all, but always ask specific hardware
whenever a timestamp is needed.

What I care most about is that there's a well-behaving time being
returned by time() or gettimeofday(), usually generated (on PeeCees)
=66rom the timer interrupt.  This should be corrected to be as good as
possible, usually through the help of ntpd.

The long-term time sources (like the HW clock) should be updated, too,
but it's contents only needs to be correct any now and then; for sure,
there isn't such a high need for strong monotony as there is in the
gettimeofday() interface. Thus, updating it every 11 minutes from the
system time IFF it's properly sync'ed seems reasonable to me. For sure,
I don't want a bad time being written to it. Maybe it would be wise to
have a "last known-good time" timestamp for it, though, to refuse using
it IFF it's a clock suspected to be horribly wrong (like the famous
146818)...

>  Something has to preserve the clock across reboots and power-offs. =20
> Which of the sources is to be trusted more is a matter of a local policy=
=20
> and neither the kernel nor tools should force any particular one.

You're right on this, but keep in mind that some machines don't rely on
a RTC at all. They ask you to enter current time+date manually and will
try to sync it with a better time source some time later.

> > I do trust ntpd, but do I trust someone who looks at it's watch?
>=20
>  Well, I do trust myself ultimately...

/* No comment on this :-)  */

>  If ntpd has been running with a good reference it must have disciplined=
=20
> the system clock, so it should have a smaller drift than the RTC.  So it=
=20
> should be safe to store the former into the latter at a shutdown (but=20
> that's a policy).  Otherwise nothing can be told about both clocks and th=
e=20
> system's administrator should decide.  In the end I think the decision=20
> should be left up to the administrator in all cases.

With "modern" RTCs, even disciplining them isn't easy. Ever kept an eye
on the frequency value? Depending on your mainboard's quality, you may
use it as a quite precise thermometer... Link the attached script into
your /etc/munin/plugins/ and have fun :)

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

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=local-ntp_frequency

#!/bin/sh

export PATH=/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin:$PATH

case "$1" in
	autoconf)
		echo no
		;;
	config)
		echo 'graph_title NTP frequency'
		echo 'graph_vlabel freq'
		echo 'graph_category NTP'
		echo 'graph_info This graph shows the frequency (mis-clocking) of the local timer source.'
		echo 'graph_scale no'
		echo 'frequency.label Frequency'
		echo 'frequency.info Current Frequency.'
		;;
	*)
		FREQUENCY="`echo rv | ntpq -n | tr ',' $'\n' | grep freq | cut -f 2 -d '='`"
		echo "frequency.value ${FREQUENCY}"
		;;
esac

exit 0


--0eh6TmSyL6TZE2Uz--

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC3YYQHb1edYOZ4bsRAu1IAKCQUEGrspnk5EQXpnKY4k8i4CxcqwCcD3SI
b5AXMp47fA1vH5XRTdfeGHY=
=0Dey
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
