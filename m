Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 23:52:33 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:50734 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006883AbcCGWwbyc2Ea (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Mar 2016 23:52:31 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ad40t-00009t-9Z; Mon, 07 Mar 2016 22:52:31 +0000
Received: from kamal by fourier with local (Exim 4.86)
        (envelope-from <kamal@whence.com>)
        id 1ad40q-0001ty-JR; Mon, 07 Mar 2016 14:52:28 -0800
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 059/273] MIPS: Fix buffer overflow in syscall_get_arguments()
Date:   Mon,  7 Mar 2016 14:47:30 -0800
Message-Id: <1457391064-6660-60-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457391064-6660-1-git-send-email-kamal@canonical.com>
References: <1457391064-6660-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt5 -stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/include/asm/syscall.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 6499d93..47bc45a 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -101,10 +101,8 @@ static inline void syscall_get_arguments(struct task_struct *task,
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
-- 
2.7.0
