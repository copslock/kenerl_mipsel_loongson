Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2007 15:00:32 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:27817 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037636AbXBSPAa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Feb 2007 15:00:30 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1JF0UGQ009862;
	Mon, 19 Feb 2007 15:00:30 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1JF0Txr009861;
	Mon, 19 Feb 2007 15:00:29 GMT
Date:	Mon, 19 Feb 2007 15:00:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Declare highstart_pfn, highend_pfn only if CONFIG_HIGHMEM=y
Message-ID: <20070219150029.GA9808@linux-mips.org>
References: <20070218.005748.27954771.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070218.005748.27954771.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 18, 2007 at 12:57:48AM +0900, Atsushi Nemoto wrote:

Thanks, I'll go for this slightly cleaner variant.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 13a4208..f08ae71 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -61,8 +61,6 @@
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
-unsigned long highstart_pfn, highend_pfn;
-
 /*
  * We have up to 8 empty zeroed pages so we can map one of the right colour
  * when needed.  This is necessary only on R4000 / R4400 SC and MC versions
@@ -261,6 +259,8 @@ EXPORT_SYMBOL(copy_from_user_page);
 
 
 #ifdef CONFIG_HIGHMEM
+unsigned long highstart_pfn, highend_pfn;
+
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
 
