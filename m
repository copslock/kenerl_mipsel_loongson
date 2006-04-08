Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Apr 2006 04:46:23 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:18135 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133352AbWDHDqK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Apr 2006 04:46:10 +0100
Received: (qmail 23491 invoked from network); 8 Apr 2006 07:59:09 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 8 Apr 2006 07:59:09 -0000
Message-ID: <44373456.2070107@ru.mvista.com>
Date:	Sat, 08 Apr 2006 07:56:06 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Manish Lachwani <mlachwani@mvista.com>,
	Jordan Crouse <jordan.crouse@amd.com>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Enable 36-bit physical address on MIPS32R2 also
References: <B482D8AA59BF244F99AFE7520D74BF9609D4F2@server1.RightHand.righthandtech.com> <4433C9EE.8030402@ru.mvista.com> <4436C301.2060001@ru.mvista.com>
In-Reply-To: <4436C301.2060001@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------050807040407080201000703"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050807040407080201000703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    PTEs in MIPS32R2 have the same layout for the 36-bit physical address case
as in MIPS32R1, according to the architecture manuals -- so, fix the #if's.
    Not sure that we need that #if defined(CONFIG_CPU_MIPS32) at all though...

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------050807040407080201000703
Content-Type: text/plain;
 name="MIPS32R2-36bit-phys-addr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MIPS32R2-36bit-phys-addr.patch"

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 4d6bc45..5f31351 100644
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
@@ -137,9 +137,9 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 #define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_val(prot))
 #else
 #define pte_pfn(x)		((unsigned long)((x).pte >> PAGE_SHIFT))
-#define pfn_pte(pfn, prot)	__pte(((unsigned long long)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #endif
-#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1) */
+#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 
 #define __pgd_offset(address)	pgd_index(address)
 #define __pud_offset(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
@@ -202,7 +202,7 @@ pfn_pte(unsigned long pfn, pgprot_t prot
  */
 #define PTE_FILE_MAX_BITS	27
 
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 	/* fixme */
 #define pte_to_pgoff(_pte) (((_pte).pte_high >> 6) + ((_pte).pte_high & 0x3f))
 #define pgoff_to_pte(off) \
diff --git a/include/asm-mips/pgtable-bits.h b/include/asm-mips/pgtable-bits.h
index 01e76e9..3aad751 100644
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
@@ -123,7 +123,7 @@
 
 #endif
 #endif
-#endif /* defined(CONFIG_CPU_MIPS32_R1) && defined(CONFIG_64BIT_PHYS_ADDR) */
+#endif /* defined(CONFIG_CPU_MIPS32) && defined(CONFIG_64BIT_PHYS_ADDR) */
 
 #define __READABLE	(_PAGE_READ | _PAGE_SILENT_READ | _PAGE_ACCESSED)
 #define __WRITEABLE	(_PAGE_WRITE | _PAGE_SILENT_WRITE | _PAGE_MODIFIED)
@@ -140,7 +140,7 @@
 #define PAGE_CACHABLE_DEFAULT	_CACHE_CACHABLE_COW
 #endif
 
-#if defined(CONFIG_CPU_MIPS32_R1) && defined(CONFIG_64BIT_PHYS_ADDR)
+#if defined(CONFIG_CPU_MIPS32) && defined(CONFIG_64BIT_PHYS_ADDR)
 #define CONF_CM_DEFAULT		(PAGE_CACHABLE_DEFAULT >> 3)
 #else
 #define CONF_CM_DEFAULT		(PAGE_CACHABLE_DEFAULT >> 9)
diff --git a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
index 702a28f..925211d 100644
--- a/include/asm-mips/pgtable.h
+++ b/include/asm-mips/pgtable.h
@@ -85,7 +85,7 @@ extern void paging_init(void);
 #define pte_none(pte)		(!(pte_val(pte) & ~_PAGE_GLOBAL))
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
 
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	ptep->pte_high = pte.pte_high;
@@ -173,7 +173,7 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD
  * Undefined behaviour if not..
  */
 static inline int pte_user(pte_t pte)	{ BUG(); return 0; }
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 static inline int pte_read(pte_t pte)	{ return (pte).pte_low & _PAGE_READ; }
 static inline int pte_write(pte_t pte)	{ return (pte).pte_low & _PAGE_WRITE; }
 static inline int pte_dirty(pte_t pte)	{ return (pte).pte_low & _PAGE_MODIFIED; }
@@ -332,7 +332,7 @@ static inline pgprot_t pgprot_noncached(
  */
 #define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
 
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte.pte_low &= _PAGE_CHG_MASK;


--------------050807040407080201000703--
