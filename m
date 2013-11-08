Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2013 10:44:53 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:31257 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823013Ab3KHJortLjrF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Nov 2013 10:44:47 +0100
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
        by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id rA89icGe002063
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 8 Nov 2013 09:44:40 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
        by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id rA89ibUp019918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 8 Nov 2013 09:44:37 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id rA89ibKJ017866;
        Fri, 8 Nov 2013 09:44:37 GMT
Received: from elgon.mountain (/41.202.233.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2013 01:44:36 -0800
Date:   Fri, 8 Nov 2013 12:44:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, kernel-janitors@vger.kernel.org
Subject: [patch] [MIPS] Lasat: a couple off by one bugs in picvue_proc.c
Message-ID: <20131108094431.GC27977@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: acsinet22.oracle.com [141.146.126.238]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
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

These should be ">=" instead of ">" or we go past the end of the
pvc_lines[] array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/mips/lasat/picvue_proc.c b/arch/mips/lasat/picvue_proc.c
index 638c5db..8c55de4 100644
--- a/arch/mips/lasat/picvue_proc.c
+++ b/arch/mips/lasat/picvue_proc.c
@@ -44,7 +44,7 @@ static int pvc_line_proc_show(struct seq_file *m, void *v)
 {
 	int lineno = *(int *)m->private;
 
-	if (lineno < 0 || lineno > PVC_NLINES) {
+	if (lineno < 0 || lineno >= PVC_NLINES) {
 		printk(KERN_WARNING "proc_read_line: invalid lineno %d\n", lineno);
 		return 0;
 	}
@@ -68,7 +68,7 @@ static ssize_t pvc_line_proc_write(struct file *file, const char __user *buf,
 	char kbuf[PVC_LINELEN];
 	size_t len;
 
-	BUG_ON(lineno < 0 || lineno > PVC_NLINES);
+	BUG_ON(lineno < 0 || lineno >= PVC_NLINES);
 
 	len = min(count, sizeof(kbuf) - 1);
 	if (copy_from_user(kbuf, buf, len))
