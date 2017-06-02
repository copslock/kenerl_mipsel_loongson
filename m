Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 00:18:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14322 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993914AbdFBWRvKivUF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 00:17:51 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A92906B98FD2B;
        Fri,  2 Jun 2017 23:17:38 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 23:17:43
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Set MIPS_IC_SNOOPS_REMOTE for systems with CM
Date:   Fri, 2 Jun 2017 15:17:25 -0700
Message-ID: <20170602221725.8507-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

In systems that include a MIPS Coherency Manager, the icache always
fills from a cache which is coherent across all CPUs. In I6400 & I6500
systems the icache fills from the dcache which is coherent across all
CPUs. In all other CM-based systems the icache fills from the L2 cache
which is shared between all cores.

This means that an icache will always see stores from remote CPUs
without needing to write them back any further than that L2, which is
what the cpu_icache_snoops_remote_store feature is used to test. In
order for it to return 1 without needing a per-platform override (which
is what Malta has relied upon so far) set the MIPS_IC_SNOOPS_REMOTE flag
when a CM is present.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/mm/c-r4k.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 3fe99cb271a9..6c1b982196eb 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1501,6 +1501,14 @@ static void probe_pcache(void)
 	if (c->dcache.flags & MIPS_CACHE_PINDEX)
 		c->dcache.flags &= ~MIPS_CACHE_ALIASES;
 
+	/*
+	 * In systems with CM the icache fills from L2 or closer caches, and
+	 * thus sees remote stores without needing to write them back any
+	 * further than that.
+	 */
+	if (mips_cm_present())
+		c->icache.flags |= MIPS_IC_SNOOPS_REMOTE;
+
 	switch (current_cpu_type()) {
 	case CPU_20KC:
 		/*
-- 
2.13.0
