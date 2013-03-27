Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Mar 2013 10:26:47 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:44731 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817032Ab3C0J0pNzQjC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Mar 2013 10:26:45 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 27 Mar 2013 02:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,917,1355126400"; 
   d="scan'208";a="309071538"
Received: from unknown (HELO wfg-t420.sh.intel.com) ([10.255.20.128])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2013 02:26:33 -0700
Received: from wfg by wfg-t420.sh.intel.com with local (Exim 4.77)
        (envelope-from <fengguang.wu@intel.com>)
        id 1UKmcp-0003t2-Sj; Wed, 27 Mar 2013 17:26:31 +0800
Date:   Wed, 27 Mar 2013 17:26:31 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: mm/huge_memory.c:221:7: error: incompatible types when assigning to
 type 'pmd_t' from type 'int'
Message-ID: <20130327092631.GB13351@localhost>
References: <5152b651.JKLmvRYh1bEEyapp%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5152b651.JKLmvRYh1bEEyapp%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Andrea,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
head:   a12183c62717ac4579319189a00f5883a18dff08
commit: 71e3aac0724ffe8918992d76acfe3aad7d8724a5 thp: transparent hugepage core
date:   2 years, 2 months ago
config: make ARCH=mips allmodconfig

All error/warnings:

   mm/huge_memory.c:19:15: error: expected identifier or '(' before numeric constant
   mm/huge_memory.c: In function 'double_flag_show':
   mm/huge_memory.c:28:24: error: lvalue required as unary '&' operand
   mm/huge_memory.c:29:3: error: lvalue required as unary '&' operand
   mm/huge_memory.c:31:32: error: lvalue required as unary '&' operand
   mm/huge_memory.c: In function 'double_flag_store':
   mm/huge_memory.c:44:20: error: lvalue required as unary '&' operand
   mm/huge_memory.c:45:23: error: lvalue required as unary '&' operand
   mm/huge_memory.c:48:22: error: lvalue required as unary '&' operand
   mm/huge_memory.c:49:21: error: lvalue required as unary '&' operand
   mm/huge_memory.c:52:22: error: lvalue required as unary '&' operand
   mm/huge_memory.c:53:23: error: lvalue required as unary '&' operand
   mm/huge_memory.c: In function 'single_flag_show':
   mm/huge_memory.c:82:21: error: lvalue required as unary '&' operand
   mm/huge_memory.c: In function 'single_flag_store':
   mm/huge_memory.c:94:17: error: lvalue required as unary '&' operand
   mm/huge_memory.c:97:19: error: lvalue required as unary '&' operand
   mm/huge_memory.c: In function 'setup_transparent_hugepage':
   mm/huge_memory.c:180:4: error: lvalue required as unary '&' operand
   mm/huge_memory.c:182:6: error: lvalue required as unary '&' operand
   mm/huge_memory.c:186:6: error: lvalue required as unary '&' operand
   mm/huge_memory.c:188:4: error: lvalue required as unary '&' operand
   mm/huge_memory.c:192:6: error: lvalue required as unary '&' operand
   mm/huge_memory.c:194:6: error: lvalue required as unary '&' operand
   mm/huge_memory.c: In function 'prepare_pmd_huge_pte':
   mm/huge_memory.c:211:9: error: 'struct mm_struct' has no member named 'pmd_huge_pte'
   mm/huge_memory.c:214:30: error: 'struct mm_struct' has no member named 'pmd_huge_pte'
   mm/huge_memory.c:215:4: error: 'struct mm_struct' has no member named 'pmd_huge_pte'
   mm/huge_memory.c: In function 'maybe_pmd_mkwrite':
   mm/huge_memory.c:221:3: error: implicit declaration of function 'pmd_mkwrite' [-Werror=implicit-function-declaration]
>> mm/huge_memory.c:221:7: error: incompatible types when assigning to type 'pmd_t' from type 'int'
   mm/huge_memory.c: In function '__do_huge_pmd_anonymous_page':
   mm/huge_memory.c:240:2: error: implicit declaration of function 'clear_huge_page' [-Werror=implicit-function-declaration]
   mm/huge_memory.c:240:31: error: 'HPAGE_PMD_NR' undeclared (first use in this function)
   mm/huge_memory.c:240:31: note: each undeclared identifier is reported only once for each function it appears in
   mm/huge_memory.c:250:3: error: implicit declaration of function 'mk_pmd' [-Werror=implicit-function-declaration]
