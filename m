Return-Path: <SRS0=Alo4=OT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51645C04EB8
	for <linux-mips@archiver.kernel.org>; Mon, 10 Dec 2018 14:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005CC2086D
	for <linux-mips@archiver.kernel.org>; Mon, 10 Dec 2018 14:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6qQ26h/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005CC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeLJOVT (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:21:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46001 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeLJOVT (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 10 Dec 2018 09:21:19 -0500
Received: by mail-qk1-f194.google.com with SMTP id y78so6510857qka.12
        for <linux-mips@vger.kernel.org>; Mon, 10 Dec 2018 06:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOoTzdmKMdtBA2BpXbDLD0G8LWx+DyKy7zXrDUTZebs=;
        b=X6qQ26h/11V6sgU0OMygX4vB5jJmONTRHOEsU6ut2JkcQo8d/vOYEtraj4EuVGDJDl
         xl+RSTobeDhtn6BhYV1IhqxW0+fcf+/YpQKL5Hbq4ze+Bg6HZ/HvaqISS2qSEKvwgUkF
         tqPclHGXHvtrl0lxoOjXzfZ1JU1LG3NBUwSmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOoTzdmKMdtBA2BpXbDLD0G8LWx+DyKy7zXrDUTZebs=;
        b=iXCbgMzaV+wbWpH+D12HsTtiYRiAW3yU5FwG1VPq/PphX1xBnxUZYliIlkkyA7rQXB
         GsAhv9dAqYuhQ6WbS2YXZAtksDdyiPAF96tvJ7AnGrxzQsG9W3TWea+e/jxjMN2D1Yq3
         nzBGNn56OXL8/iulM5Jc5aINroebrXyOsF7ES+hy6XoSLOD1+YTtAbN0b711CqLvgoo9
         RQiR/XlHFJqmBAIrRUnIQAdr3bBcy/SyupvpMGf5FMEZksYm2G9O2OwE3jO6EV76QZlj
         1DhyIiKNI1pZZ488EV3qEjwkl9iwTUC63vMt6iBbToBqTTnaxvI4RspSv/QWKp3Dtwrj
         X7kw==
X-Gm-Message-State: AA+aEWYo1dEbehEbODj8sEpPuyjUyUO29nqZg/9EoQ3utc/RTMDHqbJV
        5iEtQAlhPIth8mthM+KMKfWJPQ==
X-Google-Smtp-Source: AFSGD/WeUcd6n6p2wpz19wfnTScpG9IYRvhA34r/Km0TYh3/JrZAJKehAOriNmRVFL8wVHhWeyjrhA==
X-Received: by 2002:a37:1ad9:: with SMTP id l86mr10676215qkh.54.1544451677506;
        Mon, 10 Dec 2018 06:21:17 -0800 (PST)
Received: from workstation.celeiro.br ([138.204.25.7])
        by smtp.gmail.com with ESMTPSA id x127sm10195473qkx.43.2018.12.10.06.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 06:21:16 -0800 (PST)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Juergen Gross <jgross@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
Date:   Mon, 10 Dec 2018 12:21:05 -0200
Message-Id: <20181210142105.6750-1-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 32-bit systems, zsmalloc uses HIGHMEM and, when PAE is enabled, the
physical frame number might be so big that zsmalloc obj encoding (to
location) will break, causing:

BUG: KASAN: null-ptr-deref in zs_map_object+0xa4/0x2bc
Read of size 4 at addr 00000000 by task mkfs.ext4/623
CPU: 2 PID: 623 Comm: mkfs.ext4 Not tainted 4.19.0-rc8-00017-g8239bc6d3307-dirty #15
Hardware name: Generic DT based system
[<c0418f7c>] (unwind_backtrace) from [<c0410ca4>] (show_stack+0x20/0x24)
[<c0410ca4>] (show_stack) from [<c16bd540>] (dump_stack+0xbc/0xe8)
[<c16bd540>] (dump_stack) from [<c06cab74>] (kasan_report+0x248/0x390)
[<c06cab74>] (kasan_report) from [<c06c94e8>] (__asan_load4+0x78/0xb4)
[<c06c94e8>] (__asan_load4) from [<c06ddc24>] (zs_map_object+0xa4/0x2bc)
[<c06ddc24>] (zs_map_object) from [<bf0bbbd8>] (zram_bvec_rw.constprop.2+0x324/0x8e4 [zram])
[<bf0bbbd8>] (zram_bvec_rw.constprop.2 [zram]) from [<bf0bc3cc>] (zram_make_request+0x234/0x46c [zram])
[<bf0bc3cc>] (zram_make_request [zram]) from [<c09aff9c>] (generic_make_request+0x304/0x63c)
[<c09aff9c>] (generic_make_request) from [<c09b0320>] (submit_bio+0x4c/0x1c8)
[<c09b0320>] (submit_bio) from [<c0743570>] (submit_bh_wbc.constprop.15+0x238/0x26c)
[<c0743570>] (submit_bh_wbc.constprop.15) from [<c0746cf8>] (__block_write_full_page+0x524/0x76c)
[<c0746cf8>] (__block_write_full_page) from [<c07472c4>] (block_write_full_page+0x1bc/0x1d4)
[<c07472c4>] (block_write_full_page) from [<c0748eb4>] (blkdev_writepage+0x24/0x28)
[<c0748eb4>] (blkdev_writepage) from [<c064a780>] (__writepage+0x44/0x78)
[<c064a780>] (__writepage) from [<c064b50c>] (write_cache_pages+0x3b8/0x800)
[<c064b50c>] (write_cache_pages) from [<c064dd78>] (generic_writepages+0x74/0xa0)
[<c064dd78>] (generic_writepages) from [<c0748e64>] (blkdev_writepages+0x18/0x1c)
[<c0748e64>] (blkdev_writepages) from [<c064e890>] (do_writepages+0x68/0x134)
[<c064e890>] (do_writepages) from [<c06368a4>] (__filemap_fdatawrite_range+0xb0/0xf4)
[<c06368a4>] (__filemap_fdatawrite_range) from [<c0636b68>] (file_write_and_wait_range+0x64/0xd0)
[<c0636b68>] (file_write_and_wait_range) from [<c0747af8>] (blkdev_fsync+0x54/0x84)
[<c0747af8>] (blkdev_fsync) from [<c0739dac>] (vfs_fsync_range+0x70/0xd4)
[<c0739dac>] (vfs_fsync_range) from [<c0739e98>] (do_fsync+0x4c/0x80)
[<c0739e98>] (do_fsync) from [<c073a26c>] (sys_fsync+0x1c/0x20)
[<c073a26c>] (sys_fsync) from [<c0401000>] (ret_fast_syscall+0x0/0x2c)

when trying to decode (the pfn) and map the object.

That happens because one architecture might not re-define
MAX_PHYSMEM_BITS, like in this ARM 32-bit w/ LPAE enabled example. For
32-bit systems, if not re-defined, MAX_POSSIBLE_PHYSMEM_BITS will
default to BITS_PER_LONG (32) in most cases, and, with PAE enabled,
_PFN_BITS might be wrong: which may cause obj variable to overflow if
frame number is in HIGHMEM and referencing a page above the 4GB
watermark.

commit 6e00ec00b1a7 ("staging: zsmalloc: calculate MAX_PHYSMEM_BITS if
not defined") realized MAX_PHYSMEM_BITS depended on SPARSEMEM headers
and "fixed" it by calculating it using BITS_PER_LONG if SPARSEMEM wasn't
used, like in the example given above.

Systems with potential for PAE exist for a long time and assuming
BITS_PER_LONG seems inadequate. Defining MAX_PHYSMEM_BITS looks better,
however it is NOT a constant anymore for x86.

SO, instead, MAX_POSSIBLE_PHYSMEM_BITS should be defined by every
architecture using zsmalloc, together with a sanity check for
MAX_POSSIBLE_PHYSMEM_BITS being too big on 32-bit systems.

Link: https://bugs.linaro.org/show_bug.cgi?id=3765#c17
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 arch/arm/include/asm/pgtable-2level-types.h |  2 ++
 arch/arm/include/asm/pgtable-3level-types.h |  2 ++
 arch/arm64/include/asm/pgtable-types.h      |  2 ++
 arch/ia64/include/asm/page.h                |  2 ++
 arch/mips/include/asm/page.h                |  2 ++
 arch/powerpc/include/asm/mmu.h              |  2 ++
 arch/s390/include/asm/page.h                |  2 ++
 arch/sh/include/asm/page.h                  |  2 ++
 arch/sparc/include/asm/page_32.h            |  2 ++
 arch/sparc/include/asm/page_64.h            |  2 ++
 arch/x86/include/asm/pgtable-2level_types.h |  2 ++
 arch/x86/include/asm/pgtable-3level_types.h |  3 +-
 arch/x86/include/asm/pgtable_64_types.h     |  4 +--
 mm/zsmalloc.c                               | 35 +++++++++++----------
 14 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level-types.h b/arch/arm/include/asm/pgtable-2level-types.h
index 66cb5b0e89c5..552dba411324 100644
--- a/arch/arm/include/asm/pgtable-2level-types.h
+++ b/arch/arm/include/asm/pgtable-2level-types.h
@@ -64,4 +64,6 @@ typedef pteval_t pgprot_t;
 
 #endif /* STRICT_MM_TYPECHECKS */
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 32
+
 #endif	/* _ASM_PGTABLE_2LEVEL_TYPES_H */
diff --git a/arch/arm/include/asm/pgtable-3level-types.h b/arch/arm/include/asm/pgtable-3level-types.h
index 921aa30259c4..664c39e6517c 100644
--- a/arch/arm/include/asm/pgtable-3level-types.h
+++ b/arch/arm/include/asm/pgtable-3level-types.h
@@ -67,4 +67,6 @@ typedef pteval_t pgprot_t;
 
 #endif	/* STRICT_MM_TYPECHECKS */
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 36
+
 #endif	/* _ASM_PGTABLE_3LEVEL_TYPES_H */
diff --git a/arch/arm64/include/asm/pgtable-types.h b/arch/arm64/include/asm/pgtable-types.h
index 345a072b5856..45c3834eb4c8 100644
--- a/arch/arm64/include/asm/pgtable-types.h
+++ b/arch/arm64/include/asm/pgtable-types.h
@@ -64,4 +64,6 @@ typedef struct { pteval_t pgprot; } pgprot_t;
 #include <asm-generic/5level-fixup.h>
 #endif
 
+#define MAX_POSSIBLE_PHYSMEM_BITS CONFIG_ARM64_PA_BITS
+
 #endif	/* __ASM_PGTABLE_TYPES_H */
diff --git a/arch/ia64/include/asm/page.h b/arch/ia64/include/asm/page.h
index 5798bd2b462c..a3e055979e46 100644
--- a/arch/ia64/include/asm/page.h
+++ b/arch/ia64/include/asm/page.h
@@ -235,4 +235,6 @@ get_order (unsigned long size)
 
 #define __HAVE_ARCH_GATE_AREA	1
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 50
+
 #endif /* _ASM_IA64_PAGE_H */
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index e8cc328fce2d..f6a5dea1a66c 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -263,4 +263,6 @@ extern int __virt_addr_valid(const volatile void *kaddr);
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 48
+
 #endif /* _ASM_PAGE_H */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index eb20eb3b8fb0..2ebc1d2d9a5c 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -324,6 +324,8 @@ static inline u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
 #define MAX_PHYSMEM_BITS        46
 #endif
 
+#define MAX_POSSIBLE_PHYSMEM_BITS MAX_PHYSMEM_BITS
+
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/mmu.h>
 #else /* CONFIG_PPC_BOOK3S_64 */
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index a4d38092530a..8abec1461bf7 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -180,4 +180,6 @@ static inline int devmem_is_allowed(unsigned long pfn)
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
+#define MAX_POSSIBLE_PHYSMEM_BITS CONFIG_MAX_PHYSMEM_BITS
+
 #endif /* _S390_PAGE_H */
diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index 5eef8be3e59f..40c7e12cf09e 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -205,4 +205,6 @@ typedef struct page *pgtable_t;
 #define ARCH_SLAB_MINALIGN	8
 #endif
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 32
+
 #endif /* __ASM_SH_PAGE_H */
diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index b76d59edec8c..14e9ca4659d7 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -139,4 +139,6 @@ extern unsigned long pfn_base;
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 32
+
 #endif /* _SPARC_PAGE_H */
diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index e80f2d5bf62f..6d6f3654ead1 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -163,4 +163,6 @@ extern unsigned long PAGE_OFFSET;
 
 #include <asm-generic/getorder.h>
 
+#define MAX_POSSIBLE_PHYSMEM_BITS MAX_PHYS_ADDRESS_BITS
+
 #endif /* _SPARC64_PAGE_H */
diff --git a/arch/x86/include/asm/pgtable-2level_types.h b/arch/x86/include/asm/pgtable-2level_types.h
index 6deb6cd236e3..c2eae59e6505 100644
--- a/arch/x86/include/asm/pgtable-2level_types.h
+++ b/arch/x86/include/asm/pgtable-2level_types.h
@@ -38,4 +38,6 @@ typedef union {
 /* This covers all VMSPLIT_* and VMSPLIT_*_OPT variants */
 #define PGD_KERNEL_START	(CONFIG_PAGE_OFFSET >> PGDIR_SHIFT)
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 32
+
 #endif /* _ASM_X86_PGTABLE_2LEVEL_DEFS_H */
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 33845d36897c..5fce514a49a0 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -45,7 +45,8 @@ typedef union {
  */
 #define PTRS_PER_PTE	512
 
-#define MAX_POSSIBLE_PHYSMEM_BITS	36
 #define PGD_KERNEL_START	(CONFIG_PAGE_OFFSET >> PGDIR_SHIFT)
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 36
+
 #endif /* _ASM_X86_PGTABLE_3LEVEL_DEFS_H */
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 84bd9bdc1987..d808cfde3d19 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -64,8 +64,6 @@ extern unsigned int ptrs_per_p4d;
 #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
 #define P4D_MASK		(~(P4D_SIZE - 1))
 
-#define MAX_POSSIBLE_PHYSMEM_BITS	52
-
 #else /* CONFIG_X86_5LEVEL */
 
 /*
@@ -154,4 +152,6 @@ extern unsigned int ptrs_per_p4d;
 
 #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
 
+#define MAX_POSSIBLE_PHYSMEM_BITS (pgtable_l5_enabled() ? 52 : 46)
+
 #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 0787d33b80d8..132c20b6fd4f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -80,23 +80,7 @@
  * as single (unsigned long) handle value.
  *
  * Note that object index <obj_idx> starts from 0.
- *
- * This is made more complicated by various memory models and PAE.
- */
-
-#ifndef MAX_POSSIBLE_PHYSMEM_BITS
-#ifdef MAX_PHYSMEM_BITS
-#define MAX_POSSIBLE_PHYSMEM_BITS MAX_PHYSMEM_BITS
-#else
-/*
- * If this definition of MAX_PHYSMEM_BITS is used, OBJ_INDEX_BITS will just
- * be PAGE_SHIFT
  */
-#define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
-#endif
-#endif
-
-#define _PFN_BITS		(MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
 
 /*
  * Memory for allocating for handle keeps object position by
@@ -116,6 +100,25 @@
  */
 #define OBJ_ALLOCATED_TAG 1
 #define OBJ_TAG_BITS 1
+
+/*
+ * MAX_POSSIBLE_PHYSMEM_BITS should be defined by all archs using zsmalloc:
+ * Trying to guess it from MAX_PHYSMEM_BITS, or considering it BITS_PER_LONG,
+ * proved to be wrong by not considering PAE capabilities, or using SPARSEMEM
+ * only headers, leading to bad object encoding due to object index overflow.
+ */
+#ifndef MAX_POSSIBLE_PHYSMEM_BITS
+ #define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
+ #error "MAX_POSSIBLE_PHYSMEM_BITS HAS to be defined by arch using zsmalloc";
+#else
+ #ifndef CONFIG_64BIT
+  #if (MAX_POSSIBLE_PHYSMEM_BITS >= (BITS_PER_LONG + PAGE_SHIFT - OBJ_TAG_BITS))
+   #error "MAX_POSSIBLE_PHYSMEM_BITS is wrong for this arch";
+  #endif
+ #endif
+#endif
+
+#define _PFN_BITS (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
 #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
 #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
 
-- 
2.20.0.rc1

