Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:16:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58111 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992487AbcGMNNo4u93h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D2920A789C1D7;
        Wed, 13 Jul 2016 14:13:35 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:38 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 11/13] MIPS: c-r4k: Local flush_icache_range cache op override
Date:   Wed, 13 Jul 2016 14:12:54 +0100
Message-ID: <1468415576-12600-12-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
References: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54318
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

Allow the permitted cache op types used by
local_r4k_flush_icache_range_ipi() to be overridden by the SMP caller.
This will allow SMP calls to be avoided under certain circumstances,
falling back to a single CPU performing globalized hit cache ops only.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r4k.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 004cf41dd717..cfcb336f57a0 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -721,12 +721,16 @@ static void r4k_flush_data_cache_page(unsigned long addr)
 struct flush_icache_range_args {
 	unsigned long start;
 	unsigned long end;
+	unsigned int type;
 };
 
-static inline void local_r4k_flush_icache_range(unsigned long start, unsigned long end)
+static inline void __local_r4k_flush_icache_range(unsigned long start,
+						  unsigned long end,
+						  unsigned int type)
 {
 	if (!cpu_has_ic_fills_f_dc) {
-		if (end - start >= dcache_size) {
+		if (type == R4K_INDEX ||
+		    (type & R4K_INDEX && end - start >= dcache_size)) {
 			r4k_blast_dcache();
 		} else {
 			R4600_HIT_CACHEOP_WAR_IMPL;
@@ -734,7 +738,8 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
 		}
 	}
 
-	if (end - start > icache_size)
+	if (type == R4K_INDEX ||
+	    (type & R4K_INDEX && end - start > icache_size))
 		r4k_blast_icache();
 	else {
 		switch (boot_cpu_type()) {
@@ -760,13 +765,20 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
 #endif
 }
 
+static inline void local_r4k_flush_icache_range(unsigned long start,
+						unsigned long end)
+{
+	__local_r4k_flush_icache_range(start, end, R4K_HIT | R4K_INDEX);
+}
+
 static inline void local_r4k_flush_icache_range_ipi(void *args)
 {
 	struct flush_icache_range_args *fir_args = args;
 	unsigned long start = fir_args->start;
 	unsigned long end = fir_args->end;
+	unsigned int type = fir_args->type;
 
-	local_r4k_flush_icache_range(start, end);
+	__local_r4k_flush_icache_range(start, end, type);
 }
 
 static void r4k_flush_icache_range(unsigned long start, unsigned long end)
@@ -775,9 +787,9 @@ static void r4k_flush_icache_range(unsigned long start, unsigned long end)
 
 	args.start = start;
 	args.end = end;
+	args.type = R4K_HIT | R4K_INDEX;
 
-	r4k_on_each_cpu(R4K_HIT | R4K_INDEX, local_r4k_flush_icache_range_ipi,
-			&args);
+	r4k_on_each_cpu(args.type, local_r4k_flush_icache_range_ipi, &args);
 	instruction_hazard();
 }
 
-- 
2.4.10
