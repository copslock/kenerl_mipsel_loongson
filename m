Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:32:02 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43653 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827340AbaA0UYSZCuNI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:24:18 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 35/58] MIPS: lib: csum_partial: Add EVA support
Date:   Mon, 27 Jan 2014 20:19:22 +0000
Message-ID: <1390853985-14246-36-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_24_13
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39153
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

Use EVA specific functions to read and write data to
user address space.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/csum_partial.S | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 62c8768..2e4825e 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -352,6 +352,19 @@ LEAF(csum_partial)
 		.section __ex_table,"a";	\
 		PTR	9b, handler;		\
 		.previous;			\
+	/* This is enabled in EVA mode */	\
+	.else;					\
+		/* If loading from user or storing to user */	\
+		.if ((\from == USEROP) && (type == LD_INSN)) || \
+		    ((\to == USEROP) && (type == ST_INSN));	\
+9:			__BUILD_EVA_INSN(insn##e, reg, addr);	\
+			.section __ex_table,"a";		\
+			PTR	9b, handler;			\
+			.previous;				\
+		.else;						\
+			/* EVA without exception */		\
+			insn reg, addr;				\
+		.endif;						\
 	.endif
 
 #undef LOAD
@@ -795,7 +808,19 @@ LEAF(csum_partial)
 	.endm
 
 LEAF(__csum_partial_copy_kernel)
+#ifndef CONFIG_EVA
 FEXPORT(__csum_partial_copy_to_user)
 FEXPORT(__csum_partial_copy_from_user)
+#endif
 __BUILD_CSUM_PARTIAL_COPY_USER LEGACY_MODE USEROP USEROP 1
 END(__csum_partial_copy_kernel)
+
+#ifdef CONFIG_EVA
+LEAF(__csum_partial_copy_to_user)
+__BUILD_CSUM_PARTIAL_COPY_USER EVA_MODE KERNELOP USEROP 0
+END(__csum_partial_copy_to_user)
+
+LEAF(__csum_partial_copy_from_user)
+__BUILD_CSUM_PARTIAL_COPY_USER EVA_MODE USEROP KERNELOP 0
+END(__csum_partial_copy_from_user)
+#endif
-- 
1.8.5.3
