Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 23:01:23 +0100 (CET)
Received: from 1wt.eu ([62.212.114.60]:47978 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013766AbaKPWBVahtyk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 16 Nov 2014 23:01:21 +0100
Message-Id: <20141116215328.857299108@1wt.eu>
User-Agent: quilt/0.48-1
Date:   Sun, 16 Nov 2014 22:53:33 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [ 05/48] MIPS: asm: thread_info: Add _TIF_SECCOMP flag
In-Reply-To: <28c765bc23bd4bae1611534e510f49f8@local>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

2.6.32-longterm review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

Add _TIF_SECCOMP flag to _TIF_WORK_SYSCALL_ENTRY to indicate
that the system call needs to be checked against a seccomp filter.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/6405/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
(cherry picked from commit 137f7df8cead00688524c82360930845396b8a21)
[wt: fixes CVE-2014-4157 - no _TIF_NOHZ nor _TIF_SYSCALL_TRACEPOINT in 2.6.32]
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/include/asm/thread_info.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 2ef1662..b0e25eb 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -145,7 +145,8 @@ register struct thread_info *__current_thread_info __asm__("$28");
 #define _TIF_FPUBOUND		(1<<TIF_FPUBOUND)
 #define _TIF_LOAD_WATCH		(1<<TIF_LOAD_WATCH)
 
-#define _TIF_WORK_SYSCALL_ENTRY	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT)
+#define _TIF_WORK_SYSCALL_ENTRY	(_TIF_SYSCALL_TRACE | \
+				 _TIF_SYSCALL_AUDIT | _TIF_SECCOMP)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK		(0x0000ffef & ~_TIF_SECCOMP)
-- 
1.7.12.2.21.g234cd45.dirty
