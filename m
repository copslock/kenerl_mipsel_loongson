Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 07:23:52 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992535AbeF1FWmn7Umo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jun 2018 07:22:42 +0200
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5S5JHdr056267
        for <linux-mips@linux-mips.org>; Thu, 28 Jun 2018 01:22:41 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jvs7u8jm1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 28 Jun 2018 01:22:40 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 28 Jun 2018 06:22:39 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 06:22:33 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5S5MW0u33751174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 05:22:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F12642047;
        Thu, 28 Jun 2018 06:22:23 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA4AA42042;
        Thu, 28 Jun 2018 06:22:19 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.31.233])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jun 2018 06:22:19 +0100 (BST)
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
Subject: [PATCH v5 04/10] Uprobe: Change set_orig_insn definition
Date:   Thu, 28 Jun 2018 10:52:03 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062805-0020-0000-0000-0000029FC7A7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062805-0021-0000-0000-000020EC49C6
Message-Id: <20180628052209.13056-5-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=723 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280059
Return-Path: <ravi.bangoria@linux.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64479
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

Instead of arch_uprobe, pass uprobe object to set_orig_insn(). We
need this in later set of patches.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 include/linux/uprobes.h | 2 +-
 kernel/events/uprobes.c | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 7a77bd57c9e7..85db5918f675 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -141,7 +141,7 @@ struct uprobes_state {
 };
 
 extern int set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr);
-extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
+extern int set_orig_insn(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8de52bcd1a18..04fe80057331 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -333,16 +333,17 @@ int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long v
 /**
  * set_orig_insn - Restore the original instruction.
  * @mm: the probed process address space.
- * @auprobe: arch specific probepoint information.
+ * @uprobe: uprobe object.
  * @vaddr: the virtual address to insert the opcode.
  *
  * For mm @mm, restore the original opcode (opcode) at @vaddr.
  * Return 0 (success) or a negative errno.
  */
 int __weak
-set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+set_orig_insn(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr, *(uprobe_opcode_t *)&auprobe->insn);
+	return uprobe_write_opcode(mm, vaddr,
+			*(uprobe_opcode_t *)&(uprobe->arch.insn));
 }
 
 static struct uprobe *get_uprobe(struct uprobe *uprobe)
@@ -655,7 +656,7 @@ static int
 remove_breakpoint(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	set_bit(MMF_RECALC_UPROBES, &mm->flags);
-	return set_orig_insn(&uprobe->arch, mm, vaddr);
+	return set_orig_insn(uprobe, mm, vaddr);
 }
 
 static inline bool uprobe_is_active(struct uprobe *uprobe)
-- 
2.14.4
