Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2018 10:48:40 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992940AbeGPIrioRj1B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jul 2018 10:47:38 +0200
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G8hZlT049996
        for <linux-mips@linux-mips.org>; Mon, 16 Jul 2018 04:47:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k8js9bgnq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Mon, 16 Jul 2018 04:47:36 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 16 Jul 2018 09:47:34 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 09:47:30 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G8lT0n42205324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 08:47:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75ACF4C04E;
        Mon, 16 Jul 2018 11:47:48 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53AAB4C064;
        Mon, 16 Jul 2018 11:47:45 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.31.217])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 11:47:45 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     srikar@linux.vnet.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v6 4/6] trace_uprobe/sdt: Prevent multiple reference counter for same uprobe
Date:   Mon, 16 Jul 2018 14:17:04 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071608-0016-0000-0000-000001E73B61
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071608-0017-0000-0000-0000323BE36C
Message-Id: <20180716084706.28244-5-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160105
Return-Path: <ravi.bangoria@linux.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64856
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

We assume to have only one reference counter for one uprobe.
Don't allow user to add multiple trace_uprobe entries having
same inode+offset but different reference counter.

Ex,
  # echo "p:sdt_tick/loop2 /home/ravi/tick:0x6e4(0x10036)" > uprobe_events
  # echo "p:sdt_tick/loop2_1 /home/ravi/tick:0x6e4(0xfffff)" >> uprobe_events
  bash: echo: write error: Invalid argument

  # dmesg
  trace_kprobe: Reference counter offset mismatch.

There are two exceptions though:
1) When user is trying to replace the old entry with the new
   one, we allow this if the new entry does not conflict with
   any other existing entry.
2) Any one of the reference counter offset is 0 while comparing
   new entry with old one.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/trace/trace_uprobe.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index bf2be098eb08..9fafb183c49d 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -324,6 +324,38 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 	return 0;
 }
 
+/*
+ * Uprobe with multiple reference counter is not allowed. i.e.
+ * If inode and offset matches, reference counter offset *must*
+ * match as well. Though, there are two exceptions:
+ * 1) We are replacing old trace_uprobe with new one(same
+ *    group/event) then we don't care as far as the new entry
+ *    does not conflict with any other existing entry.
+ * 2) Any one of the reference counter offset is 0 while comparing
+ *    new entry with old one.
+ */
+static struct trace_uprobe *find_old_trace_uprobe(struct trace_uprobe *new)
+{
+	struct trace_uprobe *tmp, *old = NULL;
+	struct inode *new_inode = d_real_inode(new->path.dentry);
+
+	old = find_probe_event(trace_event_name(&new->tp.call),
+				new->tp.call.class->system);
+
+	list_for_each_entry(tmp, &uprobe_list, list) {
+		if ((old ? old != tmp : true) &&
+		    new_inode == d_real_inode(tmp->path.dentry) &&
+		    new->offset == tmp->offset &&
+		    new->ref_ctr_offset != tmp->ref_ctr_offset &&
+		    new->ref_ctr_offset != 0 &&
+		    tmp->ref_ctr_offset != 0) {
+			pr_warn("Reference counter offset mismatch.");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+	return old;
+}
+
 /* Register a trace_uprobe and probe_event */
 static int register_trace_uprobe(struct trace_uprobe *tu)
 {
@@ -333,8 +365,12 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	mutex_lock(&uprobe_lock);
 
 	/* register as an event */
-	old_tu = find_probe_event(trace_event_name(&tu->tp.call),
-			tu->tp.call.class->system);
+	old_tu = find_old_trace_uprobe(tu);
+	if (IS_ERR(old_tu)) {
+		ret = PTR_ERR(old_tu);
+		goto end;
+	}
+
 	if (old_tu) {
 		/* delete old event */
 		ret = unregister_trace_uprobe(old_tu);
-- 
2.14.4
