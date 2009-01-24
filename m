Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2009 19:11:05 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34199 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21366177AbZAXTK7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Jan 2009 19:10:59 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0OJAvhY014533;
	Sat, 24 Jan 2009 19:10:58 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0OJAtxV014518;
	Sat, 24 Jan 2009 19:10:55 GMT
Date:	Sat, 24 Jan 2009 19:10:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix oops in r4k_dma_cache_inv
Message-ID: <20090124191055.GA29966@linux-mips.org>
References: <20090124221542.bcc6c19f.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090124221542.bcc6c19f.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 24, 2009 at 10:15:42PM +0900, Yoichi Yuasa wrote:

Patch looks ok - but I think we also have to assume that the starting
address of the range might be miss-aligned, so how about this patch?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 56290a7..c43f4b2 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -619,8 +619,20 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 		if (size >= scache_size)
 			r4k_blast_scache();
 		else {
-			cache_op(Hit_Writeback_Inv_SD, addr);
-			cache_op(Hit_Writeback_Inv_SD, addr + size - 1);
+			unsigned long lsize = cpu_scache_line_size();
+			unsigned long almask = ~(lsize - 1);
+
+			/*
+			 * There is no clearly documented alignment requirement
+			 * for the cache instruction on MIPS processors and
+			 * some processors, among them the RM5200 and RM7000
+			 * QED processors will throw an address error for cache
+			 * hit ops with insufficient alignment.  Solved by
+			 * aligning the address to cache line size.
+			 */
+			cache_op(Hit_Writeback_Inv_SD, addr & almask);
+			cache_op(Hit_Writeback_Inv_SD,
+				 (addr + size - 1) & almask);
 			blast_inv_scache_range(addr, addr + size);
 		}
 		return;
@@ -629,9 +641,12 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 	if (cpu_has_safe_index_cacheops && size >= dcache_size) {
 		r4k_blast_dcache();
 	} else {
+		unsigned long lsize = cpu_dcache_line_size();
+		unsigned long almask = ~(lsize - 1);
+
 		R4600_HIT_CACHEOP_WAR_IMPL;
-		cache_op(Hit_Writeback_Inv_D, addr);
-		cache_op(Hit_Writeback_Inv_D, addr + size - 1);
+		cache_op(Hit_Writeback_Inv_D, addr & almask);
+		cache_op(Hit_Writeback_Inv_D, (addr + size - 1)  & almask);
 		blast_inv_dcache_range(addr, addr + size);
 	}
 
