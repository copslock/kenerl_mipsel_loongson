Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MNS1Rw008151
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 16:28:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MNS1CR008150
	for linux-mips-outgoing; Mon, 22 Jul 2002 16:28:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MNRmRw008141
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 16:27:48 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA30300;
	Mon, 22 Jul 2002 16:28:37 -0700
Message-ID: <3D3C932F.1010508@mvista.com>
Date: Mon, 22 Jul 2002 16:20:15 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: [PATCH] Let kgdb work on Malta
Content-Type: multipart/mixed;
 boundary="------------030603000101050706010407"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------030603000101050706010407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Applies to both 2.4 & 2.5.  (The offset warning is OK)

Jun


--------------030603000101050706010407
Content-Type: text/plain;
 name="malta-kgdb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="malta-kgdb.patch"

diff -Nru linux/arch/mips/mips-boards/malta/malta_setup.c.orig linux/arch/mips/mips-boards/malta/malta_setup.c
--- linux/arch/mips/mips-boards/malta/malta_setup.c.orig	Mon Jul 22 10:45:56 2002
+++ linux/arch/mips/mips-boards/malta/malta_setup.c	Mon Jul 22 16:16:18 2002
@@ -50,10 +50,8 @@
 #endif
 
 #ifdef CONFIG_REMOTE_DEBUG
-extern void set_debug_traps(void);
 extern void rs_kgdb_hook(int);
-extern void breakpoint(void);
-static int remote_debug = 0;
+int remote_debug = 0;
 #endif
 
 extern struct ide_ops std_ide_ops;
@@ -63,9 +61,6 @@
 
 extern void mips_reboot_setup(void);
 
-extern void (*board_time_init)(void);
-extern void (*board_timer_setup)(struct irqaction *irq);
-extern unsigned long (*rtc_get_time)(void);
 extern void mips_time_init(void);
 extern void mips_timer_setup(struct irqaction *irq);
 extern unsigned long mips_rtc_get_time(void);
@@ -84,8 +79,8 @@
 #ifdef CONFIG_REMOTE_DEBUG
 	int rs_putDebugChar(char);
 	char rs_getDebugChar(void);
-	extern int (*putDebugChar)(char);
-	extern char (*getDebugChar)(void);
+	extern int (*generic_putDebugChar)(char);
+	extern char (*generic_getDebugChar)(void);
 #endif
 	char *argptr;
 	int i;
@@ -120,8 +115,8 @@
 		       line ? 1 : 0);
 
 		rs_kgdb_hook(line);
-		putDebugChar = rs_putDebugChar;
-		getDebugChar = rs_getDebugChar;
+		generic_putDebugChar = rs_putDebugChar;
+		generic_getDebugChar = rs_getDebugChar;
 
 		prom_printf("KGDB: Using serial line /dev/ttyS%d for session, "
 			    "please connect your debugger\n", line ? 1 : 0);
diff -Nru linux/arch/mips/mips-boards/malta/malta_int.c.orig linux/arch/mips/mips-boards/malta/malta_int.c
--- linux/arch/mips/mips-boards/malta/malta_int.c.orig	Mon Jul 22 10:12:44 2002
+++ linux/arch/mips/mips-boards/malta/malta_int.c	Mon Jul 22 14:25:47 2002
@@ -40,8 +40,16 @@
 
 extern asmlinkage void mipsIRQ(void);
 extern asmlinkage void do_IRQ(int irq, struct pt_regs *regs);
+
+extern void init_generic_irq();
 extern void init_i8259_irqs (void);
 
+#ifdef CONFIG_REMOTE_DEBUG
+extern void breakpoint(void);
+extern void set_debug_traps(void);
+extern int remote_debug;
+#endif
+
 void enable_mips_irq(unsigned int irq);
 void disable_mips_irq(unsigned int irq);
 

--------------030603000101050706010407--
