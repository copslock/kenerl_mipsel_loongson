Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HI26025094
	for linux-mips-outgoing; Thu, 17 Jan 2002 10:02:06 -0800
Received: from ux3.sp.cs.cmu.edu (UX3.SP.CS.CMU.EDU [128.2.198.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HI1wP25090
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 10:01:59 -0800
Received: from GS256.SP.CS.CMU.EDU by ux3.sp.cs.cmu.edu id aa15824;
          17 Jan 2002 12:01 EST
Subject: Re: -O2 in gcc 2.96 buggy?
From: Justin Carlson <justincarlson@cmu.edu>
To: Torsten Weber <t.weber@hhi.de>
Cc: Linux MIPS <linux-mips@oss.sgi.com>
In-Reply-To: <3C46C2D5.F191DC26@hhi.de>
References: <3C46C2D5.F191DC26@hhi.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-7TIf4RcVnk6Fp0HnN+IP"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 17 Jan 2002 12:01:29 -0500
Message-Id: <1011286893.315.28.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-7TIf4RcVnk6Fp0HnN+IP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-01-17 at 07:25, Torsten Weber wrote:
> On a RedHat 7.1 installation I compiled gawk (3.1.0),  but gawk crashed
> (gawk couldn't run glibc-2.2.4/scripts/firstversions.awk, it resulted
> in:
>        > (FILENAME=3D- FNR=3D1) fatal error: internal error
>        > Aborted (core dumped)
> )
> The gawk problem disappeares if I compile without optimizing with -O2
> (i.e. optimizing with -O works).
>=20
> gcc version is 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1)
>=20
> Is this problem already known, or where is my mistake?
>=20

Often compiling with -O2 reveals actual bugs in the code of the program,
not the compiler.  For example, uninitialized variables can come out
differently depending on optimization level:

#include <stdlib.h>
#include <stdio.h>

int main()
{
        int foo;
        printf("Foo is %i\n", foo);
        return 0;
}

[justinca@gs256 ~]$ gcc -O0 foo.c -o foo
[justinca@gs256 ~]$ ./foo
Foo is -1073743180
[justinca@gs256 ~]$ gcc -O2 foo.c -o foo
[justinca@gs256 ~]$ ./foo
Foo is 1075157696


-Justin


--=-7TIf4RcVnk6Fp0HnN+IP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8RwNp47Lg4cGgb74RAuHEAJ9Q5WzYjMwo2BmPExcaw6rEeK1WYQCfVHkN
kbbjboFxKyhEvSIjoYfK7Gs=
=DbhC
-----END PGP SIGNATURE-----

--=-7TIf4RcVnk6Fp0HnN+IP--
