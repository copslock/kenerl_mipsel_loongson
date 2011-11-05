Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2011 22:36:27 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:41288 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904178Ab1KEVdr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Nov 2011 22:33:47 +0100
Received: (qmail 28089 invoked from network); 5 Nov 2011 17:28:48 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Nov 2011 17:28:48 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 05 Nov 2011 10:28:48 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 8/9] MIPS: Add board_* hooks for ebase and NMI
Date:   Sat, 05 Nov 2011 14:21:17 -0700
Message-Id: <338065dfaf54d0ca25497eabf63a54f0@localhost>
In-Reply-To: <c2c8833593cb8eeef5c102468e105497@localhost>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4405

Certain BMIPS platforms need to move the exception vectors and/or
intercept NMI events.  Add hooks to make this possible.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/traps.h |    2 ++
 arch/mips/kernel/traps.c      |    6 ++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index 90ff2f4..2954bd9 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -22,7 +22,9 @@ extern void (*board_be_init)(void);
 extern int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 
 extern void (*board_nmi_handler_setup)(void);
+extern void (*board_nmi_handler)(struct pt_regs *regs);
 extern void (*board_ejtag_handler_setup)(void);
 extern void (*board_bind_eic_interrupt)(int irq, int regset);
+extern void (*board_ebase_setup)(void);
 
 #endif /* _ASM_TRAPS_H */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cbea618..f98349c 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -90,8 +90,10 @@ extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 void (*board_nmi_handler_setup)(void);
+void (*board_nmi_handler)(struct pt_regs *regs);
 void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
+void (*board_ebase_setup)(void);
 
 
 static void show_raw_backtrace(unsigned long reg29)
@@ -1343,6 +1345,8 @@ void ejtag_exception_handler(struct pt_regs *regs)
  */
 NORET_TYPE void ATTRIB_NORET nmi_exception_handler(struct pt_regs *regs)
 {
+	if (board_nmi_handler)
+		board_nmi_handler(regs);
 	bust_spinlocks(1);
 	printk("NMI taken!!!!\n");
 	die("NMI", regs);
@@ -1682,6 +1686,8 @@ void __init trap_init(void)
 			ebase += (read_c0_ebase() & 0x3ffff000);
 	}
 
+	if (board_ebase_setup)
+		board_ebase_setup();
 	per_cpu_trap_init();
 
 	/*
-- 
1.7.6.3
