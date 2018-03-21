Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:28:28 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994707AbeCUTYYXRATp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:24:24 +0100
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJNqlW134712
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:24:22 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2guv1147bp-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:24:22 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:24:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:24:14 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJODDd59310262;
        Wed, 21 Mar 2018 19:24:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AE8242047;
        Wed, 21 Mar 2018 19:16:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6042C42042;
        Wed, 21 Mar 2018 19:16:17 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:16:17 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:24:09 +0200
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 17/32] docs/vm: pagemap.txt: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:33 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0044-0000-0000-0000053E7346
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0045-0000-0000-0000287D78E9
Message-Id: <1521660168-14372-18-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210221
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rppt@linux.vnet.ibm.com
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

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/pagemap.txt | 164 +++++++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 75 deletions(-)

diff --git a/Documentation/vm/pagemap.txt b/Documentation/vm/pagemap.txt
index eafcefa..bd6d717 100644
--- a/Documentation/vm/pagemap.txt
+++ b/Documentation/vm/pagemap.txt
@@ -1,13 +1,16 @@
-pagemap, from the userspace perspective
----------------------------------------
+.. _pagemap:
+
+======================================
+pagemap from the Userspace Perspective
+======================================
 
 pagemap is a new (as of 2.6.25) set of interfaces in the kernel that allow
 userspace programs to examine the page tables and related information by
-reading files in /proc.
+reading files in ``/proc``.
 
 There are four components to pagemap:
 
- * /proc/pid/pagemap.  This file lets a userspace process find out which
+ * ``/proc/pid/pagemap``.  This file lets a userspace process find out which
    physical frame each virtual page is mapped to.  It contains one 64-bit
    value for each virtual page, containing the following data (from
    fs/proc/task_mmu.c, above pagemap_read):
@@ -37,24 +40,24 @@ There are four components to pagemap:
    determine which areas of memory are actually mapped and llseek to
    skip over unmapped regions.
 
- * /proc/kpagecount.  This file contains a 64-bit count of the number of
+ * ``/proc/kpagecount``.  This file contains a 64-bit count of the number of
    times each page is mapped, indexed by PFN.
 
- * /proc/kpageflags.  This file contains a 64-bit set of flags for each
+ * ``/proc/kpageflags``.  This file contains a 64-bit set of flags for each
    page, indexed by PFN.
 
-   The flags are (from fs/proc/page.c, above kpageflags_read):
-
-     0. LOCKED
-     1. ERROR
-     2. REFERENCED
-     3. UPTODATE
-     4. DIRTY
-     5. LRU
-     6. ACTIVE
-     7. SLAB
-     8. WRITEBACK
-     9. RECLAIM
+   The flags are (from ``fs/proc/page.c``, above kpageflags_read):
+
+    0. LOCKED
+    1. ERROR
+    2. REFERENCED
+    3. UPTODATE
+    4. DIRTY
+    5. LRU
+    6. ACTIVE
+    7. SLAB
+    8. WRITEBACK
+    9. RECLAIM
     10. BUDDY
     11. MMAP
     12. ANON
@@ -72,98 +75,108 @@ There are four components to pagemap:
     24. ZERO_PAGE
     25. IDLE
 
- * /proc/kpagecgroup.  This file contains a 64-bit inode number of the
+ * ``/proc/kpagecgroup``.  This file contains a 64-bit inode number of the
    memory cgroup each page is charged to, indexed by PFN. Only available when
    CONFIG_MEMCG is set.
 
 Short descriptions to the page flags:
-
- 0. LOCKED
-    page is being locked for exclusive access, eg. by undergoing read/write IO
-
- 7. SLAB
-    page is managed by the SLAB/SLOB/SLUB/SLQB kernel memory allocator
-    When compound page is used, SLUB/SLQB will only set this flag on the head
-    page; SLOB will not flag it at all.
-
-10. BUDDY
+=====================================
+
+0 - LOCKED
+   page is being locked for exclusive access, eg. by undergoing read/write IO
+7 - SLAB
+   page is managed by the SLAB/SLOB/SLUB/SLQB kernel memory allocator
+   When compound page is used, SLUB/SLQB will only set this flag on the head
+   page; SLOB will not flag it at all.
+10 - BUDDY
     a free memory block managed by the buddy system allocator
     The buddy system organizes free memory in blocks of various orders.
     An order N block has 2^N physically contiguous pages, with the BUDDY flag
     set for and _only_ for the first page.
-
-15. COMPOUND_HEAD
-16. COMPOUND_TAIL
+15 - COMPOUND_HEAD
     A compound page with order N consists of 2^N physically contiguous pages.
     A compound page with order 2 takes the form of "HTTT", where H donates its
     head page and T donates its tail page(s).  The major consumers of compound
     pages are hugeTLB pages (Documentation/vm/hugetlbpage.txt), the SLUB etc.
     memory allocators and various device drivers. However in this interface,
     only huge/giga pages are made visible to end users.
