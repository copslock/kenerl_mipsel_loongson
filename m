Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 09:12:11 +0100 (BST)
Received: from p508B6D44.dip.t-dialin.net ([IPv6:::ffff:80.139.109.68]:47001
	"EHLO p508B6D44.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225211AbTFBILs>; Mon, 2 Jun 2003 09:11:48 +0100
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:30341
	"HELO gateway.total-knowledge.com") by linux-mips.net with SMTP
	id <S868881AbTFBE6G>; Mon, 2 Jun 2003 06:58:06 +0200
Received: (qmail 16324 invoked by uid 502); 2 Jun 2003 04:57:00 -0000
Date: Sun, 1 Jun 2003 21:57:00 -0700
From: ilya@theIlya.com
To: linux-mips@linux-mips.org
Subject: Re: Yet another fix
Message-ID: <20030602045700.GI3035@gateway.total-knowledge.com>
References: <20030602041424.GG3035@gateway.total-knowledge.com> <13249.1054529364@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v2/QI0iRXglpx0hK"
Content-Disposition: inline
In-Reply-To: <13249.1054529364@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--v2/QI0iRXglpx0hK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

module_map is referenced in register_ioctl32_conversion in arch/mips64/ioct=
l32.c
As far as I can see, it should simply be possible to replace module_map
with vmalloc in there, but I am not sure, as I don't know how exactly
ioctl translations work...

On Mon, Jun 02, 2003 at 02:49:24PM +1000, Keith Owens wrote:
> On Sun, 1 Jun 2003 21:14:24 -0700,=20
> ilya@theIlya.com wrote:
> >I am not sure this is correct solution to a problem. Or rather, I'm pret=
ty
> >sure it is incorrect one.. There is a reference to module_map somewhere,=
 however
> >it is not inculded if modules are disabled. Here is sorta fix
> >
> >Index: include/asm-mips64/module.h
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >RCS file: /home/cvs/linux/include/asm-mips64/module.h,v
> >retrieving revision 1.5
> >diff -u -r1.5 module.h
> >--- include/asm-mips64/module.h 1 Jun 2003 00:39:15 -0000       1.5
> >+++ include/asm-mips64/module.h 2 Jun 2003 03:59:23 -0000
> >@@ -11,4 +11,8 @@
> > #define Elf_Sym Elf32_Sym
> > #define Elf_Ehdr Elf32_Ehdr
> >=20
> >+#ifndef CONFIG_MODULES
> >+#define module_map(x) vmalloc(x)
> >+#endif
> >+
> > #endif /* _ASM_MODULE_H */
>=20
> That fix is incorrect.  There should be no references to module_map
> when CONFIG_MODULES=3Dn.  Please find out where module_map is being
> incorrectly used and fix that code.
>=20

--v2/QI0iRXglpx0hK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+2tkc7sVBmHZT8w8RArEMAJ9Om3f1EdOliQH3/y5rlMWMHtCxdgCfQlFK
pLyc/tfO0TxNVBHaL4H2nug=
=84+t
-----END PGP SIGNATURE-----

--v2/QI0iRXglpx0hK--
