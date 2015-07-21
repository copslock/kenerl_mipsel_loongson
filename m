Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2015 22:00:07 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:35012 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011524AbbGUT7spsF0x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jul 2015 21:59:48 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id A7A2B29176;
        Tue, 21 Jul 2015 19:59:42 +0000 (GMT)
Received: from prod-mail-relay06.akamai.com (prod-mail-relay06.akamai.com [172.17.120.126])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id 6F0B129171;
        Tue, 21 Jul 2015 19:59:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1437508782; bh=ycuDQMKSBEwgPDs6bbb1rAfM3wCQt8M2zC6BNcNuwck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obVpHI45GrNefARpMc/3QA2XRTaWICmjGymmjaOzsiRwdSCq6hD3DRkReLKdrDC9/
         a0gNgwgxRZ+WPTgixTOaUZq0KWZhpg6JHlwaydhpfvzdQ8fioXcbv+gBuIw1kNSd5p
         anu6x9eoDrTC/YOzw0qiumd4F0OvRq13uSUvzeD4=
Received: from bos-lp6ds.kendall.corp.akamai.com (bos-lp6ds.kendall.corp.akamai.com [172.28.12.165])
        by prod-mail-relay06.akamai.com (Postfix) with ESMTP id 6515D2111;
        Tue, 21 Jul 2015 19:59:42 +0000 (GMT)
From:   Eric B Munson <emunson@akamai.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric B Munson <emunson@akamai.com>, Michal Hocko <mhocko@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH V4 5/6] mm: mmap: Add mmap flag to request VM_LOCKONFAULT
Date:   Tue, 21 Jul 2015 15:59:40 -0400
Message-Id: <1437508781-28655-6-git-send-email-emunson@akamai.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1437508781-28655-1-git-send-email-emunson@akamai.com>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: emunson@akamai.com
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

The cost of faulting in all memory to be locked can be very high when
working with large mappings.  If only portions of the mapping will be
used this can incur a high penalty for locking.

Now that we have the new VMA flag for the locked but not present state,
expose it as an mmap option like MAP_LOCKED -> VM_LOCKED.

Signed-off-by: Eric B Munson <emunson@akamai.com>
Cc: Michal Hocko <mhocko@suse.cz>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: linux-api@vger.kernel.org
---
Changes from V3:
 Add missing MAP_LOCKONFAULT to tile

 arch/alpha/include/uapi/asm/mman.h   | 1 +
 arch/mips/include/uapi/asm/mman.h    | 1 +
 arch/parisc/include/uapi/asm/mman.h  | 1 +
 arch/powerpc/include/uapi/asm/mman.h | 1 +
 arch/sparc/include/uapi/asm/mman.h   | 1 +
 arch/tile/include/uapi/asm/mman.h    | 1 +
 arch/xtensa/include/uapi/asm/mman.h  | 1 +
 include/linux/mman.h                 | 3 ++-
 include/uapi/asm-generic/mman.h      | 1 +
 kernel/events/core.c                 | 2 ++
 mm/mmap.c                            | 6 ++++--
 11 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 77ae8db..3f80ca4 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -30,6 +30,7 @@
 #define MAP_NONBLOCK	0x40000		/* do not block on IO */
 #define MAP_STACK	0x80000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x100000	/* create a huge page mapping */
+#define MAP_LOCKONFAULT	0x200000	/* Lock pages after they are faulted in, do not prefault */
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_SYNC		2		/* synchronous memory sync */
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 71ed81d..905c1ea 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -48,6 +48,7 @@
 #define MAP_NONBLOCK	0x20000		/* do not block on IO */
 #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
+#define MAP_LOCKONFAULT	0x100000	/* Lock pages after they are faulted in, do not prefault */
 
 /*
  * Flags for msync
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index c0871ce..c4695f6 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -24,6 +24,7 @@
 #define MAP_NONBLOCK	0x20000		/* do not block on IO */
 #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
