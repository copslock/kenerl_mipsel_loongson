Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:28:43 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994711AbeCUTY2nhKZB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:24:28 +0100
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJM3bA130277
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:24:27 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2guv1147ep-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:24:26 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:24:23 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp10.uk.ibm.com (192.168.101.140) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:24:18 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJOHDM61472976;
        Wed, 21 Mar 2018 19:24:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 350F511C04A;
        Wed, 21 Mar 2018 19:16:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1504A11C052;
        Wed, 21 Mar 2018 19:16:45 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:16:44 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:24:13 +0200
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
Subject: [PATCH 18/32] docs/vm: page_migration: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:34 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0040-0000-0000-000004258214
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0041-0000-0000-000026288779
Message-Id: <1521660168-14372-19-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210221
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63109
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
 Documentation/vm/page_migration | 149 +++++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 72 deletions(-)

diff --git a/Documentation/vm/page_migration b/Documentation/vm/page_migration
index 0478ae2..07b67a8 100644
--- a/Documentation/vm/page_migration
+++ b/Documentation/vm/page_migration
@@ -1,5 +1,8 @@
+.. _page_migration:
+
+==============
 Page migration
---------------
+==============
 
 Page migration allows the moving of the physical location of pages between
 nodes in a numa system while the process is running. This means that the
