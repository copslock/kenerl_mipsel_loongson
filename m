Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2013 17:31:42 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:59545 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867251Ab3LTQbgoTrZj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Dec 2013 17:31:36 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH] mips: fix 64-bit compilation error without CONFIG_MIPS32_O32
Date:   Fri, 20 Dec 2013 16:31:07 +0000
Message-ID: <1387557067-51026-1-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.73]
X-SEF-Processed: 7_3_0_01192__2013_12_20_16_31_31
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

Attempting to compile a 64-bit kernel without CONFIG_MIPS32_O32 defined
(using GCC 4.8.1) results in the following compilation error:

arch/mips/include/asm/syscall.h: In function 'mips_get_syscall_arg':
arch/mips/include/asm/syscall.h:32:16: error: unused variable 'usp' [-Werror=unused-variable]

Fix by adding __maybe_unsued to the definition of usp.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 81c8913..c48f8d8 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -29,7 +29,7 @@ static inline long syscall_get_nr(struct task_struct *task,
 static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
 	struct task_struct *task, struct pt_regs *regs, unsigned int n)
 {
-	unsigned long usp = regs->regs[29];
+	unsigned long __maybe_unused usp = regs->regs[29];
 
 	switch (n) {
 	case 0: case 1: case 2: case 3:
-- 
1.8.5.2
