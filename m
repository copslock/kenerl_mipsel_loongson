Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 13:06:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45983 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008950AbbAIMGpDMuMS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 13:06:45 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 89F12ACC90BE4;
        Fri,  9 Jan 2015 12:06:36 +0000 (GMT)
Received: from metadesk01.kl.imgtec.org (192.168.14.104) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 9 Jan 2015 12:06:38 +0000
From:   Daniel Sanders <daniel.sanders@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Daniel Sanders <daniel.sanders@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Behan Webster <behanw@converseincode.com>
Subject: [PATCH] MIPS: Changed current_thread_info() to an equivalent supported by both clang and GCC
Date:   Fri, 9 Jan 2015 12:06:17 +0000
Message-ID: <1420805177-9087-1-git-send-email-daniel.sanders@imgtec.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.14.104]
Return-Path: <Daniel.Sanders@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.sanders@imgtec.com
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

Without this, a 'break' instruction is executed very early in the boot and
the boot hangs.

The problem is that clang doesn't honour named registers on local variables
and silently treats them as normal uninitialized variables. However, it
does honour them on global variables.

Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>
---
 arch/mips/include/asm/thread_info.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

For reference, a similar patch for ARM's stack pointer has already been merged:
  0abc08b ARM: 8170/1: Add global named register current_stack_pointer for ARM

This is part of a patch series to get Linux for Mips working when compiled with
clang. I've chosen to submit this patch individually since it's my first kernel
patch and I'd like to be sure I'm following your processes correctly before I
submit all of them.

Please CC me on replies since I'm not subscribed to the mailing list.

diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 99eea59..2a2f3c4 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -58,11 +58,11 @@ struct thread_info {
 #define init_stack		(init_thread_union.stack)
 
 /* How to get the thread information struct from C.  */
+register struct thread_info *current_gp_register asm("$28");
+
 static inline struct thread_info *current_thread_info(void)
 {
-	register struct thread_info *__current_thread_info __asm__("$28");
-
-	return __current_thread_info;
+	return current_gp_register;
 }
 
 #endif /* !__ASSEMBLY__ */
-- 
2.1.3
