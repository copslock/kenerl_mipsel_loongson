Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 06:19:23 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990946AbeHIETP1ayYf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2018 06:19:15 +0200
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w794J1Kw137175
        for <linux-mips@linux-mips.org>; Thu, 9 Aug 2018 00:19:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2krddpt1hd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 09 Aug 2018 00:19:13 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 9 Aug 2018 05:19:11 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 05:19:06 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w794J59L41222182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 04:19:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DABAA4040;
        Thu,  9 Aug 2018 07:19:12 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52749A404D;
        Thu,  9 Aug 2018 07:19:09 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.35.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 07:19:09 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     srikar@linux.vnet.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org, liu.song.a23@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v8 1/6] Uprobes: Simplify uprobe_register() body
Date:   Thu,  9 Aug 2018 09:48:51 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080904-4275-0000-0000-000002A7356E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080904-4276-0000-0000-000037B04172
Message-Id: <20180809041856.1547-2-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090045
Return-Path: <ravi.bangoria@linux.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65487
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

Simplify uprobe_register() function body and let __uprobe_register()
handle everything. Also move dependency functions around to fix build
failures.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/events/uprobes.c | 69 ++++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ccc579a7d32e..471eac896635 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -840,13 +840,8 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 	return err;
 }
 
-static int __uprobe_register(struct uprobe *uprobe, struct uprobe_consumer *uc)
-{
-	consumer_add(uprobe, uc);
-	return register_for_each_vma(uprobe, uc);
-}
-
-static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
+static void
+__uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	int err;
 
@@ -860,24 +855,46 @@ static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *u
 }
 
 /*
- * uprobe_register - register a probe
+ * uprobe_unregister - unregister a already registered probe.
+ * @inode: the file in which the probe has to be removed.
+ * @offset: offset from the start of the file.
+ * @uc: identify which probe if multiple probes are colocated.
+ */
+void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+{
+	struct uprobe *uprobe;
+
+	uprobe = find_uprobe(inode, offset);
+	if (WARN_ON(!uprobe))
+		return;
+
+	down_write(&uprobe->register_rwsem);
+	__uprobe_unregister(uprobe, uc);
+	up_write(&uprobe->register_rwsem);
+	put_uprobe(uprobe);
+}
+EXPORT_SYMBOL_GPL(uprobe_unregister);
+
+/*
+ * __uprobe_register - register a probe
  * @inode: the file in which the probe has to be placed.
  * @offset: offset from the start of the file.
  * @uc: information on howto handle the probe..
  *
- * Apart from the access refcount, uprobe_register() takes a creation
+ * Apart from the access refcount, __uprobe_register() takes a creation
  * refcount (thro alloc_uprobe) if and only if this @uprobe is getting
  * inserted into the rbtree (i.e first consumer for a @inode:@offset
  * tuple).  Creation refcount stops uprobe_unregister from freeing the
  * @uprobe even before the register operation is complete. Creation
  * refcount is released when the last @uc for the @uprobe
- * unregisters. Caller of uprobe_register() is required to keep @inode
+ * unregisters. Caller of __uprobe_register() is required to keep @inode
  * (and the containing mount) referenced.
  *
  * Return errno if it cannot successully install probes
  * else return 0 (success)
  */
-int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+static int __uprobe_register(struct inode *inode, loff_t offset,
+			     struct uprobe_consumer *uc)
 {
 	struct uprobe *uprobe;
 	int ret;
@@ -904,7 +921,8 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
 	down_write(&uprobe->register_rwsem);
 	ret = -EAGAIN;
 	if (likely(uprobe_is_active(uprobe))) {
-		ret = __uprobe_register(uprobe, uc);
+		consumer_add(uprobe, uc);
+		ret = register_for_each_vma(uprobe, uc);
 		if (ret)
 			__uprobe_unregister(uprobe, uc);
 	}
@@ -915,6 +933,12 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
 		goto retry;
 	return ret;
 }
+
+int uprobe_register(struct inode *inode, loff_t offset,
+		    struct uprobe_consumer *uc)
+{
+	return __uprobe_register(inode, offset, uc);
+}
 EXPORT_SYMBOL_GPL(uprobe_register);
 
 /*
@@ -946,27 +970,6 @@ int uprobe_apply(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-/*
- * uprobe_unregister - unregister a already registered probe.
- * @inode: the file in which the probe has to be removed.
- * @offset: offset from the start of the file.
- * @uc: identify which probe if multiple probes are colocated.
- */
-void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
-{
-	struct uprobe *uprobe;
-
-	uprobe = find_uprobe(inode, offset);
-	if (WARN_ON(!uprobe))
-		return;
-
-	down_write(&uprobe->register_rwsem);
-	__uprobe_unregister(uprobe, uc);
-	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
-}
-EXPORT_SYMBOL_GPL(uprobe_unregister);
-
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
-- 
2.14.4
