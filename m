Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 22:08:33 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:56037 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225388AbVGVVIS>;
	Fri, 22 Jul 2005 22:08:18 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6MLANaD016737;
	Fri, 22 Jul 2005 17:10:23 -0400
Received: from pobox.hsv.redhat.com (pobox.hsv.redhat.com [172.16.16.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6MLAHV23419;
	Fri, 22 Jul 2005 17:10:17 -0400
Received: from riff.hsv.redhat.com (riff.hsv.redhat.com [172.16.16.120])
	by pobox.hsv.redhat.com (8.12.8/8.12.8) with ESMTP id j6MLAGJG027011;
	Fri, 22 Jul 2005 17:10:17 -0400
Subject: Re: Battery status
From:	Clark Williams <williams@redhat.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Rodolfo Giometti <giometti@linux.it>, linux-mips@linux-mips.org
In-Reply-To: <20050722191732.GB3770@linux-mips.org>
References: <20050722142205.GE21044@enneenne.com>
	 <1122044036.10743.5.camel@riff>  <20050722191732.GB3770@linux-mips.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LFd7Ps2KMVCcfkifU55B"
Date:	Fri, 22 Jul 2005 16:10:16 -0500
Message-Id: <1122066616.10743.33.camel@riff>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Return-Path: <williams@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: williams@redhat.com
Precedence: bulk
X-list: linux-mips


--=-LFd7Ps2KMVCcfkifU55B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-07-22 at 15:17 -0400, Ralf Baechle wrote:
> On Fri, Jul 22, 2005 at 09:53:56AM -0500, Clark Williams wrote:
>=20
> > > I'd like to implement a way to allow userspace to read battery status
> > > (or percentage).  I notice this port of APM interface for ARM
> > > architecture =ABarch/arm/kernel/apm.c=BB and I think I can use cometh=
ing
> > > similar... what do you think about that?
> >=20
> > You might want to look at how acpi is presented in the /proc interface.
> > You could hook your battery status routines into the acpi entries:
> >=20
> > 	/proc/acpi/battery/BAT0/{alarm,info,status}=20
> >=20
> > Just a thought.
>=20
> Forget it.  One of the great advantages of MIPS is that Intel has ACPI.
> On the open Richter scale for stupidity ACPI in computing is a 9.8.

I never said that I liked ACPI, just that I liked the /proc interface.
I'm not really a fan of putting an interpreter into the system
firmware...

Clark

--=20
Clark Williams <williams@redhat.com>

--=-LFd7Ps2KMVCcfkifU55B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC4WC4Hyuj/+TTEp0RArDiAJ95wcICWXXeNUDRBPeLUB8bFa4xewCfa6r1
SE5vYtPODtkydAa/UOQpm8I=
=z/yp
-----END PGP SIGNATURE-----

--=-LFd7Ps2KMVCcfkifU55B--
