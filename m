Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 16:33:12 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([IPv6:::ffff:81.174.11.161]:62160 "EHLO
	zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8225313AbVGVPc5>; Fri, 22 Jul 2005 16:32:57 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DvzY5-0006Nt-00; Fri, 22 Jul 2005 17:34:53 +0200
Date:	Fri, 22 Jul 2005 17:34:53 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Clark Williams <williams@redhat.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Battery status
Message-ID: <20050722153453.GI21044@enneenne.com>
References: <20050722142205.GE21044@enneenne.com> <1122044036.10743.5.camel@riff> <20050722151402.GG21044@enneenne.com> <1122045924.10743.16.camel@riff>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UdiMmEj9EzJj2jSc"
Content-Disposition: inline
In-Reply-To: <1122045924.10743.16.camel@riff>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--UdiMmEj9EzJj2jSc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 22, 2005 at 10:25:24AM -0500, Clark Williams wrote:
> /me goes and actually *looks* at the acpi driver(s)

Ok. I see! :)

> I would recommend writing a completely separate driver that just
> provides the hook(s) to get to battery and any other info you want to
> provide. I did it on another platform (can't seem to find that code
> though) mainly to use the /proc/acpi/event interface and receive button
> presses and things like that. Something like a fake-acpi.c that various
> platform folks could use to translate their events into the acpi
> interface.=20

Yes, just file =ABarch/arm/kernel/apm.c=BB does regarding APM.

> That's kinda hokey now that I actually wrote it down and looked at it.
> Maybe what we need to do is put together a framework somewhat like the
> way acpi presents state information, but not called acpi (wouldn't want
> someone thinking that we'd ported the acpi interpreter to MIPS :). I'm
> not even sure if it should go into /proc or /sys.=20
>=20
> I just liked the fact that the event interface and the status interfaces
> were presented in somewhat logical fashion to user space, such that a
> shell script could be used to gather information or manipulate the state
> (e.g. 'echo 3 >/proc/acpi/sleep' to suspend to RAM).=20

Yes.

> Gah. Sorry, you were asking for an answer and I turned this into a
> design discussion. My opinion: if you're in a hurry, write a simple

Nonono. It's very interesting what you are saying!

> driver that presents a /proc interface to get to battery information.=20

Ok. Currently I have some time to spend on it... do you have any
suggestions about I can start developing it in the good way? :)

Thanks a lot,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--UdiMmEj9EzJj2jSc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC4RIdQaTCYNJaVjMRAs6pAKDORdvneM34oP0EQ9p9wtWYTeHqDgCfb0z0
9UxDnKMiAdnuuLvuyVy9ivU=
=WeCQ
-----END PGP SIGNATURE-----

--UdiMmEj9EzJj2jSc--
