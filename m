Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:25:01 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994656AbeCUTXeUS0Eo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:23:34 +0100
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJK9I8105475
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:33 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2guv66ups5-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:32 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:23:29 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp11.uk.ibm.com (192.168.101.141) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:23:24 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJNNCm58261676;
        Wed, 21 Mar 2018 19:23:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F4BD42045;
        Wed, 21 Mar 2018 19:15:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A09C542041;
        Wed, 21 Mar 2018 19:15:27 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:15:27 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:23:19 +0200
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
Subject: [PATCH 06/32] docs/vm: hmm.txt: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:22 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0040-0000-0000-00000443E0A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0041-0000-0000-000020E705C2
Message-Id: <1521660168-14372-7-git-send-email-rppt@linux.vnet.ibm.com>
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
X-archive-position: 63097
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
 Documentation/vm/hmm.txt | 66 ++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

diff --git a/Documentation/vm/hmm.txt b/Documentation/vm/hmm.txt
index 4d3aac9..3fafa33 100644
--- a/Documentation/vm/hmm.txt
+++ b/Documentation/vm/hmm.txt
@@ -1,4 +1,8 @@
+.. hmm:
+
+=====================================
 Heterogeneous Memory Management (HMM)
+=====================================
 
 Transparently allow any component of a program to use any memory region of said
 program with a device without using device specific memory allocator. This is
@@ -14,19 +18,10 @@ deals with how device memory is represented inside the kernel. Finaly the last
 section present the new migration helper that allow to leverage the device DMA
 engine.
 
+.. contents:: :local:
 
-1) Problems of using device specific memory allocator:
-2) System bus, device memory characteristics
-3) Share address space and migration
-4) Address space mirroring implementation and API
-5) Represent and manage device memory from core kernel point of view
-6) Migrate to and from device memory
-7) Memory cgroup (memcg) and rss accounting
-
-
--------------------------------------------------------------------------------
-
-1) Problems of using device specific memory allocator:
+Problems of using device specific memory allocator
+==================================================
 
 Device with large amount of on board memory (several giga bytes) like GPU have
 historically manage their memory through dedicated driver specific API. This
@@ -68,9 +63,8 @@ only do-able with a share address. It is as well more reasonable to use a share
 address space for all the other patterns.
 
 
--------------------------------------------------------------------------------
-
-2) System bus, device memory characteristics
+System bus, device memory characteristics
+=========================================
 
 System bus cripple share address due to few limitations. Most system bus only
 allow basic memory access from device to main memory, even cache coherency is
@@ -100,9 +94,8 @@ access any memory memory but we must also permit any memory to be migrated to
 device memory while device is using it (blocking CPU access while it happens).
 
 
--------------------------------------------------------------------------------
-
-3) Share address space and migration
+Share address space and migration
+=================================
 
 HMM intends to provide two main features. First one is to share the address
 space by duplication the CPU page table into the device page table so same
@@ -140,14 +133,13 @@ leverage device memory by migrating part of data-set that is actively use by a
 device.
 
 
--------------------------------------------------------------------------------
-
-4) Address space mirroring implementation and API
+Address space mirroring implementation and API
+==============================================
 
 Address space mirroring main objective is to allow to duplicate range of CPU
 page table into a device page table and HMM helps keeping both synchronize. A
 device driver that want to mirror a process address space must start with the
-registration of an hmm_mirror struct:
+registration of an hmm_mirror struct::
 
  int hmm_mirror_register(struct hmm_mirror *mirror,
                          struct mm_struct *mm);
@@ -156,7 +148,7 @@ registration of an hmm_mirror struct:
 
 The locked variant is to be use when the driver is already holding the mmap_sem
 of the mm in write mode. The mirror struct has a set of callback that are use
-to propagate CPU page table:
+to propagate CPU page table::
 
  struct hmm_mirror_ops {
      /* sync_cpu_device_pagetables() - synchronize page tables
@@ -187,7 +179,8 @@ be done with the update.
 
 
 When device driver wants to populate a range of virtual address it can use
-either:
+either::
+
  int hmm_vma_get_pfns(struct vm_area_struct *vma,
                       struct hmm_range *range,
                       unsigned long start,
@@ -211,7 +204,7 @@ that array correspond to an address in the virtual range. HMM provide a set of
 flags to help driver identify special CPU page table entries.
 
 Locking with the update() callback is the most important aspect the driver must
-respect in order to keep things properly synchronize. The usage pattern is :
+respect in order to keep things properly synchronize. The usage pattern is::
 
  int driver_populate_range(...)
  {
@@ -251,9 +244,8 @@ concurrently for multiple devices. Waiting for each device to report commands
 as executed is serialize (there is no point in doing this concurrently).
 
 
--------------------------------------------------------------------------------
-
-5) Represent and manage device memory from core kernel point of view
+Represent and manage device memory from core kernel point of view
+=================================================================
 
 Several differents design were try to support device memory. First one use
 device specific data structure to keep information about migrated memory and
@@ -269,14 +261,14 @@ un-aware of the difference. We only need to make sure that no one ever try to
 map those page from the CPU side.
 
 HMM provide a set of helpers to register and hotplug device memory as a new
-region needing struct page. This is offer through a very simple API:
+region needing struct page. This is offer through a very simple API::
 
  struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
                                    struct device *device,
                                    unsigned long size);
  void hmm_devmem_remove(struct hmm_devmem *devmem);
 
-The hmm_devmem_ops is where most of the important things are:
+The hmm_devmem_ops is where most of the important things are::
 
  struct hmm_devmem_ops {
      void (*free)(struct hmm_devmem *devmem, struct page *page);
@@ -294,13 +286,12 @@ second callback happens whenever CPU try to access a device page which it can
 not do. This second callback must trigger a migration back to system memory.
 
 
--------------------------------------------------------------------------------
-
-6) Migrate to and from device memory
+Migrate to and from device memory
+=================================
 
 Because CPU can not access device memory, migration must use device DMA engine
 to perform copy from and to device memory. For this we need a new migration
-helper:
+helper::
 
  int migrate_vma(const struct migrate_vma_ops *ops,
                  struct vm_area_struct *vma,
@@ -319,7 +310,7 @@ such migration base on range of address the device is actively accessing.
 
 The migrate_vma_ops struct define two callbacks. First one (alloc_and_copy())
 control destination memory allocation and copy operation. Second one is there
-to allow device driver to perform cleanup operation after migration.
+to allow device driver to perform cleanup operation after migration::
 
  struct migrate_vma_ops {
      void (*alloc_and_copy)(struct vm_area_struct *vma,
@@ -353,9 +344,8 @@ bandwidth but this is considered as a rare event and a price that we are
 willing to pay to keep all the code simpler.
 
 
--------------------------------------------------------------------------------
-
-7) Memory cgroup (memcg) and rss accounting
+Memory cgroup (memcg) and rss accounting
+========================================
 
 For now device memory is accounted as any regular page in rss counters (either
 anonymous if device page is use for anonymous, file if device page is use for
-- 
2.7.4
