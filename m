Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BErIp10011
	for linux-mips-outgoing; Mon, 11 Feb 2002 06:53:18 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BEr9910008
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 06:53:09 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E0F4984C; Mon, 11 Feb 2002 14:52:46 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 253384292; Mon, 11 Feb 2002 14:53:02 +0100 (CET)
Date: Mon, 11 Feb 2002 14:53:02 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
Message-ID: <20020211135302.GB30314@paradigm.rfc822.org>
References: <20020209150155.GA853@paradigm.rfc822.org> <Pine.GSO.3.96.1020211134516.18917A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020211134516.18917A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2002 at 01:51:47PM +0100, Maciej W. Rozycki wrote:
> On Sat, 9 Feb 2002, Florian Lohoff wrote:
>=20
> > i just stumbled when i tried to compile a program (bootloader) with
> > gcc which uses varargs. I got the error that "sgidefs.h" was missing.
> > sgidefs.h is contained in the glibc which gets included by va-mips.h
> > from stdarg.h - I dont think this is correct as i should be able
> > to compile programs without glibc.
>=20
>  Hmm, in 2.95.3 in va-mips.h I see:=20
>=20
> /* Get definitions for _MIPS_SIM_ABI64 etc.  */
> #ifdef _MIPS_SIM
> #include <sgidefs.h>
> #endif
>=20
> so you shouldn't need sgidefs.h normally.  Or did something get broken for
> 3.x?

revamp:/tmp/arcboot-0.2# make
cd arclib; make all
make[1]: Entering directory `/tmp/arcboot-0.2/arclib'
cc -O -Werror -Wall -mno-abicalls -G 0 -fno-pic    -c -o arc.o arc.c
cc -O -Werror -Wall -mno-abicalls -G 0 -fno-pic    -c -o stdio.o stdio.c
In file included from
/usr/lib/gcc-lib/mips-linux/2.95.4/include/stdarg.h:27,
                 from stdio.h:8,
                 from stdio.c:7:
/usr/lib/gcc-lib/mips-linux/2.95.4/include/va-mips.h:89: sgidefs.h: No
such file or directory
make[1]: *** [stdio.o] Error 1
make[1]: Leaving directory `/tmp/arcboot-0.2/arclib'
make: *** [all] Error 2

revamp:/tmp/arcboot-0.2# gcc -v
Reading specs from /usr/lib/gcc-lib/mips-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)

revamp:/tmp/arcboot-0.2# vi /usr/lib/gcc-lib/mips-linux/2.95.4/include/va-m=
ips.h
[...]
     87 /* Get definitions for _MIPS_SIM_ABI64 etc.  */
     88 #ifdef _MIPS_SIM
     89 #include <sgidefs.h>
     90 #endif
[...]

I just saw it - I cant explain it ...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Z8y9Uaz2rXW+gJcRAgIGAKDePhcd7reW8Dgat1jApOHOhfDbmgCgp69G
urxYbdizNiUq1X7NqkuX50I=
=Cfob
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
