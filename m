Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 20:06:31 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:36513 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225357AbVGVTGN>;
	Fri, 22 Jul 2005 20:06:13 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6MJ8Im5012999;
	Fri, 22 Jul 2005 15:08:18 -0400
Received: from pobox.hsv.redhat.com (pobox.hsv.redhat.com [172.16.16.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6MJ8CV19251;
	Fri, 22 Jul 2005 15:08:12 -0400
Received: from riff.hsv.redhat.com (riff.hsv.redhat.com [172.16.16.120])
	by pobox.hsv.redhat.com (8.12.8/8.12.8) with ESMTP id j6MJ85JG023376;
	Fri, 22 Jul 2005 15:08:12 -0400
Subject: Re: Battery status
From:	Clark Williams <williams@redhat.com>
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050722153453.GI21044@enneenne.com>
References: <20050722142205.GE21044@enneenne.com>
	 <1122044036.10743.5.camel@riff> <20050722151402.GG21044@enneenne.com>
	 <1122045924.10743.16.camel@riff>  <20050722153453.GI21044@enneenne.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OtVtGhM1ub7kFKOg8O/c"
Date:	Fri, 22 Jul 2005 14:08:05 -0500
Message-Id: <1122059285.10743.30.camel@riff>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Return-Path: <williams@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: williams@redhat.com
Precedence: bulk
X-list: linux-mips


--=-OtVtGhM1ub7kFKOg8O/c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-07-22 at 17:34 +0200, Rodolfo Giometti wrote:
> > Gah. Sorry, you were asking for an answer and I turned this into a
> > design discussion. My opinion: if you're in a hurry, write a simple
>=20
> Nonono. It's very interesting what you are saying!
>=20

Ok, just remember: you asked for it! :)

> > driver that presents a /proc interface to get to battery information.=20
>=20
> Ok. Currently I have some time to spend on it... do you have any
> suggestions about I can start developing it in the good way? :)

I would start out deciding where the user-space interface would live. If
it were me, I'd probably create a /proc entry called <myplatform> (where
<myplatform> =3D=3D whatever mips platform you're using, e.g. malta4kc),
then put proc entries for whatevery you're interested in in there. For
example, I'd do battery like this:

	/proc/malta4kc/battery/{info,status}

So that if you cat the info entry, you'd get the make, model, capacity,
etc. If you cat the state entry, you'll get remaining charge, charging
state, discharge rate, etc. Anyway, that's good enough to start with and
if later you want to make it more generic, you can get more opinions on
where it should live in the filesystem.

Then, I'd go look at some driver modules that manage /proc entries (like
the acpi stuff). To start with I'd put a skeleton in place that
responded with fixed values, then write up some underlying routines to
actually grab stuff from the battery in response to a read from
the /proc entry.

What platform are you doing this for?

Clark

--=20
Clark Williams <williams@redhat.com>

--=-OtVtGhM1ub7kFKOg8O/c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC4UQVHyuj/+TTEp0RAquFAJ91BiNsN3URTRC6mHs5Ws+e1MQicwCcDX7u
6/Yufzh/QbUaXU5+glLH30M=
=nbay
-----END PGP SIGNATURE-----

--=-OtVtGhM1ub7kFKOg8O/c--
