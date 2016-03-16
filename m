Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2016 09:10:40 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:56300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011655AbcCPIKjC-XaI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Mar 2016 09:10:39 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 6441E20219;
        Wed, 16 Mar 2016 08:10:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [221.12.19.247])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562732039D;
        Wed, 16 Mar 2016 08:10:31 +0000 (UTC)
From:   lizf@kernel.org
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Felix Fietkau <nbd@openwrt.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH 3.4 058/107] MIPS: Fix sched_getaffinity with MT FPAFF enabled
Date:   Wed, 16 Mar 2016 16:05:52 +0800
Message-Id: <1458115601-5762-58-git-send-email-lizf@kernel.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458115541-5712-1-git-send-email-lizf@kernel.org>
References: <1458115541-5712-1-git-send-email-lizf@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <lizf@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lizf@kernel.org
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

3.4.111-rc1 review patch.  If anyone has any objections, please let me know.

------------------


commit 1d62d737555e1378eb62a8bba26644f7d97139d2 upstream.

p->thread.user_cpus_allowed is zero-initialized and is only filled on
the first sched_setaffinity call.

To avoid adding overhead in the task initialization codepath, simply OR
the returned mask in sched_getaffinity with p->cpus_allowed.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10740/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 arch/mips/kernel/mips-mt-fpaff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 33f63ba..c7e2684 100644
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
1.9.1
