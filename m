Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2016 16:14:27 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:38790 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991932AbcIWOOVXUT0t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Sep 2016 16:14:21 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 549D1EC9F3EAF;
        Fri, 23 Sep 2016 15:14:11 +0100 (IST)
Received: from localhost (10.100.200.111) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 23 Sep
 2016 15:14:14 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "stable # v4 . 0+" <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Fix pre-r6 emulation FPU initialisation
Date:   Fri, 23 Sep 2016 15:13:53 +0100
Message-ID: <20160923141353.1596-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.111]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

In the mipsr2_decoder() function, used to emulate pre-MIPSr6
instructions that were removed in MIPSr6, the init_fpu() function is
called if a removed pre-MIPSr6 floating point instruction is the first
floating point instruction used by the task. However, init_fpu()
performs varous actions that rely upon not being migrated. For example
in the most basic case it sets the coprocessor 0 Status.CU1 bit to
enable the FPU & then loads FP register context into the FPU registers.
If the task were to migrate during this time, it may end up attempting
to load FP register context on a different CPU where it hasn't set the
CU1 bit, leading to errors such as:

    do_cpu invoked from kernel context![#2]:
    CPU: 2 PID: 7338 Comm: fp-prctl Tainted: G      D         4.7.0-00424-g49b0c82 #2
    task: 838e4000 ti: 88d38000 task.ti: 88d38000
    $ 0   : 00000000 00000001 ffffffff 88d3fef8
    $ 4   : 838e4000 88d38004 00000000 00000001
    $ 8   : 3400fc01 801f8020 808e9100 24000000
    $12   : dbffffff 807b69d8 807b0000 00000000
    $16   : 00000000 80786150 00400fc4 809c0398
    $20   : 809c0338 0040273c 88d3ff28 808e9d30
    $24   : 808e9d30 00400fb4
    $28   : 88d38000 88d3fe88 00000000 8011a2ac
    Hi    : 0040273c
    Lo    : 88d3ff28
    epc   : 80114178 _restore_fp+0x10/0xa0
    ra    : 8011a2ac mipsr2_decoder+0xd5c/0x1660
    Status: 1400fc03	KERNEL EXL IE
    Cause : 1080002c (ExcCode 0b)
    PrId  : 0001a920 (MIPS I6400)
    Modules linked in:
    Process fp-prctl (pid: 7338, threadinfo=88d38000, task=838e4000, tls=766527d0)
    Stack : 00000000 00000000 00000000 88d3fe98 00000000 00000000 809c0398 809c0338
    	  808e9100 00000000 88d3ff28 00400fc4 00400fc4 0040273c 7fb69e18 004a0000
    	  004a0000 004a0000 7664add0 8010de18 00000000 00000000 88d3fef8 88d3ff28
    	  808e9100 00000000 766527d0 8010e534 000c0000 85755000 8181d580 00000000
    	  00000000 00000000 004a0000 00000000 766527d0 7fb69e18 004a0000 80105c20
    	  ...
    Call Trace:
    [<80114178>] _restore_fp+0x10/0xa0
    [<8011a2ac>] mipsr2_decoder+0xd5c/0x1660
    [<8010de18>] do_ri+0x90/0x6b8
    [<80105c20>] ret_from_exception+0x0/0x10

Fix this by disabling preemption around the call to init_fpu(), ensuring
that it starts & completes on one CPU.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: b0a668fb2038 ("MIPS: kernel: mips-r2-to-r6-emul: Add R2 emulator for MIPS R6")
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: stable <stable@vger.kernel.org> # v4.0+
---
 arch/mips/kernel/mips-r2-to-r6-emul.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index c3372ca..0a7e10b 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -1164,7 +1164,9 @@ fpu_emul:
 		regs->regs[31] = r31;
 		regs->cp0_epc = epc;
 		if (!used_math()) {     /* First time FPU user.  */
+			preempt_disable();
 			err = init_fpu();
+			preempt_enable();
 			set_used_math();
 		}
 		lose_fpu(1);    /* Save FPU state for the emulator. */
-- 
2.10.0
