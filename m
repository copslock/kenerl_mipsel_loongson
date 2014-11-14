Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 16:21:02 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:32785 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013737AbaKNPSmuxwsF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Nov 2014 16:18:42 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP; 14 Nov 2014 07:18:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="416529654"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.23.232.122])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2014 07:09:20 -0800
Subject: [PATCH 06/11] x86, mpx: introduce VM_MPX to indicate that a VMA is MPX specific
To:     hpa@zytor.com
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        qiaowei.ren@intel.com, Dave Hansen <dave@sr71.net>,
        dave.hansen@linux.intel.com
From:   Dave Hansen <dave@sr71.net>
Date:   Fri, 14 Nov 2014 07:18:25 -0800
References: <20141114151816.F56A3072@viggo.jf.intel.com>
In-Reply-To: <20141114151816.F56A3072@viggo.jf.intel.com>
Message-Id: <20141114151825.565625B3@viggo.jf.intel.com>
Return-Path: <dave@sr71.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@sr71.net
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


From: Dave Hansen <dave.hansen@linux.intel.com>

MPX-enabled applications using large swaths of memory can
potentially have large numbers of bounds tables in process
address space to save bounds information. These tables can take
up huge swaths of memory (as much as 80% of the memory on the
system) even if we clean them up aggressively. In the worst-case
scenario, the tables can be 4x the size of the data structure
being tracked. IOW, a 1-page structure can require 4 bounds-table
pages.

Being this huge, our expectation is that folks using MPX are
going to be keen on figuring out how much memory is being
dedicated to it. So we need a way to track memory use for MPX.

If we want to specifically track MPX VMAs we need to be able to
distinguish them from normal VMAs, and keep them from getting
merged with normal VMAs. A new VM_ flag set only on MPX VMAs does
both of those things. With this flag, MPX bounds-table VMAs can
be distinguished from other VMAs, and userspace can also walk
/proc/$pid/smaps to get memory usage for MPX.

In addition to this flag, we also introduce a special ->vm_ops
specific to MPX VMAs (see the patch "add MPX specific mmap
interface"), but currently different ->vm_ops do not by
themselves prevent VMA merging, so we still need this flag.

We understand that VM_ flags are scarce and are open to other
options.

Signed-off-by: Qiaowei Ren <qiaowei.ren@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/fs/proc/task_mmu.c |    3 +++
 b/include/linux/mm.h |    6 ++++++
 2 files changed, 9 insertions(+)

diff -puN fs/proc/task_mmu.c~mpx-v11-introduce-VM-MPX-to-indicate-that-a-VMA-is-MPX-specific fs/proc/task_mmu.c
--- a/fs/proc/task_mmu.c~mpx-v11-introduce-VM-MPX-to-indicate-that-a-VMA-is-MPX-specific	2014-11-14 07:06:22.670627067 -0800
+++ b/fs/proc/task_mmu.c	2014-11-14 07:06:22.676627338 -0800
@@ -552,6 +552,9 @@ static void show_smap_vma_flags(struct s
 		[ilog2(VM_GROWSDOWN)]	= "gd",
 		[ilog2(VM_PFNMAP)]	= "pf",
 		[ilog2(VM_DENYWRITE)]	= "dw",
+#ifdef CONFIG_X86_INTEL_MPX
+		[ilog2(VM_MPX)]		= "mp",
+#endif
 		[ilog2(VM_LOCKED)]	= "lo",
 		[ilog2(VM_IO)]		= "io",
 		[ilog2(VM_SEQ_READ)]	= "sr",
diff -puN include/linux/mm.h~mpx-v11-introduce-VM-MPX-to-indicate-that-a-VMA-is-MPX-specific include/linux/mm.h
--- a/include/linux/mm.h~mpx-v11-introduce-VM-MPX-to-indicate-that-a-VMA-is-MPX-specific	2014-11-14 07:06:22.672627157 -0800
+++ b/include/linux/mm.h	2014-11-14 07:06:22.676627338 -0800
@@ -128,6 +128,7 @@ extern unsigned int kobjsize(const void
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
+#define VM_ARCH_2	0x02000000
 #define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
@@ -155,6 +156,11 @@ extern unsigned int kobjsize(const void
 # define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
 #endif
 
+#if defined(CONFIG_X86)
+/* MPX specific bounds table or bounds directory */
+# define VM_MPX		VM_ARCH_2
+#endif
+
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
 #endif
_
