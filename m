Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 09:12:32 +0100 (BST)
Received: from p508B6D44.dip.t-dialin.net ([IPv6:::ffff:80.139.109.68]:47001
	"EHLO p508B6D44.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225214AbTFBILs>; Mon, 2 Jun 2003 09:11:48 +0100
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:31621
	"HELO gateway.total-knowledge.com") by linux-mips.net with SMTP
	id <S868897AbTFBFEo>; Mon, 2 Jun 2003 07:04:44 +0200
Received: (qmail 16539 invoked by uid 502); 2 Jun 2003 05:03:41 -0000
Date: Sun, 1 Jun 2003 22:03:41 -0700
From: ilya@theIlya.com
To: linux-mips@linux-mips.org
Subject: Another lost patch
Message-ID: <20030602050341.GJ3035@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JsihDCElWRmQcbOr"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--JsihDCElWRmQcbOr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 I think this is still needed as well...

Index: arch/mips64/mm/tlb-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/tlb-r4k.c,v
retrieving revision 1.18
diff -u -r1.18 tlb-r4k.c
--- arch/mips64/mm/tlb-r4k.c    28 May 2003 07:32:46 -0000      1.18
+++ arch/mips64/mm/tlb-r4k.c    2 Jun 2003 03:58:44 -0000
@@ -253,8 +253,9 @@
        tlb_probe();
        BARRIER;
        pmdp = pmd_offset(pgdp, address);
+
        idx = read_c0_index();
-       ptep = pte_offset(pmdp, address);
+       ptep = pte_offset_map(pmdp, address);
        BARRIER;
        write_c0_entrylo0(pte_val(*ptep++) >> 6);
        write_c0_entrylo1(pte_val(*ptep) >> 6);


--JsihDCElWRmQcbOr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+2tqs7sVBmHZT8w8RArMSAJ0Vlm2GgizkYX/aVDixmCFQvUUYWQCfe75s
ycFdKGBTlvYFmYXSZhMrgM4=
=PsY3
-----END PGP SIGNATURE-----

--JsihDCElWRmQcbOr--
