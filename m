Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 07:24:10 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993097AbeF1FWs1xWoo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jun 2018 07:22:48 +0200
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5S5J9HN098007
        for <linux-mips@linux-mips.org>; Thu, 28 Jun 2018 01:22:45 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jvpn8dwag-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 28 Jun 2018 01:22:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 28 Jun 2018 06:22:43 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 06:22:38 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5S5Mb2P23527652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 05:22:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC51A42045;
        Thu, 28 Jun 2018 06:22:27 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ACB642042;
        Thu, 28 Jun 2018 06:22:24 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.31.233])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jun 2018 06:22:24 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     srikar@linux.vnet.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v5 05/10] Uprobe: Change uprobe_write_opcode definition
Date:   Thu, 28 Jun 2018 10:52:04 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062805-0016-0000-0000-000001E0F21D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062805-0017-0000-0000-0000323534D7
Message-Id: <20180628052209.13056-6-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=949 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280059
Return-Path: <ravi.bangoria@linux.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ravi.bangoria@linux.ibm.com
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

Add addition argument 'uprobe' to uprobe_write_opcode(). We need
this in later set of patches.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/arm/probes/uprobes/core.c | 2 +-
 arch/mips/kernel/uprobes.c     | 2 +-
 include/linux/uprobes.h        | 2 +-
 kernel/events/uprobes.c        | 9 +++++----
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index c678a5c4a284..a4856a904a0a 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -32,7 +32,7 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
 int set_swbp(struct uprobe *uprobe, struct mm_struct *mm,
 	     unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr,
+	return uprobe_write_opcode(uprobe, mm, vaddr,
 		   __opcode_to_mem_arm(uprobe->arch.bpinsn));
 }
 
diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index 2aaa378a46e6..8bdf4b54c4a7 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -224,7 +224,7 @@ unsigned long arch_uretprobe_hijack_return_addr(
 int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm,
 	unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(uprobe, mm, vaddr, UPROBE_SWBP_INSN);
 }
 
 void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 85db5918f675..88942b1f0a3e 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -146,7 +146,7 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t opcode);
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 04fe80057331..3e0426c76376 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -268,6 +268,7 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
  * that have fixed length instructions.
  *
  * uprobe_write_opcode - write the opcode at a given virtual address.
+ * @uprobe: uprobe object.
  * @mm: the probed process address space.
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
@@ -275,8 +276,8 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
  * Called with mm->mmap_sem held for write.
  * Return 0 (success) or a negative errno.
  */
-int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
-			uprobe_opcode_t opcode)
+int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
+			unsigned long vaddr, uprobe_opcode_t opcode)
 {
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
@@ -327,7 +328,7 @@ int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
  */
 int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(uprobe, mm, vaddr, UPROBE_SWBP_INSN);
 }
 
 /**
@@ -342,7 +343,7 @@ int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long v
 int __weak
 set_orig_insn(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr,
+	return uprobe_write_opcode(uprobe, mm, vaddr,
 			*(uprobe_opcode_t *)&(uprobe->arch.insn));
 }
 
-- 
2.14.4
