Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2008 08:04:40 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:37297 "HELO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with SMTP
	id S20024304AbYE0HEi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 May 2008 08:04:38 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id B1068319FFC
	for <linux-mips@linux-mips.org>; Tue, 27 May 2008 07:04:28 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Tue, 27 May 2008 07:04:28 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.227]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 27 May 2008 00:04:22 -0700
Message-ID: <483BB274.10901@avtrex.com>
Date:	Tue, 27 May 2008 00:04:20 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] [MIPS] Fix asm constraints for 'ins' instructions.
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2008 07:04:22.0547 (UTC) FILETIME=[E40C5630:01C8BFC7]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips


The third operand to 'ins' must be a constant int, not a register.

Signed-off-by: David Daney <ddaney@avtrex.com>
---
 include/asm-mips/bitops.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
index 6427247..9a7274b 100644
--- a/include/asm-mips/bitops.h
+++ b/include/asm-mips/bitops.h
@@ -82,7 +82,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		"2:	b	1b					\n"
 		"	.previous					\n"
 		: "=&r" (temp), "=m" (*m)
-		: "ir" (bit), "m" (*m), "r" (~0));
+		: "i" (bit), "m" (*m), "r" (~0));
 #endif /* CONFIG_CPU_MIPSR2 */
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
@@ -147,7 +147,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		"2:	b	1b					\n"
 		"	.previous					\n"
 		: "=&r" (temp), "=m" (*m)
-		: "ir" (bit), "m" (*m));
+		: "i" (bit), "m" (*m));
 #endif /* CONFIG_CPU_MIPSR2 */
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
@@ -428,7 +428,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 		"2:	b	1b					\n"
 		"	.previous					\n"
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
-		: "ri" (bit), "m" (*m)
+		: "i" (bit), "m" (*m)
 		: "memory");
 #endif
 	} else if (cpu_has_llsc) {
-- 
1.5.4.5
