Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 14:31:19 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:11238 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038642AbWJMNbP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 14:31:15 +0100
Received: by nf-out-0910.google.com with SMTP id a25so873718nfc
        for <linux-mips@linux-mips.org>; Fri, 13 Oct 2006 06:31:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=DbxLxeBdz9AO5+QYwDpq8y6Bmk/XnkIprbpOuOz8hvSBcDqQkdJonUdrXDSO2uf0AVZlp/D60bC5+3L527c7sVJseZVljKyTwqiGH0O5SwKlsJErdWDc+8SI7UEq80tn70vMYcfYKVpWJFd2t0O/VKMCo9UDnbCAVu36HrdR3SM=
Received: by 10.48.210.16 with SMTP id i16mr2089608nfg;
        Fri, 13 Oct 2006 06:31:15 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id m15sm1015853nfc.2006.10.13.06.31.14;
        Fri, 13 Oct 2006 06:31:15 -0700 (PDT)
Message-ID: <452F951C.4020509@innova-card.com>
Date:	Fri, 13 Oct 2006 15:31:08 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
CC:	ralf@linux-mips.org, anemo@mba.ocn.ne.jp, ths@networkno.de,
	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: Re: [PATCH 7/7] Make free_init_pages() arguments to be physical addresses
References: <11607431461469-git-send-email-fbuihuu@gmail.com> <1160743147155-git-send-email-fbuihuu@gmail.com>
In-Reply-To: <1160743147155-git-send-email-fbuihuu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
[snip]
>  void free_initrd_mem(unsigned long start, unsigned long end)
>  {
> -	free_init_pages("initrd memory", start, end);
> +	free_init_pages("initrd memory",
> +			virt_to_phys(start),
> +			virt_to_phys(end));
>  }

argh, this part generates warnings... please consider the patch
below instead.

-- >8 --

Subject: [PATCH 7/7] Make free_init_pages() arguments to be physical addresses

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
