Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 11:22:44 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:58062 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007944AbcBZKWnj9NHh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 11:22:43 +0100
Received: from av-217-129-142-138.netvisao.pt ([217.129.142.138] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1aZFXm-0006NY-Up; Fri, 26 Feb 2016 10:22:43 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 075/129] MIPS: Fix buffer overflow in syscall_get_arguments()
Date:   Fri, 26 Feb 2016 10:20:46 +0000
Message-Id: <1456482100-4667-76-git-send-email-luis.henriques@canonical.com>
In-Reply-To: <1456482100-4667-1-git-send-email-luis.henriques@canonical.com>
References: <1456482100-4667-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.16.7-ckt25 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: James Hogan <james.hogan@imgtec.com>

commit f4dce1ffd2e30fa31756876ef502ce6d2324be35 upstream.

Since commit 4c21b8fd8f14 ("MIPS: seccomp: Handle indirect system calls
(o32)"), syscall_get_arguments() attempts to handle o32 indirect syscall
arguments by incrementing both the start argument number and the number
of arguments to fetch. However only the start argument number needs to
be incremented. The number of arguments does not change, they're just
shifted up by one, and in fact the output array is provided by the
caller and is likely only n entries long, so reading more arguments
overflows the output buffer.

In the case of seccomp, this results in it fetching 7 arguments starting
at the 2nd one, which overflows the unsigned long args[6] in
populate_seccomp_data(). This clobbers the $s0 register from
syscall_trace_enter() which __seccomp_phase1_filter() saved onto the
stack, into which syscall_trace_enter() had placed its syscall number
argument. This caused Chromium to crash.

Credit goes to Milko for tracking it down as far as $s0 being clobbered.

Fixes: 4c21b8fd8f14 ("MIPS: seccomp: Handle indirect system calls (o32)")
Reported-by: Milko Leporis <milko.leporis@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12213/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/include/asm/syscall.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index cdf68b33bd65..1c7e4526cbf3 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -107,10 +107,8 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	/* O32 ABI syscall() - Either 64-bit with O32 or 32-bit */
 	if ((config_enabled(CONFIG_32BIT) ||
 	    test_tsk_thread_flag(task, TIF_32BIT_REGS)) &&
-	    (regs->regs[2] == __NR_syscall)) {
+	    (regs->regs[2] == __NR_syscall))
 		i++;
-		n++;
-	}
 
 	while (n--)
 		ret |= mips_get_syscall_arg(args++, task, regs, i++);
