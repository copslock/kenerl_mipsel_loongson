Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2014 13:53:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:19030 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6825887AbaEALxZaQFFH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 May 2014 13:53:25 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 84E4532E32DB2
        for <linux-mips@linux-mips.org>; Thu,  1 May 2014 12:53:15 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 1 May
 2014 12:53:18 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 1 May 2014 12:53:17 +0100
Received: from asmith-linux.le.imgtec.org (192.168.154.62) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 1 May 2014 12:53:17 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH] MIPS: ptrace: Avoid smp_processor_id() in preemptible code
Date:   Thu, 1 May 2014 12:51:19 +0100
Message-ID: <1398945079-1591-1-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 1.9.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.62]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

ptrace_{get,set}_watch_regs access current_cpu_data to get the watch
register count/masks, which calls smp_processor_id(). However they are
run in preemptible context and therefore trigger warnings like so:

[ 6340.092000] BUG: using smp_processor_id() in preemptible [00000000] code: gdb/367
[ 6340.092000] caller is ptrace_get_watch_regs+0x44/0x220

Since the watch register count/masks should be the same across all
CPUs, use boot_cpu_data instead. Note that this may need to change in
future should a heterogenous system be supported where the count/masks
are not the same across all CPUs (the current code is also incorrect
for this scenario - current_cpu_data here would not necessarily be
correct for the CPU that the target task will execute on).

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/ptrace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 71f85f4..f639ccd 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -163,7 +163,7 @@ int ptrace_get_watch_regs(struct task_struct *child,
 	enum pt_watch_style style;
 	int i;
 
-	if (!cpu_has_watch || current_cpu_data.watch_reg_use_cnt == 0)
+	if (!cpu_has_watch || boot_cpu_data.watch_reg_use_cnt == 0)
 		return -EIO;
 	if (!access_ok(VERIFY_WRITE, addr, sizeof(struct pt_watch_regs)))
 		return -EIO;
@@ -177,14 +177,14 @@ int ptrace_get_watch_regs(struct task_struct *child,
 #endif
 
 	__put_user(style, &addr->style);
-	__put_user(current_cpu_data.watch_reg_use_cnt,
+	__put_user(boot_cpu_data.watch_reg_use_cnt,
 		   &addr->WATCH_STYLE.num_valid);
-	for (i = 0; i < current_cpu_data.watch_reg_use_cnt; i++) {
+	for (i = 0; i < boot_cpu_data.watch_reg_use_cnt; i++) {
 		__put_user(child->thread.watch.mips3264.watchlo[i],
 			   &addr->WATCH_STYLE.watchlo[i]);
 		__put_user(child->thread.watch.mips3264.watchhi[i] & 0xfff,
 			   &addr->WATCH_STYLE.watchhi[i]);
-		__put_user(current_cpu_data.watch_reg_masks[i],
+		__put_user(boot_cpu_data.watch_reg_masks[i],
 			   &addr->WATCH_STYLE.watch_masks[i]);
 	}
 	for (; i < 8; i++) {
@@ -204,12 +204,12 @@ int ptrace_set_watch_regs(struct task_struct *child,
 	unsigned long lt[NUM_WATCH_REGS];
 	u16 ht[NUM_WATCH_REGS];
 
-	if (!cpu_has_watch || current_cpu_data.watch_reg_use_cnt == 0)
+	if (!cpu_has_watch || boot_cpu_data.watch_reg_use_cnt == 0)
 		return -EIO;
 	if (!access_ok(VERIFY_READ, addr, sizeof(struct pt_watch_regs)))
 		return -EIO;
 	/* Check the values. */
-	for (i = 0; i < current_cpu_data.watch_reg_use_cnt; i++) {
+	for (i = 0; i < boot_cpu_data.watch_reg_use_cnt; i++) {
 		__get_user(lt[i], &addr->WATCH_STYLE.watchlo[i]);
 #ifdef CONFIG_32BIT
 		if (lt[i] & __UA_LIMIT)
@@ -228,7 +228,7 @@ int ptrace_set_watch_regs(struct task_struct *child,
 			return -EINVAL;
 	}
 	/* Install them. */
-	for (i = 0; i < current_cpu_data.watch_reg_use_cnt; i++) {
+	for (i = 0; i < boot_cpu_data.watch_reg_use_cnt; i++) {
 		if (lt[i] & 7)
 			watch_active = 1;
 		child->thread.watch.mips3264.watchlo[i] = lt[i];
-- 
1.9.2
