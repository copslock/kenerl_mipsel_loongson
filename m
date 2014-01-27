Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:22:42 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43569 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823911AbaA0UVKgHPZx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:21:10 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 07/58] MIPS: kernel: scall32-o32: Use EVA wrappers to fetch syscall arguments
Date:   Mon, 27 Jan 2014 20:18:54 +0000
Message-ID: <1390853985-14246-8-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_21_05
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Arguments 4-8 are stored on user's stack, so use the EVA instructions
to fetch them if EVA is enabled.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/scall32-o32.S | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index e8e541b..2fae6eb 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -6,6 +6,7 @@
  * Copyright (C) 1995-99, 2000- 02, 06 Ralf Baechle <ralf@linux-mips.org>
  * Copyright (C) 2001 MIPS Technologies, Inc.
  * Copyright (C) 2004 Thiemo Seufer
+ * Copyright (C) 2014 Imagination Technologies Ltd.
  */
 #include <linux/errno.h>
 #include <asm/asm.h>
@@ -74,10 +75,10 @@ NESTED(handle_sys, PT_SIZE, sp)
 	.set    noreorder
 	.set	nomacro
 
-1:	lw	t5, 16(t0)		# argument #5 from usp
-4:	lw	t6, 20(t0)		# argument #6 from usp
-3:	lw	t7, 24(t0)		# argument #7 from usp
-2:	lw	t8, 28(t0)		# argument #8 from usp
+1:	user_lw(t5, 16(t0))		# argument #5 from usp
+4:	user_lw(t6, 20(t0))		# argument #6 from usp
+3:	user_lw(t7, 24(t0))		# argument #7 from usp
+2:	user_lw(t8, 28(t0))		# argument #8 from usp
 
 	sw	t5, 16(sp)		# argument #5 to ksp
 	sw	t6, 20(sp)		# argument #6 to ksp
-- 
1.8.5.3
