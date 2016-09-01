Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 18:34:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8324 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992310AbcIAQbPt99j2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 18:31:15 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 466806F262608;
        Thu,  1 Sep 2016 17:30:56 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 17:30:59 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 9/9] MIPS: c-r4k: Fix flush_icache_range() for EVA
Date:   Thu, 1 Sep 2016 17:30:15 +0100
Message-ID: <359bd15e6b6797f5e0240ad6ad2e0051a84ae6ec.1472747205.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

flush_icache_range() flushes icache lines in a protected fashion for
kernel addresses, however this isn't correct with EVA where protected
cache ops only operate on user addresses, making flush_icache_range()
ineffective.

Split the implementations of __flush_icache_user_range() from
flush_icache_range(), changing the normal flush_icache_range() to use
unprotected normal cache ops.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r4k.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 36f4aa6d768f..eed8aefe1de4 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -722,11 +722,13 @@ struct flush_icache_range_args {
 	unsigned long start;
 	unsigned long end;
 	unsigned int type;
+	bool user;
 };
 
 static inline void __local_r4k_flush_icache_range(unsigned long start,
 						  unsigned long end,
-						  unsigned int type)
+						  unsigned int type,
+						  bool user)
 {
 	if (!cpu_has_ic_fills_f_dc) {
 		if (type == R4K_INDEX ||
@@ -734,7 +736,10 @@ static inline void __local_r4k_flush_icache_range(unsigned long start,
 			r4k_blast_dcache();
 		} else {
 			R4600_HIT_CACHEOP_WAR_IMPL;
-			protected_blast_dcache_range(start, end);
+			if (user)
+				protected_blast_dcache_range(start, end);
+			else
+				blast_dcache_range(start, end);
 		}
 	}
 
@@ -748,7 +753,10 @@ static inline void __local_r4k_flush_icache_range(unsigned long start,
 			break;
 
 		default:
-			protected_blast_icache_range(start, end);
+			if (user)
+				protected_blast_icache_range(start, end);
+			else
+				blast_icache_range(start, end);
 			break;
 		}
 	}
@@ -757,7 +765,13 @@ static inline void __local_r4k_flush_icache_range(unsigned long start,
 static inline void local_r4k_flush_icache_range(unsigned long start,
 						unsigned long end)
 {
-	__local_r4k_flush_icache_range(start, end, R4K_HIT | R4K_INDEX);
+	__local_r4k_flush_icache_range(start, end, R4K_HIT | R4K_INDEX, false);
+}
+
+static inline void local_r4k_flush_icache_user_range(unsigned long start,
+						     unsigned long end)
+{
+	__local_r4k_flush_icache_range(start, end, R4K_HIT | R4K_INDEX, true);
 }
 
 static inline void local_r4k_flush_icache_range_ipi(void *args)
@@ -766,11 +780,13 @@ static inline void local_r4k_flush_icache_range_ipi(void *args)
 	unsigned long start = fir_args->start;
 	unsigned long end = fir_args->end;
 	unsigned int type = fir_args->type;
+	bool user = fir_args->user;
 
-	__local_r4k_flush_icache_range(start, end, type);
+	__local_r4k_flush_icache_range(start, end, type, user);
 }
 
-static void r4k_flush_icache_range(unsigned long start, unsigned long end)
+static void __r4k_flush_icache_range(unsigned long start, unsigned long end,
+				     bool user)
 {
 	struct flush_icache_range_args args;
 	unsigned long size, cache_size;
@@ -778,6 +794,7 @@ static void r4k_flush_icache_range(unsigned long start, unsigned long end)
 	args.start = start;
 	args.end = end;
 	args.type = R4K_HIT | R4K_INDEX;
+	args.user = user;
 
 	/*
 	 * Indexed cache ops require an SMP call.
@@ -803,6 +820,16 @@ static void r4k_flush_icache_range(unsigned long start, unsigned long end)
 	instruction_hazard();
 }
 
+static void r4k_flush_icache_range(unsigned long start, unsigned long end)
+{
+	return __r4k_flush_icache_range(start, end, false);
+}
+
+static void r4k_flush_icache_user_range(unsigned long start, unsigned long end)
+{
+	return __r4k_flush_icache_range(start, end, true);
+}
+
 #if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
 
 static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
@@ -1904,8 +1931,8 @@ void r4k_cache_init(void)
 	flush_data_cache_page	= r4k_flush_data_cache_page;
 	flush_icache_range	= r4k_flush_icache_range;
 	local_flush_icache_range	= local_r4k_flush_icache_range;
-	__flush_icache_user_range	= r4k_flush_icache_range;
-	__local_flush_icache_user_range	= local_r4k_flush_icache_range;
+	__flush_icache_user_range	= r4k_flush_icache_user_range;
+	__local_flush_icache_user_range	= local_r4k_flush_icache_user_range;
 
 #if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
 	if (coherentio) {
-- 
git-series 0.8.10
