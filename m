Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Mar 2010 10:39:47 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:49564 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491187Ab0CDJjo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Mar 2010 10:39:44 +0100
Received: from localhost.localdomain (pek-lpgbuild1.wrs.com [128.224.153.29])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o249dXVZ024419;
        Thu, 4 Mar 2010 01:39:36 -0800 (PST)
From:   Yang Shi <yang.shi@windriver.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Protect current_cpu_data with preempt disable in delay()
Date:   Thu,  4 Mar 2010 17:39:33 +0800
Message-Id: <1267695573-27360-1-git-send-email-yang.shi@windriver.com>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <yang.shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

During machine restart with reboot command, get the following
bug info:

BUG: using smp_processor_id() in preemptible [00000000] code: reboot/1989
caller is __udelay+0x14/0x70
Call Trace:
[<ffffffff8110ad28>] dump_stack+0x8/0x34
[<ffffffff812dde04>] debug_smp_processor_id+0xf4/0x110
[<ffffffff812d90bc>] __udelay+0x14/0x70
[<ffffffff81378274>] md_notify_reboot+0x12c/0x148
[<ffffffff81161054>] notifier_call_chain+0x64/0xc8
[<ffffffff811614dc>] __blocking_notifier_call_chain+0x64/0xc0
[<ffffffff8115566c>] kernel_restart_prepare+0x1c/0x38
[<ffffffff811556cc>] kernel_restart+0x14/0x50
[<ffffffff8115581c>] SyS_reboot+0x10c/0x1f0
[<ffffffff81103684>] handle_sysn32+0x44/0x84

The root cause is that current_cpu_data is accessed in preemptible
context, so protect it with preempt_disable/preempt_enable pair
in delay().

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/mips/lib/delay.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
index 6b3b1de..dc38064 100644
--- a/arch/mips/lib/delay.c
+++ b/arch/mips/lib/delay.c
@@ -41,7 +41,11 @@ EXPORT_SYMBOL(__delay);
 
 void __udelay(unsigned long us)
 {
-	unsigned int lpj = current_cpu_data.udelay_val;
+	unsigned int lpj;
+
+	preempt_disable();
+	lpj = current_cpu_data.udelay_val;
+	preempt_enable();
 
 	__delay((us * 0x000010c7ull * HZ * lpj) >> 32);
 }
-- 
1.6.3.3
