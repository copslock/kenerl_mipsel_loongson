Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 13:01:39 +0000 (GMT)
Received: from nz-out-0506.google.com ([64.233.162.235]:44897 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022381AbXCWNBh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 13:01:37 +0000
Received: by nz-out-0506.google.com with SMTP id x7so781579nzc
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2007 06:00:32 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=cy1HkPC+qBlGyZ8fTGdLriR76PdaF5+8ZHe3vtxi9yukXo4aunrFiqr04CS75J2/blKrDOZvArvvy/KrYyRC6hRGOiwCv2KGBIJwiEe7q3BvI1zDOEFmuFEfCTz4seBLMvM2FwtzQB5lacvOYcQheMEsFAtOF81iTjIk3AX+X9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=GCpsDM71Dcb7J5MJYeWkbCEeElNRxf0xosDDc7XVCwEB/DH/JaqwRehLzXIlKzKqc9rEIGZ4dOxJkPhirGSfK9D+bsHefXwGjqEDJsLmeFofrkH0SDCX/jpcFf2XymbQo3YsxwI+zmeIqwF0EMjFxPLUd/2NqCsQWcEVRRbICd8=
Received: by 10.65.253.6 with SMTP id f6mr6641994qbs.1174654832046;
        Fri, 23 Mar 2007 06:00:32 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id c1sm11495173nfe.2007.03.23.06.00.31;
        Fri, 23 Mar 2007 06:00:31 -0700 (PDT)
Message-ID: <4603CF6C.6050507@innova-card.com>
Date:	Fri, 23 Mar 2007 14:00:28 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: [RFC] Simplify pte_offset_map() on 32 bits
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Looking its implementation, I'm wondering why this macro and its
sister "pte_offset_map_nested()" are so complex.

I changed their implementations as the following patch shows and my
tiny 32 bits machine still boot fine.

Code size is a little bit decreased:

	vmlinux  =>  vmlinux~patched
	 text:  3045700  3044664    -1036  0%
	 data:   155756   155756        0  0%
	  bss:  2269216  2269216        0  0%
	total:  5470672  5469636    -1036  0%


Could anybody have a look and tell me if I'm missing something ?

Thanks,
		Franck
-- >8 --

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 2fbd47e..a0e76e4 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -143,6 +143,7 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 #define __pgd_offset(address)	pgd_index(address)
 #define __pud_offset(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
 #define __pmd_offset(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
+#define __pte_offset(address)	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
@@ -153,17 +154,15 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 #define pgd_offset(mm,addr)	((mm)->pgd + pgd_index(addr))
 
 /* Find an entry in the third-level page table.. */
-#define __pte_offset(address)						\
-	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset(dir, address)					\
 	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 #define pte_offset_kernel(dir, address)					\
 	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 
 #define pte_offset_map(dir, address)                                    \
-	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 #define pte_offset_map_nested(dir, address)                             \
-	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 #define pte_unmap(pte) ((void)(pte))
 #define pte_unmap_nested(pte) ((void)(pte))
 
diff --git a/mm/memory.c b/mm/memory.c
