Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 15:48:35 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.185]:15474 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038486AbWLFPrI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 15:47:08 +0000
Received: by nf-out-0910.google.com with SMTP id l24so555907nfc
        for <linux-mips@linux-mips.org>; Wed, 06 Dec 2006 07:47:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=qe03BI23PZnFQMoZ63XLQRF0RIRDhVDgIyGcy3JGSH1yJMKeeutse5OL2+OTg26WEBi+mJ9Qm9AccgUuc38qVBqOBw2W56nXwBfnrgMpyIEhh88hZG234yRNf9Feh+zkjbP42QPbLvPAPiZ8IiaLl7oNteoIgphFvB1VRXZCGLI=
Received: by 10.48.254.10 with SMTP id b10mr2414826nfi.1165420026878;
        Wed, 06 Dec 2006 07:47:06 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id m16sm2290262nfc.2006.12.06.07.47.06;
        Wed, 06 Dec 2006 07:47:06 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 9CCEA23F759; Wed,  6 Dec 2006 16:48:30 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 1/3] paging_init(): use highend_pfn/highstart_pfn
Date:	Wed,  6 Dec 2006 16:48:28 +0100
Message-Id: <11654201101028-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <1165420110699-git-send-email-fbuihuu@gmail.com>
References: <1165420110699-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch makes paging_init() use highend_pfn/highstart_pfn globals.

It removes the need of 'high' local which was needed only by
HIGHMEM config.

More important perhaps, it fixes a bug when HIGHMEM is set
but there's actually no physical highmem (highend_pfn = 0)

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/init.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 1db991d..30245c0 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -341,7 +341,7 @@ static int __init page_is_ram(unsigned l
 void __init paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
-	unsigned long max_dma, high, low;
+	unsigned long max_dma, low;
 #ifndef CONFIG_FLATMEM
 	unsigned long zholes_size[MAX_NR_ZONES] = { 0, };
 	unsigned long i, j, pfn;
@@ -356,7 +356,6 @@ void __init paging_init(void)
 
 	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 	low = max_low_pfn;
-	high = highend_pfn;
 
 #ifdef CONFIG_ISA
 	if (low < max_dma)
@@ -369,13 +368,13 @@ void __init paging_init(void)
 	zones_size[ZONE_DMA] = low;
 #endif
 #ifdef CONFIG_HIGHMEM
-	if (cpu_has_dc_aliases) {
-		printk(KERN_WARNING "This processor doesn't support highmem.");
-		if (high - low)
-			printk(" %ldk highmem ignored", high - low);
-		printk("\n");
-	} else
-		zones_size[ZONE_HIGHMEM] = high - low;
+	zones_size[ZONE_HIGHMEM] = highend_pfn - highstart_pfn;
+
+	if (cpu_has_dc_aliases && zones_size[ZONE_HIGHMEM]) {
+		printk(KERN_WARNING "This processor doesn't support highmem."
+		       " %ldk highmem ignored\n", zones_size[ZONE_HIGHMEM]);
+		zones_size[ZONE_HIGHMEM] = 0;
+	}
 #endif
 
 #ifdef CONFIG_FLATMEM
-- 
1.4.4.1
