Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:36:54 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:49892 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225316AbSLRBgx>;
	Wed, 18 Dec 2002 01:36:53 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id A5224D657; Wed, 18 Dec 2002 02:42:48 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: Use C99 struct initializers in ip22 code
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:42:48 +0100
Message-ID: <m2pts0qezr.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        switch to C99 declarations in ip22 code. note that some of the
        structs was already initialized that way.

        There are also two printk labels in the middle.

Later, Juan.

Index: arch/mips/sgi-ip22/ip22-eisa.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-eisa.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 ip22-eisa.c
--- arch/mips/sgi-ip22/ip22-eisa.c	23 Jul 2002 16:39:10 -0000	1.1.2.1
+++ arch/mips/sgi-ip22/ip22-eisa.c	18 Dec 2002 00:49:19 -0000
@@ -153,14 +153,13 @@
 }
 
 static struct hw_interrupt_type ip22_eisa1_irq_type = {
-	"IP22 EISA",
-	startup_eisa1_irq,
-	shutdown_eisa1_irq,
-	enable_eisa1_irq,
-	disable_eisa1_irq,
-	mask_and_ack_eisa1_irq,
-	end_eisa1_irq,
-	NULL
+	.typename	= "IP22 EISA",
+	.startup	= startup_eisa1_irq,
+	.shutdown	= shutdown_eisa1_irq,
+	.enable		= enable_eisa1_irq,
+	.disable	= disable_eisa1_irq,
+	.ack		= mask_and_ack_eisa1_irq,
+	.end		= end_eisa1_irq,
 };
 
 static void enable_eisa2_irq(unsigned int irq)
@@ -217,22 +216,23 @@
 }
 
 static struct hw_interrupt_type ip22_eisa2_irq_type = {
-	"IP22 EISA",
-	startup_eisa2_irq,
-	shutdown_eisa2_irq,
-	enable_eisa2_irq,
-	disable_eisa2_irq,
-	mask_and_ack_eisa2_irq,
-	end_eisa2_irq,
-	NULL
+	.typename	= "IP22 EISA",
+	.startup	= startup_eisa2_irq,
+	.shutdown	= shutdown_eisa2_irq,
+	.enable		= enable_eisa2_irq,
+	.disable	= disable_eisa2_irq,
+	.ack		= mask_and_ack_eisa2_irq,
+	.end		= end_eisa2_irq,
 };
 
 static struct irqaction eisa_action = {
-	ip22_eisa_intr, 0, 0, "EISA", NULL, NULL
+	.handler	= ip22_eisa_intr,
+	.name		= "EISA",
 };
 
 static struct irqaction cascade_action = {
-	no_action, 0, 0, "EISA cascade", NULL, NULL
+	.handler	= no_action,
+	.name		= "EISA cascade",
 };
 
 int __init ip22_eisa_init(void)
Index: arch/mips/sgi-ip22/ip22-gio.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-gio.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 ip22-gio.c
--- arch/mips/sgi-ip22/ip22-gio.c	5 Aug 2002 23:53:35 -0000	1.1.2.3
+++ arch/mips/sgi-ip22/ip22-gio.c	18 Dec 2002 00:49:19 -0000
@@ -27,41 +27,25 @@
 
 #define GIO_NO_DEVICE		0x80
 
-static struct gio_dev gio_slot[GIO_NUM_SLOTS] = {
-	{
-		0,
-		0,
-		0,
-		GIO_NO_DEVICE,
-		GIO_SLOT_GFX,
-		GIO_ADDR_GFX,
-		GIO_GFX_MAP_SIZE,
-		NULL,
-		"GFX"
-	},
-	{
-		0,
-		0,
-		0,
-		GIO_NO_DEVICE,
-		GIO_SLOT_GIO1,
-		GIO_ADDR_GIO1,
-		GIO_GIO1_MAP_SIZE,
-		NULL,
-		"EXP0"
-	},
-	{
-		0,
-		0,
-		0,
-		GIO_NO_DEVICE,
-		GIO_SLOT_GIO2,
-		GIO_ADDR_GIO2,
-		GIO_GIO2_MAP_SIZE,
-		NULL,
-		"EXP1"
-	}
-};
+static struct gio_dev gio_slot[GIO_NUM_SLOTS] = {{
+	.flags		= GIO_NO_DEVICE,
+	.slot_number	= GIO_SLOT_GFX,
+	.base_addr	= GIO_ADDR_GFX,
+	.map_size	= GIO_GFX_MAP_SIZE,
+	.slot_name	= "GFX",
+}, {
+	.flags		= GIO_NO_DEVICE,
+	.slot_number	= GIO_SLOT_GIO1,
+	.base_addr	= GIO_ADDR_GIO1,
+	.map_size	= GIO_GIO1_MAP_SIZE,
+	.slot_name	= "EXP0",
+}, {
+	.flags		= GIO_NO_DEVICE,
+	.slot_number	= GIO_SLOT_GIO2,
+	.base_addr	= GIO_ADDR_GIO2,
+	.map_size	= GIO_GIO2_MAP_SIZE,
+	.slot_name	= "EXP1"
+}};
 
 static int gio_read_proc(char *buf, char **start, off_t off,
 			 int count, int *eof, void *data)
