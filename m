Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:31:16 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994656AbeCUTZIPsfSN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:25:08 +0100
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJIiVH107227
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:25:06 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gut67se9v-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:25:06 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:25:03 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:24:58 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJOvnn46137362;
        Wed, 21 Mar 2018 19:24:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0208A4C04E;
        Wed, 21 Mar 2018 19:18:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A1CC4C052;
        Wed, 21 Mar 2018 19:18:01 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:18:01 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:24:53 +0200
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
Subject: [PATCH 27/32] docs/vm: userfaultfd.txt: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:43 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0044-0000-0000-0000053E7354
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0045-0000-0000-0000287D78F8
Message-Id: <1521660168-14372-28-git-send-email-rppt@linux.vnet.ibm.com>
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
X-archive-position: 63118
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
 Documentation/vm/userfaultfd.txt | 66 ++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/Documentation/vm/userfaultfd.txt b/Documentation/vm/userfaultfd.txt
index bb2f945..5048cf6 100644
--- a/Documentation/vm/userfaultfd.txt
+++ b/Documentation/vm/userfaultfd.txt
@@ -1,6 +1,11 @@
-= Userfaultfd =
+.. _userfaultfd:
 
-== Objective ==
+===========
+Userfaultfd
+===========
+
+Objective
+=========
 
 Userfaults allow the implementation of on-demand paging from userland
 and more generally they allow userland to take control of various
@@ -9,7 +14,8 @@ memory page faults, something otherwise only the kernel code could do.
 For example userfaults allows a proper and more optimal implementation
 of the PROT_NONE+SIGSEGV trick.
 
-== Design ==
+Design
+======
 
 Userfaults are delivered and resolved through the userfaultfd syscall.
 
@@ -41,7 +47,8 @@ different processes without them being aware about what is going on
 themselves on the same region the manager is already tracking, which
 is a corner case that would currently return -EBUSY).
 
-== API ==
+API
+===
 
 When first opened the userfaultfd must be enabled invoking the
 UFFDIO_API ioctl specifying a uffdio_api.api value set to UFFD_API (or
@@ -101,7 +108,8 @@ UFFDIO_COPY. They're atomic as in guaranteeing that nothing can see an
 half copied page since it'll keep userfaulting until the copy has
 finished.
 
-== QEMU/KVM ==
+QEMU/KVM
+========
 
 QEMU/KVM is using the userfaultfd syscall to implement postcopy live
 migration. Postcopy live migration is one form of memory
@@ -163,7 +171,8 @@ sending the same page twice (in case the userfault is read by the
 postcopy thread just before UFFDIO_COPY|ZEROPAGE runs in the migration
 thread).
 
-== Non-cooperative userfaultfd ==
+Non-cooperative userfaultfd
+===========================
 
 When the userfaultfd is monitored by an external manager, the manager
 must be able to track changes in the process virtual memory
@@ -172,27 +181,30 @@ the same read(2) protocol as for the page fault notifications. The
 manager has to explicitly enable these events by setting appropriate
 bits in uffdio_api.features passed to UFFDIO_API ioctl:
 
-UFFD_FEATURE_EVENT_FORK - enable userfaultfd hooks for fork(). When
-this feature is enabled, the userfaultfd context of the parent process
-is duplicated into the newly created process. The manager receives
-UFFD_EVENT_FORK with file descriptor of the new userfaultfd context in
-the uffd_msg.fork.
-
-UFFD_FEATURE_EVENT_REMAP - enable notifications about mremap()
-calls. When the non-cooperative process moves a virtual memory area to
-a different location, the manager will receive UFFD_EVENT_REMAP. The
-uffd_msg.remap will contain the old and new addresses of the area and
-its original length.
-
-UFFD_FEATURE_EVENT_REMOVE - enable notifications about
-madvise(MADV_REMOVE) and madvise(MADV_DONTNEED) calls. The event
-UFFD_EVENT_REMOVE will be generated upon these calls to madvise. The
-uffd_msg.remove will contain start and end addresses of the removed
-area.
-
-UFFD_FEATURE_EVENT_UNMAP - enable notifications about memory
-unmapping. The manager will get UFFD_EVENT_UNMAP with uffd_msg.remove
-containing start and end addresses of the unmapped area.
+UFFD_FEATURE_EVENT_FORK
+	enable userfaultfd hooks for fork(). When this feature is
+	enabled, the userfaultfd context of the parent process is
+	duplicated into the newly created process. The manager
+	receives UFFD_EVENT_FORK with file descriptor of the new
+	userfaultfd context in the uffd_msg.fork.
+
+UFFD_FEATURE_EVENT_REMAP
+	enable notifications about mremap() calls. When the
+	non-cooperative process moves a virtual memory area to a
+	different location, the manager will receive
+	UFFD_EVENT_REMAP. The uffd_msg.remap will contain the old and
+	new addresses of the area and its original length.
+
+UFFD_FEATURE_EVENT_REMOVE
+	enable notifications about madvise(MADV_REMOVE) and
+	madvise(MADV_DONTNEED) calls. The event UFFD_EVENT_REMOVE will
+	be generated upon these calls to madvise. The uffd_msg.remove
+	will contain start and end addresses of the removed area.
+
+UFFD_FEATURE_EVENT_UNMAP
+	enable notifications about memory unmapping. The manager will
+	get UFFD_EVENT_UNMAP with uffd_msg.remove containing start and
+	end addresses of the unmapped area.
 
 Although the UFFD_FEATURE_EVENT_REMOVE and UFFD_FEATURE_EVENT_UNMAP
 are pretty similar, they quite differ in the action expected from the
-- 
2.7.4
