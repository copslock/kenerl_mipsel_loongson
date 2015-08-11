Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2015 10:29:01 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:58795 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010945AbbHKI3AIuqnC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Aug 2015 10:29:00 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB2C2AD69;
        Tue, 11 Aug 2015 08:28:59 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Felix Fietkau <nbd@openwrt.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>, Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] MIPS: Fix sched_getaffinity with MT FPAFF enabled
Date:   Tue, 11 Aug 2015 10:28:45 +0200
Message-Id: <1439281735-15942-4-git-send-email-jslaby@suse.cz>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439281735-15942-1-git-send-email-jslaby@suse.cz>
References: <1439281735-15942-1-git-send-email-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit 1d62d737555e1378eb62a8bba26644f7d97139d2 upstream.

p->thread.user_cpus_allowed is zero-initialized and is only filled on
the first sched_setaffinity call.

To avoid adding overhead in the task initialization codepath, simply OR
the returned mask in sched_getaffinity with p->cpus_allowed.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10740/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/mips-mt-fpaff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index cb098628aee8..ca16964a2b5e 100644
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
2.5.0
