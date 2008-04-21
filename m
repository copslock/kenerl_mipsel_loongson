Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2008 09:52:09 +0100 (BST)
Received: from smtp6.pp.htv.fi ([213.243.153.40]:4001 "EHLO smtp6.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20038289AbYDUIwH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Apr 2008 09:52:07 +0100
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp6.pp.htv.fi (Postfix) with ESMTP id B53BF5BC03C;
	Mon, 21 Apr 2008 11:52:04 +0300 (EEST)
Date:	Mon, 21 Apr 2008 11:51:37 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] mips: unexport __kmap_atomic_to_page
Message-ID: <20080421085137.GF26897@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

This patch removes the no longer used export of __kmap_atomic_to_page.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
4d052a402ef108fb899e725d3492b605b8921d15 diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index 10dd2af..8f2cd8e 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -116,4 +116,3 @@ EXPORT_SYMBOL(__kmap);
 EXPORT_SYMBOL(__kunmap);
 EXPORT_SYMBOL(__kmap_atomic);
 EXPORT_SYMBOL(__kunmap_atomic);
-EXPORT_SYMBOL(__kmap_atomic_to_page);