>> mm/huge_memory.c:250:9: error: incompatible types when assigning to type 'pmd_t' from type 'int'
   mm/huge_memory.c:251:3: error: implicit declaration of function 'pmd_mkdirty' [-Werror=implicit-function-declaration]
   mm/huge_memory.c:251:3: error: incompatible type for argument 1 of 'maybe_pmd_mkwrite'
   mm/huge_memory.c:218:21: note: expected 'pmd_t' but argument is of type 'int'
   mm/huge_memory.c:252:3: error: implicit declaration of function 'pmd_mkhuge' [-Werror=implicit-function-declaration]
>> mm/huge_memory.c:252:9: error: incompatible types when assigning to type 'pmd_t' from type 'int'
   mm/huge_memory.c:260:3: error: implicit declaration of function 'set_pmd_at' [-Werror=implicit-function-declaration]
   mm/huge_memory.c: In function 'alloc_hugepage':
   mm/huge_memory.c:271:9: error: 'HPAGE_PMD_ORDER' undeclared (first use in this function)
   mm/huge_memory.c: In function 'do_huge_pmd_anonymous_page':
   mm/huge_memory.c:286:3: error: implicit declaration of function 'transparent_hugepage_defrag' [-Werror=implicit-function-declaration]
   mm/huge_memory.c:310:2: error: implicit declaration of function 'handle_pte_fault' [-Werror=implicit-function-declaration]
   mm/huge_memory.c: In function 'copy_huge_pmd':
   mm/huge_memory.c:349:39: error: 'HPAGE_PMD_NR' undeclared (first use in this function)
   mm/huge_memory.c:352:2: error: implicit declaration of function 'pmd_mkold' [-Werror=implicit-function-declaration]
   mm/huge_memory.c:352:2: error: implicit declaration of function 'pmd_wrprotect' [-Werror=implicit-function-declaration]
>> mm/huge_memory.c:352:6: error: incompatible types when assigning to type 'pmd_t' from type 'int'
   mm/huge_memory.c: In function 'get_pmd_huge_pte':
   mm/huge_memory.c:372:14: error: 'struct mm_struct' has no member named 'pmd_huge_pte'
   mm/huge_memory.c:374:5: error: 'struct mm_struct' has no member named 'pmd_huge_pte'
   mm/huge_memory.c:376:5: error: 'struct mm_struct' has no member named 'pmd_huge_pte'
   mm/huge_memory.c: In function 'do_huge_pmd_wp_page_fallback':
   mm/huge_memory.c:395:42: error: 'HPAGE_PMD_NR' undeclared (first use in this function)
   mm/huge_memory.c: In function 'do_huge_pmd_wp_page':
   mm/huge_memory.c:481:3: error: implicit declaration of function 'pmd_mkyoung' [-Werror=implicit-function-declaration]
>> mm/huge_memory.c:481:9: error: incompatible types when assigning to type 'pmd_t' from type 'int'
   mm/huge_memory.c:482:3: error: incompatible type for argument 1 of 'maybe_pmd_mkwrite'
   mm/huge_memory.c:218:21: note: expected 'pmd_t' but argument is of type 'int'
   mm/huge_memory.c:484:4: error: incompatible type for argument 3 of 'update_mmu_cache'
   In file included from include/linux/mm.h:41:0,
                    from mm/huge_memory.c:8:
   arch/mips/include/asm/pgtable.h:370:20: note: expected 'struct pte_t *' but argument is of type 'pmd_t'
   mm/huge_memory.c:492:6: error: implicit declaration of function 'transparent_hugepage_debug_cow' [-Werror=implicit-function-declaration]
   mm/huge_memory.c:504:2: error: implicit declaration of function 'copy_user_huge_page' [-Werror=implicit-function-declaration]
   mm/huge_memory.c:504:50: error: 'HPAGE_PMD_NR' undeclared (first use in this function)
>> mm/huge_memory.c:514:9: error: incompatible types when assigning to type 'pmd_t' from type 'int'
   mm/huge_memory.c:515:3: error: incompatible type for argument 1 of 'maybe_pmd_mkwrite'
   mm/huge_memory.c:218:21: note: expected 'pmd_t' but argument is of type 'int'
