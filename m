Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2008 19:58:41 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:12715 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20036180AbYEUS6j (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 May 2008 19:58:39 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 89BE331A33E;
	Wed, 21 May 2008 18:58:37 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 21 May 2008 18:58:35 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.19]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 21 May 2008 11:58:12 -0700
Message-ID: <48346C45.1050608@avtrex.com>
Date:	Wed, 21 May 2008 11:39:01 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [PATCH] mips: Remove board_watchpoint_handler.
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2008 18:58:12.0106 (UTC) FILETIME=[9DF9E6A0:01C8BB74]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

mips: Remove board_watchpoint_handler.

It is not used anywhere in tree.

Signed-off-by: David Daney <ddaney@avtrex.com>
---
 arch/mips/kernel/traps.c |    6 ------
 include/asm-mips/traps.h |    1 -
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index f9165d1..6e7e4a2 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -71,7 +71,6 @@ extern asmlinkage void handle_reserved(void);
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 	struct mips_fpu_struct *ctx, int has_fpu);
 
-void (*board_watchpoint_handler)(struct pt_regs *regs);
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 void (*board_nmi_handler_setup)(void);
@@ -892,11 +891,6 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
 
 asmlinkage void do_watch(struct pt_regs *regs)
 {
-	if (board_watchpoint_handler) {
-		(*board_watchpoint_handler)(regs);
-		return;
-	}
-
 	/*
 	 * We use the watch exception where available to detect stack
 	 * overflows.
diff --git a/include/asm-mips/traps.h b/include/asm-mips/traps.h
index e5dbde6..90ff2f4 100644
--- a/include/asm-mips/traps.h
+++ b/include/asm-mips/traps.h
@@ -24,6 +24,5 @@ extern int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 extern void (*board_nmi_handler_setup)(void);
 extern void (*board_ejtag_handler_setup)(void);
 extern void (*board_bind_eic_interrupt)(int irq, int regset);
-extern void (*board_watchpoint_handler)(struct pt_regs *regs);
 
 #endif /* _ASM_TRAPS_H */
-- 
1.5.4.5
