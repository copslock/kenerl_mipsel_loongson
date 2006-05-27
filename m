Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 May 2006 20:40:42 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:35035 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133770AbWE0Ske (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 May 2006 20:40:34 +0200
Received: (qmail 15465 invoked from network); 27 May 2006 22:48:37 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 27 May 2006 22:48:37 -0000
Message-ID: <44789CEB.2050001@ru.mvista.com>
Date:	Sat, 27 May 2006 22:39:39 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>,
	Jordan Crouse <jordan.crouse@amd.com>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Fix non-linear memory mapping on MIPS (take 2)
References: <44772379.30903@ru.mvista.com>
In-Reply-To: <44772379.30903@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------000902050009090303030904"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000902050009090303030904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

    Fix the non-linear memory mapping done via remap_file_pages() -- it didn't 
work on any MIPS CPU because the page offset clashing with _PAGE_FILE and some 
other page protection bits which should have been left zeros for this kind of 
pages.
    The patch has been tested on MIPS32, MIPS64, and Alchemy CPUs, only
R3000/TX3927 part hasn't been tested for the lack of time...

Signed-off-by: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------000902050009090303030904
Content-Type: text/plain;
 name="MIPS-fix-non-linear-memory-mapping.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MIPS-fix-non-linear-memory-mapping.patch"

Index: linux-mips/include/asm-mips/pgtable-32.h
===================================================================
--- linux-mips.orig/include/asm-mips/pgtable-32.h
+++ linux-mips/include/asm-mips/pgtable-32.h
@@ -177,16 +177,18 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 	((swp_entry_t) { ((type) << 10) | ((offset) << 15) })
 
 /*
- * Bits 0, 1, 2, 9 and 10 are taken, split up the 27 bits of offset
- * into this range:
+ * Bits 0, 4, 8, and 9 are taken, split up 28 bits of offset into this range:
  */
-#define PTE_FILE_MAX_BITS	27
+#define PTE_FILE_MAX_BITS	28
 
-#define pte_to_pgoff(_pte) \
-	((((_pte).pte >> 3) & 0x3f ) + (((_pte).pte >> 11) << 8 ))
-
-#define pgoff_to_pte(off) \
-	((pte_t) { (((off) & 0x3f) << 3) + (((off) >> 8) << 11) + _PAGE_FILE })
+#define pte_to_pgoff(_pte)	((((_pte).pte >> 1 ) & 0x07) | \
+				 (((_pte).pte >> 2 ) & 0x38) | \
+				 (((_pte).pte >> 10) <<  6 ))
+
+#define pgoff_to_pte(off)	((pte_t) { (((off) & 0x07) << 1 ) | \
+					   (((off) & 0x38) << 2 ) | \
+					   (((off) >>  6 ) << 10) | \
+					   _PAGE_FILE })
 
 #else
 
@@ -203,24 +205,29 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 		((swp_entry_t)  { ((type) << 8) | ((offset) << 13) })
 #endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 /*
- * Bits 0, 1, 2, 7 and 8 are taken, split up the 27 bits of offset
- * into this range:
+ * Bits 0 and 1 of pte_high are taken, use the rest for the page offset...
  */
-#define PTE_FILE_MAX_BITS	27
+#define PTE_FILE_MAX_BITS	30
 
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
-	/* fixme */
-#define pte_to_pgoff(_pte) (((_pte).pte_high >> 6) + ((_pte).pte_high & 0x3f))
-#define pgoff_to_pte(off) \
-	((pte_t){(((off) & 0x3f) + ((off) << 6) + _PAGE_FILE)})
+#define pte_to_pgoff(_pte)	((_pte).pte_high >> 2)
+#define pgoff_to_pte(off) 	((pte_t) { _PAGE_FILE, (off) << 2 })
 
 #else
-#define pte_to_pgoff(_pte) \
-	((((_pte).pte >> 3) & 0x1f ) + (((_pte).pte >> 9) << 6 ))
+/*
+ * Bits 0, 4, 6, and 7 are taken, split up 28 bits of offset into this range:
+ */
+#define PTE_FILE_MAX_BITS	28
 
-#define pgoff_to_pte(off) \
-	((pte_t) { (((off) & 0x1f) << 3) + (((off) >> 6) << 9) + _PAGE_FILE })
+#define pte_to_pgoff(_pte)	((((_pte).pte >> 1) & 0x7) | \
+				 (((_pte).pte >> 2) & 0x8) | \
+				 (((_pte).pte >> 8) <<  4))
+
+#define pgoff_to_pte(off)	((pte_t) { (((off) & 0x7) << 1) | \
+					   (((off) & 0x8) << 2) | \
+					   (((off) >>  4) << 8) | \
+					   _PAGE_FILE })
 #endif
 
 #endif
Index: linux-mips/include/asm-mips/pgtable-64.h
===================================================================
--- linux-mips.orig/include/asm-mips/pgtable-64.h
+++ linux-mips/include/asm-mips/pgtable-64.h
@@ -224,15 +224,12 @@ static inline pte_t mk_swap_pte(unsigned
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 /*
- * Bits 0, 1, 2, 7 and 8 are taken, split up the 32 bits of offset
- * into this range:
+ * Bits 0, 4, 6, and 7 are taken. Let's leave bits 1, 2, 3, and 5 alone to
+ * make things easier, and only use the upper 56 bits for the page offset...
  */
-#define PTE_FILE_MAX_BITS	32
+#define PTE_FILE_MAX_BITS	56
 
-#define pte_to_pgoff(_pte) \
-	((((_pte).pte >> 3) & 0x1f ) + (((_pte).pte >> 9) << 6 ))
-
-#define pgoff_to_pte(off) \
-	((pte_t) { (((off) & 0x1f) << 3) + (((off) >> 6) << 9) + _PAGE_FILE })
+#define pte_to_pgoff(_pte)	((_pte).pte >> 8)
+#define pgoff_to_pte(off)	((pte_t) { ((off) << 8) | _PAGE_FILE })
 
 #endif /* _ASM_PGTABLE_64_H */


--------------000902050009090303030904--
