Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2004 15:09:14 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:54780 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225269AbUCPPJN>;
	Tue, 16 Mar 2004 15:09:13 +0000
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i2GF9Bx6029416;
	Tue, 16 Mar 2004 07:09:11 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i2GF9BQE029414;
	Tue, 16 Mar 2004 07:09:11 -0800
Date: Tue, 16 Mar 2004 07:09:11 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH 2.6] missing _raw_write_trylock
Message-ID: <20040316070911.B29232@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please help me reviewing the code, because inline assembly bug is
always tricky and miserable.  

Jun

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk

diff -Nru linux/include/asm-mips/spinlock.h.orig linux/include/asm-mips/spinlock.h
--- linux/include/asm-mips/spinlock.h.orig	2004-01-05 10:48:38.000000000 -0800
+++ linux/include/asm-mips/spinlock.h	2004-03-15 18:50:30.000000000 -0800
@@ -167,4 +167,28 @@
 	: "memory");
 }
 
+static inline int _raw_write_trylock(rwlock_t *rw)
+{
+	unsigned int tmp;
+	int ret;
+
+	__asm__ __volatile__(
+	".set\tnoreorder\t\t\t# _raw_write_trylock\n"
+	"li\t%2, 0\n\t"
+	"1:\tll\t%1, %3\n\t"
+	"bnez\t%1, 2f\n\t"
+	"lui\t%1, 0x8000\n\t"
+	"sc\t%1, %0\n\t"
+	"beqz\t%1, 1b\n\t"
+	"sync\n\t"
+	"li\t%2, 1\n\t"
+	".set\treorder\n"
+	"2:"
+	: "=m" (rw->lock), "=&r" (tmp), "=&r" (ret)
+	: "m" (rw->lock)
+	: "memory");
+
+	return ret;
+}
+
 #endif /* _ASM_SPINLOCK_H */

--zhXaljGHf11kAtnf--
