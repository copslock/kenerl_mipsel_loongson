Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 13:00:04 +0000 (GMT)
Received: from p508B5BE3.dip.t-dialin.net ([IPv6:::ffff:80.139.91.227]:47045
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225536AbSLTNAD>; Fri, 20 Dec 2002 13:00:03 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBKCxt631568;
	Fri, 20 Dec 2002 13:59:55 +0100
Date: Fri, 20 Dec 2002 13:59:55 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: test_bit returns int in all the architectures
Message-ID: <20021220135955.A31554@linux-mips.org>
References: <m2fzstgffx.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m2fzstgffx.fsf@demo.mitica>; from quintela@mandrakesoft.com on Fri, Dec 20, 2002 at 11:20:02AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 20, 2002 at 11:20:02AM +0100, Juan Quintela wrote:

>         to be consistent with everybody else, test_bit should return a
>         int.  Notice that it only returns 0/1, not a big deal.

I'm using below patch instead.

  Ralf

Index: include/asm-mips/bitops.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/bitops.h,v
retrieving revision 1.21.2.9
diff -u -r1.21.2.9 bitops.h
--- include/asm-mips/bitops.h	5 Dec 2002 03:25:20 -0000	1.21.2.9
+++ include/asm-mips/bitops.h	20 Dec 2002 12:54:10 -0000
@@ -582,9 +582,9 @@
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static __inline__ int test_bit(int nr, volatile void *addr)
+static inline int test_bit(int nr, volatile void *addr)
 {
-	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) != 0;
+	return 1UL & (((const volatile unsigned long *) addr)[nr >> SZLONG_LOG] >> (nr & SZLONG_MASK));
 }
 
 /*
Index: include/asm-mips64/bitops.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/bitops.h,v
retrieving revision 1.15.2.10
diff -u -r1.15.2.10 bitops.h
--- include/asm-mips64/bitops.h	5 Dec 2002 03:25:20 -0000	1.15.2.10
+++ include/asm-mips64/bitops.h	20 Dec 2002 12:54:12 -0000
@@ -302,9 +302,9 @@
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static inline unsigned long test_bit(int nr, volatile void * addr)
+static inline int test_bit(int nr, volatile void * addr)
 {
-	return 1UL & (((volatile unsigned long *) addr)[nr >> 6] >> (nr & 0x3f));
+	return 1UL & (((const volatile unsigned long *) addr)[nr >> SZLONG_LOG] >> (nr & SZLONG_MASK));
 }
 
 /*
