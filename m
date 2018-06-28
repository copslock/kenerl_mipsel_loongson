Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 07:22:48 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992554AbeF1FW3ZJoXo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jun 2018 07:22:29 +0200
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5S5J8Hh105225
        for <linux-mips@linux-mips.org>; Thu, 28 Jun 2018 01:22:27 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jvrp0j1a3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 28 Jun 2018 01:22:27 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 28 Jun 2018 06:22:25 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 06:22:20 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5S5MINj23593108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 05:22:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9286E42049;
        Thu, 28 Jun 2018 06:22:09 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E45142045;
        Thu, 28 Jun 2018 06:22:06 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.31.233])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jun 2018 06:22:06 +0100 (BST)
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
Subject: [PATCH v5 01/10] Uprobes: Move uprobe structure to uprobe.h
Date:   Thu, 28 Jun 2018 10:52:00 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062805-0020-0000-0000-0000029FC797
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062805-0021-0000-0000-000020EC49BA
Message-Id: <20180628052209.13056-2-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=901 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280059
Return-Path: <ravi.bangoria@linux.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64476
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

We need struct uprobe in some arch specific files. Move it to
uprobe.h from uprobe.c

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 include/linux/uprobes.h | 25 +++++++++++++++++++++++++
 kernel/events/uprobes.c | 24 ------------------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e950df8..044359083a57 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -28,6 +28,7 @@
 #include <linux/rbtree.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/rwsem.h>
 
 struct vm_area_struct;
 struct mm_struct;
@@ -61,6 +62,30 @@ struct uprobe_consumer {
 #ifdef CONFIG_UPROBES
 #include <asm/uprobes.h>
 
+struct uprobe {
+	struct rb_node		rb_node;	/* node in the rb tree */
+	atomic_t		ref;
+	struct rw_semaphore	register_rwsem;
+	struct rw_semaphore	consumer_rwsem;
+	struct list_head	pending_list;
+	struct uprobe_consumer	*consumers;
+	struct inode		*inode;		/* Also hold a ref to inode */
+	loff_t			offset;
+	unsigned long		flags;
+
+	/*
+	 * The generic code assumes that it has two members of unknown type
+	 * owned by the arch-specific code:
+	 *
+	 *	insn -	copy_insn() saves the original instruction here for
+	 *		arch_uprobe_analyze_insn().
+	 *
+	 *	ixol -	potentially modified instruction to execute out of
+	 *		line, copied to xol_area by xol_get_insn_slot().
+	 */
+	struct arch_uprobe	arch;
+};
+
 enum uprobe_task_state {
 	UTASK_RUNNING,
 	UTASK_SSTEP,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ccc579a7d32e..e6e812304b22 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -64,30 +64,6 @@ static struct percpu_rw_semaphore dup_mmap_sem;
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
 
-struct uprobe {
-	struct rb_node		rb_node;	/* node in the rb tree */
-	atomic_t		ref;
-	struct rw_semaphore	register_rwsem;
-	struct rw_semaphore	consumer_rwsem;
-	struct list_head	pending_list;
-	struct uprobe_consumer	*consumers;
-	struct inode		*inode;		/* Also hold a ref to inode */
-	loff_t			offset;
-	unsigned long		flags;
-
-	/*
-	 * The generic code assumes that it has two members of unknown type
-	 * owned by the arch-specific code:
-	 *
-	 * 	insn -	copy_insn() saves the original instruction here for
-	 *		arch_uprobe_analyze_insn().
-	 *
-	 *	ixol -	potentially modified instruction to execute out of
-	 *		line, copied to xol_area by xol_get_insn_slot().
-	 */
-	struct arch_uprobe	arch;
-};
-
 /*
  * Execute out of line area: anonymous executable mapping installed
  * by the probed task to execute the copy of the original instruction
-- 
2.14.4
