Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 00:54:34 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:6021 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225200AbTC1Axd>;
	Fri, 28 Mar 2003 00:53:33 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 6A89A46BA6; Fri, 28 Mar 2003 01:52:04 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: c-r4k.c 2/7 micro prid optimization
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Fri, 28 Mar 2003 01:52:04 +0100
Message-ID: <m2wuik9utn.fsf@neno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        prid is only used during init.

Later, Juan.

 build/arch/mips/mm/c-r4k.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN build/arch/mips/mm/c-r4k.c~c-r4k_move_prid_call build/arch/mips/mm/c-r4k.c
--- 24/build/arch/mips/mm/c-r4k.c~c-r4k_move_prid_call	2003-03-27 15:40:38.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/c-r4k.c	2003-03-27 15:41:06.000000000 +0100
@@ -45,7 +45,7 @@ static unsigned long scache_size, sc_lsi
 
 static void r4k_blast_dcache_page(unsigned long addr)
 {
-	unsigned int prid = read_c0_prid() & 0xfff0;
+	unsigned int prid;
 	static void *l = &&init;
 
 	goto *l;
@@ -74,6 +74,7 @@ dc_32_r4600:
 	}
 
 init:
+	prid = read_c0_prid() & 0xfff0;
 	if (prid == 0x2010)			/* R4600 V1.7 */
 		l = &&dc_32_r4600;
 	else if (dc_lsize == 16)

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
