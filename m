Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:53:55 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:10371 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225195AbTC0Cxn>;
	Thu, 27 Mar 2003 02:53:43 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 5761646A59; Thu, 27 Mar 2003 03:52:16 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: Remove unneded conditional
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:52:16 +0100
Message-ID: <m2r88ted27.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

 build/arch/mips/math-emu/sp_sub.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff -puN build/arch/mips/math-emu/sp_sub.c~consolidate_conditional build/arch/mips/math-emu/sp_sub.c
--- 24/build/arch/mips/math-emu/sp_sub.c~consolidate_conditional	2003-03-19 23:32:43.000000000 +0100
+++ 24-quintela/build/arch/mips/math-emu/sp_sub.c	2003-03-19 23:33:57.000000000 +0100
@@ -167,12 +167,11 @@ ieee754sp ieee754sp_sub(ieee754sp x, iee
 			xe = xe;
 			xs = ys;
 		}
-		if (xm == 0) {
-			if (ieee754_csr.rm == IEEE754_RD)
-				return ieee754sp_zero(1);	/* round negative inf. => sign = -1 */
-			else
-				return ieee754sp_zero(0);	/* other round modes   => sign = 1 */
-		}
+		if (xm == 0)
+			/* if IEEE754_RD round negative inf. => sign = -1
+			      other round modes              => sign = 1 */
+			return ieee754sp_zero(ieee754_csr.rm == IEEE754_RD);
+
 		/* normalize to rounding precision
 		 */
 		while ((xm >> (SP_MBITS + 3)) == 0) {

_

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
