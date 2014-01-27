Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:32:58 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43665 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870559AbaA0UYdgu00B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:24:33 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 39/58] MIPS: asm: r4kcache: Build flushing code for instruction cache
Date:   Mon, 27 Jan 2014 20:19:26 +0000
Message-ID: <1390853985-14246-40-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_24_33
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39156
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Build code to invalidate an address range in the  instruction cache
using the Hit Invalidate cache operation.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/r4kcache.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 34d1a19..a89e86d 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -455,6 +455,7 @@ __BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I, protected_, )
 __BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I_Loongson23, \
 	protected_, loongson23_)
 __BUILD_BLAST_CACHE_RANGE(d, dcache, Hit_Writeback_Inv_D, , )
+__BUILD_BLAST_CACHE_RANGE(i, icache, Hit_Invalidate_I, , )
 __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, , )
 /* blast_inv_dcache_range */
 __BUILD_BLAST_CACHE_RANGE(inv_d, dcache, Hit_Invalidate_D, , )
-- 
1.8.5.3
