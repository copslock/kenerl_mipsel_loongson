Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2017 17:33:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45401 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993865AbdDEPdFZfI35 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Apr 2017 17:33:05 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A69AC406CEC5B;
        Wed,  5 Apr 2017 16:32:55 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 5 Apr 2017 16:32:58 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Rabin Vincent <rabinv@axis.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] MIPS: cevt-r4k: Fix out-of-bounds array access
Date:   Wed, 5 Apr 2017 16:32:45 +0100
Message-ID: <dda2852408884df379eb1fc8ae40aceaf094be61.1491406275.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57569
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

calculate_min_delta() may incorrectly access a 4th element of buf2[]
which only has 3 elements. This may trigger undefined behaviour and has
been reported to cause strange crashes in start_kernel() sometime after
timer initialization when built with GCC 5.3, possibly due to
register/stack corruption:

sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 10737418237ns
CPU 0 Unable to handle kernel paging request at virtual address ffffb0aa, epc == 8067daa8, ra == 8067da84
Oops[#1]:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.18 #51
task: 8065e3e0 task.stack: 80644000
$ 0   : 00000000 00000001 00000000 00000000
$ 4   : 8065b4d0 00000000 805d0000 00000010
$ 8   : 00000010 80321400 fffff000 812de408
$12   : 00000000 00000000 00000000 ffffffff
$16   : 00000002 ffffffff 80660000 806a666c
$20   : 806c0000 00000000 00000000 00000000
$24   : 00000000 00000010
$28   : 80644000 80645ed0 00000000 8067da84
Hi    : 00000000
Lo    : 00000000
epc   : 8067daa8 start_kernel+0x33c/0x500
ra    : 8067da84 start_kernel+0x318/0x500
Status: 11000402 KERNEL EXL
Cause : 4080040c (ExcCode 03)
BadVA : ffffb0aa
PrId  : 0501992c (MIPS 1004Kc)
Modules linked in:
Process swapper/0 (pid: 0, threadinfo=80644000, task=8065e3e0, tls=00000000)
Call Trace:
[<8067daa8>] start_kernel+0x33c/0x500
Code: 24050240  0c0131f9  24849c64 <a200b0a8> 41606020  000000c0  0c1a45e6 00000000  0c1a5f44

UBSAN also detects the same issue:

================================================================
UBSAN: Undefined behaviour in arch/mips/kernel/cevt-r4k.c:85:41
load of address 80647e4c with insufficient space
for an object of type 'unsigned int'
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.18 #47
Call Trace:
[<80028f70>] show_stack+0x88/0xa4
[<80312654>] dump_stack+0x84/0xc0
[<8034163c>] ubsan_epilogue+0x14/0x50
[<803417d8>] __ubsan_handle_type_mismatch+0x160/0x168
[<8002dab0>] r4k_clockevent_init+0x544/0x764
[<80684d34>] time_init+0x18/0x90
[<8067fa5c>] start_kernel+0x2f0/0x500
=================================================================

buf2[] is intentionally only 3 elements so that the last element is the
median once 5 samples have been inserted, so explicitly prevent the
possibility of comparing against the 4th element rather than extending
the array.

Fixes: 1fa405552e33f2 ("MIPS: cevt-r4k: Dynamically calculate min_delta_ns")
Reported-by: Rabin Vincent <rabinv@axis.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Tested-by: Rabin Vincent <rabinv@axis.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.7.x-
---
 arch/mips/kernel/cevt-r4k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 804d2a2a19fe..dd6a18bc10ab 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -80,7 +80,7 @@ static unsigned int calculate_min_delta(void)
 		}
 
 		/* Sorted insert of 75th percentile into buf2 */
-		for (k = 0; k < i; ++k) {
+		for (k = 0; k < i && k < ARRAY_SIZE(buf2); ++k) {
 			if (buf1[ARRAY_SIZE(buf1) - 1] < buf2[k]) {
 				l = min_t(unsigned int,
 					  i, ARRAY_SIZE(buf2) - 1);
-- 
git-series 0.8.10
