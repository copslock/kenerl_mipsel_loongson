Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2014 16:53:19 +0100 (CET)
Received: from mail-qa0-f46.google.com ([209.85.216.46]:61887 "EHLO
        mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007757AbaLJPxReBSfF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Dec 2014 16:53:17 +0100
Received: by mail-qa0-f46.google.com with SMTP id n8so2158573qaq.33
        for <linux-mips@linux-mips.org>; Wed, 10 Dec 2014 07:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OQTC6VKXJGEZ0EfFSP38sQQEyqwyA7GCN5ApSs9SJgQ=;
        b=k2QOEPO9DBek9Qchqrf1FXjS0TakiWhdO9cko6AkQ8PueP+MPUjzpscmJ7ogG/sVUa
         Bn8NhyxrXUVJ2qvKaSF0dKPJmB7GHJCXYA6cJJ6Ndx/JfRC7VPReYe+I8UUJNSLPW0C9
         mi2R7gDuBMx/untwF8Gr8otzrxgV12F1XEmOmKKRQBmDZ5NFbavWjm3/WyejKBYYYHkB
         YqMWDsibGqlfHGNQvtCks1QncdyPpmaXQORK/MYMV3UgjvjihbgPrkRUD4d2Wt4t2CzZ
         GUyCAcTawT1RN7S8wPNwkZwVU0oQj7ZfDl8KbUGhNHmjZpHWPAq5rQ/5mIh+n+xZ9hRj
         VnBw==
X-Received: by 10.224.93.6 with SMTP id t6mr9625262qam.93.1418226791798;
        Wed, 10 Dec 2014 07:53:11 -0800 (PST)
Received: from htj.dyndns.org.com (207-38-238-8.c3-0.wsd-ubr1.qens-wsd.ny.cable.rcn.com. [207.38.238.8])
        by mx.google.com with ESMTPSA id p78sm4504191qgp.44.2014.12.10.07.53.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2014 07:53:10 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-mips@linux-mips.org
Subject: [PATCH 03/12] mips: use {cpu|node}mask pr_cont and seq output functions
Date:   Wed, 10 Dec 2014 10:52:45 -0500
Message-Id: <1418226774-30215-4-git-send-email-tj@kernel.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1418226774-30215-1-git-send-email-tj@kernel.org>
References: <1418226774-30215-1-git-send-email-tj@kernel.org>
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
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

Convert the existing user of cpu{mask|list}_scnprintf() and
node{mask|list}_scnprintf() which use them just to printk or
seq_printf() the resulting buffer to use the following functions
instead respectively.

* For printk: cpu{mask|list}_pr_cont() and node{mask|list}_pr_cont().

* For seq_file: seq_cpumask[_list]() and seq_nodemask[_list]().

Because these conversions usually break up a single output function
call into multiple, the reduction is LOC isn't too big but it removes
unnecessary complexity and/or arbitrary limit on the length printed.

This patch is dependent on the previous patch ("bitmap, cpumask,
nodemask: implement pr_cont variants of formatting functions") which
is planned to go through -mm.  It'd be the easiest to route this
together.  If this should go through the subsystem tree, please wait
till the forementioned patch is merged to mainline.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/netlogic/common/smp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 4fde7ac..e91592a 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -162,7 +162,6 @@ void __init nlm_smp_setup(void)
 	unsigned int boot_cpu;
 	int num_cpus, i, ncore, node;
 	volatile u32 *cpu_ready = nlm_get_boot_data(BOOT_CPU_READY);
-	char buf[64];
 
 	boot_cpu = hard_smp_processor_id();
 	cpumask_clear(&phys_cpu_present_mask);
@@ -189,10 +188,12 @@ void __init nlm_smp_setup(void)
 		}
 	}
 
-	cpumask_scnprintf(buf, ARRAY_SIZE(buf), &phys_cpu_present_mask);
-	pr_info("Physical CPU mask: %s\n", buf);
-	cpumask_scnprintf(buf, ARRAY_SIZE(buf), cpu_possible_mask);
-	pr_info("Possible CPU mask: %s\n", buf);
+	pr_info("Physical CPU mask: ");
+	cpumask_pr_cont(&phys_cpu_present_mask);
+	pr_cont("\n");
+	pr_info("Possible CPU mask: ");
+	cpumask_pr_cont(cpu_possible_mask);
+	pr_cont("\n");
 
 	/* check with the cores we have woken up */
 	for (ncore = 0, i = 0; i < NLM_NR_NODES; i++)
-- 
2.1.0
