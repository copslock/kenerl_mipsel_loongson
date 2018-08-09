Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 06:24:41 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993070AbeHIEYc3jLdH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2018 06:24:32 +0200
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w794J1fd119876
        for <linux-mips@linux-mips.org>; Thu, 9 Aug 2018 00:24:31 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kref3g5k8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 09 Aug 2018 00:24:31 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 9 Aug 2018 05:19:29 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 05:19:24 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w794JNcE7864530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 04:19:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABB81A4040;
        Thu,  9 Aug 2018 07:19:30 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74CEEA4055;
        Thu,  9 Aug 2018 07:19:27 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.35.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 07:19:27 +0100 (BST)
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
Subject: [PATCH v8 5/6] trace_uprobe/sdt: Prevent multiple reference counter for same uprobe
Date:   Thu,  9 Aug 2018 09:48:55 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080904-0008-0000-0000-0000025F3397
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080904-0009-0000-0000-000021C74132
Message-Id: <20180809041856.1547-6-ravi.bangoria@linux.ibm.com>
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
X-archive-position: 65492
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

There is one exception though:
When user is trying to replace the old entry with the new
one, we allow this if the new entry does not conflict with
any other existing entries.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/trace/trace_uprobe.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index bf2be098eb08..be64d943d7ea 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -324,6 +324,35 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 	return 0;
 }
 
+/*
+ * Uprobe with multiple reference counter is not allowed. i.e.
+ * If inode and offset matches, reference counter offset *must*
+ * match as well. Though, there is one exception: If user is
+ * replacing old trace_uprobe with new one(same group/event),
+ * then we allow same uprobe with new reference counter as far
+ * as the new one does not conflict with any other existing
+ * ones.
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
+		    new->ref_ctr_offset != tmp->ref_ctr_offset) {
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
@@ -333,8 +362,12 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
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
