Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9SLLFg06240
	for linux-mips-outgoing; Sun, 28 Oct 2001 13:21:15 -0800
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9SLL5006237;
	Sun, 28 Oct 2001 13:21:06 -0800
Received: from dev1 (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with ESMTP
	id D65FB590B4; Sun, 28 Oct 2001 12:18:02 -0500 (EST)
Received: from brad by dev1 with local (Exim 3.32 #1 (Debian))
	id 15xxMA-00030D-00; Sun, 28 Oct 2001 16:20:34 -0500
Date: Sun, 28 Oct 2001 16:20:34 -0500
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: PATCH: keyboard share irqs
Message-ID: <20011028162034.A11542@dev1.ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: "Bradley D. LaRonde" <brad@ltc.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

2001-10-28  Bradley D. LaRonde <brad@ltc.com>

- Allow sharing of keyboard/aux irqs.
- Add Rockhopper BB 2.0 keyboard suport.

--- arch/mips/lib/kbd-std.c	2001/09/06 13:12:02	1.5
+++ arch/mips/lib/kbd-std.c	2001/10/28 21:16:53
@@ -7,14 +7,20 @@
  *
  * Copyright (C) 1998, 1999 by Ralf Baechle
  */
+#include <linux/config.h>
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/pc_keyb.h>
 #include <asm/keyboard.h>
 #include <asm/io.h>
 
-#define KEYBOARD_IRQ 1
-#define AUX_IRQ 12
+#ifdef CONFIG_DDB5477
+#define KEYBOARD_IRQ  18
+#define AUX_IRQ       KEYBOARD_IRQ
+#else
+#define KEYBOARD_IRQ  1
+#define AUX_IRQ       12
+#endif
 
 static void std_kbd_request_region(void)
 {
@@ -27,17 +33,17 @@
 
 static int std_kbd_request_irq(void (*handler)(int, void *, struct pt_regs *))
 {
-	return request_irq(KEYBOARD_IRQ, handler, 0, "keyboard", NULL);
+	return request_irq(KEYBOARD_IRQ, handler, SA_SHIRQ, "keyboard", &std_kbd_request_irq);
 }
 
 static int std_aux_request_irq(void (*handler)(int, void *, struct pt_regs *))
 {
-	return request_irq(AUX_IRQ, handler, 0, "PS/2 Mouse", NULL);
+	return request_irq(AUX_IRQ, handler, SA_SHIRQ, "PS/2 Mouse", &std_aux_request_irq);
 }
 
 static void std_aux_free_irq(void)
 {
-	free_irq(AUX_IRQ, NULL);
+	free_irq(AUX_IRQ, &std_aux_request_irq);
 }
 
 static unsigned char std_kbd_read_input(void)
