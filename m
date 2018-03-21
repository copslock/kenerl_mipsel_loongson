Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:23:11 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993070AbeCUTXEbzIpP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:23:04 +0100
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJIair094373
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:02 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2guvmsaeuy-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:02 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:22:59 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:22:55 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJMs3f54001786;
        Wed, 21 Mar 2018 19:22:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1EFEA4040;
        Wed, 21 Mar 2018 19:15:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2F7DA4051;
        Wed, 21 Mar 2018 19:15:33 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:15:33 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:22:50 +0200
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
Subject: [PATCH 00/32] docs/vm: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:16 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18032119-0044-0000-0000-0000053E7331
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0045-0000-0000-0000287D78D5
Message-Id: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210221
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63091
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

Hi,

These patches convert files in Documentation/vm to ReST format, add an
initial index and link it to the top level documentation.

There are no contents changes in the documentation, except few spelling
fixes. The relatively large diffstat stems from the indentation and
paragraph wrapping changes.

I've tried to keep the formatting as consistent as possible, but I could
miss some places that needed markup and add some markup where it was not
necessary.


Mike Rapoport (32):
  docs/vm: active_mm.txt convert to ReST format
  docs/vm: balance: convert to ReST format
  docs/vm: cleancache.txt: convert to ReST format
  docs/vm: frontswap.txt: convert to ReST format
  docs/vm: highmem.txt: convert to ReST format
  docs/vm: hmm.txt: convert to ReST format
  docs/vm: hugetlbpage.txt: convert to ReST format
  docs/vm: hugetlbfs_reserv.txt: convert to ReST format
  docs/vm: hwpoison.txt: convert to ReST format
  docs/vm: idle_page_tracking.txt: convert to ReST format
  docs/vm: ksm.txt: convert to ReST format
  docs/vm: mmu_notifier.txt: convert to ReST format
  docs/vm: numa_memory_policy.txt: convert to ReST format
  docs/vm: overcommit-accounting: convert to ReST format
  docs/vm: page_frags convert to ReST format
  docs/vm: numa: convert to ReST format
  docs/vm: pagemap.txt: convert to ReST format
  docs/vm: page_migration: convert to ReST format
  docs/vm: page_owner: convert to ReST format
  docs/vm: remap_file_pages.txt: conert to ReST format
  docs/vm: slub.txt: convert to ReST format
  docs/vm: soft-dirty.txt: convert to ReST format
  docs/vm: split_page_table_lock: convert to ReST format
  docs/vm: swap_numa.txt: convert to ReST format
  docs/vm: transhuge.txt: convert to ReST format
  docs/vm: unevictable-lru.txt: convert to ReST format
  docs/vm: userfaultfd.txt: convert to ReST format
  docs/vm: z3fold.txt: convert to ReST format
  docs/vm: zsmalloc.txt: convert to ReST format
  docs/vm: zswap.txt: convert to ReST format
  docs/vm: rename documentation files to .rst
  docs/vm: add index.rst and link MM documentation to top level index

 Documentation/ABI/stable/sysfs-devices-node        |   2 +-
 .../ABI/testing/sysfs-kernel-mm-hugepages          |   2 +-
 Documentation/ABI/testing/sysfs-kernel-mm-ksm      |   2 +-
 Documentation/ABI/testing/sysfs-kernel-slab        |   4 +-
 Documentation/admin-guide/kernel-parameters.txt    |  12 +-
 Documentation/dev-tools/kasan.rst                  |   2 +-
 Documentation/filesystems/proc.txt                 |   4 +-
 Documentation/filesystems/tmpfs.txt                |   2 +-
 Documentation/index.rst                            |   3 +-
 Documentation/sysctl/vm.txt                        |   6 +-
 Documentation/vm/00-INDEX                          |  58 +--
 Documentation/vm/active_mm.rst                     |  91 ++++
 Documentation/vm/active_mm.txt                     |  83 ----
 Documentation/vm/{balance => balance.rst}          |  15 +-
 .../vm/{cleancache.txt => cleancache.rst}          | 105 +++--
 Documentation/vm/conf.py                           |  10 +
 Documentation/vm/{frontswap.txt => frontswap.rst}  |  59 ++-
 Documentation/vm/{highmem.txt => highmem.rst}      |  87 ++--
 Documentation/vm/{hmm.txt => hmm.rst}              |  66 ++-
 .../{hugetlbfs_reserv.txt => hugetlbfs_reserv.rst} | 212 +++++----
 .../vm/{hugetlbpage.txt => hugetlbpage.rst}        | 243 ++++++-----
 Documentation/vm/{hwpoison.txt => hwpoison.rst}    | 141 +++---
 ...le_page_tracking.txt => idle_page_tracking.rst} |  55 ++-
 Documentation/vm/index.rst                         |  56 +++
 Documentation/vm/ksm.rst                           | 183 ++++++++
 Documentation/vm/ksm.txt                           | 178 --------
 Documentation/vm/mmu_notifier.rst                  |  99 +++++
 Documentation/vm/mmu_notifier.txt                  |  93 ----
 Documentation/vm/{numa => numa.rst}                |   6 +-
 Documentation/vm/numa_memory_policy.rst            | 485 +++++++++++++++++++++
 Documentation/vm/numa_memory_policy.txt            | 452 -------------------
 Documentation/vm/overcommit-accounting             |  80 ----
 Documentation/vm/overcommit-accounting.rst         |  87 ++++
 Documentation/vm/{page_frags => page_frags.rst}    |   5 +-
 .../vm/{page_migration => page_migration.rst}      | 149 ++++---
 .../vm/{page_owner.txt => page_owner.rst}          |  34 +-
 Documentation/vm/{pagemap.txt => pagemap.rst}      | 170 ++++----
 .../{remap_file_pages.txt => remap_file_pages.rst} |   6 +
 Documentation/vm/slub.rst                          | 361 +++++++++++++++
 Documentation/vm/slub.txt                          | 342 ---------------
 .../vm/{soft-dirty.txt => soft-dirty.rst}          |  20 +-
 ...t_page_table_lock => split_page_table_lock.rst} |  12 +-
 Documentation/vm/{swap_numa.txt => swap_numa.rst}  |  55 ++-
 Documentation/vm/{transhuge.txt => transhuge.rst}  | 286 +++++++-----
 .../{unevictable-lru.txt => unevictable-lru.rst}   | 117 +++--
 .../vm/{userfaultfd.txt => userfaultfd.rst}        |  66 +--
 Documentation/vm/{z3fold.txt => z3fold.rst}        |   6 +-
 Documentation/vm/{zsmalloc.txt => zsmalloc.rst}    |  60 ++-
 Documentation/vm/{zswap.txt => zswap.rst}          |  71 +--
 MAINTAINERS                                        |   2 +-
 arch/alpha/Kconfig                                 |   2 +-
 arch/ia64/Kconfig                                  |   2 +-
 arch/mips/Kconfig                                  |   2 +-
 arch/powerpc/Kconfig                               |   2 +-
 fs/Kconfig                                         |   2 +-
 fs/dax.c                                           |   2 +-
 fs/proc/task_mmu.c                                 |   4 +-
 include/linux/hmm.h                                |   2 +-
 include/linux/memremap.h                           |   4 +-
 include/linux/mmu_notifier.h                       |   2 +-
 include/linux/sched/mm.h                           |   4 +-
 include/linux/swap.h                               |   2 +-
 mm/Kconfig                                         |   6 +-
 mm/cleancache.c                                    |   2 +-
 mm/frontswap.c                                     |   2 +-
 mm/hmm.c                                           |   2 +-
 mm/huge_memory.c                                   |   4 +-
 mm/hugetlb.c                                       |   4 +-
 mm/ksm.c                                           |   4 +-
 mm/mmap.c                                          |   2 +-
 mm/rmap.c                                          |   6 +-
 mm/util.c                                          |   2 +-
 72 files changed, 2604 insertions(+), 2205 deletions(-)
 create mode 100644 Documentation/vm/active_mm.rst
 delete mode 100644 Documentation/vm/active_mm.txt
 rename Documentation/vm/{balance => balance.rst} (96%)
 rename Documentation/vm/{cleancache.txt => cleancache.rst} (83%)
 create mode 100644 Documentation/vm/conf.py
 rename Documentation/vm/{frontswap.txt => frontswap.rst} (91%)
 rename Documentation/vm/{highmem.txt => highmem.rst} (64%)
 rename Documentation/vm/{hmm.txt => hmm.rst} (92%)
 rename Documentation/vm/{hugetlbfs_reserv.txt => hugetlbfs_reserv.rst} (87%)
 rename Documentation/vm/{hugetlbpage.txt => hugetlbpage.rst} (64%)
 rename Documentation/vm/{hwpoison.txt => hwpoison.rst} (60%)
 rename Documentation/vm/{idle_page_tracking.txt => idle_page_tracking.rst} (72%)
 create mode 100644 Documentation/vm/index.rst
 create mode 100644 Documentation/vm/ksm.rst
 delete mode 100644 Documentation/vm/ksm.txt
 create mode 100644 Documentation/vm/mmu_notifier.rst
 delete mode 100644 Documentation/vm/mmu_notifier.txt
 rename Documentation/vm/{numa => numa.rst} (99%)
 create mode 100644 Documentation/vm/numa_memory_policy.rst
 delete mode 100644 Documentation/vm/numa_memory_policy.txt
 delete mode 100644 Documentation/vm/overcommit-accounting
 create mode 100644 Documentation/vm/overcommit-accounting.rst
 rename Documentation/vm/{page_frags => page_frags.rst} (97%)
 rename Documentation/vm/{page_migration => page_migration.rst} (63%)
 rename Documentation/vm/{page_owner.txt => page_owner.rst} (86%)
 rename Documentation/vm/{pagemap.txt => pagemap.rst} (60%)
 rename Documentation/vm/{remap_file_pages.txt => remap_file_pages.rst} (92%)
 create mode 100644 Documentation/vm/slub.rst
 delete mode 100644 Documentation/vm/slub.txt
 rename Documentation/vm/{soft-dirty.txt => soft-dirty.rst} (67%)
 rename Documentation/vm/{split_page_table_lock => split_page_table_lock.rst} (95%)
 rename Documentation/vm/{swap_numa.txt => swap_numa.rst} (74%)
 rename Documentation/vm/{transhuge.txt => transhuge.rst} (74%)
 rename Documentation/vm/{unevictable-lru.txt => unevictable-lru.rst} (92%)
 rename Documentation/vm/{userfaultfd.txt => userfaultfd.rst} (89%)
 rename Documentation/vm/{z3fold.txt => z3fold.rst} (97%)
 rename Documentation/vm/{zsmalloc.txt => zsmalloc.rst} (71%)
 rename Documentation/vm/{zswap.txt => zswap.rst} (74%)

-- 
2.7.4
