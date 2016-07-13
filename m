Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:18:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36807 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993454AbcGMNN67AGmh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:58 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0577B3C9B20E2;
        Wed, 13 Jul 2016 14:13:40 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:42 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 13/13] MIPS: c-r4k: Use SMP calls for CM indexed cache ops
Date:   Wed, 13 Jul 2016 14:12:56 +0100
Message-ID: <1468415576-12600-14-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54322
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

The MIPS Coherence Manager (CM) can propagate address-based ("hit")
cache operations to other cores in the coherent system, alleviating
software of the need to use SMP calls, however indexed cache operations
are not propagated by hardware since doing so makes no sense for
separate caches.

Update r4k_op_needs_ipi() to report that only hit cache operations are
globalized by the CM, requiring indexed cache operations to be
globalized by software via an SMP call.

r4k_on_each_cpu() previously had a special case for CONFIG_MIPS_MT_SMP,
intended to avoid the SMP calls when the only other CPUs in the system
were other VPEs in the same core, and hence sharing the same caches.
This was changed by commit cccf34e9411c ("MIPS: c-r4k: Fix cache
flushing for MT cores") to apparently handle multi-core multi-VPE
systems, but it focussed mainly on hit cache ops, so the SMP calls were
still disabled entirely for CM systems.

This doesn't normally cause problems, but tests can be written to hit
these corner cases by using multiple threads, or changing task
affinities to force the process to migrate cores. For example the
failure of mprotect RW->RX to globally sync icaches (via
flush_cache_range) can be detected by modifying and mprotecting a code
page on one core, and migrating to a different core to execute from it.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r4k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 8016babe5c84..3227a0a267f5 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -68,7 +68,7 @@
 static inline bool r4k_op_needs_ipi(unsigned int type)
 {
 	/* The MIPS Coherence Manager (CM) globalizes address-based cache ops */
-	if (mips_cm_present())
+	if (type == R4K_HIT && mips_cm_present())
 		return false;
 
 	/*
-- 
2.4.10
