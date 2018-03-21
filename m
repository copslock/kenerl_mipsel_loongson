Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:26:49 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994684AbeCUTYAP-zYU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:24:00 +0100
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJIZcU047132
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:59 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2guuubvdej-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:23:59 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:23:56 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:23:51 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJNprt54001890;
        Wed, 21 Mar 2018 19:23:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53FB542042;
        Wed, 21 Mar 2018 19:15:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 947974203F;
        Wed, 21 Mar 2018 19:15:54 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:15:54 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:23:46 +0200
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
Subject: [PATCH 12/32] docs/vm: mmu_notifier.txt: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:28 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0020-0000-0000-00000407E60B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0021-0000-0000-0000429C06B8
Message-Id: <1521660168-14372-13-git-send-email-rppt@linux.vnet.ibm.com>
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
X-archive-position: 63103
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
 Documentation/vm/mmu_notifier.txt | 108 ++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 51 deletions(-)

diff --git a/Documentation/vm/mmu_notifier.txt b/Documentation/vm/mmu_notifier.txt
index 23b4625..47baa1c 100644
--- a/Documentation/vm/mmu_notifier.txt
+++ b/Documentation/vm/mmu_notifier.txt
@@ -1,7 +1,10 @@
+.. _mmu_notifier:
+
 When do you need to notify inside page table lock ?
+===================================================
 
 When clearing a pte/pmd we are given a choice to notify the event through
-(notify version of *_clear_flush call mmu_notifier_invalidate_range) under
+(notify version of \*_clear_flush call mmu_notifier_invalidate_range) under
 the page table lock. But that notification is not necessary in all cases.
 
 For secondary TLB (non CPU TLB) like IOMMU TLB or device TLB (when device use
@@ -18,6 +21,7 @@ a page that might now be used by some completely different task.
 
 Case B is more subtle. For correctness it requires the following sequence to
 happen:
+
   - take page table lock
   - clear page table entry and notify ([pmd/pte]p_huge_clear_flush_notify())
   - set page table entry to point to new page
@@ -28,58 +32,60 @@ the device.
 
 Consider the following scenario (device use a feature similar to ATS/PASID):
 
-Two address addrA and addrB such that |addrA - addrB| >= PAGE_SIZE we assume
+Two address addrA and addrB such that \|addrA - addrB\| >= PAGE_SIZE we assume
 they are write protected for COW (other case of B apply too).
 
-[Time N] --------------------------------------------------------------------
-CPU-thread-0  {try to write to addrA}
-CPU-thread-1  {try to write to addrB}
-CPU-thread-2  {}
-CPU-thread-3  {}
-DEV-thread-0  {read addrA and populate device TLB}
-DEV-thread-2  {read addrB and populate device TLB}
-[Time N+1] ------------------------------------------------------------------
-CPU-thread-0  {COW_step0: {mmu_notifier_invalidate_range_start(addrA)}}
-CPU-thread-1  {COW_step0: {mmu_notifier_invalidate_range_start(addrB)}}
-CPU-thread-2  {}
-CPU-thread-3  {}
-DEV-thread-0  {}
-DEV-thread-2  {}
-[Time N+2] ------------------------------------------------------------------
-CPU-thread-0  {COW_step1: {update page table to point to new page for addrA}}
-CPU-thread-1  {COW_step1: {update page table to point to new page for addrB}}
-CPU-thread-2  {}
-CPU-thread-3  {}
-DEV-thread-0  {}
-DEV-thread-2  {}
-[Time N+3] ------------------------------------------------------------------
-CPU-thread-0  {preempted}
-CPU-thread-1  {preempted}
-CPU-thread-2  {write to addrA which is a write to new page}
-CPU-thread-3  {}
-DEV-thread-0  {}
-DEV-thread-2  {}
-[Time N+3] ------------------------------------------------------------------
-CPU-thread-0  {preempted}
-CPU-thread-1  {preempted}
-CPU-thread-2  {}
-CPU-thread-3  {write to addrB which is a write to new page}
-DEV-thread-0  {}
-DEV-thread-2  {}
-[Time N+4] ------------------------------------------------------------------
-CPU-thread-0  {preempted}
-CPU-thread-1  {COW_step3: {mmu_notifier_invalidate_range_end(addrB)}}
-CPU-thread-2  {}
-CPU-thread-3  {}
-DEV-thread-0  {}
-DEV-thread-2  {}
-[Time N+5] ------------------------------------------------------------------
-CPU-thread-0  {preempted}
-CPU-thread-1  {}
-CPU-thread-2  {}
-CPU-thread-3  {}
-DEV-thread-0  {read addrA from old page}
-DEV-thread-2  {read addrB from new page}
+::
+
+ [Time N] --------------------------------------------------------------------
+ CPU-thread-0  {try to write to addrA}
+ CPU-thread-1  {try to write to addrB}
+ CPU-thread-2  {}
+ CPU-thread-3  {}
+ DEV-thread-0  {read addrA and populate device TLB}
+ DEV-thread-2  {read addrB and populate device TLB}
+ [Time N+1] ------------------------------------------------------------------
+ CPU-thread-0  {COW_step0: {mmu_notifier_invalidate_range_start(addrA)}}
+ CPU-thread-1  {COW_step0: {mmu_notifier_invalidate_range_start(addrB)}}
+ CPU-thread-2  {}
+ CPU-thread-3  {}
+ DEV-thread-0  {}
+ DEV-thread-2  {}
+ [Time N+2] ------------------------------------------------------------------
+ CPU-thread-0  {COW_step1: {update page table to point to new page for addrA}}
+ CPU-thread-1  {COW_step1: {update page table to point to new page for addrB}}
+ CPU-thread-2  {}
+ CPU-thread-3  {}
+ DEV-thread-0  {}
+ DEV-thread-2  {}
+ [Time N+3] ------------------------------------------------------------------
+ CPU-thread-0  {preempted}
+ CPU-thread-1  {preempted}
+ CPU-thread-2  {write to addrA which is a write to new page}
+ CPU-thread-3  {}
+ DEV-thread-0  {}
+ DEV-thread-2  {}
+ [Time N+3] ------------------------------------------------------------------
+ CPU-thread-0  {preempted}
+ CPU-thread-1  {preempted}
+ CPU-thread-2  {}
+ CPU-thread-3  {write to addrB which is a write to new page}
+ DEV-thread-0  {}
+ DEV-thread-2  {}
+ [Time N+4] ------------------------------------------------------------------
+ CPU-thread-0  {preempted}
+ CPU-thread-1  {COW_step3: {mmu_notifier_invalidate_range_end(addrB)}}
+ CPU-thread-2  {}
+ CPU-thread-3  {}
+ DEV-thread-0  {}
+ DEV-thread-2  {}
+ [Time N+5] ------------------------------------------------------------------
+ CPU-thread-0  {preempted}
+ CPU-thread-1  {}
+ CPU-thread-2  {}
+ CPU-thread-3  {}
+ DEV-thread-0  {read addrA from old page}
+ DEV-thread-2  {read addrB from new page}
 
 So here because at time N+2 the clear page table entry was not pair with a
 notification to invalidate the secondary TLB, the device see the new value for
-- 
2.7.4
