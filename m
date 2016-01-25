Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 17:07:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49428 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010210AbcAYQHMZcKNA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jan 2016 17:07:12 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 71BA6759A576A;
        Mon, 25 Jan 2016 16:07:03 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 25 Jan 2016 16:07:06 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 25 Jan 2016 16:07:05 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: cpu_name_string: Use raw_smp_processor_id().
Date:   Mon, 25 Jan 2016 16:06:59 +0000
Message-ID: <1453738019-6553-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

If cpu_name_string() is used in non-atomic context when preemption is
enabled, it can trigger a BUG such as this one:

BUG: using smp_processor_id() in preemptible [00000000] code: unaligned/156
caller is __show_regs+0x1e4/0x330
CPU: 2 PID: 156 Comm: unaligned Tainted: G        W       4.3.0-00366-ga3592179816d-dirty #1501
Stack : ffffffff80900000 ffffffff8019bc18 000000000000005f ffffffff80a20000
         0000000000000000 0000000000000009 ffffffff8019c0e0 ffffffff80835648
         a8000000ff2bdec0 ffffffff80a1e628 000000000000009c 0000000000000002
         ffffffff80840000 a8000000fff2ffb0 0000000000000020 ffffffff8020e43c
         a8000000fff2fcf8 ffffffff80a20000 0000000000000000 ffffffff808f2607
         ffffffff8082b138 ffffffff8019cd1c 0000000000000030 ffffffff8082b138
         0000000000000002 000000000000009c 0000000000000000 0000000000000000
         0000000000000000 a8000000fff2fc40 0000000000000000 ffffffff8044dbf4
         0000000000000000 0000000000000000 0000000000000000 ffffffff8010c400
         ffffffff80855bb0 ffffffff8010d008 0000000000000000 ffffffff8044dbf4
         ...
Call Trace:
[<ffffffff8010d008>] show_stack+0x90/0xb0
[<ffffffff8044dbf4>] dump_stack+0x84/0xe0
[<ffffffff8046d4ec>] check_preemption_disabled+0x10c/0x110
[<ffffffff8010c40c>] __show_regs+0x1e4/0x330
[<ffffffff8010d060>] show_registers+0x28/0xc0
[<ffffffff80110748>] do_ade+0xcc8/0xce0
[<ffffffff80105b84>] resume_userspace_check+0x0/0x10

This is possible because cpu_name_string() is used by __show_regs(),
which is used by both show_regs() and show_registers(). These two
functions are used by various exception handling functions, only some of
which ensure that interrupts or preemption is disabled.

However the following have interrupts explicitly enabled or not
explicitly disabled:
- do_reserved() (irqs enabled)
- do_ade() (irqs not disabled)

This can be hit by setting /sys/kernel/debug/mips/unaligned_action to 2,
and triggering an address error exception, e.g. an unaligned access or
access to kernel segment from user mode.

To fix the above cases, use raw_smp_processor_id() instead. It is
unusual for CPU names to be different in the same system, and even if
they were, its possible the process has migrated between the exception
of interest and the cpu_name_string() call anyway.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cpu-info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index e7dc785a91ca..af12c1f9f1a8 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -102,7 +102,7 @@ extern void cpu_probe(void);
 extern void cpu_report(void);
 
 extern const char *__cpu_name[];
-#define cpu_name_string()	__cpu_name[smp_processor_id()]
+#define cpu_name_string()	__cpu_name[raw_smp_processor_id()]
 
 struct seq_file;
 struct notifier_block;
-- 
2.4.10
