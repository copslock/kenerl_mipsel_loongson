Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2014 16:16:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20441 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861529AbaGUNgUjlvj0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Jul 2014 15:36:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3D7EE2C2D4E8E
        for <linux-mips@linux-mips.org>; Mon, 21 Jul 2014 14:36:11 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 21 Jul 2014 14:36:13 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.145) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 21 Jul 2014 14:36:13 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/3] MIPS: Malta: EVA: Rename 'eva_entry' to 'platform_eva_init'
Date:   Mon, 21 Jul 2014 14:35:55 +0100
Message-ID: <1405949756-10427-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405949756-10427-1-git-send-email-markos.chandras@imgtec.com>
References: <1405949756-10427-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.145]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41359
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

Rename 'eva_entry' to 'platform_eva_init' as required by the new
'eva_init' macro in the eva.h header. Since this macro is now used
in a platform dependent way, it must not depend on its caller so move
the t1 register initialization inside this macro. Also set the .reorder
assembler option in case the caller may have previously set .noreorder.
This may allow a few assembler optimizations. Finally include missing
headers and document the register usage for this macro.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 .../include/asm/mach-malta/kernel-entry-init.h     | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mach-malta/kernel-entry-init.h b/arch/mips/include/asm/mach-malta/kernel-entry-init.h
index 77eeda77e73c..0cf8622db27f 100644
--- a/arch/mips/include/asm/mach-malta/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-malta/kernel-entry-init.h
@@ -10,14 +10,15 @@
 #ifndef __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
 #define __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
 
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+
 	/*
 	 * Prepare segments for EVA boot:
 	 *
 	 * This is in case the processor boots in legacy configuration
 	 * (SI_EVAReset is de-asserted and CONFIG5.K == 0)
 	 *
-	 * On entry, t1 is loaded with CP0_CONFIG
-	 *
 	 * ========================= Mappings =============================
 	 * Virtual memory           Physical memory           Mapping
 	 * 0x00000000 - 0x7fffffff  0x80000000 - 0xfffffffff   MUSUK (kuseg)
@@ -30,12 +31,20 @@
 	 *
 	 *
 	 * Lowmem is expanded to 2GB
+	 *
+	 * The following code uses the t0, t1, t2 and ra registers without
+	 * previously preserving them.
+	 *
 	 */
-	.macro	eva_entry
+	.macro	platform_eva_init
+
+	.set	push
+	.set	reorder
 	/*
 	 * Get Config.K0 value and use it to program
 	 * the segmentation registers
 	 */
+	mfc0    t1, CP0_CONFIG
 	andi	t1, 0x7 /* CCA */
 	move	t2, t1
 	ins	t2, t1, 16, 3
@@ -77,6 +86,8 @@
 	mtc0    t0, $16, 5
 	sync
 	jal	mips_ihb
+
+	.set	pop
 	.endm
 
 	.macro	kernel_entry_setup
@@ -95,7 +106,7 @@
 	sll     t0, t0, 6   /* SC bit */
 	bgez    t0, 9f
 
-	eva_entry
+	platform_eva_init
 	b       0f
 9:
 	/* Assume we came from YAMON... */
@@ -127,8 +138,7 @@ nonsc_processor:
 #ifdef CONFIG_EVA
 	sync
 	ehb
-	mfc0    t1, CP0_CONFIG
-	eva_entry
+	platform_eva_init
 #endif
 	.endm
 
-- 
2.0.0
