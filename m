Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 20:18:04 +0100 (CET)
Received: from 12-234-207-60.client.attbi.com ([12.234.207.60]:14724 "HELO
	gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225193AbSLJTSE>; Tue, 10 Dec 2002 20:18:04 +0100
Received: (qmail 18848 invoked by uid 502); 10 Dec 2002 19:18:01 -0000
Date: Tue, 10 Dec 2002 11:18:01 -0800
From: ilya@theIlya.com
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: update_mmu_cache bug
Message-ID: <20021210191801.GF609@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Following small patch is needed to prevent kernel from going into infinite loop
on page_fault. Probably similar patches are needed for other CPUs as well,
but since I don;t have any, I'll let those who do take care of that :)

	Ilya.

Index: arch/mips64/mm/tlb-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/tlb-r4k.c,v
retrieving revision 1.9
diff -u -r1.9 tlb-r4k.c
--- arch/mips64/mm/tlb-r4k.c    2 Dec 2002 00:27:49 -0000       1.9
+++ arch/mips64/mm/tlb-r4k.c    10 Dec 2002 17:02:30 -0000
@@ -260,8 +260,9 @@
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


--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE99j3p84S94bALfyURAuaBAJ0U/Oj0U3JxZ3HtJ7a72M6UfeQK+gCgtDtF
K8GshhZtcFIjXVQjGRRJWDU=
=mmNt
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--
