Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2011 00:17:22 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:49737 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903754Ab1LSXQz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Dec 2011 00:16:55 +0100
Received: by yenl2 with SMTP id l2so3851980yen.36
        for <multiple recipients>; Mon, 19 Dec 2011 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+Hq03BsPERqOUAKPfdDNRByY5IUctmh3ayM1IGe/1aE=;
        b=g8k3vE/h5egdlqI5J7MryC2PFS2/Pse6hlFrQgrE906VNEfGjRm6+PUR+NPCDF2WS4
         PeqpDfMCPgbYqwXoUeQgiha+xIbnyETo4e1eF9MrD3iBPRdjtFv6h+z4jBNHN5xhWab1
         osxChgBrIafiYD5rv9OOLP41t3B+UmMKHq1yM=
Received: by 10.236.161.103 with SMTP id v67mr31104151yhk.87.1324336609304;
        Mon, 19 Dec 2011 15:16:49 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id v15sm18762839anq.4.2011.12.19.15.16.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 15:16:48 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBJNGkog029853;
        Mon, 19 Dec 2011 15:16:46 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBJNGkXF029852;
        Mon, 19 Dec 2011 15:16:46 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/5] MIPS: Introduce board_cache_error_setup() hook.
Date:   Mon, 19 Dec 2011 15:16:38 -0800
Message-Id: <1324336602-29812-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1324336602-29812-1-git-send-email-ddaney.cavm@gmail.com>
References: <1324336602-29812-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15605

From: David Daney <david.daney@cavium.com>

This is used in subsequent patches.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/traps.h |    1 +
 arch/mips/kernel/traps.c      |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index 90ff2f4..d4d0e76 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -24,5 +24,6 @@ extern int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 extern void (*board_nmi_handler_setup)(void);
 extern void (*board_ejtag_handler_setup)(void);
 extern void (*board_bind_eic_interrupt)(int irq, int regset);
+extern void (*board_cache_error_setup)(void);
 
 #endif /* _ASM_TRAPS_H */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 363c476..f305c04 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -91,7 +91,7 @@ int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 void (*board_nmi_handler_setup)(void);
 void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
-
+void __cpuinitdata(*board_cache_error_setup)(void);
 
 static void show_raw_backtrace(unsigned long reg29)
 {
@@ -1786,6 +1786,9 @@ void __init trap_init(void)
 
 	set_except_vector(26, handle_dsp);
 
+	if (board_cache_error_setup)
+		board_cache_error_setup();
+
 	if (cpu_has_vce)
 		/* Special exception: R4[04]00 uses also the divec space. */
 		memcpy((void *)(ebase + 0x180), &except_vec3_r4000, 0x100);
-- 
1.7.2.3
