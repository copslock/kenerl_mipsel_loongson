Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 04:46:32 +0100 (CET)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:40475 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007642AbcCBDqITdQgd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Mar 2016 04:46:08 +0100
X-QQ-mid: bizesmtp15t1456890345t465t20
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 02 Mar 2016 11:45:15 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK70B00A0000000
X-QQ-FEAT: uuX/0Mknq+qBKX4wVSFydyK1Jk4QKouz5nbN/N2+p/HM2HDTbqxHqaCMslMa0
        iStxAQ4qE16cdtnU3q4lhidz0Q01EH7eWU/EV96bR3K3ZIQaiV9FzUoCcSTXjXSb806RzYV
        a3JIauBDVhD48p3RrbHj7OTP45LrBaXu64vQtgHBjtqpNet5jxl+o6/fgN394z4fWEBtsly
        gvadD3DNqr0dv+7x6bwV85kjEvkkzfs7NjMeulD2kn14IIH2uorzOSPLA2zHuW3K9UidU1e
        tlcwo3v7i6jMjd
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V5 2/5] MIPS: Loongson-3: Set cache flush handlers to cache_noop
Date:   Wed,  2 Mar 2016 11:45:12 +0800
Message-Id: <1456890315-28814-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456890315-28814-1-git-send-email-chenhc@lemote.com>
References: <1456890315-28814-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Loongson-3 maintains cache coherency by hardware, this means:
 1) It's icache is coherent with dcache.
 2) It's dcaches don't alias (maybe depend on PAGE_SIZE).
 3) It maintains cache coherency across cores (and for DMA).

So we can skip most cache flush operations by setting relevant handlers
to `cache_noop' in `r4k_cache_init'.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/mm/c-r4k.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 2abc73d..8df4a94 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1777,6 +1777,20 @@ void r4k_cache_init(void)
 		/* Optimization: an L2 flush implicitly flushes the L1 */
 		current_cpu_data.options |= MIPS_CPU_INCLUSIVE_CACHES;
 		break;
+	case CPU_LOONGSON3:
+		/* Loongson-3 maintains cache coherency by hardware */
+		__flush_cache_all	= cache_noop;
+		__flush_cache_vmap	= cache_noop;
+		__flush_cache_vunmap	= cache_noop;
+		__flush_kernel_vmap_range = (void *)cache_noop;
+		flush_cache_mm		= (void *)cache_noop;
+		flush_cache_page	= (void *)cache_noop;
+		flush_cache_range	= (void *)cache_noop;
+		flush_cache_sigtramp	= (void *)cache_noop;
+		flush_icache_all	= (void *)cache_noop;
+		flush_data_cache_page	= (void *)cache_noop;
+		local_flush_data_cache_page	= (void *)cache_noop;
+		break;
 	}
 }
 
-- 
2.7.0
