Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9FFGc008064
	for linux-mips-outgoing; Mon, 15 Oct 2001 08:16:38 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9FFGRD08061
	for <linux-mips@oss.sgi.com>; Mon, 15 Oct 2001 08:16:29 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA22376;
	Mon, 15 Oct 2001 17:15:14 +0200 (MET DST)
Date: Mon, 15 Oct 2001 17:15:14 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: linux 2.4.9: A SysRQ fix for non-PC_KEYB configurations
Message-ID: <Pine.GSO.3.96.1011015170629.2591G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf,

 The DECstation setup doesn't compile if MAGIC_SYSRQ is enabled.  That's
because SYSRQ_KEY is undefined.  The following patch fixes the generic
configuration as well as the LK201 keyboard handler.  If any other MIPS
machine uses a non-PC keyboard, it needs to define kbd_sysrq_key as well,
to a real value, if possible.  A compilation error will reveal the need to
interested parties. 

 Please apply.  Thanks.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.9-20011009-dec-sysrq-0
diff -up --recursive --new-file linux-mips-2.4.9-20011009.macro/drivers/tc/lk201.c linux-mips-2.4.9-20011009/drivers/tc/lk201.c
--- linux-mips-2.4.9-20011009.macro/drivers/tc/lk201.c	Sat Sep 29 04:26:52 2001
+++ linux-mips-2.4.9-20011009/drivers/tc/lk201.c	Mon Oct 15 01:34:56 2001
@@ -5,12 +5,16 @@
  * for more details.
  *
  */
+#include <linux/config.h>
+
 #include <linux/errno.h>
 #include <linux/tty.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/kbd_ll.h>
+
+#include <asm/keyboard.h>
 #include <asm/wbflush.h>
 #include <asm/dec/tc.h>
 #include <asm/dec/machtype.h>
@@ -27,6 +31,8 @@
  */
 unsigned char lk201_sysrq_xlate[128];
 unsigned char *kbd_sysrq_xlate = lk201_sysrq_xlate;
+
+unsigned char kbd_sysrq_key = -1;
 #endif
 
 #define KEYB_LINE	3
diff -up --recursive --new-file linux-mips-2.4.9-20011009.macro/include/asm-mips/keyboard.h linux-mips-2.4.9-20011009/include/asm-mips/keyboard.h
--- linux-mips-2.4.9-20011009.macro/include/asm-mips/keyboard.h	Sat Sep 29 04:26:55 2001
+++ linux-mips-2.4.9-20011009/include/asm-mips/keyboard.h	Mon Oct 15 01:29:25 2001
@@ -88,6 +88,9 @@ extern int kbd_rate(struct kbd_repeat *r
 extern void kbd_init_hw(void);
 extern unsigned char *kbd_sysrq_xlate;
 
+extern unsigned char kbd_sysrq_key;
+#define SYSRQ_KEY kbd_sysrq_key
+
 #endif
 
 #endif /* __KERNEL */
