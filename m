Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6A6pYRw023403
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 9 Jul 2002 23:51:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6A6pY89023402
	for linux-mips-outgoing; Tue, 9 Jul 2002 23:51:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from myware.mynet (cpe-24-221-190-179.ca.sprintbbd.net [24.221.190.179])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6A6pNRw023393;
	Tue, 9 Jul 2002 23:51:24 -0700
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by myware.mynet (8.12.3/8.12.3) with ESMTP id g6A6v1rv025965;
	Tue, 9 Jul 2002 23:57:01 -0700
Subject: Re: PATCH: Fix SHMLBA for mips (Re: LTP testing (shmat01))
From: Ulrich Drepper <drepper@redhat.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Carsten Langgaard <carstenl@mips.com>, Ralf Baechle <ralf@oss.sgi.com>,
   Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sources.redhat.com>
In-Reply-To: <20020708112903.A14451@lucon.org>
References: <3D246924.542682B2@mips.com>
	<20020704193414.A29570@dea.linux-mips.net> <3D249181.D9147AAE@mips.com>
	<20020704215614.B29422@dea.linux-mips.net> <3D29CC6B.5090004@mvista.com>
	<20020708194539.C2758@dea.linux-mips.net> <3D29D65C.84630789@mips.com> 
	<20020708112903.A14451@lucon.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-SgIusYTMPIy4UteC3JRA"
X-Mailer: Ximian Evolution 1.0.7 (1.0.7-2) 
Date: 09 Jul 2002 23:57:01 -0700
Message-Id: <1026284222.25809.67.camel@myware.mynet>
Mime-Version: 1.0
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-SgIusYTMPIy4UteC3JRA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-07-08 at 11:29, H. J. Lu wrote:
> On Mon, Jul 08, 2002 at 08:13:48PM +0200, Carsten Langgaard wrote:
> > I have no preferences of the value of SHMLBA, as long as the define in
> > /usr/include/sys/shm.c and include/asm-mips/shmparam.h are in sync.
> >=20
> > /Carsten
> >=20
>=20
> How about this patch?

No.  As Roland said, define SHMLBA in the mips bits/shm.h file and
change sys/shm.h to define SHMLBA only if it wasn't defined before.

--=20
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

--=-SgIusYTMPIy4UteC3JRA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9K9q92ijCOnn/RHQRAgmoAKCWfZLBu34YhIokKeNzIL0nWyjcUwCZAcUj
gJk9ISBKbh7L2xBI0elTTD0=
=lYhQ
-----END PGP SIGNATURE-----

--=-SgIusYTMPIy4UteC3JRA--
