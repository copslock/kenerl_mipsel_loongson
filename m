Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2005 13:15:19 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([IPv6:::ffff:81.174.11.161]:43432 "EHLO
	zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8225249AbVGWMPD>; Sat, 23 Jul 2005 13:15:03 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DwIw8-0001sp-00; Sat, 23 Jul 2005 14:17:00 +0200
Date:	Sat, 23 Jul 2005 14:17:00 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Clark Williams <williams@redhat.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Battery status
Message-ID: <20050723121700.GK21044@enneenne.com>
References: <20050722142205.GE21044@enneenne.com> <1122044036.10743.5.camel@riff> <20050722151402.GG21044@enneenne.com> <1122045924.10743.16.camel@riff> <20050722153453.GI21044@enneenne.com> <1122059285.10743.30.camel@riff>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L977DYpOHGH1NqKf"
Content-Disposition: inline
In-Reply-To: <1122059285.10743.30.camel@riff>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--L977DYpOHGH1NqKf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 22, 2005 at 02:08:05PM -0500, Clark Williams wrote:
> I would start out deciding where the user-space interface would live. If
> it were me, I'd probably create a /proc entry called <myplatform> (where
> <myplatform> =3D=3D whatever mips platform you're using, e.g. malta4kc),
> then put proc entries for whatevery you're interested in in there. For
> example, I'd do battery like this:
>=20
> 	/proc/malta4kc/battery/{info,status}

But, doing like this you break userland compatibility... I'd like use
already written code for battery management, not write new one. :)

> So that if you cat the info entry, you'd get the make, model, capacity,
> etc. If you cat the state entry, you'll get remaining charge, charging
> state, discharge rate, etc. Anyway, that's good enough to start with and
> if later you want to make it more generic, you can get more opinions on
> where it should live in the filesystem.

I see. However I think is better implement =ABstandard=BB files like:

   /proc/acpi/battery/BATT/{alarm, info, state}

> Then, I'd go look at some driver modules that manage /proc entries (like
> the acpi stuff). To start with I'd put a skeleton in place that
> responded with fixed values, then write up some underlying routines to
> actually grab stuff from the battery in response to a read from
> the /proc entry.
>=20
> What platform are you doing this for?

A custum board based on Alchemy Au1100.

However I've already ported the file =ABarch/arm/kernel/apm.c=BB for non
i386 architectures and it seems working good. :) Even if it implements
APM features.

Now I'll do some tests with userland code (GPE) and after that I'll
consider if I have to start with ACPI also.

Thanks a lot for your suggestion! Hope to send you a patch as soon as
possible.

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--L977DYpOHGH1NqKf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC4jU8QaTCYNJaVjMRAu+5AJ435ytBp9dSz3S6j0RwaTSIfkj+7gCfRMGT
siBkismpuBR79l3IouSv6K8=
=Tuz+
-----END PGP SIGNATURE-----

--L977DYpOHGH1NqKf--
