Received:  by oss.sgi.com id <S42464AbQJCKfk>;
	Tue, 3 Oct 2000 03:35:40 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:28128 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42201AbQJCKfV>;
	Tue, 3 Oct 2000 03:35:21 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA09851;
	Tue, 3 Oct 2000 12:34:15 +0200 (MET DST)
Date:   Tue, 3 Oct 2000 12:34:14 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
In-Reply-To: <Pine.LNX.4.10.10010011140080.377-100000@cassiopeia.home>
Message-ID: <Pine.GSO.3.96.1001003123227.8359F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, 1 Oct 2000, Geert Uytterhoeven wrote:

> > tty00 at 0xbf900001 (irq = 4) is a Z85C30 SCC
> > tty01 at 0xbf900009 (irq = 4) is a Z85C30 SCC
> > tty02 at 0xbf980001 (irq = 4) is a Z85C30 SCC
> > tty03 at 0xbf980009 (irq = 4) is a Z85C30 SCC
> 
> Shouldn't these be reported as ttyS0[0-3]?

 Ralf, could you please apply?  Thanks.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -u --recursive --new-file linux-mips-2.4.0-test7-20000829.macro/drivers/char/dz.c linux-mips-2.4.0-test7-20000829/drivers/char/dz.c
--- linux-mips-2.4.0-test7-20000829.macro/drivers/char/dz.c	Fri Jun 30 04:26:16 2000
+++ linux-mips-2.4.0-test7-20000829/drivers/char/dz.c	Mon Oct  2 22:27:38 2000
@@ -1047,7 +1047,7 @@
   }
 
   if (--info->count < 0) {
-    printk("ds_close: bad serial port count for ttys%d: %d\n",
+    printk("ds_close: bad serial port count for ttyS%02d: %d\n",
 	   info->line, info->count);
     info->count = 0;
   }
@@ -1379,7 +1379,7 @@
     if (! info->port)
       return 0;
 
-    printk("ttyS%02d at 0x%04x (irq = %d)\n", info->line, info->port, SERIAL);
+    printk("ttyS%02d at 0x%08x (irq = %d)\n", info->line, info->port, SERIAL);
   }
 
   /* reset the chip */
diff -u --recursive --new-file linux-mips-2.4.0-test7-20000829.macro/drivers/tc/zs.c linux-mips-2.4.0-test7-20000829/drivers/tc/zs.c
--- linux-mips-2.4.0-test7-20000829.macro/drivers/tc/zs.c	Fri Aug 11 04:26:34 2000
+++ linux-mips-2.4.0-test7-20000829/drivers/tc/zs.c	Mon Oct  2 22:25:15 2000
@@ -623,7 +623,7 @@
 	save_flags(flags); cli();
 
 #ifdef SERIAL_DEBUG_OPEN
-	printk("starting up ttyS%d (irq %d)...", info->line, info->irq);
+	printk("starting up ttyS%02d (irq %d)...", info->line, info->irq);
 #endif
 
 	/*
@@ -1258,7 +1258,7 @@
 	}
 	
 #ifdef SERIAL_DEBUG_OPEN
-	printk("rs_close ttys%d, count = %d\n", info->line, info->count);
+	printk("rs_close ttyS%02d, count = %d\n", info->line, info->count);
 #endif
 	if ((tty->count == 1) && (info->count != 1)) {
 		/*
@@ -1273,7 +1273,7 @@
 		info->count = 1;
 	}
 	if (--info->count < 0) {
-		printk("rs_close: bad serial port count for ttys%d: %d\n",
+		printk("rs_close: bad serial port count for ttyS%02d: %d\n",
 		       info->line, info->count);
 		info->count = 0;
 	}
@@ -1463,7 +1463,7 @@
 	retval = 0;
 	add_wait_queue(&info->open_wait, &wait);
 #ifdef SERIAL_DEBUG_OPEN
-	printk("block_til_ready before block: ttys%d, count = %d\n",
+	printk("block_til_ready before block: ttyS%02d, count = %d\n",
 	       info->line, info->count);
 #endif
 	cli();
@@ -1499,7 +1499,7 @@
 			break;
 		}
 #ifdef SERIAL_DEBUG_OPEN
-		printk("block_til_ready blocking: ttys%d, count = %d\n",
+		printk("block_til_ready blocking: ttyS%02d, count = %d\n",
 		       info->line, info->count);
 #endif
 		schedule();
@@ -1510,7 +1510,7 @@
 		info->count++;
 	info->blocked_open--;
 #ifdef SERIAL_DEBUG_OPEN
-	printk("block_til_ready after blocking: ttys%d, count = %d\n",
+	printk("block_til_ready after blocking: ttyS%02d, count = %d\n",
 	       info->line, info->count);
 #endif
 	if (retval)
@@ -1600,7 +1600,7 @@
 	info->pgrp = current->pgrp;
 
 #ifdef SERIAL_DEBUG_OPEN
-	printk("rs_open ttys%d successful...", info->line);
+	printk("rs_open ttyS%02d successful...", info->line);
 #endif
 /* tty->low_latency = 1; */
 	return 0;
@@ -1817,7 +1817,7 @@
 		info->normal_termios = serial_driver.init_termios;
 		init_waitqueue_head(&info->open_wait);
 		init_waitqueue_head(&info->close_wait);
-		printk("tty%02d at 0x%08x (irq = %d)", info->line, 
+		printk("ttyS%02d at 0x%08x (irq = %d)", info->line, 
 		       info->port, info->irq);
 		printk(" is a Z85C30 SCC\n");
 	}
