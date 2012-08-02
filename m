Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2012 05:31:32 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:41828 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903482Ab2HBDb0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2012 05:31:26 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q723VIj6016934
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 1 Aug 2012 20:31:18 -0700 (PDT)
Received: from localhost.localdomain (128.224.153.43) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.2.309.2; Wed, 1 Aug 2012 20:31:18 -0700
From:   Fan Du <fdu@windriver.com>
To:     <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: oops when show backtrace of all active cpu
Date:   Thu, 2 Aug 2012 11:31:14 +0800
Message-ID: <1343878276-4108-1-git-send-email-fdu@windriver.com>
X-Mailer: git-send-email 1.7.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-archive-position: 34017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fdu@windriver.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

show_backtrace must have an valid task when calling unwind_stack,
so fix it by checking first.

root@romashell:/root> echo l > /proc/sysrq-trigger
SysRq : Show backtrace of all active CPUs
Stack : ffffffff81bf0000 ffffffff81ce0000root@octeon:/root>  ffffffff81bf0000 0000000000000036
        ffffffff81bf0000 0000000000000003 a80000041b60b850 ffffffff811dfa8c
        0000000000004000 a80000041fc0c060 a80000041b60b870 ffffffff8124c42c
        0000000000000038 ffffffff811b8efc a800000003abbc00 ffffffff81be0980
        ffffffff81be4200 0000000000000038 ffffffff81ce0000 0000000000000000
        ffffffff81b92c40 a80000041b60b8c0 ffffffff81b92c40 ffffffff8157b0d8
        0000000000000000 0000000000004000 0000000000004000 0000000000000000
        ffffffff81be0990 a80000041b60b810 a80000041b60b910 ffffffff8157b0e4
        a80000041b60b958 a800000003b9b358 0000000000000001 ffffffff81d70000
        0000000000000000 ffffffff811a1ac8 a80000041b60b990 ffffffff8157b0d8
        ...
Call Trace:
[<ffffffff811a1ac8>] show_stack+0xd8/0x100
CPU 14 Unable to handle kernel paging request at virtual address 0000000000000008, epc == ffffffff8119c6a4, ra == ffffffff811a0664
Oops[#1]:
Cpu 14
$ 0   : 0000000000000000 ffffffff811a0664 000000000000002e 0000000000020003
$ 4   : 0000000000000000 a80000041b60b770 ffffffff811a1ac8 a80000041b60b778
$ 8   : ffffffffffffffff 0000000000003fff 000000000000282d 0000000000000001
$12   : ffffffff811a19a8 000000001000001f a80000041fe68000 0000000000000000
$16   : 0000000000000000 ffffffff81b5ae70 a80000041b60b770 ffffffff811a1ac8
$20   : a80000041b60b810 0000000000000000 ffffffff81b5ae98 0000000000200200
$24   : 0000000000000000 000000002b6e8c94
$28   : a80000041b608000 a80000041b60b700 a80000041b60b700 ffffffff811a0664
Hi    : 0000000000000002
Lo    : bf7889a5a0000000
epc   : ffffffff8119c6a4 unwind_stack+0x2c/0x180
    Not tainted
ra    : ffffffff811a0664 show_backtrace+0x15c/0x178
Status: 10008ce2    KX SX UX KERNEL EXL
Cause : 40808008
BadVA : 0000000000000008
PrId  : 000d030b (Cavium Octeon+)
Modules linked in:
Process klogd (pid: 1163, threadinfo=a80000041b608000, task=a80000041c271600, tls=000000002aed3f70)
Stack : 0000000000000000 0000000000000000 ffffffff81b5ae70 a80000041b60b778
        a80000041b60b770 ffffffff811a0650 a80000041b60b740 ffffffff811a1ac8
        ffffffff811a1ac8 0000000000000000 ffffffff81b5ae70 a80000041b60b778
        a80000041b60b770 ffffffff811a0664 a80000041b60b810 ffffffff8157b0e4
        0000000000000000 a80000041b60b950 0000000000000028 0000000000000000
        ffffffff81b5abe0 a80000041b60b810 a80000041b60b7c0 ffffffff811a075c
        a80000041b60b7d0 0000000000000000 0000000000000000 0000000000000000
        0000000000004000 0000000000004000 0000000000000000 ffffffff81be0990
        a80000041b60b810 ffffffff811a1a30 ffffffff81bf0000 ffffffff81ce0000
        ffffffff81bf0000 0000000000000036 ffffffff81bf0000 0000000000000003
        ...
Call Trace:
[<ffffffff8119c6a4>] unwind_stack+0x2c/0x180
[<ffffffff811a0664>] show_backtrace+0x15c/0x178
[<ffffffff811a075c>] show_stacktrace+0xdc/0x138
[<ffffffff811a1a30>] show_stack+0x40/0x100
[<ffffffff8157b0e4>] showacpu+0x84/0x98
[<ffffffff8121dd54>] generic_smp_call_function_interrupt+0x174/0x250
[<ffffffff817581d4>] smp_call_function_interrupt+0x34/0x50
[<ffffffff81105518>] mailbox_interrupt+0x78/0x80
[<ffffffff8124c42c>] handle_IRQ_event+0x9c/0x368
[<ffffffff8124f5b8>] handle_percpu_irq+0x70/0xd0
[<ffffffff81758180>] do_IRQ+0x40/0x60
[<ffffffff811025f0>] native_plat_irq_dispatch+0xf8/0x188
[<ffffffff811024e4>] plat_irq_dispatch+0x24/0x38
[<ffffffff811a3e60>] ret_from_irq+0x0/0x4
[<ffffffff817572a8>] _raw_spin_unlock_irq+0x38/0x70
[<ffffffff811e07b8>] do_syslog+0x408/0x590
[<ffffffff81344b50>] kmsg_read+0x48/0x98
[<ffffffff81337200>] proc_reg_read+0xa0/0xf0
[<ffffffff812d47ec>] vfs_read+0xcc/0x160
[<ffffffff812d4a44>] SyS_read+0x6c/0x168
[<ffffffff811ad564>] handle_sysn32+0x44/0x84

Code: 00000000  00000000  00a0902d <dc900008> 1200002d  00c0882d  3c02811a  64423e60  10c20033
Disabling lock debugging due to kernel taint
Kernel panic - not syncing: Fatal exception in interrupt

Signed-off-by: Fan Du <fdu@windriver.com>
---
 arch/mips/kernel/traps.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b25b921..99c6611 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -151,6 +151,10 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs)
 		show_raw_backtrace(sp);
 		return;
 	}
+
+	if (task == NULL)
+		task = current;
+
 	printk("Call Trace:\n");
 	do {
 		print_ip_sym(pc);
-- 
1.7.0.5
