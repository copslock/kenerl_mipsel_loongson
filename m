Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fASEN8q21330
	for linux-mips-outgoing; Wed, 28 Nov 2001 06:23:08 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fASEMwo21312;
	Wed, 28 Nov 2001 06:22:58 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E29D8AA1; Wed, 28 Nov 2001 14:22:51 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id B55814125; Wed, 28 Nov 2001 14:13:39 +0100 (CET)
Date: Wed, 28 Nov 2001 14:13:39 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] const mips_io_port_base !?
Message-ID: <20011128141339.A5530@paradigm.rfc822.org>
References: <20011127010214.B21296@paradigm.rfc822.org> <20011127171544.A29424@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20011127171544.A29424@dea.linux-mips.net>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2001 at 05:15:44PM +1100, Ralf Baechle wrote:
> On Tue, Nov 27, 2001 at 01:02:14AM +0100, Florian Lohoff wrote:
>=20
> Blame whoever designed C that there is no sane way to give a variable an
> attribute like "will never change again after the first initalization thus
> keeping the value in a register beyond function calls and any other kind
> of memory barrier is ok".  This inconsistence merily achieves a better
> optimization of the code; the set_* function is intended to hide this cute
> little standard violation away ...

The problem is that it doesnt build without the patch:

mipsel-linux-gcc -I /home/mnt/mips/dec/linux/include/asm/gcc
-D__KERNEL__ -I/home/mnt/mips/dec/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -mcpu=3Dr4600
-mips2 -Wa,--trap -pipe    -DEXPORT_SYMTAB -c setup.c
Assembler messages:
Warning: The -mcpu option is deprecated.  Please use -march and -mtune
instead.
Warning: The -march option is incompatible to -mipsN and therefore
ignored.
setup.c:109: conflicting types for `mips_io_port_base'
/home/mnt/mips/dec/linux/include/asm/io.h:63: previous declaration of
`mips_io_port_base'
setup.c: In function `setup_arch':
setup.c:678: warning: unused variable `tmp'
setup.c:679: warning: unused variable `initrd_header'
make[1]: *** [setup.o] Error 1
make[1]: Leaving directory `/home/mnt/mips/dec/linux/arch/mips/kernel'
make: *** [_dir_arch/mips/kernel] Error 2
(flo@paradigm)/home/mnt/mips/dec/linux#=20

(flo@paradigm)/home/mnt/mips/dec/linux# mipsel-linux-gcc -v
Reading specs from /usr/local/lib/gcc-lib/mipsel-linux/3.0.2/specs
Configured with: ./configure --target=3Dmipsel-linux --enable-languages=3Dc
--disable-shared
Thread model: single
gcc version 3.0.2 20010825 (Debian prerelease)
(flo@paradigm)/home/mnt/mips/dec/linux# mipsel-linux-as --version
GNU assembler 2.11.92.0.10 Debian/GNU Linux
Copyright 2001 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms
of
the GNU General Public License.  This program has absolutely no
warranty.
This assembler was configured for a target of `mipsel-linux'.


--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8BOMDUaz2rXW+gJcRAl1FAKC27jFWAUwz37hgPqJC2WCmrw+KuQCfUfMp
JYeUk7EeRXsaaNi3SDwySB8=
=r3NA
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
