Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:17:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35765 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993313AbcGMNNrpaKrh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:47 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C76C9AD545ED8;
        Wed, 13 Jul 2016 14:13:38 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:41 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 12/13] MIPS: c-r4k: Avoid small flush_icache_range SMP calls
Date:   Wed, 13 Jul 2016 14:12:55 +0100
Message-ID: <1468415576-12600-13-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54320
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

Avoid SMP calls for flushing small icache ranges. On non-CM platforms,
and CM platforms too after we make r4k_on_each_cpu() take the cache op
type into account, it will be called on multiple CPUs due to the
possibility that local_r4k_flush_icache_range_ipi() could do
non-globalized indexed cache ops. This rougly copies the range size
check out into r4k_flush_icache_range(), which can disallow indexed
cache ops and allow r4k_on_each_cpu() to skip the SMP call.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r4k.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index cfcb336f57a0..8016babe5c84 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -784,12 +784,33 @@ static inline void local_r4k_flush_icache_range_ipi(void *args)
 static void r4k_flush_icache_range(unsigned long start, unsigned long end)
 {
 	struct flush_icache_range_args args;
+	unsigned long size, cache_size;
 
 	args.start = start;
 	args.end = end;
 	args.type = R4K_HIT | R4K_INDEX;
 
+	/*
+	 * Indexed cache ops require an SMP call.
+	 * Consider if that can or should be avoided.
+	 */
+	preempt_disable();
+	if (r4k_op_needs_ipi(R4K_INDEX) && !r4k_op_needs_ipi(R4K_HIT)) {
+		/*
+		 * If address-based cache ops don't require an SMP call, then
+		 * use them exclusively for small flushes.
+		 */
+		size = start - end;
+		cache_size = icache_size;
+		if (!cpu_has_ic_fills_f_dc) {
+			size *= 2;
+			cache_size += dcache_size;
+		}
+		if (size <= cache_size)
+			args.type &= ~R4K_INDEX;
+	}
 	r4k_on_each_cpu(args.type, local_r4k_flush_icache_range_ipi, &args);
+	preempt_enable();
 	instruction_hazard();
 }
 
-- 
2.4.10
