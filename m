Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:18:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8692 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993355AbcGMNNwNZzFh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:52 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 380A0E2B78242;
        Wed, 13 Jul 2016 14:13:33 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:35 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 10/13] MIPS: c-r4k: Split r4k_flush_kernel_vmap_range()
Date:   Wed, 13 Jul 2016 14:12:53 +0100
Message-ID: <1468415576-12600-11-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54321
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

Split the operation of r4k_flush_kernel_vmap_range() into separate
SMP callbacks for the indexed cache flush and hit cache flush cases,
since the logic to determine which to use can be determined by the
initiating CPU prior to doing any SMP calls.

This will help when we change r4k_on_each_cpu() to distinguish indexed
and hit cache ops in a later patch, preventing globalized hit cache ops
being performed redundantly on multiple CPUs.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r4k.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 57374f0c33f2..004cf41dd717 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -978,6 +978,15 @@ struct flush_kernel_vmap_range_args {
 	int		size;
 };
 
+static inline void local_r4k_flush_kernel_vmap_range_index(void *args)
+{
+	/*
+	 * Aliases only affect the primary caches so don't bother with
+	 * S-caches or T-caches.
+	 */
+	r4k_blast_dcache();
+}
+
 static inline void local_r4k_flush_kernel_vmap_range(void *args)
 {
 	struct flush_kernel_vmap_range_args *vmra = args;
@@ -988,12 +997,8 @@ static inline void local_r4k_flush_kernel_vmap_range(void *args)
 	 * Aliases only affect the primary caches so don't bother with
 	 * S-caches or T-caches.
 	 */
-	if (size >= dcache_size)
-		r4k_blast_dcache();
-	else {
-		R4600_HIT_CACHEOP_WAR_IMPL;
-		blast_dcache_range(vaddr, vaddr + size);
-	}
+	R4600_HIT_CACHEOP_WAR_IMPL;
+	blast_dcache_range(vaddr, vaddr + size);
 }
 
 static void r4k_flush_kernel_vmap_range(unsigned long vaddr, int size)
@@ -1003,8 +1008,12 @@ static void r4k_flush_kernel_vmap_range(unsigned long vaddr, int size)
 	args.vaddr = (unsigned long) vaddr;
 	args.size = size;
 
-	r4k_on_each_cpu(R4K_HIT | R4K_INDEX, local_r4k_flush_kernel_vmap_range,
-			&args);
+	if (size >= dcache_size)
+		r4k_on_each_cpu(R4K_INDEX,
+				local_r4k_flush_kernel_vmap_range_index, NULL);
+	else
+		r4k_on_each_cpu(R4K_HIT, local_r4k_flush_kernel_vmap_range,
+				&args);
 }
 
 static inline void rm7k_erratum31(void)
-- 
2.4.10
