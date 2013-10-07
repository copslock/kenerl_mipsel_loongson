Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 13:15:13 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:57323 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868725Ab3JGLPGlm82z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 13:15:06 +0200
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: stack protector: Fix per-task canary switch
Date:   Mon, 7 Oct 2013 12:14:26 +0100
Message-ID: <1381144466-19736-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_10_07_12_15_01
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38219
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

Commit 1400eb6 (MIPS: r4k,octeon,r2300: stack protector: change canary
per task) was merged in v3.11 and introduced assembly in the MIPS resume
functions to update the value of the current canary in
__stack_chk_guard. However it used PTR_L resulting in a load of the
canary value, instead of PTR_LA to construct its address. The value is
intended to be random but is then treated as an address in the
subsequent LONG_S (store).

This was observed to cause a fault and panic:

CPU 0 Unable to handle kernel paging request at virtual address 139fea20, epc == 8000cc0c, ra == 8034f2a4
Oops[#1]:
...
$24   : 139fea20 1e1f7cb6
...
Call Trace:
[<8000cc0c>] resume+0xac/0x118
[<8034f2a4>] __schedule+0x5f8/0x78c
[<8034f4e0>] schedule_preempt_disabled+0x20/0x2c
[<80348eec>] rest_init+0x74/0x84
[<804dc990>] start_kernel+0x43c/0x454
Code: 3c18804b  8f184030  8cb901f8 <af190000> 00c0e021  8cb002f0 8cb102f4  8cb202f8  8cb302fc

This can also be forced by modifying
arch/mips/include/asm/stackprotector.h so that the default
__stack_chk_guard value is more likely to be a bad (or unaligned)
pointer.

Fix it to use PTR_LA instead, to load the address of the canary value,
which the LONG_S can then use to write into it.

Reported-by: bobjones (via #mipslinux on IRC)
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gregory Fong <gregory.0xf0@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> #3.11
---
Ralf: This is a regression in v3.11, so please consider for v3.12.

(Sorry, resent to Cc stable correctly)

 arch/mips/kernel/octeon_switch.S | 2 +-
 arch/mips/kernel/r2300_switch.S  | 2 +-
 arch/mips/kernel/r4k_switch.S    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 4204d76..029e002 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -73,7 +73,7 @@
 3:
 
 #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	PTR_L	t8, __stack_chk_guard
+	PTR_LA	t8, __stack_chk_guard
 	LONG_L	t9, TASK_STACK_CANARY(a1)
 	LONG_S	t9, 0(t8)
 #endif
diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
index 38af83f..20b7b04 100644
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -67,7 +67,7 @@ LEAF(resume)
 1:
 
 #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	PTR_L	t8, __stack_chk_guard
+	PTR_LA	t8, __stack_chk_guard
 	LONG_L	t9, TASK_STACK_CANARY(a1)
 	LONG_S	t9, 0(t8)
 #endif
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 921238a..078de5e 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -69,7 +69,7 @@
 1:
 
 #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	PTR_L	t8, __stack_chk_guard
+	PTR_LA	t8, __stack_chk_guard
 	LONG_L	t9, TASK_STACK_CANARY(a1)
 	LONG_S	t9, 0(t8)
 #endif
-- 
1.8.1.2
