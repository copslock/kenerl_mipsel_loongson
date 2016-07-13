Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:15:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40219 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993107AbcGMNNgNZzFh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:36 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4DB58C57D1859;
        Wed, 13 Jul 2016 14:13:17 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:19 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 04/13] MIPS: c-r4k: Fix protected_writeback_scache_line for EVA
Date:   Wed, 13 Jul 2016 14:12:47 +0100
Message-ID: <1468415576-12600-5-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54315
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

The protected_writeback_scache_line() function is used by
local_r4k_flush_cache_sigtramp() to flush an FPU delay slot emulation
trampoline on the userland stack from the caches so it is visible to
subsequent instruction fetches.

Commit de8974e3f76c ("MIPS: asm: r4kcache: Add EVA cache flushing
functions") updated some protected_ cache flush functions to use EVA
CACHEE instructions via protected_cachee_op(), and commit 83fd43449baa
("MIPS: r4kcache: Add EVA case for protected_writeback_dcache_line") did
the same thing for protected_writeback_dcache_line(), but
protected_writeback_scache_line() never got updated. Lets fix that now
to flush the right user address from the secondary cache rather than
some arbitrary kernel unmapped address.

This issue was spotted through code inspection, and it seems unlikely to
be possible to hit this in practice. It theoretically affect EVA kernels
on EVA capable cores with an L2 cache, where the icache fetches straight
from RAM (cpu_icache_snoops_remote_store == 0), running a hard float
userland with FPU disabled (nofpu). That both Malta and Boston platforms
override cpu_icache_snoops_remote_store to 1 suggests that all MIPS
cores fetch instructions into icache straight from L2 rather than RAM.

Fixes: de8974e3f76c ("MIPS: asm: r4kcache: Add EVA cache flushing functions")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/r4kcache.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 38902bf97adc..667ca3c467b7 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -210,7 +210,11 @@ static inline void protected_writeback_dcache_line(unsigned long addr)
 
 static inline void protected_writeback_scache_line(unsigned long addr)
 {
+#ifdef CONFIG_EVA
+	protected_cachee_op(Hit_Writeback_Inv_SD, addr);
+#else
 	protected_cache_op(Hit_Writeback_Inv_SD, addr);
+#endif
 }
 
 /*
-- 
2.4.10
