Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Sep 2009 04:21:58 +0200 (CEST)
Received: from [65.98.92.6] ([65.98.92.6]:1696 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491787AbZISCVu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 19 Sep 2009 04:21:50 +0200
Received: (qmail 32385 invoked from network); 19 Sep 2009 02:21:44 -0000
Received: from unknown (HELO two) (127.0.0.1)
  by 127.0.0.1 with SMTP; 19 Sep 2009 02:21:44 -0000
Received: by two (sSMTP sendmail emulation); Fri, 18 Sep 2009 19:21:44 -0700
From:	Kevin Cernekee <cernekee@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Date:	Fri, 18 Sep 2009 19:12:45 -0700
Subject: [PATCH] MIPS: Avoid destructive invalidation on partial L2 cachelines
Message-Id: <de70b67245e012ab0c11b520a721989b@localhost>
User-Agent: vim 7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

This extends commit a8ca8b64e3fdfec17679cba0ca5ce6e3ffed092d to cover
the board cache code.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/mm/sc-mips.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index b55c2d1..5ab5fa8 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -32,6 +32,11 @@ static void mips_sc_wback_inv(unsigned long addr, unsigned long size)
  */
 static void mips_sc_inv(unsigned long addr, unsigned long size)
 {
+	unsigned long lsize = cpu_scache_line_size();
+	unsigned long almask = ~(lsize - 1);
+
+	cache_op(Hit_Writeback_Inv_SD, addr & almask);
+	cache_op(Hit_Writeback_Inv_SD, (addr + size - 1) & almask);
 	blast_inv_scache_range(addr, addr + size);
 }
 
-- 
1.6.3.1
