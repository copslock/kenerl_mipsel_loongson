Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 00:54:14 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:5509 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225199AbTC1Ax0>;
	Fri, 28 Mar 2003 00:53:26 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 88E6C46BA6; Fri, 28 Mar 2003 01:51:57 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: c-r4k.c 1/7 s/switch/formula/
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Fri, 28 Mar 2003 01:51:57 +0100
Message-ID: <m2y9309utu.fsf@neno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
	use the same calculation for sc_size as in every other *_size.

Later, Juan.


 build/arch/mips/mm/c-r4k.c |   15 +--------------
 1 files changed, 1 insertion(+), 14 deletions(-)

diff -puN build/arch/mips/mm/c-r4k.c~c-r4k_remove_switch build/arch/mips/mm/c-r4k.c
--- 24/build/arch/mips/mm/c-r4k.c~c-r4k_remove_switch	2003-03-28 00:33:48.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/c-r4k.c	2003-03-28 00:33:48.000000000 +0100
@@ -635,20 +635,7 @@ static int __init probe_scache(unsigned 
 	if ((config >> 17) & 1)
 		return 0;
 
-	switch ((config >> 22) & 3) {
-	case 0:
-		sc_lsize = 16;
-		break;
-	case 1:
-		sc_lsize = 32;
-		break;
-	case 2:
-		sc_lsize = 64;
-		break;
-	case 3:
-		sc_lsize = 128;
-		break;
-	}
+	sc_lsize = 16 << ((config >> 22) & 3);
 
 	begin = (unsigned long) &stext;
 	begin &= ~((4 * 1024 * 1024) - 1);

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
