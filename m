Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2003 15:59:22 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:4482
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8224861AbTDQO7V>; Thu, 17 Apr 2003 15:59:21 +0100
Received: (qmail 14272 invoked by uid 502); 17 Apr 2003 14:59:11 -0000
Date: Thu, 17 Apr 2003 07:59:11 -0700
From: ilya@theIlya.com
To: Bruno Randolf <bruno.randolf@4g-systems.de>
Cc: linux-mips@linux-mips.org
Subject: Re: insmod segfault
Message-ID: <20030417145911.GC4485@gateway.total-knowledge.com>
References: <200304171329.37998.bruno.randolf@4g-systems.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <200304171329.37998.bruno.randolf@4g-systems.de>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I think you have to add -DMODULE when compiling soemthing as module...

On Thu, Apr 17, 2003 at 01:29:33PM +0200, Bruno Randolf wrote:
Content-Description: clearsigned data
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> hello!
>=20
> i have problems with a kernel module: when i insmod it, i get a segmentat=
ion=20
> fault and "Unable to handle kernel paging request at virtual address=20
> 00000004" oops, so as far as i understand it, it seems like relocation do=
es=20
> not occur properly.
>=20
> i can reproduce the problem with the attached simple test code. when i in=
smod=20
> only hello_module.o it works fine, but when i insmod the result of "ld"=
=20
> (mod.o) i get the error. so it seems the problem is with the linker. or a=
m i=20
> using wrong compiler / linker flags or doing something stupid?
>=20
> i compile with "gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer=20
> - -fno-strict-aliasing -mno-abicalls -G 0 -fno-pic -mcpu=3Dr4600 -mips2=
=20
> - -Wa,--trap -pipe -mlong-calls -I/usr/src/linux/include -O3 -D__KERNEL__=
=20
> - -DLINUX -DMESSAGES"
>=20
> and link with "ld -r -o mod.o hello_module.o b.o"
>=20
> versions:
> * au1500 CPU
> * kernel version 2.4.21-pre4 from cvs
> * gcc version 3.0.4 (also: gcc version 2.95.4)
> * GNU ld version 2.12.90.0.1 20020307 Debian/GNU Linux
> * insmod version 2.4.15
>=20
> objdump -x mod.o says:
>=20
> - ---
>=20
> mod.o:     file format elf32-tradlittlemips
> mod.o
> architecture: mips:6000, flags 0x00000011:
> HAS_RELOC, HAS_SYMS
> start address 0x00000000
> private flags =3D 10001001: [abi=3DO32] [mips2] [not 32bitmode]
>=20
> Sections:
> Idx Name          Size      VMA               LMA               File off =
 Algn
>   0 .reginfo      00000018  00000000  00000000  00000034  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_SAME_S=
IZE
>   1 .text         00000070  00000000  00000000  00000050  2**4
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>   2 .rodata       00000030  00000000  00000000  000000c0  2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   3 .modinfo      0000001c  00000000  00000000  000000f0  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   4 .data         00000000  00000000  00000000  00000110  2**4
>                   CONTENTS, ALLOC, LOAD, DATA
>   5 .sbss         00000000  00000000  00000000  00000110  2**0
>                   ALLOC
>   6 .bss          00000000  00000000  00000000  00000110  2**4
>                   ALLOC
>   7 .comment      00000024  00000000  00000000  00000110  2**0
>                   CONTENTS, READONLY
>   8 .pdr          00000040  00000000  00000000  00000134  2**2
>                   CONTENTS, RELOC, READONLY
> SYMBOL TABLE:
> 00000000 l    d  .reginfo       00000000
> 00000000 l    d  .text  00000000
> 00000000 l    d  *ABS*  00000000
> 00000000 l    d  *ABS*  00000000
> 00000000 l    d  .rodata        00000000
> 00000000 l    d  .modinfo       00000000
> 00000000 l    d  .data  00000000
> 00000000 l    d  .sbss  00000000
> 00000000 l    d  .bss   00000000
> 00000000 l    d  .comment       00000000
> 00000000 l    d  .pdr   00000000
> 00000000 l    d  *ABS*  00000000
> 00000000 l    d  *ABS*  00000000
> 00000000 l    d  *ABS*  00000000
> 00000000 l    d  *ABS*  00000000
> 00000000 l    d  *ABS*  00000000
> 00000000 l    df *ABS*  00000000 hello_module.c
> 00000000 l     O .modinfo       0000001b __module_kernel_version
> 00000000 l    df *ABS*  00000000 b.c
> 00000004 g     O .scommon       00000004 b
> 00000038 g     F .text  00000000 cleanup_module
> 00000000 g     F .text  00000000 init_module
> 00000000         *UND*  00000000 printk
> 00000004 g     O .scommon       00000004 glob_int
>=20
>=20
> RELOCATION RECORDS FOR [.text]:
> OFFSET   TYPE              VALUE
> 00000008 R_MIPS_HI16       .rodata
> 0000000c R_MIPS_LO16       .rodata
> 00000010 R_MIPS_HI16       printk
> 00000014 R_MIPS_LO16       printk
> 00000028 R_MIPS_HI16       glob_int
> 0000002c R_MIPS_LO16       glob_int
> 00000040 R_MIPS_HI16       .rodata
> 00000044 R_MIPS_LO16       .rodata
> 00000048 R_MIPS_HI16       printk
> 0000004c R_MIPS_LO16       printk
>=20
>=20
> RELOCATION RECORDS FOR [.pdr]:
> OFFSET   TYPE              VALUE
> 00000000 R_MIPS_32         init_module
> 00000020 R_MIPS_32         cleanup_module
>=20
> - ---
>=20
> thanks for any hints.
>=20
> btw: this issue is not related to the one i posted about before ("au1500m=
m=20
> problems") - which is resolved already and was caused by a wrong=20
> initialization of the dual PHY ethernet hardware.
>=20
> bruno
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
>=20
> iD8DBQE+npAhfg2jtUL97G4RAu5qAJ4xWO8tpPYTCTkcWzkIn3D2ylhAhQCgo2As
> dAXSGorKOTB9E6C1r3I1WEU=3D
> =3D2wA9
> -----END PGP SIGNATURE-----





--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+nsE/7sVBmHZT8w8RAv9wAJ0cQ8ZvBIB+NBxc4n5KK1uC+Q8TIACg2cZ2
qrQtV0V0VtCDya5IAvEAp18=
=cA0Z
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
