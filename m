Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 05:18:19 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:21381
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225206AbTFBESR>; Mon, 2 Jun 2003 05:18:17 +0100
Received: (qmail 21792 invoked by uid 502); 2 Jun 2003 04:18:15 -0000
Date: Sun, 1 Jun 2003 21:18:15 -0700
From: ilya@theIlya.com
To: linux-mips@linux-mips.org
Subject: Lost patch?
Message-ID: <20030602041815.GH3035@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This seems like an error to me:

Index: include/asm-mips64/pgtable.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/include/asm-mips64/pgtable.h,v
retrieving revision 1.80
diff -u -r1.80 pgtable.h
--- include/asm-mips64/pgtable.h        1 Jun 2003 08:24:04 -0000       1.80
+++ include/asm-mips64/pgtable.h        2 Jun 2003 03:59:24 -0000
@@ -255,9 +255,8 @@
 #define pfn_pte(pfn, prot)     __pte(((pfn) << PAGE_SHIFT) | pgprot_val(pr=
ot))
 #else
=20
-#define pte_page(x) ( NODE_MEM_MAP(PHYSADDR_TO_NID(pte_val(x))) +
+#define pte_page(x) ( NODE_MEM_MAP(PHYSADDR_TO_NID(pte_val(x))) + \
        PLAT_NODE_DATA_LOCALNR(pte_val(x), PHYSADDR_TO_NID(pte_val(x))) )
-                                =20
 #endif
=20
 /*


--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+2tAH7sVBmHZT8w8RAg0QAJ48KVK7ZpXRQ9ExwdgcfS4KLr+1OgCgud00
13HV5p4TFzudANt9pWhMMdU=
=i47B
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--
