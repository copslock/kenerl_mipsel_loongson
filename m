Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:39:14 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:53476 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225324AbSLRBhY>;
	Wed, 18 Dec 2002 01:37:24 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 201B5D657; Wed, 18 Dec 2002 02:43:20 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: math-emu ambigous else
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:43:19 +0100
Message-ID: <m265tsqeyw.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        compiler complained that this else was ambiguous.

Later, Juan.

PD. Once there, change the code to:

    return ieee754sp_zero(ieee754_csr.rm ==IEEE754_RD);

shouldn't be better and indeed clearer?



Index: arch/mips/math-emu/sp_sub.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/math-emu/sp_sub.c,v
retrieving revision 1.4.2.1
diff -u -r1.4.2.1 sp_sub.c
--- arch/mips/math-emu/sp_sub.c	5 Aug 2002 23:53:34 -0000	1.4.2.1
+++ arch/mips/math-emu/sp_sub.c	18 Dec 2002 00:49:18 -0000
@@ -167,12 +167,12 @@
 			xe = xe;
 			xs = ys;
 		}
-		if (xm == 0)
+		if (xm == 0) {
 			if (ieee754_csr.rm == IEEE754_RD)
 				return ieee754sp_zero(1);	/* round negative inf. => sign = -1 */
 			else
 				return ieee754sp_zero(0);	/* other round modes   => sign = 1 */
-
+		}
 		/* normalize to rounding precision
 		 */
 		while ((xm >> (SP_MBITS + 3)) == 0) {




-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
