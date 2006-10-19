Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 12:22:43 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:18911 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038251AbWJSLUK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 12:20:10 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1027109nfc
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 04:20:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=klsUO3TnouTMqXlStn7mwNV4DmZQdiEOvhw9MuZxlsIMeWjNpaGUkd8gdbu22wK8Oi/pnpDPMf5uIpwr+wbPhlKW54jbKJqLCvX8MCGwJ8Qef5GqRlaow1hZ/U2zxV02q8ZsL2gyOQFxuOaMJJI9VzPuUucC+RRbN7mzuwNBNCg=
Received: by 10.48.230.18 with SMTP id c18mr5588502nfh;
        Thu, 19 Oct 2006 04:20:09 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id m15sm841330nfc.2006.10.19.04.20.09;
        Thu, 19 Oct 2006 04:20:09 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id DDB8A23F775; Thu, 19 Oct 2006 13:20:06 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 7/7] Make free_init_pages() arguments to be physical addresses
Date:	Thu, 19 Oct 2006 13:20:05 +0200
Message-Id: <11612568063714-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11612568052624-git-send-email-fbuihuu@gmail.com>
References: <11612568052624-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

It allows caller of this function to not care about CKSEG0/XKPHYS
address mixes. It's now automatically done by free_init_pages().

We can now safely remove hack needed by 64 bit kernels with
CONFIG_BUILD_ELF64=n in free_initmem().

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/init.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 072b3b0..733bdec 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -485,15 +485,18 @@ #endif
 }
 #endif /* !CONFIG_NEED_MULTIPLE_NODES */
 
-void free_init_pages(char *what, unsigned long begin, unsigned long end)
+static void free_init_pages(char *what, unsigned long begin, unsigned long end)
 {
-	unsigned long addr;
+	unsigned long pfn;
 
-	for (addr = begin; addr < end; addr += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page((void *)addr));
-		init_page_count(virt_to_page((void *)addr));
-		memset((void *)addr, 0xcc, PAGE_SIZE);
-		free_page(addr);
+	for (pfn = PFN_UP(begin); pfn < PFN_DOWN(end); pfn++) {
+		struct page *page = pfn_to_page(pfn);
+		void *addr = phys_to_virt(PFN_PHYS(pfn));
+
+		ClearPageReserved(page);
+		init_page_count(page);
+		memset(addr, POISON_FREE_INITMEM, PAGE_SIZE);
+		__free_page(page);
 		totalram_pages++;
 	}
 	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
@@ -502,7 +505,9 @@ void free_init_pages(char *what, unsigne
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	free_init_pages("initrd memory", start, end);
+	free_init_pages("initrd memory",
+			virt_to_phys((void *)start),
+			virt_to_phys((void *)end));
 }
 #endif
 
@@ -510,17 +515,13 @@ extern unsigned long prom_free_prom_memo
 
 void free_initmem(void)
 {
-	unsigned long start, end, freed;
+	unsigned long freed;
 
 	freed = prom_free_prom_memory();
 	if (freed)
 		printk(KERN_INFO "Freeing firmware memory: %ldk freed\n",freed);
 
-	start = (unsigned long)(&__init_begin);
-	end = (unsigned long)(&__init_end);
-#ifdef CONFIG_64BIT
-	start = PAGE_OFFSET | CPHYSADDR(start);
-	end = PAGE_OFFSET | CPHYSADDR(end);
-#endif
-	free_init_pages("unused kernel memory", start, end);
+	free_init_pages("unused kernel memory",
+			__pa_symbol(&__init_begin),
+			__pa_symbol(&__init_end));
 }
-- 
1.4.2.3
