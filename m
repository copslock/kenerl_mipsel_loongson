Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 17:50:16 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:1724 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133780AbWEZPuF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 May 2006 17:50:05 +0200
Received: (qmail 4953 invoked from network); 26 May 2006 19:58:00 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 26 May 2006 19:58:00 -0000
Message-ID: <44772379.30903@ru.mvista.com>
Date:	Fri, 26 May 2006 19:49:13 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>,
	Jordan Crouse <jordan.crouse@amd.com>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Fix non-linear memory mapping on MIPS
Content-Type: multipart/mixed;
 boundary="------------090503040602090601070409"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090503040602090601070409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

    Fix the non-linear memory mapping done via remap_file_pages() -- it didn't 
work on any MIPS CPU because the page offset was clashing with _PAGE_FILE and 
some other page protection bits which should have been left zeros for this
kind of pages.
    The patch has been tested on MIPS32, MIPS64, and Alchemy CPUs, only 
R3000/TX3927 part hasn't been tested for the lack of time...

Signed-off-by: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------090503040602090601070409
Content-Type: text/plain;
 name="MIPS-fix-non-linear-memory-mapping.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MIPS-fix-non-linear-memory-mapping.patch"

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 4d6bc45..e88cbd9 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -177,16 +177,19 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 	((swp_entry_t) { ((type) << 10) | ((offset) << 15) })
 
 /*
- * Bits 0, 1, 2, 9 and 10 are taken, split up the 27 bits of offset
+ * Bits 0, 3, 4, 8, and 9 are taken, split up 27 bits of offset
  * into this range:
  */
 #define PTE_FILE_MAX_BITS	27
 
-#define pte_to_pgoff(_pte) \
-	((((_pte).pte >> 3) & 0x3f ) + (((_pte).pte >> 11) << 8 ))
-
-#define pgoff_to_pte(off) \
-	((pte_t) { (((off) & 0x3f) << 3) + (((off) >> 8) << 11) + _PAGE_FILE })
+#define pte_to_pgoff(_pte)	((((_pte).pte >> 1 ) & 0x03) | \
+				 (((_pte).pte >> 3 ) & 0x1c) | \
+				 (((_pte).pte >> 10) <<  5 ))
+
+#define pgoff_to_pte(off)	((pte_t) { (((off) & 0x03) << 1 ) | \
+					   (((off) & 0x1c) << 3 ) | \
+					   (((off) >>  5 ) << 10) | \
+					   _PAGE_FILE })
 
 #else
 
@@ -196,24 +199,31 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 #define __swp_entry(type,offset)	\
 		((swp_entry_t) { ((type) << 8) | ((offset) << 13) })
 
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 /*
- * Bits 0, 1, 2, 7 and 8 are taken, split up the 27 bits of offset
+ * Bits 0 and 1 of pte_high are taken, split up 30 bits of offset
  * into this range:
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
+ * Bits 0, 3, 4, 6, and 7 are taken, split up 27 bits of offset
+ * into this range:
+ */
+#define PTE_FILE_MAX_BITS	27
 
-#define pgoff_to_pte(off) \
-	((pte_t) { (((off) & 0x1f) << 3) + (((off) >> 6) << 9) + _PAGE_FILE })
+#define pte_to_pgoff(_pte)	((((_pte).pte >> 1) & 0x3) | \
+				 (((_pte).pte >> 3) & 0x4) | \
+				 (((_pte).pte >> 8) <<  3))
+
+#define pgoff_to_pte(off)	((pte_t) { (((off) & 0x3) << 1) | \
+					   (((off) & 0x4) << 3) | \
+					   (((off) >> 3 ) << 8) | \
+					   _PAGE_FILE })
 #endif
 
 #endif
diff --git a/include/asm-mips/pgtable-64.h b/include/asm-mips/pgtable-64.h
index 82166b2..c0f3446 100644
--- a/include/asm-mips/pgtable-64.h
+++ b/include/asm-mips/pgtable-64.h
@@ -224,15 +224,12 @@ static inline pte_t mk_swap_pte(unsigned
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 /*
- * Bits 0, 1, 2, 7 and 8 are taken, split up the 32 bits of offset
- * into this range:
+ * Bits 0, 3, 4, 6, and 7 are taken. Let's leave bits 1, 2, and 5 alone
+ * to make things easier, and only use the upper 56 bits for the page offset...
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






--------------090503040602090601070409--
