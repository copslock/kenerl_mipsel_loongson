Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2006 09:38:46 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.190]:36120 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038971AbWLEJil (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Dec 2006 09:38:41 +0000
Received: by nf-out-0910.google.com with SMTP id l24so156791nfc
        for <linux-mips@linux-mips.org>; Tue, 05 Dec 2006 01:38:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=kVRJ7whDkyr7ggJYQqNIeUWQ/s9L7o24yNLvHqwd0kshIuqBSKCSMQvQeZYQyDILLnpIN/AYj0uC2UaxMmo2fm4p+sIDELTl+ukqDFf5q16w5vhXTDHHnwBE3ZYVv6lWM9Kb4MV/PrFmxybkGMocDmJBjW2Sytc2tQS9ySFSeVI=
Received: by 10.49.57.14 with SMTP id j14mr585706nfk.1165311520956;
        Tue, 05 Dec 2006 01:38:40 -0800 (PST)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id d2sm1948705nfe.2006.12.05.01.38.40;
        Tue, 05 Dec 2006 01:38:40 -0800 (PST)
Message-ID: <45753E6C.1030702@innova-card.com>
Date:	Tue, 05 Dec 2006 10:39:56 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] pte_offset(dir,addr): parenthesis fix
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch adds missing parenthesis around 'dir' argument in
pte_offset() macro definition.

It also removes an extra space in the definition of
pte_offset_kernel() macro.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 Hi Ralf,
 Could you apply this trivial patch ?

 include/asm-mips/pgtable-32.h |    6 +++---
 include/asm-mips/pgtable-64.h |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index d20f2e9..2fbd47e 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -156,9 +156,9 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 #define __pte_offset(address)						\
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset(dir, address)					\
-	((pte_t *) (pmd_page_vaddr(*dir)) + __pte_offset(address))
-#define pte_offset_kernel(dir, address) \
-	((pte_t *) pmd_page_vaddr(*(dir)) +  __pte_offset(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
+#define pte_offset_kernel(dir, address)					\
+	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 
 #define pte_offset_map(dir, address)                                    \
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
diff --git a/include/asm-mips/pgtable-64.h b/include/asm-mips/pgtable-64.h
index b9b1e86..a5b1871 100644
--- a/include/asm-mips/pgtable-64.h
+++ b/include/asm-mips/pgtable-64.h
@@ -212,9 +212,9 @@ static inline pmd_t *pmd_offset(pud_t *
 #define __pte_offset(address)						\
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset(dir, address)					\
-	((pte_t *) (pmd_page_vaddr(*dir)) + __pte_offset(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 #define pte_offset_kernel(dir, address)					\
-	((pte_t *) pmd_page_vaddr(*(dir)) +  __pte_offset(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 #define pte_offset_map(dir, address)					\
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
 #define pte_offset_map_nested(dir, address)				\
-- 
1.4.4.1
