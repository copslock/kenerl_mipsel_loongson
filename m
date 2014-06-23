Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 10:33:02 +0200 (CEST)
Received: from ip4-83-240-18-248.cust.nbox.cz ([83.240.18.248]:52280 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821443AbaFWIcgqPHSw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 10:32:36 +0200
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.80.1)
        (envelope-from <jslaby@suse.cz>)
        id 1Wyzfu-0003HJ-J1; Mon, 23 Jun 2014 10:32:26 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 007/111] MIPS: asm: thread_info: Add _TIF_SECCOMP flag
Date:   Mon, 23 Jun 2014 10:30:42 +0200
Message-Id: <649066ce296368e2733ce1d4005f10dc673a9e8f.1403512280.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <55d5f044a1fc96a74e4470e318c0a24f27a9ab7e.1403512280.git.jslaby@suse.cz>
References: <55d5f044a1fc96a74e4470e318c0a24f27a9ab7e.1403512280.git.jslaby@suse.cz>
In-Reply-To: <cover.1403512280.git.jslaby@suse.cz>
References: <cover.1403512280.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Markos Chandras <markos.chandras@imgtec.com>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 137f7df8cead00688524c82360930845396b8a21 upstream.

Add _TIF_SECCOMP flag to _TIF_WORK_SYSCALL_ENTRY to indicate
that the system call needs to be checked against a seccomp filter.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/6405/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 61215a34acc6..897cd58407c8 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -134,7 +134,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_LOAD_WATCH		(1<<TIF_LOAD_WATCH)
 
 #define _TIF_WORK_SYSCALL_ENTRY	(_TIF_NOHZ | _TIF_SYSCALL_TRACE |	\
-				 _TIF_SYSCALL_AUDIT)
+				 _TIF_SYSCALL_AUDIT | _TIF_SECCOMP)
 
 /* work to do in syscall_trace_leave() */
 #define _TIF_WORK_SYSCALL_EXIT	(_TIF_NOHZ | _TIF_SYSCALL_TRACE |	\
-- 
2.0.0
