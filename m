Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 15:52:10 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:59874 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225313AbVGVOvy>;
	Fri, 22 Jul 2005 15:51:54 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6MErwTp028230;
	Fri, 22 Jul 2005 10:53:58 -0400
Received: from pobox.hsv.redhat.com (pobox.hsv.redhat.com [172.16.16.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6MErvV06816;
	Fri, 22 Jul 2005 10:53:57 -0400
Received: from riff.hsv.redhat.com (riff.hsv.redhat.com [172.16.16.120])
	by pobox.hsv.redhat.com (8.12.8/8.12.8) with ESMTP id j6MEruJG015731;
	Fri, 22 Jul 2005 10:53:57 -0400
Subject: Re: Battery status
From:	Clark Williams <williams@redhat.com>
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050722142205.GE21044@enneenne.com>
References: <20050722142205.GE21044@enneenne.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jIS/MOu1subX4z1HFMjy"
Date:	Fri, 22 Jul 2005 09:53:56 -0500
Message-Id: <1122044036.10743.5.camel@riff>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Return-Path: <williams@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: williams@redhat.com
Precedence: bulk
X-list: linux-mips


--=-jIS/MOu1subX4z1HFMjy
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-07-22 at 16:22 +0200, Rodolfo Giometti wrote:
> Hello,
>=20
> I'd like to implement a way to allow userspace to read battery status
> (or percentage).  I notice this port of APM interface for ARM
> architecture =ABarch/arm/kernel/apm.c=BB and I think I can use comething
> similar... what do you think about that?

You might want to look at how acpi is presented in the /proc interface.
You could hook your battery status routines into the acpi entries:

	/proc/acpi/battery/BAT0/{alarm,info,status}=20

Just a thought.

Clark

--=20
Clark Williams <williams@redhat.com>

--=-jIS/MOu1subX4z1HFMjy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC4QiEHyuj/+TTEp0RAoHYAJ0XLHUGXYg8ulcWu4oUW8XtR61htwCaAihJ
8ihg6EiYOVHVzWmihMPs/yY=
=RAaN
-----END PGP SIGNATURE-----

--=-jIS/MOu1subX4z1HFMjy--
