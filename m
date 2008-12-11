Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2008 23:44:37 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:22059 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207793AbYLKXke (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Dec 2008 23:40:34 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4941a3b50000>; Thu, 11 Dec 2008 18:35:22 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:33:51 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:33:50 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBBNXk24031899;
	Thu, 11 Dec 2008 15:33:46 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBBNXjhX031898;
	Thu, 11 Dec 2008 15:33:45 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 11/20] MIPS: Modify core io.h macros to account for the Octeon Errata Core-301.
Date:	Thu, 11 Dec 2008 15:33:29 -0800
Message-Id: <1229038418-31833-11-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <4941A2F5.1010202@caviumnetworks.com>
References: <4941A2F5.1010202@caviumnetworks.com>
X-OriginalArrivalTime: 11 Dec 2008 23:33:51.0020 (UTC) FILETIME=[EC34E6C0:01C95BE8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/io.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 501a40b..436878e 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -295,6 +295,12 @@ static inline void iounmap(const volatile void __iomem *addr)
 #undef __IS_KSEG1
 }
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+#define war_octeon_io_reorder_wmb()  		wmb()
+#else
+#define war_octeon_io_reorder_wmb()		do { } while (0)
+#endif
+
 #define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, irq)			\
 									\
 static inline void pfx##write##bwlq(type val,				\
@@ -303,6 +309,8 @@ static inline void pfx##write##bwlq(type val,				\
 	volatile type *__mem;						\
 	type __val;							\
 									\
+	war_octeon_io_reorder_wmb();					\
+									\
 	__mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));	\
 									\
 	__val = pfx##ioswab##bwlq(__mem, val);				\
@@ -370,6 +378,8 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 	volatile type *__addr;						\
 	type __val;							\
 									\
+	war_octeon_io_reorder_wmb();					\
+									\
 	__addr = (void *)__swizzle_addr_##bwlq(mips_io_port_base + port); \
 									\
 	__val = pfx##ioswab##bwlq(__addr, val);				\
@@ -504,8 +514,12 @@ BUILDSTRING(q, u64)
 #endif
 
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+#define mmiowb() wmb()
+#else
 /* Depends on MIPS II instruction set */
 #define mmiowb() asm volatile ("sync" ::: "memory")
+#endif
 
 static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
 {
-- 
1.5.6.5
