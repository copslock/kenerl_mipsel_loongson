Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Feb 2016 11:09:01 +0100 (CET)
Received: from smtpbg202.qq.com ([184.105.206.29]:45399 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006863AbcB0KI6l5xx1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 27 Feb 2016 11:08:58 +0100
X-QQ-mid: bizesmtp15t1456567702t047t08
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 27 Feb 2016 18:07:41 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: +c2Kczbw9d2ojlD+MUoxfauEbxtMjB440VC4+Aksg1OtcXyOQDHHBqaODWPoW
        cUKRKp1itQRw/jczKTVkGjgiE0tBWbGNl238I8KDi1sbKzHMr+MfH2EQzi2fUTfmG9ckHF+
        a1rbaYvxxeWbwTuGICI1fPyHSjhTtJ3bcFzkUAGOp3a0hg8s9D1FuMrHH9UBtqNNldRxpFr
        0JJFL9q3ipk2I3kE3sIALCfZL15/py80c59Hy8zOE3sqG7UvC2nQKXv7CXLRBafrpruljgm
        ew2bt8tJfiv9QEq79CX3oPaGA=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V4 2/5] MIPS: Loongson-3: Set cache flush handlers to cache_noop
Date:   Sat, 27 Feb 2016 18:07:35 +0800
Message-Id: <1456567658-14694-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456567658-14694-1-git-send-email-chenhc@lemote.com>
References: <1456567658-14694-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52351
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
