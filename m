Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:53:35 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:9859 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8224827AbTC0Cxd>;
	Thu, 27 Mar 2003 02:53:33 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id D8DC546A4B; Thu, 27 Mar 2003 03:52:05 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: Make IP22 compile without newport
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:52:05 +0100
Message-ID: <m2u1dped2i.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

Make sgi-ip22 compile without newport support.  Users that don't have
a graphic card (or an unsupported graphics card) don't need it.

Once there, I remove a duplicated call to gfx_register().

TODO: shmiq.o can also be removed when you don't have setup
     CONFIG_NEWPORT_CONSOLE or CONFIG_NEWPORT_GFX.  But they have an
     incestous relation with this file.

Later, Juan.

 build/arch/mips/sgi-ip22/ip22-setup.c |    3 ++-
 build/drivers/char/misc.c             |    5 -----
 build/drivers/sgi/char/Makefile       |    5 +++--
 build/drivers/sgi/char/shmiq.c        |   11 +++++++++--
 4 files changed, 14 insertions(+), 10 deletions(-)

diff -puN build/arch/mips/sgi-ip22/ip22-setup.c~newport build/arch/mips/sgi-ip22/ip22-setup.c
--- 24/build/arch/mips/sgi-ip22/ip22-setup.c~newport	2003-03-26 17:53:58.000000000 +0100
+++ 24-quintela/build/arch/mips/sgi-ip22/ip22-setup.c	2003-03-26 17:53:58.000000000 +0100
@@ -142,8 +142,9 @@ void __init ip22_setup(void)
 	/* Now enable boardcaches, if any. */
 	indy_sc_init();
 #endif
+#ifdef CONFIG_VT
 	conswitchp = NULL;
-
+#endif
 	/* Set the IO space to some sane value */
 	set_io_port_base (KSEG1ADDR (0x00080000));
 
diff -puN build/drivers/sgi/char/Makefile~newport build/drivers/sgi/char/Makefile
--- 24/build/drivers/sgi/char/Makefile~newport	2003-03-26 17:53:58.000000000 +0100
+++ 24-quintela/build/drivers/sgi/char/Makefile	2003-03-26 18:53:50.000000000 +0100
@@ -10,10 +10,11 @@
 O_TARGET := sgichar.o
 
 export-objs	:= newport.o rrm.o shmiq.o sgicons.o usema.o rrm.o
-obj-y		:= newport.o shmiq.o sgicons.o usema.o streamable.o
+obj-y		:= shmiq.o
 
 obj-$(CONFIG_IP22_SERIAL)	+= sgiserial.o
+obj-$(CONFIG_SGI_NEWPORT_CONSOLE)	+= newport.o streamable.o
 obj-$(CONFIG_SGI_DS1286)	+= ds1286.o
-obj-$(CONFIG_SGI_NEWPORT_GFX)	+= graphics.o rrm.o
+obj-$(CONFIG_SGI_NEWPORT_GFX)	+= sgicons.o graphics.o rrm.o usema.o
 
 include $(TOPDIR)/Rules.make
diff -puN build/drivers/sgi/char/shmiq.c~newport build/drivers/sgi/char/shmiq.c
--- 24/build/drivers/sgi/char/shmiq.c~newport	2003-03-26 17:53:58.000000000 +0100
+++ 24-quintela/build/drivers/sgi/char/shmiq.c	2003-03-26 18:40:12.000000000 +0100
@@ -166,6 +166,7 @@ shmiq_forget_file (unsigned long fdes)
 	return 0;
 }
 
+#ifdef CONFIG_SGI_NEWPORT_GFX
 static int
 shmiq_sioc (int device, int cmd, struct strioctl *s)
 {
@@ -194,12 +195,12 @@ shmiq_sioc (int device, int cmd, struct 
 	printk ("Unknown I_STR request for shmiq device: 0x%x\n", cmd);
 	return -EINVAL;
 }
+#endif /* CONFIG_SGI_NEWPORT_GFX */
 
 static int
 shmiq_ioctl (struct inode *inode, struct file *f, unsigned int cmd, unsigned long arg)
 {
 	struct file *file;
-	struct strioctl sioc;
 	int v;
 
 	switch (cmd){
@@ -226,7 +227,10 @@ shmiq_ioctl (struct inode *inode, struct
 		v = shmiq_forget_file (arg);
 		return v;
 
-	case I_STR:
+#ifdef CONFIG_SGI_NEWPORT_GFX
+	case I_STR: {
+		struct strioctl sioc;
+
 		v = get_sioc (&sioc, arg);
 		if (v)
 			return v;
@@ -234,6 +238,8 @@ shmiq_ioctl (struct inode *inode, struct
 		/* FIXME: This forces device = 0 */
 		return shmiq_sioc (0, sioc.ic_cmd, &sioc);
 	}
+#endif
+	}
 
 	return -EINVAL;
 
@@ -471,3 +477,4 @@ shmiq_init (void)
 }
 
 EXPORT_SYMBOL(shmiq_init);
+EXPORT_SYMBOL(shmiq_push_event);
diff -puN build/drivers/char/misc.c~newport build/drivers/char/misc.c
--- 24/build/drivers/char/misc.c~newport	2003-03-26 17:53:58.000000000 +0100
+++ 24-quintela/build/drivers/char/misc.c	2003-03-26 17:53:58.000000000 +0100
@@ -266,12 +266,7 @@ int __init misc_init(void)
 	pmu_device_init();
 #endif
 #ifdef CONFIG_SGI_NEWPORT_GFX
-	gfx_register ();
-#endif
-#ifdef CONFIG_SGI_IP22
 	streamable_init ();
-#endif
-#ifdef CONFIG_SGI_NEWPORT_GFX
 	gfx_register ();
 #endif
 #ifdef CONFIG_TOSHIBA

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