>> mm/huge_memory.c:516:9: error: incompatible types when assigning to type 'pmd_t' from type 'int'
   mm/huge_memory.c:520:3: error: incompatible type for argument 3 of 'update_mmu_cache'
   In file included from include/linux/mm.h:41:0,
                    from mm/huge_memory.c:8:
   arch/mips/include/asm/pgtable.h:370:20: note: expected 'struct pte_t *' but argument is of type 'pmd_t'
   mm/huge_memory.c: In function 'follow_trans_huge_pmd':
>> mm/huge_memory.c:555:8: error: incompatible types when assigning to type 'pmd_t' from type 'int'
   mm/huge_memory.c: In function 'zap_huge_pmd':
   mm/huge_memory.c:586:43: error: 'HPAGE_PMD_NR' undeclared (first use in this function)
   mm/huge_memory.c: In function '__split_huge_page_splitting':
   mm/huge_memory.c:654:3: error: implicit declaration of function 'pmdp_splitting_flush' [-Werror=implicit-function-declaration]
   mm/huge_memory.c: In function '__split_huge_page_refcount':
   mm/huge_memory.c:672:18: error: 'HPAGE_PMD_NR' undeclared (first use in this function)
   mm/huge_memory.c:728:2: error: implicit declaration of function 'ClearPageCompound' [-Werror=implicit-function-declaration]
   mm/huge_memory.c: In function '__split_huge_page_map':
   mm/huge_memory.c:769:36: error: 'HPAGE_PMD_NR' undeclared (first use in this function)
   mm/huge_memory.c:779:4: error: implicit declaration of function 'pmd_young' [-Werror=implicit-function-declaration]
   mm/huge_memory.c:815:3: error: implicit declaration of function 'pmd_mknotpresent' [-Werror=implicit-function-declaration]
   mm/huge_memory.c: In function '__split_huge_page':
   mm/huge_memory.c:838:3: error: implicit declaration of function 'vma_address' [-Werror=implicit-function-declaration]
   mm/huge_memory.c: At top level:
   mm/huge_memory.c:860:5: error: redefinition of 'split_huge_page'
   In file included from include/linux/mm.h:249:0,
                    from mm/huge_memory.c:8:
   include/linux/huge_mm.h:108:19: note: previous definition of 'split_huge_page' was here
   mm/huge_memory.c: In function 'single_flag_show':
   mm/huge_memory.c:86:1: warning: control reaches end of non-void function [-Wreturn-type]
   mm/huge_memory.c: In function 'double_flag_show':
   mm/huge_memory.c:35:1: warning: control reaches end of non-void function [-Wreturn-type]
   cc1: some warnings being treated as errors

vim +221 mm/huge_memory.c

