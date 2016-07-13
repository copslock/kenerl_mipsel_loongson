Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:16:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51954 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993264AbcGMNNkHcNKh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:40 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 49612BBF71D44;
        Wed, 13 Jul 2016 14:13:21 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:24 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 06/13] MIPS: c-r4k: Avoid dcache flush for sigtramps
Date:   Wed, 13 Jul 2016 14:12:49 +0100
Message-ID: <1468415576-12600-7-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54317
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

Avoid the dcache and scache flush in local_r4k_flush_cache_sigtramp() if
the icache fills straight from the dcache.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r4k.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 600b0ad48319..58b810e67bba 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -841,12 +841,16 @@ static void local_r4k_flush_cache_sigtramp(void *args)
 	}
 
 	R4600_HIT_CACHEOP_WAR_IMPL;
-	if (dc_lsize)
-		vaddr ? flush_dcache_line(addr & ~(dc_lsize - 1))
-		      : protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
-	if (!cpu_icache_snoops_remote_store && scache_size)
-		vaddr ? flush_scache_line(addr & ~(sc_lsize - 1))
-		      : protected_writeback_scache_line(addr & ~(sc_lsize - 1));
+	if (!cpu_has_ic_fills_f_dc) {
+		if (dc_lsize)
+			vaddr ? flush_dcache_line(addr & ~(dc_lsize - 1))
+			      : protected_writeback_dcache_line(
+							addr & ~(dc_lsize - 1));
+		if (!cpu_icache_snoops_remote_store && scache_size)
+			vaddr ? flush_scache_line(addr & ~(sc_lsize - 1))
+			      : protected_writeback_scache_line(
+							addr & ~(sc_lsize - 1));
+	}
 	if (ic_lsize)
 		vaddr ? flush_icache_line(addr & ~(ic_lsize - 1))
 		      : protected_flush_icache_line(addr & ~(ic_lsize - 1));
-- 
2.4.10