-17. HUGE
+16 - COMPOUND_TAIL
+    A compound page tail (see description above).
+17 - HUGE
     this is an integral part of a HugeTLB page
-
-19. HWPOISON
+19 - HWPOISON
     hardware detected memory corruption on this page: don't touch the data!
-
-20. NOPAGE
+20 - NOPAGE
     no page frame exists at the requested address
-
-21. KSM
+21 - KSM
     identical memory pages dynamically shared between one or more processes
-
-22. THP
+22 - THP
     contiguous pages which construct transparent hugepages
-
-23. BALLOON
+23 - BALLOON
     balloon compaction page
-
-24. ZERO_PAGE
+24 - ZERO_PAGE
     zero page for pfn_zero or huge_zero page
-
-25. IDLE
+25 - IDLE
     page has not been accessed since it was marked idle (see
     Documentation/vm/idle_page_tracking.txt). Note that this flag may be
     stale in case the page was accessed via a PTE. To make sure the flag
-    is up-to-date one has to read /sys/kernel/mm/page_idle/bitmap first.
-
-    [IO related page flags]
- 1. ERROR     IO error occurred
- 3. UPTODATE  page has up-to-date data
-              ie. for file backed page: (in-memory data revision >= on-disk one)
- 4. DIRTY     page has been written to, hence contains new data
-              ie. for file backed page: (in-memory data revision >  on-disk one)
- 8. WRITEBACK page is being synced to disk
-
-    [LRU related page flags]
- 5. LRU         page is in one of the LRU lists
- 6. ACTIVE      page is in the active LRU list
-18. UNEVICTABLE page is in the unevictable (non-)LRU list
-                It is somehow pinned and not a candidate for LRU page reclaims,
-		eg. ramfs pages, shmctl(SHM_LOCK) and mlock() memory segments
- 2. REFERENCED  page has been referenced since last LRU list enqueue/requeue
- 9. RECLAIM     page will be reclaimed soon after its pageout IO completed
-11. MMAP        a memory mapped page
-12. ANON        a memory mapped page that is not part of a file
-13. SWAPCACHE   page is mapped to swap space, ie. has an associated swap entry
-14. SWAPBACKED  page is backed by swap/RAM
+    is up-to-date one has to read ``/sys/kernel/mm/page_idle/bitmap`` first.
+
+IO related page flags
+---------------------
+
+1 - ERROR
+   IO error occurred
+3 - UPTODATE
+   page has up-to-date data
+   ie. for file backed page: (in-memory data revision >= on-disk one)
+4 - DIRTY
+   page has been written to, hence contains new data
+   ie. for file backed page: (in-memory data revision >  on-disk one)
+8 - WRITEBACK
+   page is being synced to disk
+
+LRU related page flags
+----------------------
+
+5 - LRU
+   page is in one of the LRU lists
+6 - ACTIVE
+   page is in the active LRU list
+18 - UNEVICTABLE
+   page is in the unevictable (non-)LRU list It is somehow pinned and
+   not a candidate for LRU page reclaims, eg. ramfs pages,
+   shmctl(SHM_LOCK) and mlock() memory segments
+2 - REFERENCED
+   page has been referenced since last LRU list enqueue/requeue
+9 - RECLAIM
+   page will be reclaimed soon after its pageout IO completed
+11 - MMAP
+   a memory mapped page
+12 - ANON
+   a memory mapped page that is not part of a file
+13 - SWAPCACHE
+   page is mapped to swap space, ie. has an associated swap entry
+14 - SWAPBACKED
+   page is backed by swap/RAM
 
 The page-types tool in the tools/vm directory can be used to query the
 above flags.
 
-Using pagemap to do something useful:
+Using pagemap to do something useful
+====================================
 
 The general procedure for using pagemap to find out about a process' memory
 usage goes like this:
 
- 1. Read /proc/pid/maps to determine which parts of the memory space are
+ 1. Read ``/proc/pid/maps`` to determine which parts of the memory space are
     mapped to what.
  2. Select the maps you are interested in -- all of them, or a particular
     library, or the stack or the heap, etc.
- 3. Open /proc/pid/pagemap and seek to the pages you would like to examine.
+ 3. Open ``/proc/pid/pagemap`` and seek to the pages you would like to examine.
  4. Read a u64 for each page from pagemap.
- 5. Open /proc/kpagecount and/or /proc/kpageflags.  For each PFN you just
-    read, seek to that entry in the file, and read the data you want.
+ 5. Open ``/proc/kpagecount`` and/or ``/proc/kpageflags``.  For each PFN you
+    just read, seek to that entry in the file, and read the data you want.
 
 For example, to find the "unique set size" (USS), which is the amount of
 memory that a process is using that is not shared with any other process,
@@ -171,7 +184,8 @@ you can go through every map in the process, find the PFNs, look those up
 in kpagecount, and tally up the number of pages that are only referenced
 once.
 
-Other notes:
+Other notes
+===========
 
 Reading from any of the files will return -EINVAL if you are not starting
 the read on an 8-byte boundary (e.g., if you sought an odd number of bytes
-- 
2.7.4
