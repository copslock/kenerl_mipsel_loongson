Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 05:14:29 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:20613
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225206AbTFBEO1>; Mon, 2 Jun 2003 05:14:27 +0100
Received: (qmail 21658 invoked by uid 502); 2 Jun 2003 04:14:24 -0000
Date: Sun, 1 Jun 2003 21:14:24 -0700
From: ilya@theIlya.com
To: wesolows@foobazco.org
Cc: linux-mips@linux-mips.org
Subject: Yet another fix
Message-ID: <20030602041424.GG3035@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am not sure this is correct solution to a problem. Or rather, I'm pretty
sure it is incorrect one.. There is a reference to module_map somewhere, ho=
wever
it is not inculded if modules are disabled. Here is sorta fix

Index: include/asm-mips64/module.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/include/asm-mips64/module.h,v
retrieving revision 1.5
diff -u -r1.5 module.h
--- include/asm-mips64/module.h 1 Jun 2003 00:39:15 -0000       1.5
+++ include/asm-mips64/module.h 2 Jun 2003 03:59:23 -0000
@@ -11,4 +11,8 @@
 #define Elf_Sym Elf32_Sym
 #define Elf_Ehdr Elf32_Ehdr
=20
+#ifndef CONFIG_MODULES
+#define module_map(x) vmalloc(x)
+#endif
+
 #endif /* _ASM_MODULE_H */


--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+2s8f7sVBmHZT8w8RAmu8AKCG5kHyIx57QuAmgWu8tacj0k5ZNQCgrY8e
p+5y0ft3qvM6DZsX1Awauqg=
=+mNz
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--
