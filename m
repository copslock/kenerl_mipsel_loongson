Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 07:43:38 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:46118 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903960Ab1KKGlS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 07:41:18 +0100
Received: (qmail 16063 invoked from network); 11 Nov 2011 06:41:07 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Nov 2011 06:41:07 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Thu, 10 Nov 2011 22:41:07 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH V2 7/8] MIPS: Add board_ebase_setup()
Date:   Thu, 10 Nov 2011 22:30:30 -0800
Message-Id: <154fd216c3014f6bf574885a05f9f9a9@localhost>
In-Reply-To: <5f9666eb295ce196b2a9688afab07dea@localhost>
References: <5f9666eb295ce196b2a9688afab07dea@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10048

Some systems need to relocate the MIPS exception vector base during
trap initialization.  Add a hook to make this possible.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/traps.h |    1 +
 arch/mips/kernel/traps.c      |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index 4edab87..ff74aec 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -24,6 +24,7 @@ extern int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 extern void (*board_nmi_handler_setup)(void);
 extern void (*board_ejtag_handler_setup)(void);
 extern void (*board_bind_eic_interrupt)(int irq, int regset);
+extern void (*board_ebase_setup)(void);
 
 extern int register_nmi_notifier(struct notifier_block *nb);
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 33945aa..c18dfd4 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -91,6 +91,7 @@ int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 void (*board_nmi_handler_setup)(void);
 void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
+void (*board_ebase_setup)(void);
 
 
 static void show_raw_backtrace(unsigned long reg29)
@@ -1691,6 +1692,8 @@ void __init trap_init(void)
 			ebase += (read_c0_ebase() & 0x3ffff000);
 	}
 
+	if (board_ebase_setup)
+		board_ebase_setup();
 	per_cpu_trap_init();
 
 	/*
-- 
1.7.6.3
