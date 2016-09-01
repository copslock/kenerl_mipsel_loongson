Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 18:32:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16654 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992285AbcIAQbDUo8g2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 18:31:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 422B0DD7DEE19;
        Thu,  1 Sep 2016 17:30:44 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 17:30:46 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 4/9] MIPS: c-r4k: Drop bc_wback_inv() from icache flush
Date:   Thu, 1 Sep 2016 17:30:10 +0100
Message-ID: <39c7d273f80cd15bd52fbc6a9bb88f2fdd36f616.1472747205.git-series.james.hogan@imgtec.com>
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
X-archive-position: 54932
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

The EVA conditional bc_wback_inv() at the end of flush_icache_range() to
flush the modified code all the way back to RAM was apparently there for
debug purposes and to accommodate the Malta EVA configuration which
makes use of a physical alias, and didn't use the CP0_EBase.WG (Write
Gate) bit to put the exception vector in the same physical alias where
the exception vector code is written and is being flushed.

Now that CP0_EBase.WG is used, lets drop this flush.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r4k.c | 11 -----------
 1 file changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index cd72805b64a7..0335a4be0635 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -752,17 +752,6 @@ static inline void __local_r4k_flush_icache_range(unsigned long start,
 			break;
 		}
 	}
-#ifdef CONFIG_EVA
-	/*
-	 * Due to all possible segment mappings, there might cache aliases
-	 * caused by the bootloader being in non-EVA mode, and the CPU switching
-	 * to EVA during early kernel init. It's best to flush the scache
-	 * to avoid having secondary cores fetching stale data and lead to
-	 * kernel crashes.
-	 */
-	bc_wback_inv(start, (end - start));
-	__sync();
-#endif
 }
 
 static inline void local_r4k_flush_icache_range(unsigned long start,
-- 
git-series 0.8.10
