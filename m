Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2SJJ4P13070
	for linux-mips-outgoing; Wed, 28 Mar 2001 11:19:04 -0800
Received: from boco.fee.vutbr.cz (boco.fee.vutbr.cz [147.229.9.11])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2SJJ3M13067
	for <linux-mips@oss.sgi.com>; Wed, 28 Mar 2001 11:19:03 -0800
Received: from fest.stud.fee.vutbr.cz (fest.stud.fee.vutbr.cz [147.229.9.16])
	by boco.fee.vutbr.cz (8.11.3/8.11.3) with ESMTP id f2SJJ0t58494
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified OK)
	for <linux-mips@oss.sgi.com>; Wed, 28 Mar 2001 21:19:01 +0200 (CEST)
Received: (from xmichl03@localhost)
	by fest.stud.fee.vutbr.cz (8.11.2/8.11.2) id f2SJIxe67033;
	Wed, 28 Mar 2001 21:18:59 +0200 (CEST)
From: Michl Ladislav <xmichl03@stud.fee.vutbr.cz>
Date: Wed, 28 Mar 2001 21:18:59 +0200 (CEST)
X-processed: pine.send
To: <linux-mips@oss.sgi.com>
Subject: newport console can do set_font
Message-ID: <Pine.BSF.4.33.0103282114440.66424-100000@fest.stud.fee.vutbr.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi all,

i hope this is the right place to send this. comments and corrections are
welcome.

regards,
ladis

Index: drivers/video/newport_con.c
===================================================================
RCS file: /cvs/linux/drivers/video/newport_con.c,v
retrieving revision 1.23
diff -a -u -r1.23 newport_con.c
--- drivers/video/newport_con.c	2000/11/23 02:00:54	1.23
+++ drivers/video/newport_con.c	2001/03/28 19:12:34
@@ -20,6 +20,7 @@
 #include <linux/vt_kern.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/slab.h>

 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -38,6 +39,14 @@

 #define FONT_DATA ((unsigned char *)font_vga_8x16.data)

+/* borrowed from fbcon.c */
+#define REFCOUNT(fd)	(((int *)(fd))[-1])
+#define FNTSIZE(fd)	(((int *)(fd))[-2])
+#define FNTCHARCNT(fd)	(((int *)(fd))[-3])
+#define FONT_EXTRA_WORDS 3
+
+static unsigned char *font_data[MAX_NR_CONSOLES];
+
 extern struct newport_regs *npregs;

 static int logo_active;
@@ -274,6 +283,7 @@
 static const char * __init newport_startup(void)
 #endif
 {
+    int i;
     struct newport_regs *p;

     npregs = (struct newport_regs *) (KSEG1 + 0x1f0f0000);
@@ -289,11 +299,14 @@
 	return NULL;
     }

+    for (i = 0; i < MAX_NR_CONSOLES; i++)
+        font_data[i] = FONT_DATA;
+
     newport_reset ();
     newport_get_revisions();
     newport_get_screensize();

-    // gfx_init (display_desc);
+    /* gfx_init (display_desc); */

     return "SGI Newport";
 }
@@ -329,7 +342,7 @@
 {
     unsigned char *p;

-    p = &FONT_DATA[(charattr & 0xff) << 4];
+    p = &font_data[vc->vc_num][(charattr & 0xff) << 4];
     charattr = (charattr >> 8) & 0xff;
     xpos <<= 3;
     ypos <<= 4;
@@ -378,7 +391,7 @@
 			     NPORT_DMODE0_L32);

     for (i = 0; i < count; i++, xpos += 8) {
-	p = &FONT_DATA[(s[i] & 0xff) << 4];
+	p = &font_data[vc->vc_num][(s[i] & 0xff) << 4];

 	newport_wait();

@@ -446,11 +459,82 @@
     return 1;
 }

-static int newport_font_op(struct vc_data *vc, struct console_font_op *f)
+static int newport_set_font(int unit, struct console_font_op *op)
 {
-    return -ENOSYS;
+	int w = op->width;
+	int h = op->height;
+	int size = h * op->charcount;
+	int i;
+	unsigned char *new_data, *data = op->data, *p;
+
+	/* ladis: when I grow up, there will be a day... and more sizes will
+	 * be supported ;-) */
+	if ((w != 8) || (h != 16) || (op->charcount != 256 && op->charcount != 512))
+		return -EINVAL;
+
+	if (!(new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER)))
+		return -ENOMEM;
+
+	new_data += FONT_EXTRA_WORDS * sizeof(int);
+	FNTSIZE(new_data) = size;
+	FNTCHARCNT(new_data) = op->charcount;
+	REFCOUNT(new_data) = 0; /* usage counter */
+
+	p = new_data;
+	for (i = 0; i < op->charcount; i++) {
+		memcpy(p, data, h);
+		data += 32;
+		p += h;
+        }
+
+	/* check if font is already used by other console */
+	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+		if (font_data[i] != FONT_DATA && FNTSIZE(font_data[i]) == size
+		&& !memcmp(font_data[i], new_data, size)) {
+			kfree(new_data - FONT_EXTRA_WORDS * sizeof(int));
+			/* current font is the same as the new one */
+			if (i == unit)
+				return 0;
+			new_data = font_data[i];
+			break;
+		}
+	}
+	/* old font is user font */
+	if (font_data[unit] != FONT_DATA) {
+		if (--REFCOUNT(font_data[unit]) == 0)
+			kfree(font_data[unit] - FONT_EXTRA_WORDS * sizeof(int));
+	}
+	REFCOUNT(new_data)++;
+	font_data[unit] = new_data;
+
+	return 0;
 }

+static int newport_set_def_font(int unit, struct console_font_op *op)
+{
+	if (font_data[unit] != FONT_DATA) {
+		if (--REFCOUNT(font_data[unit]) == 0)
+			kfree(font_data[unit] - FONT_EXTRA_WORDS * sizeof(int));
+		font_data[unit] = FONT_DATA;
+	}
+
+	return 0;
+}
+
+static int newport_font_op(struct vc_data *vc, struct console_font_op *op)
+{
+	int unit = vc->vc_num;
+
+	switch (op->op) {
+		case KD_FONT_OP_SET:
+			return newport_set_font(unit, op);
+		case KD_FONT_OP_SET_DEFAULT:
+			return newport_set_def_font(unit, op);
+		default:
+			return -ENOSYS;
+	}
+}
+
 static int newport_set_palette(struct vc_data *vc, unsigned char *table)
 {
     return -EINVAL;
@@ -594,21 +678,21 @@
 };

 #ifdef MODULE
-
-int init_module(void) {
-    if (!newport_startup())
-       printk("Error loading SGI Newport Console driver\n");
-    else
-       printk("Loading SGI Newport Console Driver\n");

-    take_over_console(&newport_con,0,MAX_NR_CONSOLES-1,1);
-
-    return 0;
+int init_module(void)
+{
+	if (!newport_startup())
+		printk("Error loading SGI Newport Console driver\n");
+	else
+		printk("Loading SGI Newport Console Driver\n");
+	take_over_console(&newport_con,0,MAX_NR_CONSOLES-1,1);
+	return 0;
 }

-int cleanup_module(void) {
-    printk("Unloading SGI Newport Console Driver\n");
-    return 0;
+int cleanup_module(void)
+{
+	printk("Unloading SGI Newport Console Driver\n");
+	return 0;
 }

 #endif
