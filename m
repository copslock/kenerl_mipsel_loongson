Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 10:59:06 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:24300 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225416AbSLSK60>;
	Thu, 19 Dec 2002 10:58:26 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 3283BD657; Thu, 19 Dec 2002 12:04:29 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: All printks in drivers/sgi/char/* have sensical tags
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 12:04:29 +0100
Message-ID: <m2znr2jmma.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        this puts a sensible tag to every printk in drivers/sgi/*
	it also remove to old enable/disable_gconsole comented code.

Later, Juan.

Index: drivers/sgi/char/graphics.c
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/graphics.c,v
retrieving revision 1.30.2.3
diff -u -r1.30.2.3 graphics.c
--- drivers/sgi/char/graphics.c	18 Dec 2002 19:11:09 -0000	1.30.2.3
+++ drivers/sgi/char/graphics.c	19 Dec 2002 10:38:05 -0000
@@ -53,12 +53,6 @@
 
 #define GRAPHICS_CARD(inode) 0
 
-/*
-void enable_gconsole(void) {};
-void disable_gconsole(void) {};
-*/
-
-
 int
 sgi_graphics_open (struct inode *inode, struct file *file)
 {
@@ -136,7 +130,7 @@
 		 * below to find our board information.
 		 */
 		if (board != devnum){
-			printk ("Parameter board does not match the current board\n");
+			printk (KERN_DEBUG "Parameter board does not match the current board\n");
 			return -EINVAL;
 		}
 
@@ -223,7 +217,7 @@
 	unsigned long virt_add, phys_add;
 
 #ifdef DEBUG
-	printk ("Got a page fault for board %d address=%lx guser=%lx\n", board,
+	printk (KERN_DEBUG"Got a page fault for board %d address=%lx guser=%lx\n", board,
 		address, (unsigned long) cards[board].g_user);
 #endif
 
@@ -325,7 +319,7 @@
 	struct graphics_ops *g;
 #endif
 
-	printk ("GFX INIT: ");
+	printk (KERN_INFO "GFX INIT: ");
 	shmiq_init ();
 	usema_init ();
 
@@ -352,18 +346,18 @@
 int init_module(void) {
 	static int initiated = 0;
 
-	printk("SGI Newport Graphics version %i.%i.%i\n",42,54,69);
+	printk(KERN_INFO "SGI Newport Graphics version %i.%i.%i\n",42,54,69);
 
 	if (!initiated++) {
 		shmiq_init();
 		usema_init();
-		printk("Adding first board\n");
+		printk(KERN_INFO "Adding first board\n");
 		boards++;
 		cards[0].g_regs = 0x1f0f0000;
 		cards[0].g_regs_size = sizeof (struct newport_regs);
 	}
 
-	printk("Boards: %d\n", boards);
+	printk(KERN_INFO "Boards: %d\n", boards);
 
 	misc_register (&dev_graphics);
 	misc_register (&dev_opengl);
@@ -372,7 +366,7 @@
 }
 
 void cleanup_module(void) {
-	printk("Shutting down SGI Newport Graphics\n");
+	printk(KERN_INFO "Shutting down SGI Newport Graphics\n");
 
 	misc_deregister (&dev_graphics);
 	misc_deregister (&dev_opengl);
Index: drivers/sgi/char/rrm.c
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/rrm.c,v
retrieving revision 1.6.2.1
diff -u -r1.6.2.1 rrm.c
--- drivers/sgi/char/rrm.c	5 Aug 2002 23:53:40 -0000	1.6.2.1
+++ drivers/sgi/char/rrm.c	19 Dec 2002 10:38:05 -0000
@@ -53,7 +53,7 @@
 	int i, rnid;
 
 	if (cmd > RRM_FUNCTIONS){
-		printk ("Called unimplemented rrm ioctl: %d\n", cmd + RRM_BASE);
+		printk (KERN_DEBUG "Called unimplemented rrm ioctl: %d\n", cmd + RRM_BASE);
 		return -EINVAL;
 	}
 	i = verify_area (VERIFY_READ, arg, rrm_functions [cmd].arg_size);
Index: drivers/sgi/char/sgiserial.c
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/Attic/sgiserial.c,v
retrieving revision 1.33.2.6
diff -u -r1.33.2.6 sgiserial.c
--- drivers/sgi/char/sgiserial.c	7 Nov 2002 01:47:46 -0000	1.33.2.6
+++ drivers/sgi/char/sgiserial.c	19 Dec 2002 10:38:07 -0000
@@ -684,7 +685,7 @@
 	save_flags(flags); cli();
 
 #ifdef SERIAL_DEBUG_OPEN
-	printk("starting up ttys%d (irq %d)...\n", info->line, info->irq);
+	printk(KERN_DEBUG "starting up ttys%d (irq %d)...\n", info->line, info->irq);
 #endif
 
 	/*
@@ -761,7 +762,7 @@
 		return;
 
 #ifdef SERIAL_DEBUG_OPEN
-	printk("Shutting down serial port %d (irq %d)....", info->line,
+	printk(KERN_DEBUG "Shutting down serial port %d (irq %d)....", info->line,
 	       info->irq);
 #endif
 
@@ -1166,7 +1167,7 @@
 #ifdef SERIAL_DEBUG_THROTTLE
 	char	buf[64];
 
-	printk("throttle %s: %d....\n", _tty_name(tty, buf),
+	printk(KERN_DEBUG "throttle %s: %d....\n", _tty_name(tty, buf),
 	       tty->ldisc.chars_in_buffer(tty));
 #endif
 
@@ -1190,7 +1191,7 @@
 #ifdef SERIAL_DEBUG_THROTTLE
 	char	buf[64];
 
-	printk("unthrottle %s: %d....\n", _tty_name(tty, buf),
+	printk(KERN_DEBUG "unthrottle %s: %d....\n", _tty_name(tty, buf),
 	       tty->ldisc.chars_in_buffer(tty));
 #endif
 
@@ -1487,7 +1488,7 @@
 	}
 
 #ifdef SERIAL_DEBUG_OPEN
-	printk("rs_close ttys%d, count = %d\n", info->line, info->count);
+	printk(KERN_DEBUG "rs_close ttys%d, count = %d\n", info->line, info->count);
 #endif
 	if ((tty->count == 1) && (info->count != 1)) {
 		/*
@@ -1497,12 +1498,12 @@
 		 * one, we've got real problems, since it means the
 		 * serial port won't be shutdown.
 		 */
-		printk("rs_close: bad serial port count; tty->count is 1, "
+		printk(KERN_DEBUG "rs_close: bad serial port count; tty->count is 1, "
 		       "info->count is %d\n", info->count);
 		info->count = 1;
 	}
 	if (--info->count < 0) {
-		printk("rs_close: bad serial port count for ttys%d: %d\n",
+		printk(KERN_DEBUG "rs_close: bad serial port count for ttys%d: %d\n",
 		       info->line, info->count);
 		info->count = 0;
 	}
@@ -1666,7 +1667,7 @@
 	retval = 0;
 	add_wait_queue(&info->open_wait, &wait);
 #ifdef SERIAL_DEBUG_OPEN
-	printk("block_til_ready before block: ttys%d, count = %d\n",
+	printk(KERN_DEBUG "block_til_ready before block: ttys%d, count = %d\n",
 	       info->line, info->count);
 #endif
 	info->count--;
@@ -1697,7 +1698,7 @@
 			break;
 		}
 #ifdef SERIAL_DEBUG_OPEN
-		printk("block_til_ready blocking: ttys%d, count = %d\n",
+		printk(KERN_DEBUG "block_til_ready blocking: ttys%d, count = %d\n",
 		       info->line, info->count);
 #endif
 		schedule();
@@ -1708,7 +1709,7 @@
 		info->count++;
 	info->blocked_open--;
 #ifdef SERIAL_DEBUG_OPEN
-	printk("block_til_ready after blocking: ttys%d, count = %d\n",
+	printk(KERN_DEBUG "block_til_ready after blocking: ttys%d, count = %d\n",
 	       info->line, info->count);
 #endif
 	if (retval)
@@ -1741,7 +1742,7 @@
 	if (serial_paranoia_check(info, tty->device, "rs_open"))
 		return -ENODEV;
 #ifdef SERIAL_DEBUG_OPEN
-	printk("rs_open %s%d, count = %d\n", tty->driver.name, info->line,
+	printk(KERN_DEBUG "rs_open %s%d, count = %d\n", tty->driver.name, info->line,
 	       info->count);
 #endif
 	info->count++;
@@ -1758,7 +1759,7 @@
 	retval = block_til_ready(tty, filp, info);
 	if (retval) {
 #ifdef SERIAL_DEBUG_OPEN
-		printk("rs_open returning after block_til_ready with %d\n",
+		printk(KERN_DEBUG "rs_open returning after block_til_ready with %d\n",
 		       retval);
 #endif
 		return retval;
@@ -1784,7 +1785,7 @@
 	info->pgrp = current->pgrp;
 
 #ifdef SERIAL_DEBUG_OPEN
-	printk("rs_open ttys%d successful...\n", info->line);
+	printk(KERN_DEBUG "rs_open ttys%d successful...\n", info->line);
 #endif
 	return 0;
 }
@@ -1793,7 +1794,7 @@
 
 static void show_serial_version(void)
 {
-	printk("SGI Zilog8530 serial driver version 1.00\n");
+	printk(KERN_INFO "SGI Zilog8530 serial driver version 1.00\n");
 }
 
 /* Return layout for the requested zs chip number. */
@@ -1842,12 +1843,12 @@
 
 	if(io) {
 		if (!msg_printed) {
-			printk("zs%d: console I/O\n", ((channel>>1)&1));
+			printk(KERN_INFO "zs%d: console I/O\n", ((channel>>1)&1));
 			msg_printed = 1;
 		}
 
 	} else {
-		printk("zs%d: console %s\n", ((channel>>1)&1),
+		printk(KERN_INFO "zs%d: console %s\n", ((channel>>1)&1),
 		       (i==1 ? "input" : (o==1 ? "output" : "WEIRD")));
 	}
 }
@@ -2014,7 +2015,7 @@
 		info->normal_termios = serial_driver.init_termios;
 		init_waitqueue_head(&info->open_wait);
 		init_waitqueue_head(&info->close_wait);
-		printk("tty%02d at 0x%04x (irq = %d)", info->line,
+		printk(KERN_INFO "tty%02d at 0x%04x (irq = %d)", info->line,
 		       info->port, info->irq);
 		printk(" is a Zilog8530\n");
 	}
@@ -2214,7 +2215,7 @@
 	info = zs_soft + con->index;
 	info->is_cons = 1;
 
-	printk("Console: ttyS%d (Zilog8530), %d baud\n",
+	printk(KERN_INFO "Console: ttyS%d (Zilog8530), %d baud\n",
 						info->line, baud);
 
 	i = con->cflag & CBAUD;
Index: drivers/sgi/char/shmiq.c
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/shmiq.c,v
retrieving revision 1.28.2.2
diff -u -r1.28.2.2 shmiq.c
--- drivers/sgi/char/shmiq.c	7 Nov 2002 01:47:46 -0000	1.28.2.2
+++ drivers/sgi/char/shmiq.c	19 Dec 2002 10:38:07 -0000
@@ -114,7 +114,7 @@
 
 	e->un.time = jiffies;
 	s->events [s->tail] = *e;
-	printk ("KERNEL: dev=%d which=%d type=%d flags=%d\n",
+	printk (KERN_INFO "KERNEL: dev=%d which=%d type=%d flags=%d\n",
 		e->data.device, e->data.which, e->data.type, e->data.flags);
 	s->tail = tail_next;
 	shmiqs [device].tail = tail_next;
@@ -174,13 +175,13 @@
 		/*
 		 * Ok, we just return the index they are providing us
 		 */
-		printk ("QIOCGETINDX: returning %d\n", *(int *)s->ic_dp);
+		printk (KERN_DEBUG "QIOCGETINDX: returning %d\n", *(int *)s->ic_dp);
 		return 0;
 
 	case QIOCIISTR: {
 		struct muxioctl *mux = (struct muxioctl *) s->ic_dp;
 
-		printk ("Double indirect ioctl: [%d, %x\n", mux->index, mux->realcmd);
+		printk (KERN_DEBUG "Double indirect ioctl: [%d, %x\n", mux->index, mux->realcmd);
 		return -EINVAL;
 	}
 
@@ -191,7 +192,7 @@
 		return 0;
 	}
 	}
-	printk ("Unknown I_STR request for shmiq device: 0x%x\n", cmd);
+	printk (KERN_DEBUG "Unknown I_STR request for shmiq device: 0x%x\n", cmd);
 	return -EINVAL;
 }
 
@@ -271,14 +276,14 @@
 			 * already been attached
 			 */
 			if (shmiqs [minor].mapped) {
-				printk("SHMIQ:The thingie is already mapped\n");
+				printk(KERN_DEBUG "SHMIQ:The thingie is already mapped\n");
 				return -EINVAL;
 			}
 
 			vaddr = (unsigned long) req.user_vaddr;
 			vma = find_vma (current->mm, vaddr);
 			if (!vma) {
-				printk ("SHMIQ: could not find %lx the vma\n",
+				printk (KERN_DEBUG "SHMIQ: could not find %lx the vma\n",
 				        vaddr);
 				return -EINVAL;
 			}
Index: drivers/sgi/char/usema.c
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/usema.c,v
retrieving revision 1.22.2.3
diff -u -r1.22.2.3 usema.c
--- drivers/sgi/char/usema.c	18 Dec 2002 19:11:09 -0000	1.22.2.3
+++ drivers/sgi/char/usema.c	19 Dec 2002 10:38:07 -0000
@@ -56,7 +56,7 @@
 	get_file(usema->filp);
 	fd_install(newfd, usema->filp);
 	/* Is that it? */
-	printk("UIOCATTACHSEMA: new usema fd is %d", newfd);
+	printk(KERN_INFO "UIOCATTACHSEMA: new usema fd is %d", newfd);
 	return newfd;
 }
 
@@ -67,7 +67,7 @@
 	struct irix_usema *usema = file->private_data;
 	int retval;
 
-	printk("[%s:%d] wants ioctl 0x%xd (arg 0x%lx)",
+	printk(KERN_INFO "[%s:%d] wants ioctl 0x%xd (arg 0x%lx)",
 	       current->comm, current->pid, cmd, arg);
 
 	switch(cmd) {
@@ -87,7 +87,7 @@
 		if (usema == 0)
 			return -EINVAL;
 
-		printk("UIOCATTACHSEMA: attaching usema %p to process %d\n",
+		printk(KERN_INFO "UIOCATTACHSEMA: attaching usema %p to process %d\n",
 		       usema, current->pid);
 		/* XXX what is attach->us_handle for? */
 		return sgi_usema_attach(attach, usema);
@@ -101,12 +101,12 @@
 
 		retval = verify_area(VERIFY_READ, attach, sizeof(usattach_t));
 		if (retval) {
-			printk("[%s:%d] sgi_usema_ioctl(UIOC*BLOCK): "
+			printk(KERN_DEBUG "[%s:%d] sgi_usema_ioctl(UIOC*BLOCK): "
 			       "verify_area failure",
 			       current->comm, current->pid);
 			return retval;
 		}
-		printk("UIOC*BLOCK: putting process %d to sleep on usema %p",
+		printk(KERN_INFO "UIOC*BLOCK: putting process %d to sleep on usema %p",
 		       current->pid, usema);
 		if (cmd == UIOCNOIBLOCK)
 			interruptible_sleep_on(&usema->proc_list);
@@ -121,13 +121,13 @@
 
 		retval = verify_area(VERIFY_READ, attach, sizeof(usattach_t));
 		if (retval) {
-			printk("[%s:%d] sgi_usema_ioctl(UIOC*BLOCK): "
+			printk(KERN_DEBUG "[%s:%d] sgi_usema_ioctl(UIOC*BLOCK): "
 			       "verify_area failure",
 			       current->comm, current->pid);
 			return retval;
 		}
 
-		printk("[%s:%d] releasing usema %p",
+		printk(KERN_DEBUG "[%s:%d] releasing usema %p",
 		       current->comm, current->pid, usema);
 		wake_up(&usema->proc_list);
 		return 0;
@@ -141,7 +141,7 @@
 {
 	struct irix_usema *usema = filp->private_data;
 
-	printk("[%s:%d] wants to poll usema %p",
+	printk(KERN_DEBUG "[%s:%d] wants to poll usema %p",
 	       current->comm, current->pid, usema);
 
 	return 0;


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
