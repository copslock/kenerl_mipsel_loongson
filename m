Received:  by oss.sgi.com id <S42311AbQHYJEg>;
	Fri, 25 Aug 2000 02:04:36 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:58763 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42304AbQHYJEF>;
	Fri, 25 Aug 2000 02:04:05 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA08056;
	Fri, 25 Aug 2000 11:02:58 +0200 (MET DST)
Date:   Fri, 25 Aug 2000 11:02:57 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
cc:     Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: [PATCH] dz.c: cleanups, getting rid of panic and suser (fwd)
Message-ID: <Pine.GSO.3.96.1000825110048.7175B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

 Here is what I got from linux-kernel today.  I thought someone might be
interested.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

---------- Forwarded message ----------
Message-ID: <20000824194303.B3047@conectiva.com.br>
Date: Thu, 24 Aug 2000 19:43:03 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Olivier A.D.Lebaillif" <olivier.lebaillif@ifrsys.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dz.c: cleanups, getting rid of panic and suser

Hi,

   Please take a look and consider applying.

                        - Arnaldo

--- linux-2.4.0-test7/drivers/char/dz.c	Mon Jun 26 22:03:05 2000
+++ linux-2.4.0-test7.acme/drivers/char/dz.c	Thu Aug 24 19:41:53 2000
@@ -17,6 +17,10 @@
  *  
  * Parts (C) 1999 David Airlie, airlied@linux.ie 
  * [07-SEP-99] Bugfixes 
+ *
+ * Arnaldo Carvalho de Melo <acme@conectiva.com.br> 08/23/2000
+ * - get rid of verify_area, panics and suser, using !capable(CAP_SYS_ADMIN) now
+ * - include missing restore_flags in dz_init
  */
 
 #define DEBUG_DZ 1
@@ -844,14 +848,16 @@
   struct dz_serial old_info;
   int retval = 0;
 
+  if (!capable(CAP_SYS_ADMIN))
+    return -EPERM;
+
   if (!new_info)
     return -EFAULT;
 
-  copy_from_user (&new_serial, new_info, sizeof(new_serial));
-  old_info = *info;
+  if (copy_from_user(&new_serial, new_info, sizeof(new_serial)))
+	  return -EFAULT;
 
-  if (!suser())
-    return -EPERM;
+  old_info = *info;
 
   if (info->count > 1)
     return -EBUSY;
@@ -919,7 +925,6 @@
 
 static int dz_ioctl (struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
 {
-  int error;
   struct dz_serial * info = (struct dz_serial *)tty->driver_data;
   int retval;
 
@@ -949,40 +954,30 @@
     return 0;
 
   case TIOCGSOFTCAR:
-    error = verify_area (VERIFY_WRITE, (void *)arg, sizeof(long));
-    if (error)
-      return error;
-    put_user (C_CLOCAL(tty) ? 1 : 0, (unsigned long *)arg);
-    return 0;
+    return put_user (C_CLOCAL(tty) ? 1 : 0, (unsigned long *)arg);
 
   case TIOCSSOFTCAR:
-    error = get_user (arg, (unsigned long *)arg);
-    if (error)
-      return error;
+    if (get_user (arg, (unsigned long *)arg))
+	    return -EFAULT;
     tty->termios->c_cflag = ((tty->termios->c_cflag & ~CLOCAL) | (arg ? CLOCAL : 0));
     return 0;
 
   case TIOCGSERIAL:
-    error = verify_area (VERIFY_WRITE, (void *)arg, sizeof(struct serial_struct));
-    if (error)
-      return error;
+    if (verify_area (VERIFY_WRITE, (void *)arg, sizeof(struct serial_struct)))
+	    return -EFAULT;
     return get_serial_info (info, (struct serial_struct *)arg);
 
   case TIOCSSERIAL:
     return set_serial_info (info, (struct serial_struct *) arg);
 
   case TIOCSERGETLSR: /* Get line status register */
-    error = verify_area (VERIFY_WRITE, (void *)arg, sizeof(unsigned int));
-    if (error)
-      return error;
-    else
-      return get_lsr_info (info, (unsigned int *)arg);
+    if (verify_area (VERIFY_WRITE, (void *)arg, sizeof(unsigned int)))
+	    return -EFAULT;
+    return get_lsr_info (info, (unsigned int *)arg);
 
   case TIOCSERGSTRUCT:
-    error = verify_area (VERIFY_WRITE, (void *)arg, sizeof(struct dz_serial));
-    if (error)
-      return error;
-    copy_to_user((struct dz_serial *)arg, info, sizeof(struct dz_serial));
+    if (copy_to_user((struct dz_serial *)arg, info, sizeof(struct dz_serial)))
+	    return -EFAULT;
     return 0;
     
   default:
@@ -1290,7 +1285,7 @@
 
 int __init dz_init(void)
 {
-  int i, flags;
+  int i, flags, ret;
   struct dz_serial *info;
 
   /* Setup base handler, and timer table. */
@@ -1340,10 +1335,16 @@
   callout_driver.major = TTYAUX_MAJOR;
   callout_driver.subtype = SERIAL_TYPE_CALLOUT;
 
-  if (tty_register_driver (&serial_driver))
-    panic("Couldn't register serial driver\n");
-  if (tty_register_driver (&callout_driver))
-    panic("Couldn't register callout driver\n");
+  ret = tty_register_driver (&serial_driver);
+  if (ret) {
+	printk(KERN_ERR "Couldn't register serial driver\n");
+	return ret;
+  }
+  ret = tty_register_driver (&callout_driver);
+  if (ret) {
+	printk(KERN_ERR "Couldn't register callout driver\n");
+	goto cleanup_serial_driver;
+  }
   save_flags(flags); cli();
  
   for (i=0; i < DZ_NB_PORT;  i++)  
@@ -1376,8 +1377,10 @@
 
     /* If we are pointing to address zero then punt - not correctly
        set up in setup.c to handle this. */
-    if (! info->port)
+    if (!info->port) {
+      restore_flags(flags);
       return 0;
+    }
 
     printk("ttyS%02d at 0x%04x (irq = %d)\n", info->line, info->port, SERIAL);
   }
@@ -1396,12 +1399,17 @@
      is updated... in request_irq - to immediatedly obliterate
      it is unwise. */
   restore_flags(flags);
- 
 
-  if (request_irq (SERIAL, dz_interrupt, SA_INTERRUPT, "DZ", lines[0]))
-    panic ("Unable to register DZ interrupt\n");
+  if (request_irq (SERIAL, dz_interrupt, SA_INTERRUPT, "DZ", lines[0])) {
+    printk(KERN_ERR "Unable to register DZ interrupt\n");
+    ret = -EBUSY;
+    goto cleanup_callout_driver;
+  }
  
   return 0;
+cleanup_callout_driver:	tty_unregister_driver(&callout_driver);
+cleanup_serial_driver:	tty_unregister_driver(&serial_driver);
+  return ret;
 }
 
 #ifdef CONFIG_SERIAL_CONSOLE
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
