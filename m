Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:29:49 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994619AbeCUTYoOVETa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:24:44 +0100
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2LJIY1Q047081
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:24:43 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2guuubve95-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 15:24:42 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 21 Mar 2018 19:24:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 21 Mar 2018 19:24:34 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w2LJOYjb63176800;
        Wed, 21 Mar 2018 19:24:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6D83A4040;
        Wed, 21 Mar 2018 19:17:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1A20A404D;
        Wed, 21 Mar 2018 19:17:13 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.27])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Mar 2018 19:17:13 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 21 Mar 2018 21:24:30 +0200
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
Subject: [PATCH 22/32] docs/vm: soft-dirty.txt: convert to ReST format
Date:   Wed, 21 Mar 2018 21:22:38 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0044-0000-0000-0000053E734A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0045-0000-0000-0000287D78ED
Message-Id: <1521660168-14372-23-git-send-email-rppt@linux.vnet.ibm.com>
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
X-archive-position: 63113
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
 Documentation/vm/soft-dirty.txt | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/vm/soft-dirty.txt b/Documentation/vm/soft-dirty.txt
index 55684d1..cb0cfd6 100644
--- a/Documentation/vm/soft-dirty.txt
+++ b/Documentation/vm/soft-dirty.txt
@@ -1,34 +1,38 @@
-                            SOFT-DIRTY PTEs
+.. _soft_dirty:
 
-  The soft-dirty is a bit on a PTE which helps to track which pages a task
+===============
+Soft-Dirty PTEs
+===============
+
+The soft-dirty is a bit on a PTE which helps to track which pages a task
 writes to. In order to do this tracking one should
 
   1. Clear soft-dirty bits from the task's PTEs.
 
-     This is done by writing "4" into the /proc/PID/clear_refs file of the
+     This is done by writing "4" into the ``/proc/PID/clear_refs`` file of the
      task in question.
 
   2. Wait some time.
 
   3. Read soft-dirty bits from the PTEs.
 
-     This is done by reading from the /proc/PID/pagemap. The bit 55 of the
+     This is done by reading from the ``/proc/PID/pagemap``. The bit 55 of the
      64-bit qword is the soft-dirty one. If set, the respective PTE was
      written to since step 1.
 
 
-  Internally, to do this tracking, the writable bit is cleared from PTEs
+Internally, to do this tracking, the writable bit is cleared from PTEs
 when the soft-dirty bit is cleared. So, after this, when the task tries to
 modify a page at some virtual address the #PF occurs and the kernel sets
 the soft-dirty bit on the respective PTE.
 
-  Note, that although all the task's address space is marked as r/o after the
+Note, that although all the task's address space is marked as r/o after the
 soft-dirty bits clear, the #PF-s that occur after that are processed fast.
 This is so, since the pages are still mapped to physical memory, and thus all
 the kernel does is finds this fact out and puts both writable and soft-dirty
 bits on the PTE.
 
-  While in most cases tracking memory changes by #PF-s is more than enough
+While in most cases tracking memory changes by #PF-s is more than enough
 there is still a scenario when we can lose soft dirty bits -- a task
 unmaps a previously mapped memory region and then maps a new one at exactly
 the same place. When unmap is called, the kernel internally clears PTE values
@@ -36,7 +40,7 @@ including soft dirty bits. To notify user space application about such
 memory region renewal the kernel always marks new memory regions (and
 expanded regions) as soft dirty.
 
-  This feature is actively used by the checkpoint-restore project. You
+This feature is actively used by the checkpoint-restore project. You
 can find more details about it on http://criu.org
 
 
-- 
2.7.4
