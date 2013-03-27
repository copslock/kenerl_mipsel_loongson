Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Mar 2013 15:53:42 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:8233 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823555Ab3C0Oxe5Q2uj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Mar 2013 15:53:34 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 27 Mar 2013 07:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,919,1355126400"; 
   d="scan'208";a="309213302"
Received: from unknown (HELO wfg-t420.sh.intel.com) ([10.255.20.128])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2013 07:53:22 -0700
Received: from wfg by wfg-t420.sh.intel.com with local (Exim 4.77)
        (envelope-from <fengguang.wu@intel.com>)
        id 1UKrj6-0007eA-Cy; Wed, 27 Mar 2013 22:53:20 +0800
Date:   Wed, 27 Mar 2013 22:53:20 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: mm/huge_memory.c:221:7: error: incompatible types when assigning
 to type 'pmd_t' from type 'int'
Message-ID: <20130327145320.GA29127@localhost>
References: <5152b651.JKLmvRYh1bEEyapp%fengguang.wu@intel.com>
 <20130327092631.GB13351@localhost>
 <20130327140207.GL27472@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130327140207.GL27472@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35983
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

On Wed, Mar 27, 2013 at 03:02:07PM +0100, Andrea Arcangeli wrote:
> Hi,
> 
> On Wed, Mar 27, 2013 at 05:26:31PM +0800, Fengguang Wu wrote:
> > Hi Andrea,
> > 
> > FYI, kernel build failed on
> > 
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
> > head:   a12183c62717ac4579319189a00f5883a18dff08
> > commit: 71e3aac0724ffe8918992d76acfe3aad7d8724a5 thp: transparent hugepage core
> > date:   2 years, 2 months ago
> > config: make ARCH=mips allmodconfig
> > 
> > All error/warnings:
> > 
> >    mm/huge_memory.c:19:15: error: expected identifier or '(' before numeric constant
> >    mm/huge_memory.c: In function 'double_flag_show':
> >    mm/huge_memory.c:28:24: error: lvalue required as unary '&' operand
> >    mm/huge_memory.c:29:3: error: lvalue required as unary '&' operand
> >    mm/huge_memory.c:31:32: error: lvalue required as unary '&' operand
> 
> It's certainly mips specific, TRANSPARENT_HUGEPAGE gets set but
> there's likely some asm header screwup, maybe hidden by
> setting/unsetting some other config option. Wondering if there's any
> pending push that may be fixing this already. If you need I can build
> the cross compiler and solve it but it's good idea to check if there's
> a pending push somewhere (or in -mm) first.

Hi Andrea!  Unfortunately there are no pending fixes. My build script
will auto check linux-next if it's an upstream build error. Which can
be further verified with the below reproduce log.

Thanks,
Fengguang
---

=============== linus/master linus/master ===============
/home/wfg/linux
HEAD is now at de55eb1... Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
/home/wfg/linux/obj-compiletest

make ARCH=mips allmodconfig
make ARCH=mips mm/huge_memory.o

!!! BUILD ERROR !!!
grep -a -F mm/huge_memory.c /tmp/build-err-de55eb1d60d2ed0f1ba5e13226d91b3bfbe1c108-wfg --color
warning: (LOCKDEP && FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && KMEMCHECK) selects FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (CRIS || M68K || FRV || UML || AVR32 || SUPERH || BLACKFIN || MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS)
warning: (LOCKDEP && FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && KMEMCHECK) selects FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (CRIS || M68K || FRV || UML || AVR32 || SUPERH || BLACKFIN || MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS)
/c/wfg/linux/mm/huge_memory.c: In function 'set_huge_zero_page':
/c/wfg/linux/mm/huge_memory.c:773:2: error: implicit declaration of function 'pfn_pmd' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:773:8: error: incompatible types when assigning to type 'pmd_t' from type 'int'
cc1: some warnings being treated as errors
make[2]: *** [mm/huge_memory.o] Error 1

=============== linux-next next/master ===============
/home/wfg/linux
Checking out files: 100% (5078/5078), done.
Previous HEAD position was de55eb1... Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
HEAD is now at b77e727... Add linux-next specific files for 20130327
/home/wfg/linux/obj-compiletest

make ARCH=mips allmodconfig
make ARCH=mips mm/huge_memory.o

