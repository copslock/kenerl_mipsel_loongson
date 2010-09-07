Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Sep 2010 06:15:59 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:44959 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490963Ab0IGEPz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Sep 2010 06:15:55 +0200
Received: (qmail 3663 invoked from network); 7 Sep 2010 04:15:52 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 7 Sep 2010 04:15:52 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Mon, 06 Sep 2010 21:15:52 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 6 Sep 2010 21:03:46 -0700
Subject: [PATCH 2/5] MIPS: sync after cacheflush
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Message-Id: <72d10d33beedb9d877a7373dafc04a75@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 27720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4956

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
index 6721ee2..05c3de3 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -605,6 +605,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 			r4k_blast_scache();
 		else
 			blast_scache_range(addr, addr + size);
+		__sync();
 		return;
 	}
 
@@ -621,6 +622,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 	}
 
 	bc_wback_inv(addr, size);
+	__sync();
 }
 
 static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
@@ -648,6 +650,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 				 (addr + size - 1) & almask);
 			blast_inv_scache_range(addr, addr + size);
 		}
+		__sync();
 		return;
 	}
 
@@ -664,6 +667,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 	}
 
 	bc_inv(addr, size);
+	__sync();
 }
 #endif /* CONFIG_DMA_NONCOHERENT */
 
-- 
1.7.0.4
