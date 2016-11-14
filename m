Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 03:05:12 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37766 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992227AbcKNCEU1HPAO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 03:04:20 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66d7-0005pT-ET; Mon, 14 Nov 2016 02:04:17 +0000
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66d7-0000Rs-8N; Mon, 14 Nov 2016 02:04:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        "Leonid Yegoshin" <leonid.yegoshin@imgtec.com>
Date:   Mon, 14 Nov 2016 00:14:20 +0000
Message-ID: <lsq.1479082460.109059554@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 121/346] MIPS: c-r4k: Fix protected_writeback_scache_line
 for EVA
In-Reply-To: <lsq.1479082458.755945576@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.39-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 0758b116b4080d9a2a2a715bec6eee2cbd828215 upstream.

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
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13800/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/r4kcache.h | 4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -263,7 +263,11 @@ static inline void protected_writeback_d
 
 static inline void protected_writeback_scache_line(unsigned long addr)
 {
+#ifdef CONFIG_EVA
+	protected_cachee_op(Hit_Writeback_Inv_SD, addr);
+#else
 	protected_cache_op(Hit_Writeback_Inv_SD, addr);
+#endif
 }
 
 /*
