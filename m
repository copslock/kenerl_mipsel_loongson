Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 10:13:55 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:19075 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225523AbSLTKNz>;
	Fri, 20 Dec 2002 10:13:55 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id D3E3CD657; Fri, 20 Dec 2002 11:20:02 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: test_bit returns int in all the architectures
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 20 Dec 2002 11:20:02 +0100
Message-ID: <m2fzstgffx.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        to be consistent with everybody else, test_bit should return a
        int.  Notice that it only returns 0/1, not a big deal.

Later, Juan.

Index: include/asm-mips64/bitops.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/bitops.h,v
retrieving revision 1.15.2.10
diff -u -r1.15.2.10 bitops.h
--- include/asm-mips64/bitops.h	5 Dec 2002 03:25:20 -0000	1.15.2.10
+++ include/asm-mips64/bitops.h	20 Dec 2002 09:55:13 -0000
@@ -302,7 +302,7 @@
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static inline unsigned long test_bit(int nr, volatile void * addr)
+static inline unsigned int test_bit(int nr, volatile void * addr)
 {
 	return 1UL & (((volatile unsigned long *) addr)[nr >> 6] >> (nr & 0x3f));
 }


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
