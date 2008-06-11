Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 18:08:40 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:38615 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20043464AbYFKREl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 18:04:41 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 0A1CC31E993;
	Wed, 11 Jun 2008 17:04:41 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 11 Jun 2008 17:04:40 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 11 Jun 2008 10:04:26 -0700
Message-ID: <48500599.9080807@avtrex.com>
Date:	Wed, 11 Jun 2008 10:04:25 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	MIPS Linux List <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: Resend: [PATCH] [MIPS] Fix asm constraints for 'ins' instructions.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2008 17:04:26.0342 (UTC) FILETIME=[342DB860:01C8CBE5]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This patch may have been lost in the Great LMO Firewall Saga, so I am resending it:

-------- Original Message --------
Subject: [PATCH] [MIPS] Fix asm constraints for 'ins' instructions.
Date: Tue, 27 May 2008 00:04:20 -0700
From: David Daney <ddaney@avtrex.com>
To: linux-mips@linux-mips.org


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
