Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 17:14:46 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:58187 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039624AbWJPQMY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Oct 2006 17:12:24 +0100
Received: by nf-out-0910.google.com with SMTP id l23so2530946nfc
        for <linux-mips@linux-mips.org>; Mon, 16 Oct 2006 09:12:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=a5JjquTlEUV3P7DEFs2OucDRWBu86o9doO1iyg41CCOHDdOHNozFau0BjckZnf/15MMPsIYr0BNrzyyjzpi3Ue7SfBV+uKYn1Ct13MTemDpv+PKuGe0aCaLKkN/eWclIdDPEIZIFiqW8w27FOjXXtrFj2GXugpglLgaZDDjOF/Q=
Received: by 10.48.254.10 with SMTP id b10mr12376396nfi;
        Mon, 16 Oct 2006 09:12:20 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id c28sm1140203nfb.2006.10.16.09.12.20;
        Mon, 16 Oct 2006 09:12:20 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 8D1A723F774; Mon, 16 Oct 2006 18:12:22 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 7/7] Make free_init_pages() arguments to be physical addresses
Date:	Mon, 16 Oct 2006 18:12:21 +0200
Message-Id: <11610151422647-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <1161015141975-git-send-email-fbuihuu@gmail.com>
References: <1161015141975-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12976
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
