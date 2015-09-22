Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:53:38 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:53205 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008780AbbIVRxhAL5mU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:53:37 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZeRl1-0000v3-I8; Tue, 22 Sep 2015 17:53:35 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1ZeRkz-0000b6-BK; Tue, 22 Sep 2015 10:53:33 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Felix Fietkau <nbd@openwrt.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 030/102] MIPS: Fix sched_getaffinity with MT FPAFF enabled
Date:   Tue, 22 Sep 2015 10:51:26 -0700
Message-Id: <1442944358-1248-31-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1442944358-1248-1-git-send-email-kamal@canonical.com>
References: <1442944358-1248-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt7 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@openwrt.org>

commit 1d62d737555e1378eb62a8bba26644f7d97139d2 upstream.

p->thread.user_cpus_allowed is zero-initialized and is only filled on
the first sched_setaffinity call.

To avoid adding overhead in the task initialization codepath, simply OR
the returned mask in sched_getaffinity with p->cpus_allowed.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10740/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
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
1.9.1