Index: arch/mips/sgi-ip22/ip22-int.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-int.c,v
retrieving revision 1.2.2.6
diff -u -r1.2.2.6 ip22-int.c
--- arch/mips/sgi-ip22/ip22-int.c	5 Aug 2002 23:53:35 -0000	1.2.2.6
+++ arch/mips/sgi-ip22/ip22-int.c	18 Dec 2002 00:49:19 -0000
@@ -79,14 +79,13 @@
 }
 
 static struct hw_interrupt_type ip22_local0_irq_type = {
-	"IP22 local 0",
-	startup_local0_irq,
-	shutdown_local0_irq,
-	enable_local0_irq,
-	disable_local0_irq,
-	mask_and_ack_local0_irq,
-	end_local0_irq,
-	NULL
+	.typename	= "IP22 local 0",
+	.startup	= startup_local0_irq,
+	.shutdown	= shutdown_local0_irq,
+	.enable		= enable_local0_irq,
+	.disable	= disable_local0_irq,
+	.ack		= mask_and_ack_local0_irq,
+	.end		= end_local0_irq,
 };
 
 static void enable_local1_irq(unsigned int irq)
@@ -126,14 +125,13 @@
 }
 
 static struct hw_interrupt_type ip22_local1_irq_type = {
-	"IP22 local 1",
-	startup_local1_irq,
-	shutdown_local1_irq,
-	enable_local1_irq,
-	disable_local1_irq,
-	mask_and_ack_local1_irq,
-	end_local1_irq,
-	NULL
+	.typename	= "IP22 local 1",
+	.startup	= startup_local1_irq,
+	.shutdown	= shutdown_local1_irq,
+	.enable		= enable_local1_irq,
+	.disable	= disable_local1_irq,
+	.ack		= mask_and_ack_local1_irq,
+	.end		= end_local1_irq,
 };
 
 static void enable_local2_irq(unsigned int irq)
@@ -173,14 +171,13 @@
 }
 
 static struct hw_interrupt_type ip22_local2_irq_type = {
-	"IP22 local 2",
-	startup_local2_irq,
-	shutdown_local2_irq,
-	enable_local2_irq,
-	disable_local2_irq,
-	mask_and_ack_local2_irq,
-	end_local2_irq,
-	NULL
+	.typename	= "IP22 local 2",
+	.startup	= startup_local2_irq,
+	.shutdown	= shutdown_local2_irq,
+	.enable		= enable_local2_irq,
+	.disable	= disable_local2_irq,
+	.ack		= mask_and_ack_local2_irq,
+	.end		= end_local2_irq,
 };
 
 static void enable_local3_irq(unsigned int irq)
@@ -224,14 +221,13 @@
 }
 
 static struct hw_interrupt_type ip22_local3_irq_type = {
-	"IP22 local 3",
-	startup_local3_irq,
-	shutdown_local3_irq,
-	enable_local3_irq,
-	disable_local3_irq,
-	mask_and_ack_local3_irq,
-	end_local3_irq,
-	NULL
+	.typename	= "IP22 local 3",
+	.startup	= startup_local3_irq,
+	.shutdown	= shutdown_local3_irq,
+	.enable		= enable_local3_irq,
+	.disable	= disable_local3_irq,
+	.ack		= mask_and_ack_local3_irq,
+	.end		= end_local3_irq,
 };
 
 void indy_local0_irqdispatch(struct pt_regs *regs)
@@ -292,17 +288,36 @@
 	irq_exit(cpu, irq);
 }
 
