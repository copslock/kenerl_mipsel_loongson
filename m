Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 07:43:16 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:46110 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903959Ab1KKGlP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 07:41:15 +0100
Received: (qmail 16058 invoked from network); 11 Nov 2011 06:41:04 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Nov 2011 06:41:04 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Thu, 10 Nov 2011 22:41:04 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH V2 6/8] MIPS: Add NMI notifier
Date:   Thu, 10 Nov 2011 22:30:29 -0800
Message-Id: <598dabc28eb6fdbd820ea80c0a57e87d@localhost>
In-Reply-To: <5f9666eb295ce196b2a9688afab07dea@localhost>
References: <5f9666eb295ce196b2a9688afab07dea@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10047

Allow the board support code to register a raw notifier callback for
NMI, similar to what is done for CU2 exceptions.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---

V2:

Use a raw notifier instead of a function pointer for NMI events.


 arch/mips/include/asm/traps.h |   12 ++++++++++++
 arch/mips/kernel/traps.c      |    9 +++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index 90ff2f4..4edab87 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -25,4 +25,16 @@ extern void (*board_nmi_handler_setup)(void);
 extern void (*board_ejtag_handler_setup)(void);
 extern void (*board_bind_eic_interrupt)(int irq, int regset);
 
+extern int register_nmi_notifier(struct notifier_block *nb);
+
+#define nmi_notifier(fn, pri)						\
+({									\
+	static struct notifier_block fn##_nb = {			\
+		.notifier_call = fn,					\
+		.priority = pri						\
+	};								\
+									\
+	register_nmi_notifier(&fn##_nb);				\
+})
+
 #endif /* _ASM_TRAPS_H */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 5c8a49d..33945aa 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1339,9 +1339,18 @@ void ejtag_exception_handler(struct pt_regs *regs)
 
 /*
  * NMI exception handler.
+ * No lock; only written during early bootup by CPU 0.
  */
+static RAW_NOTIFIER_HEAD(nmi_chain);
+
+int register_nmi_notifier(struct notifier_block *nb)
+{
+	return raw_notifier_chain_register(&nmi_chain, nb);
+}
+
 NORET_TYPE void ATTRIB_NORET nmi_exception_handler(struct pt_regs *regs)
 {
+	raw_notifier_call_chain(&nmi_chain, 0, regs);
 	bust_spinlocks(1);
 	printk("NMI taken!!!!\n");
 	die("NMI", regs);
-- 
1.7.6.3
