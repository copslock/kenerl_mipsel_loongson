Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 15:01:06 +0000 (GMT)
Received: from p508B7E65.dip.t-dialin.net ([IPv6:::ffff:80.139.126.101]:14172
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225367AbUA1PA5>; Wed, 28 Jan 2004 15:00:57 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0SF0iex011899;
	Wed, 28 Jan 2004 16:00:44 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0SF0h9T011898;
	Wed, 28 Jan 2004 16:00:43 +0100
Date: Wed, 28 Jan 2004 16:00:43 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Kevin Paul Herbert <kph@cisco.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Removal of ____raw_readq() and ____raw_writeq() from asm-mips/io.h
Message-ID: <20040128150043.GA11872@linux-mips.org>
References: <1075255111.8744.4.camel@shakedown> <20040128143004.GB1717@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128143004.GB1717@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Below the patch which I've just checked in.

  Ralf

Index: include/asm-mips/io.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/io.h,v
retrieving revision 1.68
diff -u -r1.68 io.h
--- include/asm-mips/io.h	19 Jan 2004 21:48:21 -0000	1.68
+++ include/asm-mips/io.h	28 Jan 2004 14:55:57 -0000
@@ -248,12 +248,10 @@
 #define __raw_readw(addr)	(*(volatile unsigned short *)(addr))
 #define __raw_readl(addr)	(*(volatile unsigned int *)(addr))
 #ifdef CONFIG_MIPS32
-#define __raw_readq(addr)						\
+#define ____raw_readq(addr)						\
 ({									\
-	unsigned long __flags;						\
 	u64 __res;							\
 									\
-	local_irq_save(__flags);					\
 	__asm__ __volatile__ (						\
 		"	.set	mips3		# ____raw_readq	\n"	\
 		"	ld	%L0, (%1)			\n"	\
@@ -262,12 +260,22 @@
 		"	.set	mips0				\n"	\
 		: "=r" (__res)						\
 		: "r" (addr));						\
+	__res;								\
+})
+#define __raw_readq(addr)						\
+({									\
+	unsigned long __flags;						\
+	u64 __res;							\
+									\
+	local_irq_save(__flags);					\
+	__res = ____raw_readq(addr);					\
 	local_irq_restore(__flags);					\
 	__res;								\
 })
 #endif
 #ifdef CONFIG_MIPS64
-#define __raw_readq(addr)	(*(volatile unsigned long *)(addr))
+#define ____raw_readq(addr)	(*(volatile unsigned long *)(addr))
+#define __raw_readq(addr)	____raw_readq(addr)
 #endif
 
 #define readb(addr)		__ioswab8(__raw_readb(addr))
@@ -279,12 +287,10 @@
 #define __raw_writew(w,addr)	((*(volatile unsigned short *)(addr)) = (w))
 #define __raw_writel(l,addr)	((*(volatile unsigned int *)(addr)) = (l))
 #ifdef CONFIG_MIPS32
-#define __raw_writeq(val,addr)						\
+#define ____raw_writeq(val,addr)						\
 ({									\
-	unsigned long __flags;						\
 	u64 __tmp;							\
 									\
-	local_irq_save(__flags);					\
 	__asm__ __volatile__ (						\
 		"	.set	mips3				\n"	\
 		"	dsll32	%L0, %L0, 0	# ____raw_writeq\n"	\
@@ -295,11 +301,19 @@
 		"	.set	mips0				\n"	\
 		: "=r" (__tmp)						\
 		: "0" ((unsigned long long)val), "r" (addr));		\
+})
+#define __raw_writeq(val,addr)						\
+({									\
+	unsigned long __flags;						\
+									\
+	local_irq_save(__flags);					\
+	____raw_writeq(val, addr);					\
 	local_irq_restore(__flags);					\
 })
 #endif
 #ifdef CONFIG_MIPS64
-#define __raw_writeq(l,addr)	((*(volatile unsigned long *)(addr)) = (l))
+#define ____raw_writeq(q,addr)	((*(volatile unsigned long *)(addr)) = (q))
+#define __raw_writeq(q,addr)	____raw_writeq(q, addr)
 #endif
 
 #define writeb(b,addr)		__raw_writeb(__ioswab8(b),(addr))
