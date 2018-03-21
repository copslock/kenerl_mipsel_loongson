Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:32:32 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994751AbeCUTZagK-WZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:25:30 +0100
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJMR4o078685
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:25:29 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2guwg9g47u-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:25:29 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:25:27 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp12.uk.ibm.com (192.168.101.142) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:25:20 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJPJi849086574;
        Wed, 21 Mar 2018 19:25:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2188611C052;
        Wed, 21 Mar 2018 19:17:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F72011C04A;
        Wed, 21 Mar 2018 19:17:46 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:17:46 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:25:15 +0200
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
Subject: [PATCH 32/32] docs/vm: add index.rst and link MM documentation to top level index
Date:   Wed, 21 Mar 2018 21:22:48 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0008-0000-0000-000004E0DF88
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0009-0000-0000-00001E7403FC
Message-Id: <1521660168-14372-33-git-send-email-rppt@linux.vnet.ibm.com>
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
X-archive-position: 63122
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
 Documentation/index.rst    |  3 ++-
 Documentation/vm/conf.py   | 10 +++++++++
 Documentation/vm/index.rst | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/vm/conf.py
 create mode 100644 Documentation/vm/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index ef5080c..cc4a098 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -45,7 +45,7 @@ the kernel interface as seen by application developers.
 .. toctree::
    :maxdepth: 2
 
-   userspace-api/index	      
+   userspace-api/index
 
 
 Introduction to kernel development
@@ -88,6 +88,7 @@ needed).
    sound/index
    crypto/index
    filesystems/index
+   vm/index
 
 Architecture-specific documentation
 -----------------------------------
diff --git a/Documentation/vm/conf.py b/Documentation/vm/conf.py
new file mode 100644
index 0000000..3b0b601
--- /dev/null
+++ b/Documentation/vm/conf.py
@@ -0,0 +1,10 @@
+# -*- coding: utf-8; mode: python -*-
+
+project = "Linux Memory Management Documentation"
+
+tags.add("subproject")
+
+latex_documents = [
+    ('index', 'memory-management.tex', project,
+     'The kernel development community', 'manual'),
+]
diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
new file mode 100644
index 0000000..6c45142
--- /dev/null
+++ b/Documentation/vm/index.rst
@@ -0,0 +1,56 @@
+=====================================
+Linux Memory Management Documentation
+=====================================
+
+This is a collection of documents about Linux memory management (mm) subsystem.
+
+User guides for MM features
+===========================
+
+The following documents provide guides for controlling and tuning
+various features of the Linux memory management
+
+.. toctree::
+   :maxdepth: 1
+
+   hugetlbpage
+   idle_page_tracking
+   ksm
+   numa_memory_policy
+   pagemap
+   transhuge
+   soft-dirty
+   swap_numa
+   userfaultfd
+   zswap
+
+Kernel developers MM documentation
+==================================
+
+The below documents describe MM internals with different level of
+details ranging from notes and mailing list responses to elaborate
+descriptions of data structures and algorithms.
+
+.. toctree::
+   :maxdepth: 1
+
+   active_mm
+   balance
+   cleancache
+   frontswap
+   highmem
+   hmm
+   hwpoison
+   hugetlbfs_reserv
+   mmu_notifier
+   numa
+   overcommit-accounting
+   page_migration
+   page_frags
+   page_owner
+   remap_file_pages
+   slub
+   split_page_table_lock
+   unevictable-lru
+   z3fold
+   zsmalloc
-- 
2.7.4