@@ -20,7 +23,7 @@ Page migration functions are provided by the numactl package by Andi Kleen
 (a version later than 0.9.3 is required. Get it from
 ftp://oss.sgi.com/www/projects/libnuma/download/). numactl provides libnuma
 which provides an interface similar to other numa functionality for page
-migration.  cat /proc/<pid>/numa_maps allows an easy review of where the
+migration.  cat ``/proc/<pid>/numa_maps`` allows an easy review of where the
 pages of a process are located. See also the numa_maps documentation in the
 proc(5) man page.
 
@@ -56,8 +59,8 @@ description for those trying to use migrate_pages() from the kernel
 (for userspace usage see the Andi Kleen's numactl package mentioned above)
 and then a low level description of how the low level details work.
 
-A. In kernel use of migrate_pages()
------------------------------------
+In kernel use of migrate_pages()
+================================
 
 1. Remove pages from the LRU.
 
@@ -78,8 +81,8 @@ A. In kernel use of migrate_pages()
    the new page for each page that is considered for
    moving.
 
-B. How migrate_pages() works
-----------------------------
+How migrate_pages() works
+=========================
 
 migrate_pages() does several passes over its list of pages. A page is moved
 if all references to a page are removable at the time. The page has
@@ -142,8 +145,8 @@ Steps:
 20. The new page is moved to the LRU and can be scanned by the swapper
     etc again.
 
-C. Non-LRU page migration
--------------------------
+Non-LRU page migration
+======================
 
 Although original migration aimed for reducing the latency of memory access
 for NUMA, compaction who want to create high-order page is also main customer.
@@ -164,89 +167,91 @@ migration path.
 If a driver want to make own pages movable, it should define three functions
 which are function pointers of struct address_space_operations.
 
-1. bool (*isolate_page) (struct page *page, isolate_mode_t mode);
+1. ``bool (*isolate_page) (struct page *page, isolate_mode_t mode);``
 
-What VM expects on isolate_page function of driver is to return *true*
-if driver isolates page successfully. On returing true, VM marks the page
-as PG_isolated so concurrent isolation in several CPUs skip the page
-for isolation. If a driver cannot isolate the page, it should return *false*.
+   What VM expects on isolate_page function of driver is to return *true*
+   if driver isolates page successfully. On returing true, VM marks the page
+   as PG_isolated so concurrent isolation in several CPUs skip the page
+   for isolation. If a driver cannot isolate the page, it should return *false*.
 
-Once page is successfully isolated, VM uses page.lru fields so driver
-shouldn't expect to preserve values in that fields.
+   Once page is successfully isolated, VM uses page.lru fields so driver
+   shouldn't expect to preserve values in that fields.
 
-2. int (*migratepage) (struct address_space *mapping,
-		struct page *newpage, struct page *oldpage, enum migrate_mode);
+2. ``int (*migratepage) (struct address_space *mapping,``
+|	``struct page *newpage, struct page *oldpage, enum migrate_mode);``
 
-After isolation, VM calls migratepage of driver with isolated page.
-The function of migratepage is to move content of the old page to new page
-and set up fields of struct page newpage. Keep in mind that you should
-indicate to the VM the oldpage is no longer movable via __ClearPageMovable()
-under page_lock if you migrated the oldpage successfully and returns
-MIGRATEPAGE_SUCCESS. If driver cannot migrate the page at the moment, driver
-can return -EAGAIN. On -EAGAIN, VM will retry page migration in a short time
-because VM interprets -EAGAIN as "temporal migration failure". On returning
-any error except -EAGAIN, VM will give up the page migration without retrying
-in this time.
+   After isolation, VM calls migratepage of driver with isolated page.
+   The function of migratepage is to move content of the old page to new page
+   and set up fields of struct page newpage. Keep in mind that you should
+   indicate to the VM the oldpage is no longer movable via __ClearPageMovable()
+   under page_lock if you migrated the oldpage successfully and returns
+   MIGRATEPAGE_SUCCESS. If driver cannot migrate the page at the moment, driver
+   can return -EAGAIN. On -EAGAIN, VM will retry page migration in a short time
+   because VM interprets -EAGAIN as "temporal migration failure". On returning
+   any error except -EAGAIN, VM will give up the page migration without retrying
+   in this time.
 
-Driver shouldn't touch page.lru field VM using in the functions.
+   Driver shouldn't touch page.lru field VM using in the functions.
 
-3. void (*putback_page)(struct page *);
+3. ``void (*putback_page)(struct page *);``
 
-If migration fails on isolated page, VM should return the isolated page
-to the driver so VM calls driver's putback_page with migration failed page.
-In this function, driver should put the isolated page back to the own data
-structure.
+   If migration fails on isolated page, VM should return the isolated page
+   to the driver so VM calls driver's putback_page with migration failed page.
+   In this function, driver should put the isolated page back to the own data
+   structure.
 
 4. non-lru movable page flags
 
-There are two page flags for supporting non-lru movable page.
+   There are two page flags for supporting non-lru movable page.
 
-* PG_movable
+   * PG_movable
 
-Driver should use the below function to make page movable under page_lock.
+     Driver should use the below function to make page movable under page_lock::
 
 	void __SetPageMovable(struct page *page, struct address_space *mapping)
 
-It needs argument of address_space for registering migration family functions
-which will be called by VM. Exactly speaking, PG_movable is not a real flag of
-struct page. Rather than, VM reuses page->mapping's lower bits to represent it.
+     It needs argument of address_space for registering migration
+     family functions which will be called by VM. Exactly speaking,
+     PG_movable is not a real flag of struct page. Rather than, VM
+     reuses page->mapping's lower bits to represent it.
 
+::
 	#define PAGE_MAPPING_MOVABLE 0x2
 	page->mapping = page->mapping | PAGE_MAPPING_MOVABLE;
 
-so driver shouldn't access page->mapping directly. Instead, driver should
-use page_mapping which mask off the low two bits of page->mapping under
-page lock so it can get right struct address_space.
-
-For testing of non-lru movable page, VM supports __PageMovable function.
-However, it doesn't guarantee to identify non-lru movable page because
-page->mapping field is unified with other variables in struct page.
-As well, if driver releases the page after isolation by VM, page->mapping
-doesn't have stable value although it has PAGE_MAPPING_MOVABLE
-(Look at __ClearPageMovable). But __PageMovable is cheap to catch whether
-page is LRU or non-lru movable once the page has been isolated. Because
-LRU pages never can have PAGE_MAPPING_MOVABLE in page->mapping. It is also
-good for just peeking to test non-lru movable pages before more expensive
-checking with lock_page in pfn scanning to select victim.
-
-For guaranteeing non-lru movable page, VM provides PageMovable function.
-Unlike __PageMovable, PageMovable functions validates page->mapping and
-mapping->a_ops->isolate_page under lock_page. The lock_page prevents sudden
-destroying of page->mapping.
-
-Driver using __SetPageMovable should clear the flag via __ClearMovablePage
-under page_lock before the releasing the page.
-
-* PG_isolated
-
-To prevent concurrent isolation among several CPUs, VM marks isolated page
-as PG_isolated under lock_page. So if a CPU encounters PG_isolated non-lru
-movable page, it can skip it. Driver doesn't need to manipulate the flag
-because VM will set/clear it automatically. Keep in mind that if driver
-sees PG_isolated page, it means the page have been isolated by VM so it
-shouldn't touch page.lru field.
-PG_isolated is alias with PG_reclaim flag so driver shouldn't use the flag
-for own purpose.
+     so driver shouldn't access page->mapping directly. Instead, driver should
+     use page_mapping which mask off the low two bits of page->mapping under
+     page lock so it can get right struct address_space.
+
+     For testing of non-lru movable page, VM supports __PageMovable function.
+     However, it doesn't guarantee to identify non-lru movable page because
+     page->mapping field is unified with other variables in struct page.
+     As well, if driver releases the page after isolation by VM, page->mapping
+     doesn't have stable value although it has PAGE_MAPPING_MOVABLE
+     (Look at __ClearPageMovable). But __PageMovable is cheap to catch whether
+     page is LRU or non-lru movable once the page has been isolated. Because
+     LRU pages never can have PAGE_MAPPING_MOVABLE in page->mapping. It is also
+     good for just peeking to test non-lru movable pages before more expensive
+     checking with lock_page in pfn scanning to select victim.
+
+     For guaranteeing non-lru movable page, VM provides PageMovable function.
+     Unlike __PageMovable, PageMovable functions validates page->mapping and
+     mapping->a_ops->isolate_page under lock_page. The lock_page prevents sudden
+     destroying of page->mapping.
+
+     Driver using __SetPageMovable should clear the flag via __ClearMovablePage
+     under page_lock before the releasing the page.
+
+   * PG_isolated
+
+     To prevent concurrent isolation among several CPUs, VM marks isolated page
+     as PG_isolated under lock_page. So if a CPU encounters PG_isolated non-lru
+     movable page, it can skip it. Driver doesn't need to manipulate the flag
+     because VM will set/clear it automatically. Keep in mind that if driver
+     sees PG_isolated page, it means the page have been isolated by VM so it
+     shouldn't touch page.lru field.
+     PG_isolated is alias with PG_reclaim flag so driver shouldn't use the flag
+     for own purpose.
 
 Christoph Lameter, May 8, 2006.
 Minchan Kim, Mar 28, 2016.
-- 
2.7.4
