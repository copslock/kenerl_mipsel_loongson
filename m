Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2003 23:10:20 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:51176
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225212AbTDMWKT>; Sun, 13 Apr 2003 23:10:19 +0100
Received: (qmail 23153 invoked by uid 502); 13 Apr 2003 22:10:13 -0000
Date: Sun, 13 Apr 2003 15:10:13 -0700
From: ilya@theIlya.com
To: linux-mips@linux-mips.org
Subject: [PATCH] c-r4k.c
Message-ID: <20030413221013.GA2217@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It seems like following is needed to get mips64/mm/c-r4k.c to compile:

Index: arch/mips64/mm/c-r4k.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/arch/mips64/mm/c-r4k.c,v
retrieving revision 1.30
diff -u -r1.30 c-r4k.c
--- arch/mips64/mm/c-r4k.c      13 Apr 2003 00:10:41 -0000      1.30
+++ arch/mips64/mm/c-r4k.c      13 Apr 2003 22:06:14 -0000
@@ -1073,7 +1073,7 @@
             PAGE_SIZE - 1);
=20
        flush_cache_sigtramp =3D r4k_flush_cache_sigtramp;
-       _flush_icache_all =3D r4k_flush_icache_all;
+       flush_icache_all =3D r4k_flush_icache_all;
        flush_data_cache_page =3D r4k_flush_data_cache_page;
        flush_icache_range =3D r4k_flush_icache_range;    /* Ouch */
=20


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+meBF7sVBmHZT8w8RAmv2AKCxfZNP+5RU0jGNsPE8DK43NF6FvgCeLJNU
HfIPRaPbJh5M1ECChhSCgtM=
=gi84
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
