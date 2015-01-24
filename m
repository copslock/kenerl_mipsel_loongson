Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2015 15:04:02 +0100 (CET)
Received: from mail-qa0-f46.google.com ([209.85.216.46]:64611 "EHLO
        mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010787AbbAXOEBZWqyg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jan 2015 15:04:01 +0100
Received: by mail-qa0-f46.google.com with SMTP id j7so1646560qaq.5
        for <linux-mips@linux-mips.org>; Sat, 24 Jan 2015 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Asu7Nv6106+4LwJWeJxk2GTmKFUY3LoEBhMyZ+u5CtQ=;
        b=Ux5FsjegRRjpxPqqC2so8fodZloXBU24rPFMpk4ZkVgprw8B9AiaVeb9lCyQZopzR7
         SZrMjag3SC/bjEdOsxRng6ZTqGOz8YkOZS4S7XRqXICTTa/ubs6ZtWQ+CReXC4pLkr6z
         eczEziTkUrvzlyFjywoN6Rx/57fIIhxT81xGSWztrFtJpv1kp+TGQJN9xEZDP9Zqzmsf
         2yRIBVHPltERo/nBRkNDYncbx2I5NthV8MRtR255bU5gKCVBSVvkqOeIE9LX3wONL4gn
         RAHA+9oNWHph2t1AYmPyJPv20laHRoxz/v7DD4VtmX/X6dreNCcnjitGokS8AwP3+In5
         ZYkA==
X-Received: by 10.224.12.19 with SMTP id v19mr24019266qav.22.1422108235420;
        Sat, 24 Jan 2015 06:03:55 -0800 (PST)
Received: from htj.lan (207-38-238-8.c3-0.wsd-ubr1.qens-wsd.ny.cable.rcn.com. [207.38.238.8])
        by mx.google.com with ESMTPSA id p10sm2629504qab.18.2015.01.24.06.03.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jan 2015 06:03:54 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-mips@linux-mips.org
Subject: [PATCH 05/32] mips: use %*pb[l] to print bitmaps including cpumasks and nodemasks
Date:   Sat, 24 Jan 2015 09:03:11 -0500
Message-Id: <1422108218-25398-6-git-send-email-tj@kernel.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1422108218-25398-1-git-send-email-tj@kernel.org>
References: <1422108218-25398-1-git-send-email-tj@kernel.org>
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45455
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

printk and friends can now formap bitmaps using '%*pb[l]'.  cpumask
and nodemask also provide cpumask_pr_args() and nodemask_pr_args()
respectively which can be used to generate the two printf arguments
necessary to format the specified cpu/nodemask.

This patch is dependent on the following two patches.

 lib/vsprintf: implement bitmap printing through '%*pb[l]'
 cpumask, nodemask: implement cpumask/nodemask_pr_args()

Please wait till the forementioned patches are merged to mainline
before applying to subsystem trees.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/netlogic/common/smp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 4fde7ac..e743bdd 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -162,7 +162,6 @@ void __init nlm_smp_setup(void)
 	unsigned int boot_cpu;
 	int num_cpus, i, ncore, node;
 	volatile u32 *cpu_ready = nlm_get_boot_data(BOOT_CPU_READY);
-	char buf[64];
 
 	boot_cpu = hard_smp_processor_id();
 	cpumask_clear(&phys_cpu_present_mask);
@@ -189,10 +188,10 @@ void __init nlm_smp_setup(void)
 		}
 	}
 
-	cpumask_scnprintf(buf, ARRAY_SIZE(buf), &phys_cpu_present_mask);
-	pr_info("Physical CPU mask: %s\n", buf);
-	cpumask_scnprintf(buf, ARRAY_SIZE(buf), cpu_possible_mask);
-	pr_info("Possible CPU mask: %s\n", buf);
+	pr_info("Physical CPU mask: %*pb\n",
+		cpumask_pr_args(&phys_cpu_present_mask));
+	pr_info("Possible CPU mask: %*pb\n",
+		cpumask_pr_args(cpu_possible_mask));
 
 	/* check with the cores we have woken up */
 	for (ncore = 0, i = 0; i < NLM_NR_NODES; i++)
@@ -209,7 +208,6 @@ static int nlm_parse_cpumask(cpumask_t *wakeup_mask)
 {
 	uint32_t core0_thr_mask, core_thr_mask;
 	int threadmode, i, j;
-	char buf[64];
 
 	core0_thr_mask = 0;
 	for (i = 0; i < NLM_THREADS_PER_CORE; i++)
@@ -244,8 +242,7 @@ static int nlm_parse_cpumask(cpumask_t *wakeup_mask)
 	return threadmode;
 
 unsupp:
-	cpumask_scnprintf(buf, ARRAY_SIZE(buf), wakeup_mask);
-	panic("Unsupported CPU mask %s", buf);
+	panic("Unsupported CPU mask %*pb", cpumask_pr_args(wakeup_mask));
 	return 0;
 }
 
-- 
2.1.0