-static struct irqaction local0_cascade =
-	{ no_action, SA_INTERRUPT, 0, "local0 cascade", NULL, NULL };
-static struct irqaction local1_cascade =
-	{ no_action, SA_INTERRUPT, 0, "local1 cascade", NULL, NULL };
-static struct irqaction buserr =
-	{ no_action, SA_INTERRUPT, 0, "Bus Error", NULL, NULL };
-static struct irqaction map0_cascade =
-	{ no_action, SA_INTERRUPT, 0, "mappable0 cascade", NULL, NULL };
+static struct irqaction local0_cascade = { 
+	.handler	= no_action,
+	.flags		= SA_INTERRUPT,
+	.name		= "local0 cascade",
+};
+
+static struct irqaction local1_cascade = { 
+	.handler	= no_action,
+	.flags		= SA_INTERRUPT,
+	.name		= "local1 cascade",
+};
+
+static struct irqaction buserr = { 
+	.handler	= no_action,
+	.flags		= SA_INTERRUPT,
+	.name		= "Bus Error",
+};
+
+static struct irqaction map0_cascade = { 
+	.handler	= no_action,
+	.flags		= SA_INTERRUPT,
+	.name		= "mapable0 cascade",
+};
+
 #ifdef I_REALLY_NEED_THIS_IRQ
-static struct irqaction map1_cascade =
-	{ no_action, SA_INTERRUPT, 0, "mappable1 cascade", NULL, NULL };
+static struct irqaction map1_cascade = { 
+	.handler	= no_action,
+	.flags		= SA_INTERRUPT,
+	.name		= "mapable1 cascade",
+};
 #endif
 
 extern void mips_cpu_irq_init(unsigned int irq_base);
Index: arch/mips/sgi-ip22/ip22-reset.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-reset.c,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 ip22-reset.c
--- arch/mips/sgi-ip22/ip22-reset.c	5 Aug 2002 23:53:35 -0000	1.1.2.4
+++ arch/mips/sgi-ip22/ip22-reset.c	18 Dec 2002 00:49:19 -0000
@@ -220,9 +220,7 @@
 }
 
 static struct notifier_block panic_block = {
-	panic_event,
-	NULL,
-	0
+	.notifier_call	= panic_event,
 };
 
 void indy_reboot_setup(void)
Index: arch/mips/sgi-ip22/ip22-system.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-system.c,v
retrieving revision 1.1.2.7
diff -u -r1.1.2.7 ip22-system.c
--- arch/mips/sgi-ip22/ip22-system.c	5 Aug 2002 14:02:43 -0000	1.1.2.7
+++ arch/mips/sgi-ip22/ip22-system.c	18 Dec 2002 00:49:19 -0000
@@ -19,18 +19,37 @@
 	int type;
 };
 
