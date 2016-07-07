Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2016 20:39:51 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:52594 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992339AbcGGSjYKemgF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jul 2016 20:39:24 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bLECo-0007rp-1U; Thu, 07 Jul 2016 18:39:22 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bLECl-0004wv-SN; Thu, 07 Jul 2016 11:39:19 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 45/99] MIPS: Avoid using unwind_stack() with usermode
Date:   Thu,  7 Jul 2016 11:37:44 -0700
Message-Id: <1467916718-18638-46-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1467916718-18638-1-git-send-email-kamal@canonical.com>
References: <1467916718-18638-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54248
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

3.19.8-ckt23 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: James Hogan <james.hogan@imgtec.com>

commit 81a76d7119f63c359750e4adeff922a31ad1135f upstream.

When showing backtraces in response to traps, for example crashes and
address errors (usually unaligned accesses) when they are set in debugfs
to be reported, unwind_stack will be used if the PC was in the kernel
text address range. However since EVA it is possible for user and kernel
address ranges to overlap, and even without EVA userland can still
trigger an address error by jumping to a KSeg0 address.

Adjust the check to also ensure that it was running in kernel mode. I
don't believe any harm can come of this problem, since unwind_stack() is
sufficiently defensive, however it is only meant for unwinding kernel
code, so to be correct it should use the raw backtracing instead.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11701/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
(cherry picked from commit d2941a975ac745c607dfb590e92bb30bc352dad9)
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7dd15e9..af1475f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -141,7 +141,7 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs)
 	if (!task)
 		task = current;
 
-	if (raw_show_trace || !__kernel_text_address(pc)) {
+	if (raw_show_trace || user_mode(regs) || !__kernel_text_address(pc)) {
 		show_raw_backtrace(sp);
 		return;
 	}
-- 
2.7.4