!!! BUILD ERROR !!!
grep -a -F mm/huge_memory.c /tmp/build-err-b77e727878653a2e6caf89234d2488025e9ea5c3-wfg --color
warning: (LOCKDEP && FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && KMEMCHECK) selects FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (CRIS || M68K || FRV || UML || AVR32 || SUPERH || BLACKFIN || MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS)
warning: (LOCKDEP && FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && KMEMCHECK) selects FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (CRIS || M68K || FRV || UML || AVR32 || SUPERH || BLACKFIN || MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS)
/c/wfg/linux/mm/huge_memory.c:36:15: error: expected identifier or '(' before numeric constant
/c/wfg/linux/mm/huge_memory.c:48:62: error: braced-group within expression allowed only inside a function
/c/wfg/linux/mm/huge_memory.c:63:62: error: braced-group within expression allowed only inside a function
/c/wfg/linux/mm/huge_memory.c: In function 'set_recommended_min_free_kbytes':
/c/wfg/linux/mm/huge_memory.c:109:2: error: implicit declaration of function 'khugepaged_enabled' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c: In function 'is_huge_zero_pmd':
/c/wfg/linux/mm/huge_memory.c:176:2: error: implicit declaration of function 'pmd_pfn' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c: In function 'get_huge_zero_page':
/c/wfg/linux/mm/huge_memory.c:189:18: error: 'THP_ZERO_PAGE_ALLOC_FAILED' undeclared (first use in this function)
/c/wfg/linux/mm/huge_memory.c:189:18: note: each undeclared identifier is reported only once for each function it appears in
/c/wfg/linux/mm/huge_memory.c:192:17: error: 'THP_ZERO_PAGE_ALLOC' undeclared (first use in this function)
/c/wfg/linux/mm/huge_memory.c: In function 'double_flag_show':
/c/wfg/linux/mm/huge_memory.c:243:24: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:244:3: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:246:32: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c: In function 'double_flag_store':
/c/wfg/linux/mm/huge_memory.c:259:20: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:260:23: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:263:22: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:264:21: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:267:22: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:268:23: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c: In function 'single_flag_show':
/c/wfg/linux/mm/huge_memory.c:313:27: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c: In function 'single_flag_store':
/c/wfg/linux/mm/huge_memory.c:331:17: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:333:19: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c: In function 'hugepage_init':
/c/wfg/linux/mm/huge_memory.c:623:2: error: implicit declaration of function 'has_transparent_hugepage' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:624:30: error: lvalue required as left operand of assignment
/c/wfg/linux/mm/huge_memory.c:644:30: error: lvalue required as left operand of assignment
/c/wfg/linux/mm/huge_memory.c: In function 'setup_transparent_hugepage':
/c/wfg/linux/mm/huge_memory.c:662:4: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:664:6: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:668:6: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:670:4: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:674:6: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c:676:6: error: lvalue required as unary '&' operand
/c/wfg/linux/mm/huge_memory.c: In function 'maybe_pmd_mkwrite':
/c/wfg/linux/mm/huge_memory.c:690:3: error: implicit declaration of function 'pmd_mkwrite' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:690:7: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c: In function 'mk_huge_pmd':
/c/wfg/linux/mm/huge_memory.c:697:2: error: implicit declaration of function 'mk_pmd' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:697:8: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c:698:2: error: implicit declaration of function 'pmd_mkdirty' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:698:2: error: incompatible type for argument 1 of 'maybe_pmd_mkwrite'
/c/wfg/linux/mm/huge_memory.c:687:7: note: expected 'pmd_t' but argument is of type 'int'
/c/wfg/linux/mm/huge_memory.c:699:2: error: implicit declaration of function 'pmd_mkhuge' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:699:8: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c: In function '__do_huge_pmd_anonymous_page':
/c/wfg/linux/mm/huge_memory.c:715:2: error: implicit declaration of function 'clear_huge_page' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:734:3: error: implicit declaration of function 'set_pmd_at' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c: In function 'set_huge_zero_page':
/c/wfg/linux/mm/huge_memory.c:773:2: error: implicit declaration of function 'pfn_pmd' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:773:8: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c:774:2: error: implicit declaration of function 'pmd_wrprotect' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:774:8: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c:775:8: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c: In function 'do_huge_pmd_anonymous_page':
/c/wfg/linux/mm/huge_memory.c:796:5: error: implicit declaration of function 'transparent_hugepage_use_zero_page' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:806:20: error: 'THP_FAULT_FALLBACK' undeclared (first use in this function)
/c/wfg/linux/mm/huge_memory.c:819:3: error: implicit declaration of function 'transparent_hugepage_defrag' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:825:18: error: 'THP_FAULT_ALLOC' undeclared (first use in this function)
/c/wfg/linux/mm/huge_memory.c:858:2: error: implicit declaration of function 'handle_pte_fault' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c: In function 'copy_huge_pmd':
/c/wfg/linux/mm/huge_memory.c:920:2: error: implicit declaration of function 'pmd_mkold' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:920:6: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c: In function 'huge_pmd_set_accessed':
/c/wfg/linux/mm/huge_memory.c:946:2: error: implicit declaration of function 'pmd_mkyoung' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:946:8: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c: In function 'do_huge_pmd_wp_page':
/c/wfg/linux/mm/huge_memory.c:1152:9: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c:1153:3: error: incompatible type for argument 1 of 'maybe_pmd_mkwrite'
/c/wfg/linux/mm/huge_memory.c:687:7: note: expected 'pmd_t' but argument is of type 'int'
/c/wfg/linux/mm/huge_memory.c:1163:6: error: implicit declaration of function 'transparent_hugepage_debug_cow' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:1170:18: error: 'THP_FAULT_FALLBACK' undeclared (first use in this function)
/c/wfg/linux/mm/huge_memory.c:1183:17: error: 'THP_FAULT_ALLOC' undeclared (first use in this function)
/c/wfg/linux/mm/huge_memory.c:1198:3: error: implicit declaration of function 'copy_user_huge_page' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c: In function 'follow_trans_huge_pmd':
/c/wfg/linux/mm/huge_memory.c:1269:8: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c: At top level:
/c/wfg/linux/mm/huge_memory.c:1290:5: error: redefinition of 'do_huge_pmd_numa_page'
/c/wfg/linux/include/linux/huge_mm.h:218:19: note: previous definition of 'do_huge_pmd_numa_page' was here
/c/wfg/linux/mm/huge_memory.c: In function 'zap_huge_pmd':
/c/wfg/linux/mm/huge_memory.c:1359:2: error: implicit declaration of function '__pmd_trans_huge_lock' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:1364:3: error: implicit declaration of function 'pmdp_get_and_clear' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:1364:12: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c: In function 'move_huge_pmd':
/c/wfg/linux/mm/huge_memory.c:1432:7: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c: In function 'change_huge_pmd':
/c/wfg/linux/mm/huge_memory.c:1449:9: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c:1451:4: error: implicit declaration of function 'pmd_modify' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:1451:10: error: incompatible types when assigning to type 'pmd_t' from type 'int'
/c/wfg/linux/mm/huge_memory.c: In function '__split_huge_page_refcount':
/c/wfg/linux/mm/huge_memory.c:1576:2: error: implicit declaration of function 'mem_cgroup_split_huge_fixup' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:1657:2: error: implicit declaration of function 'ClearPageCompound' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c: In function '__split_huge_page_map':
/c/wfg/linux/mm/huge_memory.c:1708:4: error: implicit declaration of function 'pmd_young' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c: In function '__split_huge_page':
/c/wfg/linux/mm/huge_memory.c:1768:3: error: implicit declaration of function 'vma_address' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:1769:3: error: implicit declaration of function 'is_vma_temporary_stack' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c: At top level:
/c/wfg/linux/mm/huge_memory.c:1802:5: error: redefinition of 'split_huge_page'
/c/wfg/linux/include/linux/huge_mm.h:189:19: note: previous definition of 'split_huge_page' was here
/c/wfg/linux/mm/huge_memory.c: In function 'split_huge_page':
/c/wfg/linux/mm/huge_memory.c:1828:17: error: 'THP_SPLIT' undeclared (first use in this function)
/c/wfg/linux/mm/huge_memory.c: At top level:
/c/wfg/linux/mm/huge_memory.c:1840:5: error: redefinition of 'hugepage_madvise'
/c/wfg/linux/include/linux/huge_mm.h:200:19: note: previous definition of 'hugepage_madvise' was here
/c/wfg/linux/mm/huge_memory.c:1962:5: error: redefinition of 'khugepaged_enter_vma_merge'
/c/wfg/linux/include/linux/khugepaged.h:61:19: note: previous definition of 'khugepaged_enter_vma_merge' was here
/c/wfg/linux/mm/huge_memory.c: In function 'khugepaged_alloc_hugepage':
/c/wfg/linux/mm/huge_memory.c:2195:3: error: implicit declaration of function 'khugepaged_defrag' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c:2197:19: error: 'THP_COLLAPSE_ALLOC_FAILED' undeclared (first use in this function)
/c/wfg/linux/mm/huge_memory.c:2204:19: error: 'THP_COLLAPSE_ALLOC' undeclared (first use in this function)
/c/wfg/linux/mm/huge_memory.c: In function 'hugepage_vma_check':
/c/wfg/linux/mm/huge_memory.c:2234:2: error: implicit declaration of function 'khugepaged_always' [-Werror=implicit-function-declaration]
/c/wfg/linux/mm/huge_memory.c: At top level:
/c/wfg/linux/mm/huge_memory.c:2713:6: error: expected identifier or '(' before 'do'
/c/wfg/linux/mm/huge_memory.c:2713:6: error: expected identifier or '(' before 'while'
/c/wfg/linux/mm/huge_memory.c: In function 'single_flag_show':
/c/wfg/linux/mm/huge_memory.c:314:1: warning: control reaches end of non-void function [-Wreturn-type]
/c/wfg/linux/mm/huge_memory.c: In function 'double_flag_show':
/c/wfg/linux/mm/huge_memory.c:250:1: warning: control reaches end of non-void function [-Wreturn-type]
cc1: some warnings being treated as errors
make[2]: *** [mm/huge_memory.o] Error 1