71e3aac0 Andrea Arcangeli 2011-01-13  212  		INIT_LIST_HEAD(&pgtable->lru);
71e3aac0 Andrea Arcangeli 2011-01-13  213  	else
71e3aac0 Andrea Arcangeli 2011-01-13  214  		list_add(&pgtable->lru, &mm->pmd_huge_pte->lru);
71e3aac0 Andrea Arcangeli 2011-01-13  215  	mm->pmd_huge_pte = pgtable;
71e3aac0 Andrea Arcangeli 2011-01-13  216  }
71e3aac0 Andrea Arcangeli 2011-01-13  217  
71e3aac0 Andrea Arcangeli 2011-01-13 @218  static inline pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
71e3aac0 Andrea Arcangeli 2011-01-13  219  {
71e3aac0 Andrea Arcangeli 2011-01-13  220  	if (likely(vma->vm_flags & VM_WRITE))
71e3aac0 Andrea Arcangeli 2011-01-13 @221  		pmd = pmd_mkwrite(pmd);
71e3aac0 Andrea Arcangeli 2011-01-13  222  	return pmd;
71e3aac0 Andrea Arcangeli 2011-01-13  223  }
71e3aac0 Andrea Arcangeli 2011-01-13  224  
71e3aac0 Andrea Arcangeli 2011-01-13  225  static int __do_huge_pmd_anonymous_page(struct mm_struct *mm,
71e3aac0 Andrea Arcangeli 2011-01-13  226  					struct vm_area_struct *vma,
71e3aac0 Andrea Arcangeli 2011-01-13  227  					unsigned long haddr, pmd_t *pmd,
71e3aac0 Andrea Arcangeli 2011-01-13  228  					struct page *page)
71e3aac0 Andrea Arcangeli 2011-01-13  229  {
71e3aac0 Andrea Arcangeli 2011-01-13  230  	int ret = 0;
71e3aac0 Andrea Arcangeli 2011-01-13  231  	pgtable_t pgtable;
71e3aac0 Andrea Arcangeli 2011-01-13  232  
71e3aac0 Andrea Arcangeli 2011-01-13  233  	VM_BUG_ON(!PageCompound(page));
71e3aac0 Andrea Arcangeli 2011-01-13  234  	pgtable = pte_alloc_one(mm, haddr);
71e3aac0 Andrea Arcangeli 2011-01-13  235  	if (unlikely(!pgtable)) {
71e3aac0 Andrea Arcangeli 2011-01-13  236  		put_page(page);
71e3aac0 Andrea Arcangeli 2011-01-13  237  		return VM_FAULT_OOM;
71e3aac0 Andrea Arcangeli 2011-01-13  238  	}
71e3aac0 Andrea Arcangeli 2011-01-13  239  
71e3aac0 Andrea Arcangeli 2011-01-13  240  	clear_huge_page(page, haddr, HPAGE_PMD_NR);
71e3aac0 Andrea Arcangeli 2011-01-13  241  	__SetPageUptodate(page);
71e3aac0 Andrea Arcangeli 2011-01-13  242  
71e3aac0 Andrea Arcangeli 2011-01-13  243  	spin_lock(&mm->page_table_lock);
71e3aac0 Andrea Arcangeli 2011-01-13  244  	if (unlikely(!pmd_none(*pmd))) {
71e3aac0 Andrea Arcangeli 2011-01-13  245  		spin_unlock(&mm->page_table_lock);
71e3aac0 Andrea Arcangeli 2011-01-13  246  		put_page(page);
71e3aac0 Andrea Arcangeli 2011-01-13  247  		pte_free(mm, pgtable);
71e3aac0 Andrea Arcangeli 2011-01-13  248  	} else {
71e3aac0 Andrea Arcangeli 2011-01-13  249  		pmd_t entry;
71e3aac0 Andrea Arcangeli 2011-01-13 @250  		entry = mk_pmd(page, vma->vm_page_prot);
71e3aac0 Andrea Arcangeli 2011-01-13  251  		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
71e3aac0 Andrea Arcangeli 2011-01-13 @252  		entry = pmd_mkhuge(entry);
71e3aac0 Andrea Arcangeli 2011-01-13  253  		/*
71e3aac0 Andrea Arcangeli 2011-01-13  254  		 * The spinlocking to take the lru_lock inside
71e3aac0 Andrea Arcangeli 2011-01-13  255  		 * page_add_new_anon_rmap() acts as a full memory
71e3aac0 Andrea Arcangeli 2011-01-13  256  		 * barrier to be sure clear_huge_page writes become
71e3aac0 Andrea Arcangeli 2011-01-13  257  		 * visible after the set_pmd_at() write.
71e3aac0 Andrea Arcangeli 2011-01-13  258  		 */
71e3aac0 Andrea Arcangeli 2011-01-13  259  		page_add_new_anon_rmap(page, vma, haddr);
71e3aac0 Andrea Arcangeli 2011-01-13  260  		set_pmd_at(mm, haddr, pmd, entry);
71e3aac0 Andrea Arcangeli 2011-01-13  261  		prepare_pmd_huge_pte(pgtable, mm);
71e3aac0 Andrea Arcangeli 2011-01-13  262  		add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR);
71e3aac0 Andrea Arcangeli 2011-01-13  263  		spin_unlock(&mm->page_table_lock);
71e3aac0 Andrea Arcangeli 2011-01-13  264  	}
71e3aac0 Andrea Arcangeli 2011-01-13  265  
71e3aac0 Andrea Arcangeli 2011-01-13  266  	return ret;
71e3aac0 Andrea Arcangeli 2011-01-13  267  }
71e3aac0 Andrea Arcangeli 2011-01-13  268  
71e3aac0 Andrea Arcangeli 2011-01-13  269  static inline struct page *alloc_hugepage(int defrag)
71e3aac0 Andrea Arcangeli 2011-01-13  270  {
71e3aac0 Andrea Arcangeli 2011-01-13  271  	return alloc_pages(GFP_TRANSHUGE & ~(defrag ? 0 : __GFP_WAIT),
71e3aac0 Andrea Arcangeli 2011-01-13  272  			   HPAGE_PMD_ORDER);
71e3aac0 Andrea Arcangeli 2011-01-13  273  }
71e3aac0 Andrea Arcangeli 2011-01-13  274  
71e3aac0 Andrea Arcangeli 2011-01-13  275  int do_huge_pmd_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
71e3aac0 Andrea Arcangeli 2011-01-13  276  			       unsigned long address, pmd_t *pmd,
71e3aac0 Andrea Arcangeli 2011-01-13  277  			       unsigned int flags)
71e3aac0 Andrea Arcangeli 2011-01-13  278  {
71e3aac0 Andrea Arcangeli 2011-01-13  279  	struct page *page;
71e3aac0 Andrea Arcangeli 2011-01-13  280  	unsigned long haddr = address & HPAGE_PMD_MASK;
71e3aac0 Andrea Arcangeli 2011-01-13  281  	pte_t *pte;
71e3aac0 Andrea Arcangeli 2011-01-13  282  
71e3aac0 Andrea Arcangeli 2011-01-13  283  	if (haddr >= vma->vm_start && haddr + HPAGE_PMD_SIZE <= vma->vm_end) {
71e3aac0 Andrea Arcangeli 2011-01-13  284  		if (unlikely(anon_vma_prepare(vma)))
71e3aac0 Andrea Arcangeli 2011-01-13  285  			return VM_FAULT_OOM;
71e3aac0 Andrea Arcangeli 2011-01-13  286  		page = alloc_hugepage(transparent_hugepage_defrag(vma));
71e3aac0 Andrea Arcangeli 2011-01-13  287  		if (unlikely(!page))
71e3aac0 Andrea Arcangeli 2011-01-13  288  			goto out;
71e3aac0 Andrea Arcangeli 2011-01-13  289  
71e3aac0 Andrea Arcangeli 2011-01-13  290  		return __do_huge_pmd_anonymous_page(mm, vma, haddr, pmd, page);
71e3aac0 Andrea Arcangeli 2011-01-13  291  	}
71e3aac0 Andrea Arcangeli 2011-01-13  292  out:
71e3aac0 Andrea Arcangeli 2011-01-13  293  	/*
71e3aac0 Andrea Arcangeli 2011-01-13  294  	 * Use __pte_alloc instead of pte_alloc_map, because we can't
71e3aac0 Andrea Arcangeli 2011-01-13  295  	 * run pte_offset_map on the pmd, if an huge pmd could
71e3aac0 Andrea Arcangeli 2011-01-13  296  	 * materialize from under us from a different thread.
71e3aac0 Andrea Arcangeli 2011-01-13  297  	 */
71e3aac0 Andrea Arcangeli 2011-01-13  298  	if (unlikely(__pte_alloc(mm, vma, pmd, address)))
71e3aac0 Andrea Arcangeli 2011-01-13  299  		return VM_FAULT_OOM;
71e3aac0 Andrea Arcangeli 2011-01-13  300  	/* if an huge pmd materialized from under us just retry later */
71e3aac0 Andrea Arcangeli 2011-01-13  301  	if (unlikely(pmd_trans_huge(*pmd)))
71e3aac0 Andrea Arcangeli 2011-01-13  302  		return 0;
71e3aac0 Andrea Arcangeli 2011-01-13  303  	/*
71e3aac0 Andrea Arcangeli 2011-01-13  304  	 * A regular pmd is established and it can't morph into a huge pmd
71e3aac0 Andrea Arcangeli 2011-01-13  305  	 * from under us anymore at this point because we hold the mmap_sem
71e3aac0 Andrea Arcangeli 2011-01-13  306  	 * read mode and khugepaged takes it in write mode. So now it's
71e3aac0 Andrea Arcangeli 2011-01-13  307  	 * safe to run pte_offset_map().
71e3aac0 Andrea Arcangeli 2011-01-13  308  	 */
71e3aac0 Andrea Arcangeli 2011-01-13  309  	pte = pte_offset_map(pmd, address);
71e3aac0 Andrea Arcangeli 2011-01-13  310  	return handle_pte_fault(mm, vma, address, pte, pmd, flags);
71e3aac0 Andrea Arcangeli 2011-01-13  311  }
71e3aac0 Andrea Arcangeli 2011-01-13  312  
71e3aac0 Andrea Arcangeli 2011-01-13  313  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
71e3aac0 Andrea Arcangeli 2011-01-13  314  		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
71e3aac0 Andrea Arcangeli 2011-01-13  315  		  struct vm_area_struct *vma)
71e3aac0 Andrea Arcangeli 2011-01-13  316  {
71e3aac0 Andrea Arcangeli 2011-01-13  317  	struct page *src_page;
71e3aac0 Andrea Arcangeli 2011-01-13  318  	pmd_t pmd;
71e3aac0 Andrea Arcangeli 2011-01-13  319  	pgtable_t pgtable;
71e3aac0 Andrea Arcangeli 2011-01-13  320  	int ret;
71e3aac0 Andrea Arcangeli 2011-01-13  321  
71e3aac0 Andrea Arcangeli 2011-01-13  322  	ret = -ENOMEM;
71e3aac0 Andrea Arcangeli 2011-01-13  323  	pgtable = pte_alloc_one(dst_mm, addr);
71e3aac0 Andrea Arcangeli 2011-01-13  324  	if (unlikely(!pgtable))
71e3aac0 Andrea Arcangeli 2011-01-13  325  		goto out;
71e3aac0 Andrea Arcangeli 2011-01-13  326  
71e3aac0 Andrea Arcangeli 2011-01-13  327  	spin_lock(&dst_mm->page_table_lock);
71e3aac0 Andrea Arcangeli 2011-01-13  328  	spin_lock_nested(&src_mm->page_table_lock, SINGLE_DEPTH_NESTING);
71e3aac0 Andrea Arcangeli 2011-01-13  329  
71e3aac0 Andrea Arcangeli 2011-01-13  330  	ret = -EAGAIN;
71e3aac0 Andrea Arcangeli 2011-01-13  331  	pmd = *src_pmd;
71e3aac0 Andrea Arcangeli 2011-01-13  332  	if (unlikely(!pmd_trans_huge(pmd))) {
71e3aac0 Andrea Arcangeli 2011-01-13  333  		pte_free(dst_mm, pgtable);
71e3aac0 Andrea Arcangeli 2011-01-13  334  		goto out_unlock;
71e3aac0 Andrea Arcangeli 2011-01-13  335  	}
71e3aac0 Andrea Arcangeli 2011-01-13  336  	if (unlikely(pmd_trans_splitting(pmd))) {
71e3aac0 Andrea Arcangeli 2011-01-13  337  		/* split huge page running from under us */
71e3aac0 Andrea Arcangeli 2011-01-13  338  		spin_unlock(&src_mm->page_table_lock);
71e3aac0 Andrea Arcangeli 2011-01-13  339  		spin_unlock(&dst_mm->page_table_lock);
71e3aac0 Andrea Arcangeli 2011-01-13  340  		pte_free(dst_mm, pgtable);
71e3aac0 Andrea Arcangeli 2011-01-13  341  
71e3aac0 Andrea Arcangeli 2011-01-13  342  		wait_split_huge_page(vma->anon_vma, src_pmd); /* src_vma */
71e3aac0 Andrea Arcangeli 2011-01-13  343  		goto out;
71e3aac0 Andrea Arcangeli 2011-01-13  344  	}
71e3aac0 Andrea Arcangeli 2011-01-13  345  	src_page = pmd_page(pmd);
71e3aac0 Andrea Arcangeli 2011-01-13  346  	VM_BUG_ON(!PageHead(src_page));
71e3aac0 Andrea Arcangeli 2011-01-13  347  	get_page(src_page);
71e3aac0 Andrea Arcangeli 2011-01-13  348  	page_dup_rmap(src_page);
71e3aac0 Andrea Arcangeli 2011-01-13  349  	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
71e3aac0 Andrea Arcangeli 2011-01-13  350  
71e3aac0 Andrea Arcangeli 2011-01-13  351  	pmdp_set_wrprotect(src_mm, addr, src_pmd);
71e3aac0 Andrea Arcangeli 2011-01-13 @352  	pmd = pmd_mkold(pmd_wrprotect(pmd));
71e3aac0 Andrea Arcangeli 2011-01-13  353  	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
71e3aac0 Andrea Arcangeli 2011-01-13  354  	prepare_pmd_huge_pte(pgtable, dst_mm);
71e3aac0 Andrea Arcangeli 2011-01-13  355  

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
