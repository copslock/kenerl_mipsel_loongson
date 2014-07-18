Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 11:52:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15662 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861334AbaGRJv7aN2XG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 11:51:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B79977CDF7D77
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 10:51:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 18 Jul 2014 10:51:52 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.100) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 18 Jul 2014 10:51:52 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/4] MIPS: pgtable-bits: Move the CCA bits out of the core's ifdef blocks
Date:   Fri, 18 Jul 2014 10:51:30 +0100
Message-ID: <1405677093-22591-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405677093-22591-1-git-send-email-markos.chandras@imgtec.com>
References: <1405677093-22591-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.100]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Define all the CCA bits outside the ifdef blocks for specific cores
but also allow cores to override them if necessary.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/pgtable-bits.h | 41 ++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index e592f3687d6f..011b0dcf306e 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -224,38 +224,47 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
 #define _CACHE_CACHABLE_NONCOHERENT 0
+#define _CACHE_UNCACHED_ACCELERATED _CACHE_UNCACHED
 
 #elif defined(CONFIG_CPU_SB1)
 
 /* No penalty for being coherent on the SB1, so just
    use it for "noncoherent" spaces, too.  Shouldn't hurt. */
 
-#define _CACHE_UNCACHED		    (2<<_CACHE_SHIFT)
-#define _CACHE_CACHABLE_COW	    (5<<_CACHE_SHIFT)
 #define _CACHE_CACHABLE_NONCOHERENT (5<<_CACHE_SHIFT)
-#define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)
 
 #elif defined(CONFIG_CPU_LOONGSON3)
 
 /* Using COHERENT flag for NONCOHERENT doesn't hurt. */
 
-#define _CACHE_UNCACHED             (2<<_CACHE_SHIFT)  /* LOONGSON       */
 #define _CACHE_CACHABLE_NONCOHERENT (3<<_CACHE_SHIFT)  /* LOONGSON       */
 #define _CACHE_CACHABLE_COHERENT    (3<<_CACHE_SHIFT)  /* LOONGSON-3     */
-#define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)  /* LOONGSON       */
 
-#else
-
-#define _CACHE_CACHABLE_NO_WA	    (0<<_CACHE_SHIFT)  /* R4600 only	  */
-#define _CACHE_CACHABLE_WA	    (1<<_CACHE_SHIFT)  /* R4600 only	  */
-#define _CACHE_UNCACHED		    (2<<_CACHE_SHIFT)  /* R4[0246]00	  */
-#define _CACHE_CACHABLE_NONCOHERENT (3<<_CACHE_SHIFT)  /* R4[0246]00	  */
-#define _CACHE_CACHABLE_CE	    (4<<_CACHE_SHIFT)  /* R4[04]00MC only */
-#define _CACHE_CACHABLE_COW	    (5<<_CACHE_SHIFT)  /* R4[04]00MC only */
-#define _CACHE_CACHABLE_COHERENT    (5<<_CACHE_SHIFT)  /* MIPS32R2 CMP	  */
-#define _CACHE_CACHABLE_CUW	    (6<<_CACHE_SHIFT)  /* R4[04]00MC only */
-#define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)  /* R10000 only	  */
+#endif
 
+#ifndef _CACHE_CACHABLE_NO_WA
+#define _CACHE_CACHABLE_NO_WA		(0<<_CACHE_SHIFT)
+#endif
+#ifndef _CACHE_CACHABLE_WA
+#define _CACHE_CACHABLE_WA		(1<<_CACHE_SHIFT)
+#endif
+#ifndef _CACHE_UNCACHED
+#define _CACHE_UNCACHED			(2<<_CACHE_SHIFT)
+#endif
+#ifndef _CACHE_CACHABLE_NONCOHERENT
+#define _CACHE_CACHABLE_NONCOHERENT	(3<<_CACHE_SHIFT)
+#endif
+#ifndef _CACHE_CACHABLE_CE
+#define _CACHE_CACHABLE_CE		(4<<_CACHE_SHIFT)
+#endif
+#ifndef _CACHE_CACHABLE_COW
+#define _CACHE_CACHABLE_COW		(5<<_CACHE_SHIFT)
+#endif
+#ifndef _CACHE_CACHABLE_CUW
+#define _CACHE_CACHABLE_CUW		(6<<_CACHE_SHIFT)
+#endif
+#ifndef _CACHE_UNCACHED_ACCELERATED
+#define _CACHE_UNCACHED_ACCELERATED	(7<<_CACHE_SHIFT)
 #endif
 
 #define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED | (cpu_has_rixi ? 0 : _PAGE_READ))
-- 
2.0.0
