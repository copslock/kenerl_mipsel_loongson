Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 18:01:51 +0200 (CEST)
Received: from ip4-83-240-18-248.cust.nbox.cz ([83.240.18.248]:44249 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816615AbaFRQBsh8bO4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2014 18:01:48 +0200
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.80.1)
        (envelope-from <jslaby@suse.cz>)
        id 1WxIIo-0001Tv-Fn; Wed, 18 Jun 2014 18:01:34 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     ben@decadent.org.uk, Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] MIPS: asm: thread_info: Add _TIF_SECCOMP flag
Date:   Wed, 18 Jun 2014 18:01:34 +0200
Message-Id: <1403107294-5664-1-git-send-email-jslaby@suse.cz>
X-Mailer: git-send-email 1.9.3
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40635
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

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

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
1.9.3
