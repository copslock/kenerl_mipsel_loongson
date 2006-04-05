Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2006 14:35:46 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:2196 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133357AbWDENfg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Apr 2006 14:35:36 +0100
Received: (qmail 14294 invoked from network); 5 Apr 2006 17:47:58 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 5 Apr 2006 17:47:58 -0000
Message-ID: <4433C9EE.8030402@ru.mvista.com>
Date:	Wed, 05 Apr 2006 17:45:18 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Bob Breuer <bbreuer@righthandtech.com>,
	Manish Lachwani <mlachwani@mvista.com>,
	Jordan Crouse <jordan.crouse@amd.com>
Subject: [PATCH] Fix swap entry for MIPS32 36-bit physical address
References: <B482D8AA59BF244F99AFE7520D74BF9609D4F2@server1.RightHand.righthandtech.com>
In-Reply-To: <B482D8AA59BF244F99AFE7520D74BF9609D4F2@server1.RightHand.righthandtech.com>
Content-Type: multipart/mixed;
 boundary="------------010001090406010900080603"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010001090406010900080603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    With 64-bit physical address enabled, 'swapon' was causing kernel oops
on Alchemy CPUs (MIPS32R1) because of the swap entry type field corrupting the
_PAGE_FILE bit in pte_low. So, change layout of the swap entry to use all bits
except _PAGE_PRESENT and _PAGE_FILE (the harware protection bits are loaded
from pte_high which should be cleared by __swp_entry_to_pte() macro) -- which
gives 25 bits for the swap entry offset.
    Additionally, PTEs in MIPS32R2 should have the same layout for the 36-bit
physical address case as in MIPS32R1, according to the architecture manuals --
so, fix the #ifdef's.

WBR, Sergei

Signed-off-by: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------010001090406010900080603
Content-Type: text/plain;
 name="MIPS32-36bit-phys-addr-swap-entry-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MIPS32-36bit-phys-addr-swap-entry-fix.patch"

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 0cff64c..89c269f 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -116,7 +116,7 @@ static inline void pmd_clear(pmd_t *pmdp
 	pmd_val(*pmdp) = ((unsigned long) invalid_pte_table);
 }
 
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pte_pfn(x)		((unsigned long)((x).pte_high >> 6))
 static inline pte_t
@@ -139,7 +139,7 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 #define pte_pfn(x)		((unsigned long)((x).pte >> PAGE_SHIFT))
 #define pfn_pte(pfn, prot)	__pte(((unsigned long long)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #endif
-#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1) */
+#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 
 #define __pgd_offset(address)	pgd_index(address)
 #define __pud_offset(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
@@ -190,11 +190,27 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 
 #else
 
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+/*
+ * For 36-bit physical address we store swap entry in pte_low and 0 in pte_high,
+ * which gives up 25 bits available for swap offset.
+ */
+#define __swp_type(x)		((x).val & 0x1f)
+#define __swp_offset(x) 	((((x).val >> 5) & 0x1) | \
+				 (((x).val >> 6) & 0xe) | \
+				 (((x).val >> 11) << 4))
+#define __swp_entry(type,offset) \
+		((swp_entry_t) {((type) & 0x1f ) | \
+				(((offset) & 0x1) << 5) | \
+				(((offset) & 0xe) << 6) | \
+				(((offset) >> 4 ) << 11)})
+#else
 /* Swap entries must have VALID and GLOBAL bits cleared. */
 #define __swp_type(x)		(((x).val >> 8) & 0x1f)
 #define __swp_offset(x)		((x).val >> 13)
 #define __swp_entry(type,offset)	\
 		((swp_entry_t) { ((type) << 8) | ((offset) << 13) })
+#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 
 /*
  * Bits 0, 1, 2, 7 and 8 are taken, split up the 27 bits of offset
@@ -202,7 +218,7 @@ pfn_pte(unsigned long pfn, pgprot_t prot
  */
 #define PTE_FILE_MAX_BITS	27
 
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 	/* fixme */
 #define pte_to_pgoff(_pte) (((_pte).pte_high >> 6) + ((_pte).pte_high & 0x3f))
 #define pgoff_to_pte(off) \
diff --git a/include/asm-mips/pgtable-bits.h b/include/asm-mips/pgtable-bits.h
index 01e76e9..8cbc493 100644
--- a/include/asm-mips/pgtable-bits.h
+++ b/include/asm-mips/pgtable-bits.h
@@ -33,7 +33,7 @@
  * unpredictable things.  The code (when it is written) to deal with
  * this problem will be in the update_mmu_cache() code for the r4k.
  */
-#if defined(CONFIG_CPU_MIPS32_R1) && defined(CONFIG_64BIT_PHYS_ADDR)
+#if defined(CONFIG_CPU_MIPS32) && defined(CONFIG_64BIT_PHYS_ADDR)
 
 #define _PAGE_PRESENT               (1<<6)  /* implemented in software */
 #define _PAGE_READ                  (1<<7)  /* implemented in software */



--------------010001090406010900080603--
