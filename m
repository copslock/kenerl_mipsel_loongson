Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2015 19:08:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54712 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008158AbbIURIOlXhvX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Sep 2015 19:08:14 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BC636369A846C;
        Mon, 21 Sep 2015 18:08:04 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 21 Sep 2015 18:08:08 +0100
Received: from localhost (192.168.159.181) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 21 Sep
 2015 18:08:07 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        <linux-kernel@vger.kernel.org>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        "Leonid Rosenboim" <lrosenboim@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/2] MIPS: Fix octeon FP context switch handling
Date:   Mon, 21 Sep 2015 10:07:41 -0700
Message-ID: <1442855262-25416-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.181]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49252
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

Commit 1a3d59579b9f ("MIPS: Tidy up FPU context switching") removed FP
context saving from the asm-written resume function in favour of reusing
existing code to perform the same task. However it only removed the FP
context saving code from the r4k_switch.S implementation of resume.
Octeon uses its own implementation in octeon_switch.S, so remove FP
context saving there too in order to prevent attempting to save context
twice. That formerly led to an exception from the second save as follows
because the FPU had already been disabled by the first save:

    do_cpu invoked from kernel context![#1]:
    CPU: 0 PID: 2 Comm: kthreadd Not tainted 4.3.0-rc2-dirty #2
    task: 800000041f84a008 ti: 800000041f864000 task.ti: 800000041f864000
    $ 0   : 0000000000000000 0000000010008ce1 0000000000100000 ffffffffbfffffff
    $ 4   : 800000041f84a008 800000041f84ac08 800000041f84c000 0000000000000004
    $ 8   : 0000000000000001 0000000000000000 0000000000000000 0000000000000001
    $12   : 0000000010008ce3 0000000000119c60 0000000000000036 800000041f864000
    $16   : 800000041f84ac08 800000000792ce80 800000041f84a008 ffffffff81758b00
    $20   : 0000000000000000 ffffffff8175ae50 0000000000000000 ffffffff8176c740
    $24   : 0000000000000006 ffffffff81170300
    $28   : 800000041f864000 800000041f867d90 0000000000000000 ffffffff815f3fa0
    Hi    : 0000000000fa8257
    Lo    : ffffffffe15cfc00
    epc   : ffffffff8112821c resume+0x9c/0x200
    ra    : ffffffff815f3fa0 __schedule+0x3f0/0x7d8
    Status: 10008ce2        KX SX UX KERNEL EXL
    Cause : 1080002c (ExcCode 0b)
    PrId  : 000d0601 (Cavium Octeon+)
    Modules linked in:
    Process kthreadd (pid: 2, threadinfo=800000041f864000, task=800000041f84a008, tls=0000000000000000)
    Stack : ffffffff81604218 ffffffff815f7e08 800000041f84a008 ffffffff811681b0
              800000041f84a008 ffffffff817e9878 0000000000000000 ffffffff81770000
              ffffffff81768340 ffffffff81161398 0000000000000001 0000000000000000
              0000000000000000 ffffffff815f4424 0000000000000000 ffffffff81161d68
              ffffffff81161be8 0000000000000000 0000000000000000 0000000000000000
              0000000000000000 0000000000000000 0000000000000000 ffffffff8111e16c
              0000000000000000 0000000000000000 0000000000000000 0000000000000000
              0000000000000000 0000000000000000 0000000000000000 0000000000000000
              0000000000000000 0000000000000000 0000000000000000 0000000000000000
              0000000000000000 0000000000000000 0000000000000000 0000000000000000
              ...
    Call Trace:
    [<ffffffff8112821c>] resume+0x9c/0x200
    [<ffffffff815f3fa0>] __schedule+0x3f0/0x7d8
    [<ffffffff815f4424>] schedule+0x34/0x98
    [<ffffffff81161d68>] kthreadd+0x180/0x198
    [<ffffffff8111e16c>] ret_from_kernel_thread+0x14/0x1c

Tested using cavium_octeon_defconfig on an EdgeRouter Lite.

Fixes: 1a3d59579b9f ("MIPS: Tidy up FPU context switching")
Reported-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/octeon_switch.S | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 423ae83..3375745 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -18,7 +18,7 @@
 	.set pop
 /*
  * task_struct *resume(task_struct *prev, task_struct *next,
- *		       struct thread_info *next_ti, int usedfpu)
+ *		       struct thread_info *next_ti)
  */
 	.align	7
 	LEAF(resume)
@@ -28,30 +28,6 @@
 	cpu_save_nonscratch a0
 	LONG_S	ra, THREAD_REG31(a0)
 
-	/*
-	 * check if we need to save FPU registers
-	 */
-	.set push
-	.set noreorder
-	beqz	a3, 1f
-	 PTR_L	t3, TASK_THREAD_INFO(a0)
-	.set pop
-
-	/*
-	 * clear saved user stack CU1 bit
-	 */
-	LONG_L	t0, ST_OFF(t3)
-	li	t1, ~ST0_CU1
-	and	t0, t0, t1
-	LONG_S	t0, ST_OFF(t3)
-
-	.set push
-	.set arch=mips64r2
-	fpu_save_double a0 t0 t1		# c0_status passed in t0
-						# clobbers t1
-	.set pop
-1:
-
 #if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
 	/* Check if we need to store CVMSEG state */
 	dmfc0	t0, $11,7	/* CvmMemCtl */
-- 
2.5.3
