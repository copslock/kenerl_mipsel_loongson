Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:24:20 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43577 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827297AbaA0UWWCEe6u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:22:22 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 12/58] MIPS: lib: strlen_user: Use macro to build the strlen_user symbol
Date:   Mon, 27 Jan 2014 20:18:59 +0000
Message-ID: <1390853985-14246-13-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_22_17
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39130
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

Build the __strlen_user symbol using a macro. In EVA mode we will
need to use similar code to do the userspace load operations so
it is better if we use a macro to avoid code duplications.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/strlen_user.S | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/mips/lib/strlen_user.S b/arch/mips/lib/strlen_user.S
index e362dcd..6e8bdb3 100644
--- a/arch/mips/lib/strlen_user.S
+++ b/arch/mips/lib/strlen_user.S
@@ -22,19 +22,23 @@
  *
  * Return 0 for error
  */
-LEAF(__strlen_user_asm)
+	.macro __BUILD_STRLEN_ASM func
+LEAF(__strlen_\func\()_asm)
 	LONG_L		v0, TI_ADDR_LIMIT($28)	# pointer ok?
 	and		v0, a0
-	bnez		v0, .Lfault
+	bnez		v0, .Lfault\@
 
-FEXPORT(__strlen_user_nocheck_asm)
+FEXPORT(__strlen_\func\()_nocheck_asm)
 	move		v0, a0
-1:	EX(lbu, v1, (v0), .Lfault)
+1:	EX(lbu, v1, (v0), .Lfault\@)
 	PTR_ADDIU	v0, 1
 	bnez		v1, 1b
 	PTR_SUBU	v0, a0
 	jr		ra
-	END(__strlen_user_asm)
+	END(__strlen_\func\()_asm)
 
-.Lfault:	move		v0, zero
+.Lfault\@:	move		v0, zero
 	jr		ra
+	.endm
+
+__BUILD_STRLEN_ASM user
-- 
1.8.5.3
