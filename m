Return-Path: <SRS0=OYJd=YI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D844ECE58F
	for <linux-mips@archiver.kernel.org>; Tue, 15 Oct 2019 09:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52D521835
	for <linux-mips@archiver.kernel.org>; Tue, 15 Oct 2019 09:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfJOJVd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:21:33 -0400
Received: from foss.arm.com ([217.140.110.172]:33098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfJOJVc (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 15 Oct 2019 05:21:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3CD728;
        Tue, 15 Oct 2019 02:21:30 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.42.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9AF7D3F718;
        Tue, 15 Oct 2019 02:21:19 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Steven Price <Steven.Price@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Matthew Wilcox <willy@infradead.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 0/2] mm/debug: Add tests validating architecture page table helpers
Date:   Tue, 15 Oct 2019 14:51:40 +0530
Message-Id: <1571131302-32290-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This series adds a test validation for architecture exported page table
helpers. Patch in the series adds basic transformation tests at various
levels of the page table. Before that it exports gigantic page allocation
function from HugeTLB.

This test was originally suggested by Catalin during arm64 THP migration
RFC discussion earlier. Going forward it can include more specific tests
with respect to various generic MM functions like THP, HugeTLB etc and
platform specific tests.

https://lore.kernel.org/linux-mm/20190628102003.GA56463@arrakis.emea.arm.com/

Changes in V6:

- Moved alloc_gigantic_page_order() into mm/page_alloc.c per Michal
- Moved alloc_gigantic_page_order() within CONFIG_CONTIG_ALLOC in the test
- Folded Andrew's include/asm-generic/pgtable.h fix into the test patch 2/2

Changes in V5: (https://patchwork.kernel.org/project/linux-mm/list/?series=185991)

- Redefined and moved X86 mm_p4d_folded() into a different header per Kirill/Ingo
- Updated the config option comment per Ingo and dropped 'kernel module' reference
- Updated the commit message and dropped 'kernel module' reference
- Changed DEBUG_ARCH_PGTABLE_TEST into DEBUG_VM_PGTABLE per Ingo
- Moved config option from mm/Kconfig.debug into lib/Kconfig.debug
- Renamed core test function arch_pgtable_tests() as debug_vm_pgtable()
- Renamed mm/arch_pgtable_test.c as mm/debug_vm_pgtable.c
- debug_vm_pgtable() gets called from kernel_init_freeable() after init_mm_internals()
- Added an entry in Documentation/features/debug/ per Ingo
- Enabled the test on arm64 and x86 platforms for now

Changes in V4: (https://patchwork.kernel.org/project/linux-mm/list/?series=183465)

- Disable DEBUG_ARCH_PGTABLE_TEST for ARM and IA64 platforms

Changes in V3: (https://lore.kernel.org/patchwork/project/lkml/list/?series=411216)

- Changed test trigger from module format into late_initcall()
- Marked all functions with __init to be freed after completion
- Changed all __PGTABLE_PXX_FOLDED checks as mm_pxx_folded()
- Folded in PPC32 fixes from Christophe

Changes in V2:

https://lore.kernel.org/linux-mm/1568268173-31302-1-git-send-email-anshuman.khandual@arm.com/T/#t

- Fixed small typo error in MODULE_DESCRIPTION()
- Fixed m64k build problems for lvalue concerns in pmd_xxx_tests()
- Fixed dynamic page table level folding problems on x86 as per Kirril
- Fixed second pointers during pxx_populate_tests() per Kirill and Gerald
- Allocate and free pte table with pte_alloc_one/pte_free per Kirill
- Modified pxx_clear_tests() to accommodate s390 lower 12 bits situation
- Changed RANDOM_NZVALUE value from 0xbe to 0xff
- Changed allocation, usage, free sequence for saved_ptep
- Renamed VMA_FLAGS as VMFLAGS
- Implemented a new method for random vaddr generation
- Implemented some other cleanups
- Dropped extern reference to mm_alloc()
- Created and exported new alloc_gigantic_page_order()
- Dropped the custom allocator and used new alloc_gigantic_page_order()

Changes in V1:

https://lore.kernel.org/linux-mm/1567497706-8649-1-git-send-email-anshuman.khandual@arm.com/

- Added fallback mechanism for PMD aligned memory allocation failure

Changes in RFC V2:

https://lore.kernel.org/linux-mm/1565335998-22553-1-git-send-email-anshuman.khandual@arm.com/T/#u

- Moved test module and it's config from lib/ to mm/
- Renamed config TEST_ARCH_PGTABLE as DEBUG_ARCH_PGTABLE_TEST
- Renamed file from test_arch_pgtable.c to arch_pgtable_test.c
- Added relevant MODULE_DESCRIPTION() and MODULE_AUTHOR() details
- Dropped loadable module config option
- Basic tests now use memory blocks with required size and alignment
- PUD aligned memory block gets allocated with alloc_contig_range()
- If PUD aligned memory could not be allocated it falls back on PMD aligned
  memory block from page allocator and pud_* tests are skipped
- Clear and populate tests now operate on real in memory page table entries
- Dummy mm_struct gets allocated with mm_alloc()
- Dummy page table entries get allocated with [pud|pmd|pte]_alloc_[map]()
- Simplified [p4d|pgd]_basic_tests(), now has random values in the entries

Original RFC V1:

https://lore.kernel.org/linux-mm/1564037723-26676-1-git-send-email-anshuman.khandual@arm.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steven Price <Steven.Price@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sri Krishna chowdary <schowdary@nvidia.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org


Anshuman Khandual (2):
  mm/page_alloc: Make alloc_gigantic_page() available for general use
  mm/debug: Add tests validating architecture page table helpers

 .../debug/debug-vm-pgtable/arch-support.txt   |  34 ++
 arch/arm64/Kconfig                            |   1 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/pgtable_64.h             |   6 +
 include/asm-generic/pgtable.h                 |   6 +
 include/linux/gfp.h                           |   3 +
 init/main.c                                   |   1 +
 lib/Kconfig.debug                             |  21 +
 mm/Makefile                                   |   1 +
 mm/debug_vm_pgtable.c                         | 450 ++++++++++++++++++
 mm/hugetlb.c                                  |  76 +--
 mm/page_alloc.c                               |  98 ++++
 12 files changed, 623 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/features/debug/debug-vm-pgtable/arch-support.txt
 create mode 100644 mm/debug_vm_pgtable.c

-- 
2.20.1

