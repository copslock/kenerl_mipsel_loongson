Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:38:54 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:53220 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225316AbSLRBhO>;
	Wed, 18 Dec 2002 01:37:14 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 9B6E4D657; Wed, 18 Dec 2002 02:43:10 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: mathemu remove unused variable
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:43:10 +0100
Message-ID: <m28yyoqez5.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        sign is never used in that function.

Later, Juan.

Index: arch/mips/math-emu/sp_sqrt.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/math-emu/sp_sqrt.c,v
retrieving revision 1.4
diff -u -r1.4 sp_sqrt.c
--- arch/mips/math-emu/sp_sqrt.c	4 Oct 2001 13:19:44 -0000	1.4
+++ arch/mips/math-emu/sp_sqrt.c	18 Dec 2002 00:49:18 -0000
@@ -29,7 +29,6 @@
 
 ieee754sp ieee754sp_sqrt(ieee754sp x)
 {
-	int sign = (int) 0x80000000;
 	int ix, s, q, m, t, i;
 	unsigned int r;
 	COMPXSP;


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