-static struct smatch sgi_cputable[] = {
-	{ "MIPS-R2000", CPU_R2000 },
-	{ "MIPS-R3000", CPU_R3000 },
-	{ "MIPS-R3000A", CPU_R3000A },
-	{ "MIPS-R4000", CPU_R4000SC },
-	{ "MIPS-R4400", CPU_R4400SC },
-	{ "MIPS-R4600", CPU_R4600 },
-	{ "MIPS-R8000", CPU_R8000 },
-	{ "MIPS-R5000", CPU_R5000 },
-	{ "MIPS-R5000A", CPU_R5000A },
-	{ "MIPS-R10000", CPU_R10000 }
-};
+static struct smatch sgi_cputable[] = {{ 
+	.name	= "MIPS-R2000",
+	.type	= CPU_R2000,
+},{
+	.name	= "MIPS-R3000",
+	.type	= CPU_R3000,
+},{
+	.name	= "MIPS-R3000A",
+	.type	= CPU_R3000A,
+},{
+	.name	= "MIPS-4000",
+	.type	= CPU_R4000SC,
+},{
+	.name	= "MIPS-R4400",
+	.type	= CPU_R4400SC,
+},{
+	.name	= "MIPS-R4600",
+	.type	= CPU_R4600,
+},{
+	.name	= "MIPS-R8000",
+	.type	= CPU_R8000,
+},{
+	.name	= "MIPS-R5000",
+	.type	= CPU_R5000,
+},{
+	.name	= "MIPS-R5000A",
+	.type	= CPU_R5000A,
+},{
+	.name	= "MIPS-R10000",
+	.type	= CPU_R10000,
+}};
 
 static int __init string_to_cpu(char *s)
 {
Index: drivers/sgi/char/ds1286.c
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/ds1286.c,v
retrieving revision 1.14.2.2
diff -u -r1.14.2.2 ds1286.c
--- drivers/sgi/char/ds1286.c	7 Nov 2002 01:47:46 -0000	1.14.2.2
+++ drivers/sgi/char/ds1286.c	18 Dec 2002 00:49:22 -0000
@@ -290,9 +290,9 @@
 
 static struct miscdevice ds1286_dev=
 {
-	RTC_MINOR,
-	"rtc",
-	&ds1286_fops
+	.minor	= RTC_MINOR,
+	.name	= "rtc",
+	.fops	= &ds1286_fops,
 };
 
 int __init ds1286_init(void)
Index: drivers/sgi/char/graphics.c
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/graphics.c,v
retrieving revision 1.30.2.2
diff -u -r1.30.2.2 graphics.c
--- drivers/sgi/char/graphics.c	7 Nov 2002 01:47:46 -0000	1.30.2.2
+++ drivers/sgi/char/graphics.c	18 Dec 2002 00:49:23 -0000
@@ -299,12 +293,16 @@
 
 /* /dev/graphics */
 static struct miscdevice dev_graphics = {
-	SGI_GRAPHICS_MINOR, "sgi-graphics", &sgi_graphics_fops
+	.minor	= SGI_GRAPHICS_MINOR,
+	.name	= "sgi-graphics",
+	.fops	= &sgi_graphics_fops,
 };
 
 /* /dev/opengl */
 static struct miscdevice dev_opengl = {
-	SGI_OPENGL_MINOR, "sgi-opengl", &sgi_graphics_fops
+	.minor	= SGI_OPENGL_MINOR,
+	.name	= "sgi-opengl",
+	.fops	= &sgi_graphics_fops,
 };
 
 /* This is called later from the misc-init routine */
Index: drivers/sgi/char/streamable.c
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/streamable.c,v
retrieving revision 1.13.4.2
diff -u -r1.13.4.2 streamable.c
--- drivers/sgi/char/streamable.c	7 Nov 2002 01:47:46 -0000	1.13.4.2
+++ drivers/sgi/char/streamable.c	18 Dec 2002 00:49:24 -0000
@@ -53,7 +53,7 @@
 static int
 sgi_gfx_ioctl (struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	printk ("GFX: ioctl 0x%x %ld called\n", cmd, arg);
+	printk (KERN_BEBUG "GFX: ioctl 0x%x %ld called\n", cmd, arg);
 	return 0;
 	return -EINVAL;
 }
@@ -63,7 +63,9 @@
 };
 
 static struct miscdevice dev_gfx = {
-	SGI_GFX_MINOR, "sgi-gfx", &sgi_gfx_fops
+	.minor	= SGI_GFX_MINOR,
+	.name	= "sgi-gfx",
+	.fops	= &sgi_gfx_fops,
 };
 
 /* /dev/input/keyboard streams device */
@@ -172,7 +174,9 @@
 };
 
 static struct miscdevice dev_input_keyboard = {
-	SGI_STREAMS_KEYBOARD, "streams-keyboard", &sgi_keyb_fops
+	.minor	= SGI_STREAMS_KEYBOARD,
+	.name	= "streams-keyboard",
+	.fops	= &sgi_keyb_fops,
 };
 
 /* /dev/input/mouse streams device */
@@ -305,13 +309,15 @@
 
 /* /dev/input/mouse */
 static struct miscdevice dev_input_mouse = {
-	SGI_STREAMS_KEYBOARD, "streams-mouse", &sgi_mouse_fops
+	.minor	= SGI_STREAMS_KEYBOARD,
+	.name	= "streams-mouse",
+	.fops	= &sgi_mouse_fops,
 };
 
 void
 streamable_init (void)
 {
-	printk ("streamable misc devices registered (keyb:%d, gfx:%d)\n",
+	printk (KERN_INFO "streamable misc devices registered (keyb:%d, gfx:%d)\n",
 		SGI_STREAMS_KEYBOARD, SGI_GFX_MINOR);
 
 	misc_register (&dev_gfx);
Index: drivers/sgi/char/usema.c
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/usema.c,v
retrieving revision 1.22.2.2
diff -u -r1.22.2.2 usema.c
--- drivers/sgi/char/usema.c	7 Nov 2002 01:47:46 -0000	1.22.2.2
+++ drivers/sgi/char/usema.c	18 Dec 2002 00:49:24 -0000
@@ -170,13 +170,15 @@
 };
 
 static struct miscdevice dev_usemaclone = {
-	SGI_USEMACLONE, "usemaclone", &sgi_usemaclone_fops
+	.minor	= SGI_USEMACLONE,
+	.name	= "usemaclone",
+	.fops	= &sgi_usemaclone_fops,
 };
 
 void
 usema_init(void)
 {
-	printk("usemaclone misc device registered (minor: %d)\n",
+	printk(KERN_INFO "usemaclone misc device registered (minor: %d)\n",
 	       SGI_USEMACLONE);
 	misc_register(&dev_usemaclone);
 }


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