+#define MAP_LOCKONFAULT	0x100000	/* Lock pages after they are faulted in, do not prefault */
 
 #define MS_SYNC		1		/* synchronous memory sync */
 #define MS_ASYNC	2		/* sync memory asynchronously */
diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
index f93f7eb..40a3fda 100644
--- a/arch/powerpc/include/uapi/asm/mman.h
+++ b/arch/powerpc/include/uapi/asm/mman.h
@@ -31,5 +31,6 @@
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
+#define MAP_LOCKONFAULT	0x80000		/* Lock pages after they are faulted in, do not prefault */
 
 #endif /* _UAPI_ASM_POWERPC_MMAN_H */
diff --git a/arch/sparc/include/uapi/asm/mman.h b/arch/sparc/include/uapi/asm/mman.h
index 8cd2ebc..3d74ab7 100644
--- a/arch/sparc/include/uapi/asm/mman.h
+++ b/arch/sparc/include/uapi/asm/mman.h
@@ -26,6 +26,7 @@
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
+#define MAP_LOCKONFAULT	0x8000		/* Lock pages after they are faulted in, do not prefault */
 
 
 #endif /* _UAPI__SPARC_MMAN_H__ */
diff --git a/arch/tile/include/uapi/asm/mman.h b/arch/tile/include/uapi/asm/mman.h
index acdd013..800e5c3 100644
--- a/arch/tile/include/uapi/asm/mman.h
+++ b/arch/tile/include/uapi/asm/mman.h
@@ -29,6 +29,7 @@
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_HUGETLB	0x4000		/* create a huge page mapping */
+#define MAP_LOCKONFAULT	0x100000	/* Lock pages after they are faulted in, do not prefault */
 
 
 /*
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 5725a15..689e1f2 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -55,6 +55,7 @@
 #define MAP_NONBLOCK	0x20000		/* do not block on IO */
 #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
+#define MAP_LOCKONFAULT	0x100000	/* Lock pages after they are faulted in, do not prefault */
 #ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
 # define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 16373c8..437264b 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -86,7 +86,8 @@ calc_vm_flag_bits(unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
-	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    );
+	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
+	       _calc_vm_trans(flags, MAP_LOCKONFAULT,VM_LOCKONFAULT);
 }
 
 unsigned long vm_commit_limit(void);
diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
index 555aab0..007b784 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -12,6 +12,7 @@
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
+#define MAP_LOCKONFAULT	0x80000		/* Lock pages after they are faulted in, do not prefault */
 
 /* Bits [26:31] are reserved, see mman-common.h for MAP_HUGETLB usage */
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d3dae34..53f312c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5816,6 +5816,8 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 			flags |= MAP_EXECUTABLE;
 		if (vma->vm_flags & VM_LOCKED)
 			flags |= MAP_LOCKED;
+		if (vma->vm_flags & VM_LOCKONFAULT)
+			flags |= MAP_LOCKONFAULT;
 		if (vma->vm_flags & VM_HUGETLB)
 			flags |= MAP_HUGETLB;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index de89be4..54715b6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1301,7 +1301,7 @@ unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
 	vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
-	if (flags & MAP_LOCKED)
+	if (flags & (MAP_LOCKED | MAP_LOCKONFAULT))
 		if (!can_do_mlock())
 			return -EPERM;
 
@@ -2678,12 +2678,14 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		flags |= MAP_LOCKED;
 		drop_lock_flag = VM_LOCKED;
 	} else if (vma->vm_flags & VM_LOCKONFAULT) {
+		flags |= MAP_LOCKONFAULT;
 		drop_lock_flag = VM_LOCKONFAULT;
 	}
 
+
 	if (drop_lock_flag)
 		/* drop PG_Mlocked flag for over-mapped range */
-		munlock_vma_pages_range(vma, start, start + size, VM_LOCKED);
+		munlock_vma_pages_range(vma, start, start + size, drop_lock_flag);
 
 	file = get_file(vma->vm_file);
 	ret = do_mmap_pgoff(vma->vm_file, start, size,
-- 
1.9.1
