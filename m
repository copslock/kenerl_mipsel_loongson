Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Oct 2015 02:17:32 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59926 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007411AbbJIARan9QSS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Oct 2015 02:17:30 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.247] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZkLNF-0004lB-PU; Fri, 09 Oct 2015 01:17:25 +0100
Received: from ben by deadeye with local (Exim 4.86)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZkLNA-00078C-IJ; Fri, 09 Oct 2015 01:17:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Felix Fietkau" <nbd@openwrt.org>, linux-mips@linux-mips.org
Date:   Fri, 09 Oct 2015 01:12:27 +0100
Message-ID: <lsq.1444349547.644827378@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 010/107] MIPS: Fix sched_getaffinity with MT FPAFF enabled
In-Reply-To: <lsq.1444349547.316291576@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.247
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.72-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: also convert from obsolete cpumask API]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/mips-mt-fpaff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -154,7 +154,7 @@ asmlinkage long mipsmt_sys_sched_getaffi
 				      unsigned long __user *user_mask_ptr)
 {
 	unsigned int real_len;
-	cpumask_t mask;
+	cpumask_t allowed, mask;
 	int retval;
 	struct task_struct *p;
 
@@ -173,7 +173,8 @@ asmlinkage long mipsmt_sys_sched_getaffi
 	if (retval)
 		goto out_unlock;
 
-	cpus_and(mask, p->thread.user_cpus_allowed, cpu_possible_map);
+	cpumask_or(&allowed, &p->thread.user_cpus_allowed, &p->cpus_allowed);
+	cpumask_and(&mask, &allowed, cpu_active_mask);
 
 out_unlock:
 	read_unlock(&tasklist_lock);
