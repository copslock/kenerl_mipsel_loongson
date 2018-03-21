Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:26:12 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994679AbeCUTXxTPms2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:23:53 +0100
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJL8He057687
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:51 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2guw2hs8kw-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:50 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:23:48 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp11.uk.ibm.com (192.168.101.141) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:23:42 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJNfbl57606334;
        Wed, 21 Mar 2018 19:23:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2CD94C04A;
        Wed, 21 Mar 2018 19:16:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B83D44C046;
        Wed, 21 Mar 2018 19:16:45 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:16:45 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:23:37 +0200
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
Subject: [PATCH 10/32] docs/vm: idle_page_tracking.txt: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:26 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0040-0000-0000-00000443E0AB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0041-0000-0000-000020E705C9
Message-Id: <1521660168-14372-11-git-send-email-rppt@linux.vnet.ibm.com>
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
X-archive-position: 63101
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
 Documentation/vm/idle_page_tracking.txt | 55 +++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/Documentation/vm/idle_page_tracking.txt b/Documentation/vm/idle_page_tracking.txt
index 85dcc3b..9cbe6f8 100644
--- a/Documentation/vm/idle_page_tracking.txt
+++ b/Documentation/vm/idle_page_tracking.txt
@@ -1,4 +1,11 @@
-MOTIVATION
+.. _idle_page_tracking:
+
+==================
+Idle Page Tracking
+==================
+
+Motivation
+==========
 
 The idle page tracking feature allows to track which memory pages are being
 accessed by a workload and which are idle. This information can be useful for
@@ -8,10 +15,14 @@ or deciding where to place the workload within a compute cluster.
 
 It is enabled by CONFIG_IDLE_PAGE_TRACKING=y.
 
-USER API
+.. _user_api:
 
-The idle page tracking API is located at /sys/kernel/mm/page_idle. Currently,
-it consists of the only read-write file, /sys/kernel/mm/page_idle/bitmap.
+User API
+========
+
+The idle page tracking API is located at ``/sys/kernel/mm/page_idle``.
+Currently, it consists of the only read-write file,
+``/sys/kernel/mm/page_idle/bitmap``.
 
 The file implements a bitmap where each bit corresponds to a memory page. The
 bitmap is represented by an array of 8-byte integers, and the page at PFN #i is
@@ -19,8 +30,9 @@ mapped to bit #i%64 of array element #i/64, byte order is native. When a bit is
 set, the corresponding page is idle.
 
 A page is considered idle if it has not been accessed since it was marked idle
-(for more details on what "accessed" actually means see the IMPLEMENTATION
-DETAILS section). To mark a page idle one has to set the bit corresponding to
+(for more details on what "accessed" actually means see the :ref:`Implementation
+Details <impl_details>` section).
+To mark a page idle one has to set the bit corresponding to
 the page by writing to the file. A value written to the file is OR-ed with the
 current bitmap value.
 
@@ -30,9 +42,9 @@ page types (e.g. SLAB pages) an attempt to mark a page idle is silently ignored,
 and hence such pages are never reported idle.
 
 For huge pages the idle flag is set only on the head page, so one has to read
-/proc/kpageflags in order to correctly count idle huge pages.
+``/proc/kpageflags`` in order to correctly count idle huge pages.
 
-Reading from or writing to /sys/kernel/mm/page_idle/bitmap will return
+Reading from or writing to ``/sys/kernel/mm/page_idle/bitmap`` will return
 -EINVAL if you are not starting the read/write on an 8-byte boundary, or
 if the size of the read/write is not a multiple of 8 bytes. Writing to
 this file beyond max PFN will return -ENXIO.
@@ -41,21 +53,25 @@ That said, in order to estimate the amount of pages that are not used by a
 workload one should:
 
  1. Mark all the workload's pages as idle by setting corresponding bits in
-    /sys/kernel/mm/page_idle/bitmap. The pages can be found by reading
-    /proc/pid/pagemap if the workload is represented by a process, or by
-    filtering out alien pages using /proc/kpagecgroup in case the workload is
-    placed in a memory cgroup.
+    ``/sys/kernel/mm/page_idle/bitmap``. The pages can be found by reading
+    ``/proc/pid/pagemap`` if the workload is represented by a process, or by
+    filtering out alien pages using ``/proc/kpagecgroup`` in case the workload
+    is placed in a memory cgroup.
 
  2. Wait until the workload accesses its working set.
 
- 3. Read /sys/kernel/mm/page_idle/bitmap and count the number of bits set. If
-    one wants to ignore certain types of pages, e.g. mlocked pages since they
-    are not reclaimable, he or she can filter them out using /proc/kpageflags.
+ 3. Read ``/sys/kernel/mm/page_idle/bitmap`` and count the number of bits set.
+    If one wants to ignore certain types of pages, e.g. mlocked pages since they
+    are not reclaimable, he or she can filter them out using
+    ``/proc/kpageflags``.
+
+See Documentation/vm/pagemap.txt for more information about
+``/proc/pid/pagemap``, ``/proc/kpageflags``, and ``/proc/kpagecgroup``.
 
-See Documentation/vm/pagemap.txt for more information about /proc/pid/pagemap,
-/proc/kpageflags, and /proc/kpagecgroup.
+.. _impl_details:
 
-IMPLEMENTATION DETAILS
+Implementation Details
+======================
 
 The kernel internally keeps track of accesses to user memory pages in order to
 reclaim unreferenced pages first on memory shortage conditions. A page is
@@ -77,7 +93,8 @@ When a dirty page is written to swap or disk as a result of memory reclaim or
 exceeding the dirty memory limit, it is not marked referenced.
 
 The idle memory tracking feature adds a new page flag, the Idle flag. This flag
-is set manually, by writing to /sys/kernel/mm/page_idle/bitmap (see the USER API
+is set manually, by writing to ``/sys/kernel/mm/page_idle/bitmap`` (see the
+:ref:`User API <user_api>`
 section), and cleared automatically whenever a page is referenced as defined
 above.
 
-- 
2.7.4
