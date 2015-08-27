Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2015 17:39:37 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:20435 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012874AbbH0Pjb0aMix (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Aug 2015 17:39:31 +0200
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t7RFdOLh019004
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2015 15:39:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t7RFdOle004401
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 27 Aug 2015 15:39:24 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t7RFdN1E008181;
        Thu, 27 Aug 2015 15:39:23 GMT
Received: from lappy.us.oracle.com (/10.154.183.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Aug 2015 08:39:22 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Felix Fietkau <nbd@openwrt.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: Fix sched_getaffinity with MT FPAFF enabled
Date:   Thu, 27 Aug 2015 11:37:20 -0400
Message-Id: <1440689954-10813-2-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1440689954-10813-1-git-send-email-sasha.levin@oracle.com>
References: <1440689954-10813-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Felix Fietkau <nbd@openwrt.org>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 1d62d737555e1378eb62a8bba26644f7d97139d2 ]

p->thread.user_cpus_allowed is zero-initialized and is only filled on
the first sched_setaffinity call.

To avoid adding overhead in the task initialization codepath, simply OR
the returned mask in sched_getaffinity with p->cpus_allowed.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10740/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/kernel/mips-mt-fpaff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 362bb37..116c67a 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -154,7 +154,7 @@ asmlinkage long mipsmt_sys_sched_getaffinity(pid_t pid, unsigned int len,
 				      unsigned long __user *user_mask_ptr)
 {
 	unsigned int real_len;
-	cpumask_t mask;
+	cpumask_t allowed, mask;
 	int retval;
 	struct task_struct *p;
 
@@ -173,7 +173,8 @@ asmlinkage long mipsmt_sys_sched_getaffinity(pid_t pid, unsigned int len,
 	if (retval)
 		goto out_unlock;
 
-	cpumask_and(&mask, &p->thread.user_cpus_allowed, cpu_possible_mask);
+	cpumask_or(&allowed, &p->thread.user_cpus_allowed, &p->cpus_allowed);
+	cpumask_and(&mask, &allowed, cpu_active_mask);
 
 out_unlock:
 	read_unlock(&tasklist_lock);
-- 
2.1.4
