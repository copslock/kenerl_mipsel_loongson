Received:  by oss.sgi.com id <S554050AbQLBM3i>;
	Sat, 2 Dec 2000 04:29:38 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:61962 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554053AbQLBM30>;
	Sat, 2 Dec 2000 04:29:26 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 4C4F2805; Sat,  2 Dec 2000 13:29:20 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A036A8F74; Sat,  2 Dec 2000 13:28:41 +0100 (CET)
Date:   Sat, 2 Dec 2000 13:28:41 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: [PATCH] compile fix for mm/r4xx0.c
Message-ID: <20001202132841.B2002@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Comments ?

Index: r4xx0.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/r4xx0.c,v
retrieving revision 1.45
diff -u -r1.45 arch/mips/mm/r4xx0.c
--- arch/mips/mm/r4xx0.c	2000/11/29 22:00:30	1.45
+++ arch/mips/mm/r4xx0.c	2000/12/02 12:21:06
@@ -1967,16 +1967,17 @@
 	if (!(vma->vm_flags & VM_EXEC))
 		return;
 
-	blast_icache16_page(address);
+	blast_icache16_page((unsigned long)page_address(page));
 }
 
 static void
 r4k_flush_icache_page_i32(struct vm_area_struct *vma, struct page *page)
 {
+	int address;
 	if (!(vma->vm_flags & VM_EXEC))
 		return;
 
-	address = KSEG0 + (address & PAGE_MASK & (dcache_size - 1));
+	address = KSEG0 + ((unsigned long)page_address(page) & PAGE_MASK & (dcache_size - 1));
 	blast_icache32_page_indexed(address);
 }
 
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
