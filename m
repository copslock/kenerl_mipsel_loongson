Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 19:32:08 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:50541 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491931Ab0KWScB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 19:32:01 +0100
Received: (qmail 5530 invoked from network); 23 Nov 2010 18:31:57 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 23 Nov 2010 18:31:57 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Tue, 23 Nov 2010 10:31:57 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <macro@linux-mips.org>, <skuribay@pobox.com>, <raiko@niisi.msk.ru>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 1/7] MIPS: sync after cacheflush
Date:   Tue, 23 Nov 2010 10:26:39 -0800
Message-Id: <8a8eee995454c8b271cceb440e31699a@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On processors with deep write buffers, it is likely that many cycles
will pass between a CACHE instruction and the time the data actually
gets written out to DRAM.  Add a SYNC instruction to ensure that the
buffers get emptied before the flush functions return.

Actual problem seen in the wild:

1) dma_alloc_coherent() allocates cached memory

2) memset() is called to clear the new pages

3) dma_cache_wback_inv() is called to flush the zero data out to memory

4) dma_alloc_coherent() returns an uncached (kseg1) pointer to the
freshly allocated pages

5) Caller writes data through the kseg1 pointer

6) Buffered writeback data finally gets flushed out to DRAM

7) Part of caller's data is inexplicably zeroed out

This patch adds SYNC between steps 3 and 4, which fixed the problem.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/mm/c-r4k.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index b4923a7..dc5d9c4 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -604,6 +604,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 			r4k_blast_scache();
 		else
 			blast_scache_range(addr, addr + size);
+		__sync();
 		return;
 	}
 
@@ -620,6 +621,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 	}
 
 	bc_wback_inv(addr, size);
+	__sync();
 }
 
 static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
@@ -647,6 +649,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 				 (addr + size - 1) & almask);
 			blast_inv_scache_range(addr, addr + size);
 		}
+		__sync();
 		return;
 	}
 
@@ -663,6 +666,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 	}
 
 	bc_inv(addr, size);
+	__sync();
 }
 #endif /* CONFIG_DMA_NONCOHERENT */
 
-- 
1.7.0.4
