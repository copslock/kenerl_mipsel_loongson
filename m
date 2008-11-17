Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2008 12:59:29 +0000 (GMT)
Received: from n13b.bullet.mail.mud.yahoo.com ([68.142.207.222]:26523 "HELO
	n13b.bullet.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S23723964AbYKQM7Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Nov 2008 12:59:25 +0000
Received: from [209.191.108.96] by n13.bullet.mail.mud.yahoo.com with NNFMP; 17 Nov 2008 12:59:17 -0000
Received: from [76.13.13.25] by t3.bullet.mud.yahoo.com with NNFMP; 17 Nov 2008 12:59:16 -0000
Received: from [76.13.10.181] by t4.bullet.mail.ac4.yahoo.com with NNFMP; 17 Nov 2008 12:59:16 -0000
Received: from [127.0.0.1] by omp122.mail.ac4.yahoo.com with NNFMP; 17 Nov 2008 12:59:16 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 696423.55568.bm@omp122.mail.ac4.yahoo.com
Received: (qmail 41344 invoked by uid 60001); 17 Nov 2008 12:59:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=1aVWx9CMgftN63cbyiqiuakhfaNlJDPQZsAz0fEJXfDkBlxtvJN1bsZz5BhVuKItXwfis2GTUcF+6bkpCaEHUaFrWFSwjLe84JzQ3p1Ik+kgSHGqpMWR/q4XeEYkSao++HoK6W4YUT5UgNREvF4z8I7U4r73LH2T/tHi5wUWZrM=;
X-YMail-OSG: uoUBbQwVM1nVbDU6ClcWXMyROml1oNaEFhrA3VLALB.Uw_Fyp9AUxazw6hmy5qNg5FXoy25kpRy3f_LBj8jJVhIiDTkJrVXhyCmqlJMSAWSHmkWc7_p.zfJWMUIhpoJFsgOhUZ_z7AeYm0zinwoTtxW3CJWVB70t0FOIRhsPAxAHWke0hopp8FQ0XPKPJp35._c8DrvceGATpKYtORHceKeuI12LKhjDSkudixSlyxfn3Z3wcdTS2CS2KBDOtUT4uJttzpi.FGo8tKSZpAgJuHqUsGbZWVcsyA--
Received: from [84.204.225.1] by web59809.mail.ac4.yahoo.com via HTTP; Mon, 17 Nov 2008 04:59:15 PST
X-Mailer: YahooMailWebService/0.7.260.1
Date:	Mon, 17 Nov 2008 04:59:15 -0800 (PST)
From:	Andrew Randrianasulu <randrik_a@yahoo.com>
Reply-To: randrik_a@yahoo.com
Subject: [patch] compile fixes for kernel driver for VICE coprocessor
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <324373.27740.qm@web59809.mail.ac4.yahoo.com>
Return-Path: <randrik_a@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randrik_a@yahoo.com
Precedence: bulk
X-list: linux-mips

Some function renaming and headers moving. Now it compiles (64 bit kernel, 2.6.28-rc5), but my changes very well may be done in wrong way.

Because i'm total newbie in kernel development -  can I ask few question?
First - i've changed KSEG0ADDR -> CKSEG0ADDR unconditionally. probably bad idea, but before i add some if's around it - may be someone point me to better way for doing this?
Second - i'm totally unsure about vice_vma_nopage function. probably i changed it in wrong way?
Third - eliminating <asm/pci.h> was only way for me to compile it. Vice.h includes <linux/pci.h>, hopefully it enough? If not - correct me, please.

I don't have hardware, so compile-tested only (crosscompiler - gcc-3.4.6. it gives me few warnings, may be under more recent compiler these warnings become errors?).



diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 93ea201..30978d1 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -136,4 +136,6 @@ config USB_DABUSB
 	  module will be called dabusb.
 endif # DAB
 
+source "drivers/media/vice/Kconfig"
+
 endmenu
diff --git a/drivers/media/Makefile b/drivers/media/Makefile
index 09a829d..5f8ad2e 100644
--- a/drivers/media/Makefile
+++ b/drivers/media/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the kernel multimedia device drivers.
 #
 
-obj-y += common/ video/
+obj-y += common/ video/ vice/
 
 obj-$(CONFIG_VIDEO_DEV) += radio/
 obj-$(CONFIG_DVB_CORE)  += dvb/
diff --git a/drivers/media/vice/Kconfig b/drivers/media/vice/Kconfig
new file mode 100644
index 0000000..cad3376
--- /dev/null
+++ b/drivers/media/vice/Kconfig
@@ -0,0 +1,35 @@
+#
+# O2 VICE Engine configuration
+#
+
+config O2_VICE
+    tristate "O2 VICE Engine Support"
+    depends on SGI_IP32
+    ---help---
+      This option enables O2 VICE Engine support.
+      VICE stands for Video Image Compression Engine. This is very powerfull
+      piece of silicon, that can greatly speed up lots of graphics, vide, or
+      sound related tasks. To be able to use it, you will also need special
+      library, that can be found at <insert URL here>
+
+config O2_VICE_DBGG
+    bool "VICE Debugger Support. READ HELP!"
+    depends on O2_VICE
+    ---help---
+      This option enables features of VICE driver needed to debug VICE library.
+      This is probably serious security risk. You don't need it. If you think
+      you do, you are wrong. Say NO.
+
+config O2_VICE_DBG
+    bool "You seem to insist... did you read help? Yes? No? READ HELP!"
+    depends on O2_VICE_DBGG
+    ---help---
+      You are still here? Didn't I just tell you that it is not needed?
+      Or do you want to say you *legally* obtained information needed for
+      programming VICE? That you got all the tools needed?
+      You can get bitutils patch for dealing with BSP code at
+      http://www.total-knowledge.com/progs/mips/vice/binutils-bsp.diff
+      (but it doesn't work). You will also need a patch for compiling
+      MSP code.
+
+      Sigh... You've been warned...
diff --git a/drivers/media/vice/Makefile b/drivers/media/vice/Makefile
new file mode 100644
index 0000000..354b44b
--- /dev/null
+++ b/drivers/media/vice/Makefile
@@ -0,0 +1,8 @@
+#
+# drivers/char/o2vice/Makefile
+#
+# Makefile for the O2 VICE Engine driver.
+#
+
+obj-$(CONFIG_O2_VICE)	+= main.o msp.o bsp.o dma.o
+#obj-$(CONFIG_O2_VICE_DBG) += vicedebug.o
diff --git a/drivers/media/vice/bsp.c b/drivers/media/vice/bsp.c
new file mode 100644
index 0000000..87f2101
--- /dev/null
+++ b/drivers/media/vice/bsp.c
@@ -0,0 +1,181 @@
+/*
+ *
+ * Copyright (C) 2002 Ilya Volynets
+ *	Sponsored by Total Knowledge
+ *	http://www.total-knowledge.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *=======================================================================
+ * 09.16.2002	iluxa
+ *	- skeleton only (I don't have instruction set for BSP, so there
+ *	  is no way I can test it).
+ * 04.19.2003   iluxa
+ *      - I have sketches of binutils, so I actually am making this work
+ *        It now can run infinite loop.
+ *                    "Still, it *is* spinning!" - Galileo Galilei
+ */
+
+#include <linux/autoconf.h>                                                                                                                                       
+                          
+#include <linux/module.h>
+
+#include <linux/kernel.h>   /* printk() */
+#include <asm/page.h>
+#include <linux/vmalloc.h>   /* kmalloc() */
+#include <linux/fs.h>       /* everything... */
+#include <linux/errno.h>    /* error codes */
+#include <linux/types.h>    /* size_t */
+#include <linux/proc_fs.h>
+#include <linux/fcntl.h>    /* O_ACCMODE */
+#include <linux/sched.h> 
+
+#include <asm/system.h>     /* cli(), *_flags */
+
+// #include <asm/pci.h>
+
+#include <asm/uaccess.h>    /* put_user & friends */
+#include <asm/delay.h>
+
+#include <linux/vice.h>
+
+
+/* wait queue to wait on while BSP runs */
+static DECLARE_WAIT_QUEUE_HEAD(wq);
+
+/*
+ * Loads BSP PC with value form vice->bsp_pc, takes bsp out of reset
+ * state (just in case?) and kicks off execution.
+ */
+static inline void bsp_go(u32 pc)
+{
+	vice_write_reg(BSP_HALT_RESET,BSP_HALT);
+	vice_write_reg(BSP_PC,pc);
+	vice_write_reg(BSP_HALT_RESET,0); /* BSP_HALT=0 to start */
+}
+
+/*
+ * Brings BSP engine into ready-for-execution state
+ *  - FIFOs are reset
+ *  - all status registers are reset
+ *  - BSP_HALT_RESET(0)=0
+ *  - BSP_HALT_RESET(1)=1
+ */
+void vice_bsp_reset(vice_dev* vice)
+{
+    u64 s;
+    vice_write_reg(BSP_FIFO_CTL_STAT, BSP_FIFO_CTL_RESET);
+    vice_write_reg(BSP_HALT_RESET,BSP_RESET);
+    do {
+        s=vice_read_reg(BSP_HALT_RESET);
+    } while((s&0x7)!=(BSP_RESET|BSP_HALT|BSP_HALT_ACK));
+    vice_write_reg(BSP_FIFO_CTL_STAT,0);
+    vice_write_reg(BSP_HALT_RESET, BSP_HALT);
+    do {
+        s=vice_read_reg(BSP_HALT_RESET);
+    } while((s&BSP_HALT)==0x0);
+    vice_write_reg(BSP_CAUSE,0);
+}
+
+static inline void vice_bsp_stop(void)
+{
+    int i=0;
+    u64 ctl=(vice_read_reg(BSP_HALT_RESET)|BSP_HALT)&0x7;
+    vice_write_reg(BSP_HALT_RESET,ctl);
+    while(!vice_read_reg(BSP_HALT_RESET)&BSP_HALT_ACK) {
+	    if (++i>MAX_BSP_HALT_WAIT) {
+		    printk(KERN_WARNING "o2vice: timeout stopping bsp, bsp reset\n");
+		    vice_bsp_reset(0);/*FIXME: pass vice* arrond*/
+	    }
+	    udelay(16);
+    }
+}
+
+int vice_bsp_init(struct vice_dev* vice)
+{
+    spin_lock_init(&vice->dma_lock[1]);
+    return 0;
+}
+void vice_bsp_cleanup(vice_dev* vice)
+{
+    vice_bsp_stop();
+}
+
+void vice_handle_bsp_int(vice_dev* vice)
+{
+    DPRINTK("Ah! We are done with BSP!\n");
+    if(vice->bsp_status!=VICE_RES_STATUS_INPROGRESS) {
+	DPRINTK("Ugh... BSP interrupt while BSP isn't started from driver!\n");
+	return;
+    }
+    vice->bsp_status=VICE_RES_STATUS_DONE;
+    vice->bsp_pc=-1; /* No exception, no EPC, and PC is probably
+			not one which executed Exception instruction */
+    vice->bsp_int_reason=vice_read_reg(BSP_CAUSE);
+    wake_up_interruptible(&wq);
+}
+void vice_handle_bsp_err(vice_dev* vice)
+{
+    DPRINTK("Ouch! BSP Exception!\n");
+    vice->bsp_int_reason=vice_read_reg(BSP_CAUSE);
+    DPRINTK("\treason=%016x\n",vice->bsp_int_reason);
+    if(vice->bsp_status!=VICE_RES_STATUS_INPROGRESS) {
+	DPRINTK("Ugh... BSP exception while BSP isn't started from driver!\n");
+	return;
+    }
+    vice->bsp_pc=(u32)vice_read_reg(BSP_EPC);
+    vice->bsp_status=VICE_RES_STATUS_ERR;
+    wake_up_interruptible(&wq);
+}
+
+int vice_bsp_run(vice_dev* vice, bsp_run* result)
+{
+    bsp_run r;
+    if(!access_ok(VERIFY_WRITE,result,sizeof(bsp_run)))
+	return -EFAULT;
+    DPRINTK("Checking for BSP status\n");
+    spin_lock_irq(vice->bsp_lock);
+    if(vice->bsp_status!=VICE_RES_STATUS_FREE) {
+	spin_unlock_irq(vice->bsp_lock);
+	return -EBUSY;
+    }
+    DPRINTK("BSP is free\n");
+    vice->bsp_status=VICE_RES_STATUS_INPROGRESS;
+    spin_unlock_irq(vice->bsp_lock);
+    DPRINTK("Kicking BSP off\n");
+    copy_from_user(&r,result,sizeof(r));
+    bsp_go(r.start_pc);
+    /*
+     * Sleep, untill BSP interrupts us...
+     *
+     * No spinlock is needed...
+     */
+    DPRINTK("Falling asleep\n");
+    while(vice->bsp_status==VICE_RES_STATUS_INPROGRESS) {
+        interruptible_sleep_on(&wq);
+	DPRINTK("Huh? Where am I?\n");
+	if(signal_pending(current)) {
+		vice_bsp_stop();
+		break;
+	}
+    }
+    DPRINTK("*yawn* obviously waking up....\n");
+    r.status=vice->bsp_status;
+    vice->bsp_status=VICE_RES_STATUS_FREE;
+    r.end_pc=vice->bsp_pc;
+    r.reason=vice->bsp_int_reason;
+    DPRINTK("r.reason=%x, r.pc=%x, r.status=%x\n",r.reason,r.end_pc,r.status);
+    return copy_to_user(result,&r,sizeof(r));
+}
diff --git a/drivers/media/vice/dma.c b/drivers/media/vice/dma.c
new file mode 100644
index 0000000..3916388
--- /dev/null
+++ b/drivers/media/vice/dma.c
@@ -0,0 +1,179 @@
+/*
+ *
+ * Copyright (C) 2002 Ilya Volynets
+ *	Sponsored by Total Knowledge
+ *	http://www.total-knowledge.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *======================================================================
+ */
+#include <linux/autoconf.h>
+#include <linux/module.h>
+
+#include <linux/kernel.h>   /* printk() */
+#include <asm/page.h>
+#include <linux/vmalloc.h>  /* kmalloc() */
+#include <linux/fs.h>       /* everything... */
+#include <linux/errno.h>    /* error codes */
+#include <linux/types.h>    /* size_t */
+#include <linux/proc_fs.h>
+#include <linux/fcntl.h>    /* O_ACCMODE */
+#include <linux/sched.h>
+
+#include <asm/system.h>     /* cli(), *_flags */
+// #include <asm/pci.h>
+#include <asm/uaccess.h>    /* put_user & friends */
+#include <asm/delay.h>
+
+#include <asm/errno.h>
+#include <asm/addrspace.h>
+
+/*
+ * VICE DMA support
+ */
+
+#include <linux/vice.h>
+
+/* wait queue to sleep on, while waiting for DMA */
+static DECLARE_WAIT_QUEUE_HEAD(wq);
+
+
+/*
+ * Maps one of 4M sets into VICE TLB.
+ * Currently set# can be either 0 or 1
+ */
+int vice_dma_map_set(vice_dev *vice,unsigned long set)
+{
+	unsigned long *page_set;
+	int i;
+	/* either map in 0th or 1st set (for now....) */
+	if(set>=2)
+		return -EINVAL;
+	page_set=&(vice->dma_mem[VICE_TLB_ENTRIES*set]);
+	for(i=0; i<VICE_TLB_ENTRIES; i++) {
+		vice_write_reg(VICE_TLB_OFFSET+(i<<3), page_set[i]|VICE_TLB_VALID|VICE_TLB_WRITABLE);
+	}
+	return 0;
+}
+
+/*
+ * Unmaps all pages from VICE TLB
+ */
+int vice_dma_clear_tlb(vice_dev *vice)
+{
+	int i;
+	for(i=0; i<VICE_TLB_ENTRIES; i++) {
+		vice_write_32(VICE_TLB_OFFSET+(i<<2), 0);
+	}
+	return 0;
+}
+
+int vice_dma_init(vice_dev* vice)
+{
+	int ret=0;
+	spin_lock_init(&vice->dma_lock[0]);
+	spin_lock_init(&vice->dma_lock[1]);
+	return ret;
+}
+
+int vice_dma_run(vice_dev* vice,dma_run* run)
+{
+	dma_run r;
+	if(copy_from_user(&r,run,sizeof(r)))
+		return -EINVAL;
+	if(r.channel>=2)
+		return -EINVAL;
+
+	/*
+	 * Only reason I need this spinlock is if two threads are trying to
+	 * _start_ DMA at the same time. All other accesses to dma_status need not
+	 * be interlocked.
+	 */
+	DPRINTK("Checking for channel status\n");
+	spin_lock_irq(vice->dma_lock[r.channel]);
+	if(vice->dma_status[r.channel]!=VICE_RES_STATUS_FREE) {
+		spin_unlock_irq(vice->dma_lock[r.channel]);
+		return -EBUSY;
+	}
+	DPRINTK("Channel OK\n");
+	vice->dma_status[r.channel]=VICE_RES_STATUS_INPROGRESS;
+	spin_unlock_irq(vice->dma_lock[r.channel]);
+	DPRINTK("Kicking DMA off\n");
+	if(r.channel==0)
+		vice_write_reg(DMA_CH1_CTL,r.desc|VICE_DMA_CTL_GO|VICE_DMA_CTL_IE);
+	else
+		vice_write_reg(DMA_CH2_CTL,r.desc|VICE_DMA_CTL_GO|VICE_DMA_CTL_IE);
+	/*
+	 * Sleep, untill this channel sends DMA_DONE or DMA_ERR interrupt...
+	 *
+	 * No spinlock is needed...
+	 */
+	DPRINTK("Falling asleep\n");
+	while(vice->dma_status[r.channel]==VICE_RES_STATUS_INPROGRESS) {
+		interruptible_sleep_on(&wq);
+		DPRINTK("Huh? Where am I?\n");
+		if(signal_pending(current))break;
+	}
+	DPRINTK("*yawn* obviously waking up....\n");
+	r.status=vice->dma_status[r.channel];
+	vice->dma_status[r.channel]=VICE_RES_STATUS_FREE;
+	__copy_to_user(&r,run,sizeof(r));
+	DPRINTK("Done\n");
+	return 0;
+}
+
+void vice_dma_done(vice_dev *vice, int channel)
+{
+	DPRINTK("DMA done\n");
+
+	if(vice->dma_status[channel]!=VICE_RES_STATUS_INPROGRESS) {
+		DPRINTK("Ugh... DMA interrupt on channel %d, while DMA on that channel isn't initiated from CPU!\n",channel);
+		return;
+	}
+	vice->dma_status[channel]=VICE_RES_STATUS_DONE;
+	wake_up_interruptible(&wq);
+}
+
+void vice_dma_err(vice_dev *vice, int channel)
+{
+	DPRINTK("DMA error\n");
+	spin_lock_irq(vice->dma_lock[channel]);
+	vice->dma_status[channel]=VICE_RES_STATUS_ERR;
+	spin_unlock_irq(vice->dma_lock[channel]);
+	wake_up_interruptible(&wq);
+}
+
+/*
+ * Need to stop all DMA transfers
+ */
+
+void vice_dma_cleanup(vice_dev* vice)
+{
+}
+
+void vice_dma_reset(vice_dev* vice)
+{
+	/*
+	 * Is DMA engine resettable?
+	 * ... Yes, which register?
+	 */
+	vice_write_reg(DMA_CH1_CTL,VICE_DMA_CTL_RESET);
+	vice_write_reg(DMA_CH2_CTL,VICE_DMA_CTL_RESET);
+	udelay(16); /* sleep for at least 16 VICE clocks */
+	vice_write_reg(DMA_CH1_CTL,VICE_DMA_CTL_IE|VICE_DMA_CTL_DESC1);
+	vice_write_reg(DMA_CH2_CTL,VICE_DMA_CTL_IE|VICE_DMA_CTL_DESC1);
+	vice_dma_clear_tlb(vice);
+}
diff --git a/drivers/media/vice/main.c b/drivers/media/vice/main.c
new file mode 100644
index 0000000..98e24f4
--- /dev/null
+++ b/drivers/media/vice/main.c
@@ -0,0 +1,419 @@
+/*
+ * main.c -- SGI O2 VICE driver
+ *
+ * The code skeleton came from the book "Linux Device
+ * Drivers" by Alessandro Rubini and Jonathan Corbet, published
+ * by O'Reilly & Associates.   No warranty is attached;
+ * we cannot take responsibility for errors or fitness for use.
+ *
+ * Copyright (C) 2002 Ilya Volynets.
+ *	Sponsored by Total Knowledge
+ *	http://www.total-knowledge.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *======================================================================
+ * 09.16.2002	iluxa
+ *	- first rough cut is ready.
+ */
+
+/*
+ * When debugging support is turned off, there will be no access to most of
+ * VICE I/O space. No PIO access to ram and buffers for sure, as acceessing
+ * some of "unimplemented" regions seems to halt system completely. (Is CPU
+ * just stalling, waiting for data to be returned, instead of getting error?)
+ * Safe registers are first 4K (control registers?) and next 4K with DMA
+ * describtors.
+ * Well, I could give access to correct pages through "nopage" method...
+ * Then accessing "reserved" regions would give SIG_BUS...
+ * Data ram would be problem: there are 3 2K regions, which either makes
+ * only 2 banks accessible to userspace, or none at all (giving non-root user
+ * an option to randomly hang system is not an option :)
+ */
+
+#include <linux/autoconf.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/sched.h>
+#include <linux/init.h>		/* module_(init|exit) */
+#include <linux/interrupt.h>
+
+#include <linux/kernel.h>	/* printk() */
+#include <asm/page.h>
+#include <linux/vmalloc.h>	/* kmalloc() */
+#include <linux/fs.h>		/* everything... */
+#include <linux/errno.h>	/* error codes */
+#include <linux/types.h>	/* size_t */
+#include <linux/proc_fs.h>
+#include <linux/fcntl.h>	/* O_ACCMODE */
+
+#include <asm/system.h>		/* cli(), *_flags */
+
+#include <linux/mm.h>
+
+#include <linux/vice.h>		/* local definitions */
+
+
+#include <asm/ip32/ip32_ints.h>
+
+
+int vice_major = VICE_MAJOR;
+
+module_param(vice_major, int, 0444);
+MODULE_AUTHOR("Ilya Volynets");
+
+const char *vice_str="vice";
+
+/*
+ * Different minors behave differently, so let's use multiple fops
+ */
+
+
+vice_dev *vice_device;	/* holds pointer to vice state (allocated in module_init) */
+
+/*
+ * vice_reset -- restes VICE engine
+ */
+int vice_reset(vice_dev * dev)
+{
+	vice_bsp_reset(dev);
+	vice_msp_reset(dev);
+	vice_dma_reset(dev);
+	return 0;
+}
+
+void vice_handle_buserr(vice_dev* vice)
+{
+	printk(KERN_WARNING "vice: received \"Erroneous data\" interrupt.\n");
+	printk(KERN_WARNING "\tUnfortunately I (Ilya Volynets) Have no idea what is it, so I'm simply ignoring it.\n");
+}
+
+static void vice_interrupt(int irq, void *dev_id, struct pt_regs *pregs)
+{
+	struct vice_dev *vice = (struct vice_dev *) dev_id;
+	u64 status;
+	DPRINTK("irq!\n");
+	status=vice_read_reg(VICE_INT);
+
+	if (!vice /*paranoid */ ) {
+		DPRINTK ("Paranoja ouch!\n");
+		return;
+	}
+
+	DPRINTK("Interrupt, status %016lx...\n", status);
+	if (status & VICE_INT_DMA_CH1_DONE)
+		vice_dma_done(vice,0);
+	if (status & VICE_INT_DMA_CH1_ERR)
+		vice_dma_err(vice,0);
+	if (status & VICE_INT_DMA_CH2_DONE)
+		vice_dma_done(vice,1);
+	if (status & VICE_INT_DMA_CH2_ERR)
+		vice_dma_err(vice,1);
+	if (status & VICE_INT_MSP_SW)
+		vice_handle_msp_int(vice);
+	if (status & VICE_INT_MSP_ERR)
+		vice_handle_msp_err(vice);
+	if (status & VICE_INT_BSP_SW)
+		vice_handle_bsp_int(vice);
+	if (status & VICE_INT_BSP_ERR)
+		vice_handle_bsp_err(vice);
+	if (status & VICE_INT_BUSERR)
+		vice_handle_buserr(vice);
+
+	vice_write_reg(VICE_INT_RESET,0x1FF);	/* clear handled interrupts */
+}
+
+/*
+ * Open and close
+ */
+
+/* In vice_open, the fop_array is used according to TYPE(dev) */
+int vice_open(struct inode *inode, struct file *filp)
+{
+	int res;
+	vice_dev *vice=vice_device;
+
+	/* Do not allow to open VICE with more then one app for now */
+	spin_lock(vice->vice_lock);
+	if(vice->isopen){
+		spin_unlock(vice->vice_lock);
+		return -EBUSY;
+	}
+	vice->isopen=1;
+	spin_unlock(vice->vice_lock);
+	filp->private_data=vice;
+	vice_reset(vice);
+
+//	res = request_irq(CRIME_VICE_IRQ, vice_interrupt, IRQF_SHARED, vice_str, vice);
+	if ((res=request_irq(CRIME_VICE_IRQ, vice_interrupt, IRQF_SHARED, vice_str, vice)));  {
+	
+/*	if ((res=request_irq(CRIME_VICE_IRQ, vice_interrupt, SA_SHIRQ, vice_str, vice))) { */
+		printk(KERN_ERR "vice: Can't get irq %x: res=%i\n", (unsigned int)CRIME_VICE_INT, res);
+		return res;
+//		ret = -EBUSY;
+	}
+
+	/*Actual device init goes in here */
+
+	{
+		int ret;
+		if((ret=vice_dma_mem_init(vice))!=0) {
+			DPRINTK("Failure allocating VICE I/O buffers...\n");
+			vice_dma_mem_free(vice);
+			DPRINTK("Freed already-allocated memory...\n");
+			return ret;
+		}
+		/* 
+		 * Enable interrupts in VICE
+                 * FIXME: enable only interrupts that we need.
+                 *        i.e there is no need to worry about interrypts from BSP,
+		 *        Unless *driver* knows that BSP is running (started through ioctl.
+		 *        BSP could be started from userspace, and polled for completion
+		 *        instead, if needed.
+		 */
+		vice_write_reg(VICE_INT_RESET,0x1FF); /* clear pending interrupts */
+		vice_write_reg(VICE_INT_EN,0x1FF);
+	}
+	return 0;			/* success */
+}
+
+int vice_release(struct inode *inode, struct file *filp)
+{
+	vice_dev *vice=(vice_dev*)filp->private_data;
+
+	/* disable interrupts in VICE */
+	vice_write_reg(VICE_INT_EN,0x000);
+	free_irq(CRIME_VICE_IRQ, vice);
+	vice_dma_mem_free(vice);
+	vice_reset(vice);
+
+	spin_lock(vice->vice_lock);
+	vice->isopen=0;
+	spin_unlock(vice->vice_lock);
+	return 0;
+}
+
+
+/*
+ * The ioctl() implementation
+ */
+
+int vice_ioctl(struct inode *inode, struct file *filp,
+	       unsigned int cmd, unsigned long arg)
+{
+	vice_dev* vice=(vice_dev*)filp->private_data;
+	switch(cmd) {
+	case VICE_IOCTL_MAP_DMA:
+		return vice_dma_map_set(vice,arg);
+	case VICE_IOCTL_MSP_RUN:
+		return vice_msp_run(vice,(msp_run*)arg);
+	case VICE_IOCTL_BSP_RUN:
+		return vice_bsp_run(vice,(bsp_run*)arg);
+	case VICE_IOCTL_DO_DMA:
+		return vice_dma_run(vice,(dma_run*)arg);
+	default:
+		return -ENOTTY;
+	}
+	return 0;
+}
+
+/*
+ * All it does is find 4K page in one of 64K pages from vice.dev_mem
+ * There is no need to worry about I/O addresses here, since they are remap_page_ranged
+ * on initial mmap....
+ */
+struct page* vice_vma_nopage(struct vm_area_struct *vma,unsigned long address, int write)
+{
+	vice_dev *vice=(vice_dev*)vma->vm_private_data;
+	unsigned long fkpn=((address-vma->vm_start)>>PAGE_SHIFT)+
+		(vma->vm_pgoff-(VICE_MIN_OFFSET>>PAGE_SHIFT));
+	unsigned long v_pn=fkpn>>VICE_PAGE_ORDER;
+	unsigned long kaddr;
+	struct page *pgptr;
+
+
+	if(v_pn>=sizeof(vice->dma_mem)/sizeof(vice->dma_mem[0]))
+		// return NOPAGE_SIGBUS;
+		return VM_FAULT_SIGBUS;
+
+
+	/* KLUDGE: this should be happenning automagically, just by nature of using
+	   pci_alloc_xxx for aquiring this mem. Problem is due to inconsistancy
+	   between PAGE_OFFSET and (UN)CAC_BASE
+	*/
+	// KSEG0ADDR -> CKSEG0ADDR
+	kaddr=(unsigned long)CKSEG0ADDR(vice->dma_kmem[v_pn])+
+		((fkpn-(v_pn<<VICE_PAGE_ORDER))<<PAGE_SHIFT);
+	pgptr=virt_to_page(kaddr);
+	get_page(pgptr);
+	return virt_to_page(kaddr);
+}
+
+static struct vm_operations_struct vice_vm_ops = {
+//	.nopage = vice_vma_nopage,
+	.fault =  vice_vma_nopage,
+};
+
+/*
+ * mmap I/O registers of VICE. Called when region is in 0-VICE_IO_MAX range.
+ */
+static inline int vice_io_mmap( struct vm_area_struct *vma)
+{
+	unsigned long offset=vma->vm_pgoff<<PAGE_SHIFT;
+	if(offset+vma->vm_end-vma->vm_start>VICE_IO_MAX_OFFSET+1) {
+		DPRINTK("invalid offset: %lu,length=%lx\n",offset,vma->vm_end-vma->vm_start);
+		return -EINVAL;
+	}
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_flags |= VM_IO|VM_RESERVED;
+
+//	DPRINTK("remap_page_range(vma,%016lx,%016lx,%016lx,%08x)\n",
+//		vma->vm_start,VICE_BASE+offset,vma->vm_end-vma->vm_start,vma->vm_page_prot);
+
+	// return remap_page_range(vma,vma->vm_start,VICE_BASE+offset,vma->vm_end-vma->vm_start,vma->vm_page_prot);
+	 return remap_pfn_range(vma,vma->vm_start,VICE_BASE+offset,vma->vm_end-vma->vm_start,vma->vm_page_prot); /* new function */
+}
+/*
+ * mmap I/O buffers. Called when region is above VICE_IO_MAX.
+ */
+
+static inline int vice_buffer_mmap( struct file* filep, struct vm_area_struct *vma)
+{
+	unsigned long offset=vma->vm_pgoff<<PAGE_SHIFT;
+	vice_dev *vice=filep->private_data;
+
+	/* must be VICE_PAGE aligned (64K) and size must be ... by 64K */
+	if (offset&0xFFFF||(vma->vm_end-vma->vm_start)&0xFFFF)
+		return -ENXIO; /* alignment error? */
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_flags |= VM_IO|VM_RESERVED;
+	vma->vm_private_data=vice;
+	vma->vm_file = filep;
+	return 0;
+}
+
+static int vice_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	unsigned long offset=vma->vm_pgoff<<PAGE_SHIFT;
+	vma->vm_ops = &vice_vm_ops;
+	if(offset<=VICE_IO_MAX_OFFSET)
+		return vice_io_mmap(vma);
+	else if(offset>=VICE_MIN_OFFSET&&offset+vma->vm_end-vma->vm_start<=VICE_MAX_OFFSET)
+		return vice_buffer_mmap(filp,vma);
+	else
+		return -EINVAL;
+}
+
+struct file_operations vice_fops = {
+	.owner = THIS_MODULE,
+	.ioctl = vice_ioctl,
+	.open = vice_open,
+	.release = vice_release,
+	.mmap = vice_mmap,
+};
+
+/*
+ * Finally, the module stuff
+ */
+
+/*
+ * The cleanup function is used to handle initialization failures as well.
+ * Thefore, it must be careful to work correctly even if some of the items
+ * have not been initialized
+ */
+void vice_cleanup_module(void)
+{
+	vice_dev *vice=vice_device;
+	/* cleanup_module is never called if registering failed */
+	unregister_chrdev(vice_major, "vice");
+
+	/* Cleanup MSP/BSP/DMA */
+	/* This really should be done in close.. */
+	vice_msp_cleanup(vice);
+	vice_bsp_cleanup(vice);
+	vice_dma_cleanup(vice);
+
+	/* Clean up DMA and other HW */
+
+// devfs killed
+
+
+	if (vice_device) {
+		kfree(vice);
+	}
+}
+
+
+int vice_init_module(void)
+{
+	int result;
+	vice_dev *vice;
+
+//	SET_MODULE_OWNER(&vice_fops); /* old cruft*/
+
+
+// devfs killed
+
+
+
+	/*
+	 * Register your major, and accept a dynamic number. This is the
+	 * first thing to do, in order to avoid releasing other module's
+	 * fops in vice_cleanup_module()
+	 */
+	result = register_chrdev(vice_major, "vice", &vice_fops);
+	if (result < 0) {
+		printk(KERN_WARNING "vice: can't get major %d\n", vice_major);
+		return result;
+	}
+	if (vice_major == 0)
+		vice_major = result;	/* dynamic */
+
+	/* 
+	 * allocate the devices -- we could have them static, but... I dunno...
+	 */
+	vice = kmalloc(sizeof(vice_dev), GFP_KERNEL);
+	vice_device=vice;
+	if (!vice) {
+		result = -ENOMEM;
+		goto fail;
+	}
+	memset(vice, 0, sizeof(vice_dev));
+
+// devfs killed
+
+
+
+	if ((result = vice_dma_init(vice)))
+		goto fail;
+	/* Initialize MSP & BSP */
+	if ((result = vice_msp_init(vice)))
+		goto fail;
+	if ((result = vice_bsp_init(vice)))
+		goto fail;
+
+	vice_write_reg(VICE_ID,0xfffff);
+#define ID_BITS 0xF
+	printk("SGI O2 VICE rev. %ld\n", vice_read_reg(VICE_ID)&ID_BITS);
+	return 0;			/* succeed */
+
+fail:
+	vice_cleanup_module();
+	return result;
+}
+
+module_init(vice_init_module);
+module_exit(vice_cleanup_module);
diff --git a/drivers/media/vice/msp.c b/drivers/media/vice/msp.c
new file mode 100644
index 0000000..7e01214
--- /dev/null
+++ b/drivers/media/vice/msp.c
@@ -0,0 +1,160 @@
+/*
+ *
+ * Copyright (C) 2002 Ilya Volynets
+ *	Sponsored by Total Knowledge
+ *	http://www.total-knowledge.com
+ *
+ * Development of this code was made possible by generous contribution
+ * from Total Knowledge (http://www.total-knowledge.com/)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * 09.16.2002	iluxa
+ *	- first rough cut. basic MSP operations supported
+ */
+
+// #include <linux/config.h>
+#include <linux/autoconf.h>
+#include <linux/module.h>
+
+#include <linux/kernel.h>   /* printk() */
+#include <asm/page.h>
+#include <linux/vmalloc.h>   /* kmalloc() */
+#include <linux/fs.h>       /* everything... */
+#include <linux/errno.h>    /* error codes */
+#include <linux/types.h>    /* size_t */
+#include <linux/proc_fs.h>
+#include <linux/fcntl.h>    /* O_ACCMODE */
+
+#include <linux/sched.h>
+
+#include <asm/system.h>     /* cli(), *_flags */
+// #include <asm/pci.h>
+#include <asm/uaccess.h>    /* put_user & friends */
+#include <asm/delay.h>
+
+/*
+ * The file operations for the msp device
+ * (some are overlayed with primary vice)
+ */
+
+#include <linux/vice.h>
+
+/* Statically allocate wait queue */
+static DECLARE_WAIT_QUEUE_HEAD(wq);
+
+/*
+ * Loads MSP PC with value form msp->pc, takes msp out of reset
+ * state (just in case?) and kicks off execution.
+ */
+static inline void msp_go(vice_dev* vice)
+{
+	vice_write_reg(MSP_CTL_STAT,MSP_GO|MSP_OPERATIONAL);
+}
+
+static inline void vice_msp_stop(void)
+{
+	u64 ctl=vice_read_reg(MSP_CTL_STAT)&(~MSP_GO);
+	vice_write_reg(MSP_CTL_STAT,ctl);
+}
+
+int vice_msp_run(vice_dev *vice, msp_run* result)
+{
+	msp_run r;
+	if(!access_ok(VERIFY_WRITE,result,sizeof(msp_run)))
+		return -EFAULT;
+	DPRINTK("Checking for MSP status\n");
+	spin_lock_irq(vice->msp_lock);
+	if(vice->msp_status!=VICE_RES_STATUS_FREE) {
+		spin_unlock_irq(vice->msp_lock);
+		return -EBUSY;
+	}
+	DPRINTK("MSP is free\n");
+	vice->msp_status=VICE_RES_STATUS_INPROGRESS;
+	spin_unlock_irq(vice->msp_lock);
+	DPRINTK("Kicking MSP off\n");
+	msp_go(vice);
+	/*
+	 * Sleep, untill MSP interrupts us...
+	 *
+	 * No spinlock is needed...
+	 */
+	DPRINTK("Falling asleep\n");
+	while(vice->msp_status==VICE_RES_STATUS_INPROGRESS) {
+		interruptible_sleep_on(&wq);
+		DPRINTK("Huh? Where am I?\n");
+		if(signal_pending(current))break;
+	}
+	DPRINTK("*yawn* obviously waking up....\n");
+	copy_from_user(&r,result,sizeof(r));
+	DPRINTK("r.reason=%x, r.pc=%x, r.status=%x\n",r.reason,r.pc,r.status);
+	r.status=vice->msp_status;
+	vice->msp_status=VICE_RES_STATUS_FREE;
+	r.pc=vice->msp_pc;
+	r.reason=vice->msp_int_reason;
+	DPRINTK("r.reason=%x, r.pc=%x, r.status=%x\n",r.reason,r.pc,r.status);
+	return copy_to_user(result,&r,sizeof(r));
+}
+
+void vice_handle_msp_int(vice_dev* vice)
+{
+	DPRINTK("Ah! We are done with MSP!\n");
+	if(vice->msp_status!=VICE_RES_STATUS_INPROGRESS) {
+		DPRINTK("Ugh... MSP interrupt while MSP isn't started from driver!\n");
+		return;
+	}
+	vice->msp_status=VICE_RES_STATUS_DONE;
+	vice->msp_pc=-1; /* No exception, no EPC, and PC is probably
+			    not one which executed Exception instruction */
+	vice->msp_int_reason=vice_read_reg(MSP_EXPT_FLAG);
+	wake_up_interruptible(&wq);
+}
+void vice_handle_msp_err(vice_dev* vice)
+{
+	DPRINTK("Ouch! MSP Exception!\n");
+	if(vice->msp_status!=VICE_RES_STATUS_INPROGRESS) {
+		DPRINTK("Ugh... MSP exception while MSP isn't started from driver!\n");
+		return;
+	}
+	vice->msp_status=VICE_RES_STATUS_ERR;
+	vice->msp_pc=(u32)vice_read_reg(MSP_EPC);
+	vice->msp_int_reason=vice_read_reg(MSP_EXPT_FLAG);
+	/* clear any exception bits */
+	vice_write_reg(MSP_EXPT_FLAG,0x00);
+	wake_up_interruptible(&wq);
+}
+
+int vice_msp_init(struct vice_dev* vice)
+{
+	spin_lock_init(&vice->dma_lock[0]);
+	return 0;
+}
+
+void vice_msp_reset(vice_dev *vice)
+{
+	/* start reset */
+	vice_write_reg(MSP_CTL_STAT,0);
+	/* wait for reset to complete */
+	udelay(1);
+	/* take out of reset, and prepare to go */
+	vice_write_reg(MSP_CTL_STAT,MSP_OPERATIONAL);
+	/* let MSP access all VICE internal RAM */
+	vice_write_reg(MSP_D_RAM,0x7);
+}
+
+void vice_msp_cleanup(vice_dev* vice)
+{
+	vice_msp_stop();
+}
diff --git a/include/linux/vice.h b/include/linux/vice.h
new file mode 100644
index 0000000..ccde8f6
--- /dev/null
+++ b/include/linux/vice.h
@@ -0,0 +1,451 @@
+/*
+ * vice.h -- definitions for the SGI O2 VICE
+ *
+ * The code used as a template for 'vice' driver
+ * came from the book "Linux Device Drivers" by
+ * Alessandro Rubini and Jonathan Corbet,
+ * published by O'Reilly & Associates
+ *
+ * Copyright (C) 2002 Ilya Volynets
+ *      Development was sponsored by Total Knowledge
+ *      http://www.total-knowledge.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * =====================================================================
+ * 09.16.2002 - iluxa
+ *     - MSP and DMA units mostly work.
+ *     - Simple ioctl interface to managing I/O buffers (just 2 4M buffers)
+ */
+
+#ifndef _VICE_H_
+#define _VICE_H_
+
+#include <linux/ioctl.h> /* needed for the _IOW etc stuff used later */
+#ifdef __KERNEL__
+#include <linux/pci.h>
+#endif
+#include <linux/types.h>	/* size_t */
+#include <asm/addrspace.h>
+
+/*
+ * Macros to help debugging
+ */
+
+#ifdef __KERNEL__
+
+#define VICE_DEBUG 1
+
+#undef DPRINTK             /* undef it, just in case */
+#ifdef VICE_DEBUG
+# define DPRINTK(fmt, args...) printk( KERN_DEBUG "vice: " fmt, ## args)
+#else
+# define DPRINTK(fmt, args...) /* not debugging: nothing */
+#endif
+
+#ifndef VICE_MAJOR
+#define VICE_MAJOR 0   /* dynamic major by default */
+#endif
+
+#define VICE_VICE 0 /* main vice device, debug, stream data through, etc. */
+
+#define VICE_MAX_TYPE 1 /* always define it to be max possible minor nr for this driver */
+
+
+
+#include <asm/ip32/crime.h>
+
+#endif /* __KERNEL__ */
+
+#define VICE_MAX_DMA_BUFFERS	1024		/* Max number of VICE_PAGE_SIZE pages that can be MMAPed by userland */
+						/* Affects size of page table */
+
+#define VICE_BASE	0x17000000 		/*Physical address...*/
+#define VICE_REG(reg)	(VICE_BASE|(reg))	/*access vice register*/
+#define VICE_IO_MAX_OFFSET	0xEFFF		/* Max offset mapped to registers (TLB is *not* accessible to userspace) */
+#define VICE_MIN_OFFSET	0x10000			/* Min offset mapped to RAM */
+#define VICE_MAX_OFFSET	VICE_MIN_OFFSET+0x800000/* Max offset mapped to RAM */
+
+#ifndef BIT
+#define BIT(x)	(0x1<<x)
+#endif /* !defined BIT */
+/*
+ * VICE Register definitions
+ */
+
+#define VICE_ID		0x0008 /* VICE revision id		size 8  ro */
+#define VICE_CFG	0xE000 /* VICE config register		size 16 rw */
+#define VICE_INT_RESET	0xE008 /* VICE reset interrupt		size 9  wo */
+#define VICE_INT_EN	0xE010 /* VICE interrupt enable		size 9  rw */
+#define HST_BSP_IN_BOX	0x0028 /* Host copy of BSP/MSP inbox	size 16 ro */
+#define HST_BSP_OUT_BOX	0x0030 /* Host copy of BSP/MSP outbox	size 16 ro */
+#define MSP_CTL_STAT	0x0040 /* MSP Control/Status register	size 32 rw */
+#define MSP_EXPT_FLAG	0x0048 /* MSP Exception flag		size 32 rw */
+#define MSP_PC		0x0050 /* MSP Program Counter		size 32 rw */
+#define MSP_BAD_ADDR	0x0058 /* MSP Bad Address		size 32 ro */
+#define MSP_WATCH_POINT	0x0060 /* MSP Watch Point address	size 32 rw */
+#define MSP_EPC		0x0068 /* MSP Exception PC		size 32 ro */
+#define MSP_CAUSE	0x0070 /* MSP Exception Cause		size 32 ro */
+#define BSP_RPAGE	0x0078 /* BSP R Page			size 16 rw */
+#define BSP_SW_INT	0x0080 /* BSP Software Interrupt	size 0  wo */
+#define MSP_D_RAM	0x0100 /* MSP Data RAM Arbitration register size 32 rw */
+#define VICEMSP_COUNT	0x0108 /* MSP Free Running Counter	size 32 ro */
+#define BSP_CTL_STAT	0x0110 /* BSP Control/Status register	size 16 rw */
+#define BSP_WATCH_POINT	0x0118 /* BSP Watch Point		size 16 rw */
+#define BSP_IN_COUNT	0x0120 /* BSP Decoded Bits counter	size 24 ro */
+#define BSP_OUT_COUNT	0x0128 /* BSP Encoded Bits counter	size 24 ro */
+/* 130, 138 -? */
+#define BSP_PC		0x0140 /* BSP Program Counter		size 16 rw */
+#define BSP_EPC		0x0148 /* BSP Exception PC		size 16 rw */
+#define BSP_HALT_RESET	0x0150 /* BSP Halt/Reset Register	size 2  ro */
+#define BSP_CAUSE	0x0158 /* BSP Exception Cause		size 16 ro */
+#define VICE_INT	0x0160 /* Interruot and Status		size 9  ro */
+#define BSP_FIFO_CTL_STAT 0x0168 /* BSP FIFO Control/Status	size 6  rw */
+#define BSP_AVALID_BITS 0x0170
+#define BSP_FVALID_BITS 0x0178
+#define DMA_CH1_CTL	0x0180 /* DMA Chennel 1 Control		size 16 rw */
+#define DMA_CH1_STAT	0x0188 /* DMA Channel 1 Status		size 16 ro */
+#define DMA_CH1_DATA	0x0190 /* DMA Channel 1 Fill Pattern	size 16 rw */
+#define DMA_CH1_MEM_PTR	0x0198 /* DMA Channel 1 Sys Mem Ptr	size 32 ro */
+#define DMA_CH1_VICE_PTR 0x01A0 /* DMA Channel 1 VICE Mem Ptr	size 16 ro */
+#define DMA_CH1_COUNT	0x01A8 /* DMA Channel 1 remaining count	size 16 ro */
+/*0x01B0 -- unused */
+#define MSP_SW_INT	0x01B8 /* MSP Software Interrupt	size 0  wo */
+#define DMA_CH2_CTL	0x01C0 /* DMA Chennel 2 Control		size 16 rw */
+#define DMA_CH2_STAT	0x01C8 /* DMA Channel 2 Status		size 16 ro */
+#define DMA_CH2_DATA	0x01D0 /* DMA Channel 2 Fill Pattern	size 16 rw */
+#define DMA_CH2_MEM_PTR	0x01D8 /* DMA Channel 2 Sys Mem Ptr	size 32 ro */
+#define DMA_CH2_VICE_PTR 0x01E0 /* DMA Channel 2 VICE Mem Ptr	size 16 ro */
+#define DMA_CH2_COUNT	0x01E8 /* DMA Channel 2 remaining count	size 16 ro */
+#define BSP_INBOX	0x01F0 /* BSP inbox			size 16 ro */
+#define BSP_OUTBOX	0x01F8 /* BSP outbox			size 16 rw */
+
+/* VICE RAM's */
+#define MSP_IRAM	0x2000 /* MSP instruction RAM base, length 4K */
+#define BSP_IRAM	0x4000 /* BSP instruction RAM base, length 4K */
+#define BSP_TABLE	0x5000 /* BSP Tables, length 8K */
+#define BSP_IO_IN	0x7800 /* BSP Input buffers, length 2K */
+#define BSP_IO_OUT	0x7000 /* BSP Output buffers, length 2K */
+#define VICE_DRAM_A	0x8000 /* Data RAM Bank A, , length 2K */
+#define VICE_DRAM_B	0x8800 /* Data RAM Bank B, , length 2K */
+#define VICE_DRAM_C	0x9000 /* Data RAM Bank C, , length 2K */
+
+/* VICE Interrupt status bits */
+#define VICE_INT_DMA_CH1_DONE	BIT(0)
+#define VICE_INT_DMA_CH1_ERR	BIT(1)
+#define VICE_INT_MSP_SW		BIT(2)	/* MSP wants to interrupt host (Program is finished?) */
+#define VICE_INT_MSP_ERR	BIT(3)	/* MSP exception */
+#define VICE_INT_BSP_SW		BIT(4)	/* BSP wants to interrupt host (Program is finished?) */
+#define VICE_INT_BSP_ERR	BIT(5)	/* BSP exception */
+#define VICE_INT_BUSERR		BIT(6)	/* ?? Erroneous data received through SysAD interface */
+#define VICE_INT_DMA_CH2_DONE	BIT(7)
+#define VICE_INT_DMA_CH2_ERR	BIT(8)
+
+/*
+ * VICE DMA Describtor related definitions
+ */
+
+/* Flags */
+#define VICE_DMA_HALT BIT(15)
+#define VICE_DMA_SKIP BIT(14)
+#define VICE_DMA_TOVICE  BIT(13)	/* 1=transaction is System->VICE, 0=VICE->System */
+#define VICE_DMA_FILL BIT(12)	/* 1=Pattern fill VICE memory from VICEDMA_DATA register \
+				   0=normal VICE<->System transaction */
+/* flags (11:10) */
+#define VICE_DMA_YC_NONE    (0x0<<10) /* Just plain pump it through */
+#define VICE_DMA_YC_422_420 (0x1<<10) /* Y/C 4:2:2 to Y/C 4:2:0 split */
+#define VICE_DMA_YC_422_422 (0x2<<10) /* Y/C 4:2:2 to Y/C 4:2:2 split */
+#define VICE_DMA_YC_422_Y   (0x3<<10) /* Y/C 4:2:2 to Y split -- DMA read only */
+
+/* flags(9:8) */
+#define VICE_DMA_HP_FF	(0x0<<8) /* Full Pel Vert	Full Pel Horz */
+#define VICE_DMA_HP_FH	(0x1<<8) /* Full Pel Vert	Half Pel Horz */
+#define VICE_DMA_HP_HF	(0x2<<8) /* Half Pel Vert	Full Pel Horz */
+#define VICE_DMA_HP_HH	(0x3<<8) /* Half Pel Vert	Half Pel Horz */
+
+#define VICE_DMA_ILV BIT(7) /* 0=Process describtor individually, \
+			       1=Pcocess describtors as pairs and \
+			       interleave them into VICE memory */
+/* Source/Destination location within VICE FLAGS(6:4)*/
+#define VICE_DMA_LOC_DRAMA   (0x0<<4) /* Data RAM A          */
+#define VICE_DMA_LOC_DRAMB   (0x1<<4) /* Data RAM B          */
+#define VICE_DMA_LOC_DRAMC   (0x2<<4) /* Data RAM C          */
+#define VICE_DMA_LOC_MSPI    (0x3<<4) /* MSP Instruction RAM */
+#define VICE_DMA_LOC_BSPI    (0x4<<4) /* BSP Instruction RAM */
+#define VICE_DMA_LOC_BSPTBL  (0x5<<4) /* BSP Table RAM       */
+#define VICE_DMA_LOC_BSPFIFO (0x6<<4) /* BSP Decode FIFO     */
+#define VICE_DMA_LOC_TLB     (0x7<<4) /* DMA TLB RAM         */
+
+#define VICE_DMA_HPEN BIT(3) /* 0=Half Pel mode disabled -- ignore 8:9 */
+
+typedef struct vice_dma_desc
+{
+	u64 flags;		/* See above for definitions of various bits */
+	u64 sys_addr_hi;	/* High word of system memory address */
+	u64 sys_addr_lo;	/* Low word of system memory address */
+	u64 span;		/* Length of one line */
+	u64 stride;		/* Number of bytes to skip between lines */
+	u64 line_count;	/* Number of lines */
+	u64 vice_addr_Y;	/* VICE memory address */
+	u64 vice_addr_C;	/* VICE mem address for Y/C translated mode transfers */
+} vice_dma_desc;
+
+#define DMA_DESCRIBTORS_BASE	0x1000
+#define VICE_DMA_DESC(x)	(DMA_DESCRIBTORS_BASE+((x)*sizeof(vice_dma_desc)))
+
+/*
+ * VICE DMA has eight descriptors -- 4 for each channel
+ */
+#define VICE_DMA_CH1_D1		VICE_DMA_DESC(0)
+#define VICE_DMA_CH1_D2		VICE_DMA_DESC(1)
+#define VICE_DMA_CH1_D3		VICE_DMA_DESC(2)
+#define VICE_DMA_CH1_D4		VICE_DMA_DESC(3)
+#define VICE_DMA_CH2_D1		VICE_DMA_DESC(4)
+#define VICE_DMA_CH2_D2		VICE_DMA_DESC(5)
+#define VICE_DMA_CH2_D3		VICE_DMA_DESC(6)
+#define VICE_DMA_CH2_D4		VICE_DMA_DESC(7)
+
+/* VICE DMA control register bits */
+#define VICE_DMA_CTL_GO		BIT(0) /* Write 1 to kick off DMA */
+#define VICE_DMA_CTL_IE		BIT(1) /* 1=Interrupt on DMA completion, 0=No interrupt */
+#define VICE_DMA_CTL_STOP	BIT(2) /* Write 1 to stop DMA */
+#define VICE_DMA_CTL_RESET	BIT(3) /* 1=Reset DMA engine, write 0 to allow it to run again */
+#define VICE_DMA_CTL_DESC1	BIT(4) /* Start DMA with descriptor 1 */
+#define VICE_DMA_CTL_DESC2	BIT(5) /* Start DMA with descriptor 2 */
+#define VICE_DMA_CTL_DESC3	BIT(6) /* Start DMA with descriptor 3 */
+#define VICE_DMA_CTL_DESC4	BIT(7) /* Start DMA with descriptor 4 */
+#define VICE_DMA_CTL_TLB_BYPASS	BIT(8) /* Bypass TLB for this transaction */
+#define VICE_DMA_CTL_FLUSH_BUF	BIT(9) /* What the hell does this do? */
+
+/*
+ * DMA TLB definitions
+ */
+
+#define VICE_PAGE_SHIFT 16
+#define VICE_PAGE_ORDER 4
+#define VICE_PAGE_SIZE (1<<VICE_PAGE_SHIFT)
+#define VICE_PAGE_MASK 0xFFFF0000	/* VICE DMA TLB works with 64K pages aligned on 64K boundary */
+#define VICE_TLB_OFFSET 0xF000		/* Vice TLB starts here. Range is F000-FFFC */
+#define VICE_TLB_ENTRIES 64		/* Number of TLB entried in VICE */
+
+#define VICE_DMA_LINEAR	0x00800000	/* Linear access to system memory */
+#define VICE_DMA_TILED	0x10800000	/* Tiled access to system memory */
+
+/*
+ * TLB Entry format
+ */
+#define VICE_TLB_VALID		BIT(0)
+#define VICE_TLB_WRITABLE	BIT(1)
+
+/*
+ * MSP definitions
+ */
+
+#define MSP_GO	BIT(0)	/* writing MSP_GO to MSP_CTL_STAT register starts MSP */
+#define MSP_OPERATIONAL BIT(1) /* Actually you have to write 1 to take it out of reset... Ugh */
+
+/*
+ * BSP definitions
+ */
+#define BSP_RESET           BIT(0) /* write 1 to reset BSP, 0 to take out of reset*/
+#define BSP_HALT            BIT(1) /* write 0 to start BSP, write 1 to halt it, when set to 1, BSP is halted */
+#define BSP_HALT_ACK        BIT(2) /* reads as 1, when BSP recognised HALT request (and completed everything) */
+
+#define BSP_FIFO_CTL_RESET  BIT(2)
+
+#define MAX_BSP_HALT_WAIT              10 /*max time to vait for BSP halt before reset */
+
+/*
+ * VICE IOCTL related definitions
+ */
+#define VICE_RES_STATUS_FREE		0
+#define VICE_RES_STATUS_INPROGRESS	1
+#define VICE_RES_STATUS_DONE		2
+#define VICE_RES_STATUS_ERR		3
+
+
+typedef struct dma_run
+{
+	u32 channel;
+	u32 desc;
+	u32 status;
+} dma_run;
+
+typedef struct msp_run
+{
+	u32 pc; /* PC, where MSP have finished running (either took exception, or did SW int) */
+	u32 reason; /* MSP_EXPT_CAUSE */
+	u32 status; /* Whether MSP took exception or did SW int */
+} msp_run;
+
+typedef struct bsp_run
+{
+	u32 start_pc;
+	u32 end_pc;
+	u32 reason;
+	u32 status;
+} bsp_run;
+
+/* Must be written all at once. Should I make a union of it with u32? */
+typedef struct vice_tlb_entry
+{
+	u16 page_num; /* Physical 64K page number */
+	u16 flags; /* Bit 0 - valid, bit 1 writable, rest undefined */
+} vice_tlb_entry;
+
+
+#ifdef __KERNEL__
+struct vice_dev;
+
+typedef struct vice_dev {
+	struct semaphore sem;     /* mutual exclusion semaphore     */
+	spinlock_t vice_lock;     /* locking whole VICE device */
+	u32 isopen;               /* set this on open, unset on close */
+
+	vice_dma_desc* ch1;       /* current DMA decriptor for channel 1 */
+	vice_dma_desc* ch2;       /* current DMA decriptor for channel 2 */
+
+	u32 ch1_dma_stat;         /* Various flags related to DMA in progress */
+	u32 ch2_dma_stat;         /* Various flags related to DMA in progress */
+
+	spinlock_t dma_lock[2];   /* spinlocks for accessing dma status for 2 VICE DMA channels */
+	u32 dma_status[2];        /* status of dma channels */
+
+	dma_addr_t dma_mem[VICE_TLB_ENTRIES*2]; /* 2 sets 64*64K pages, used for DMA to/from VICE */
+	void* dma_kmem[VICE_TLB_ENTRIES*2]; /* 2 sets 64*64K pages, used for DMA to/from VICE */
+
+	/*
+	  vice_page *page_table;
+	  unsigned int page_cnt;
+	*/
+
+	/* MSP stuff */
+	u32 msp_pc;			/* PC where MSP stopped (EPC) */
+	u32 msp_int_reason;		/* Reason MSP stopped */
+	u32 msp_status;		/* Free/Working/Done/Error */
+	spinlock_t msp_lock;	/* spinlock for accessing MSP status */
+
+	/* BSP stuff */
+	u32 bsp_pc;			/* PC where BSP stopped (EPC) */
+	u32 bsp_int_reason;		/* Reason BSP stopped */
+	u32 bsp_status;		/* Free/Working/Done/Error */
+	spinlock_t bsp_lock;	/* spinlock for accessing BSP status */
+} vice_dev;
+
+#endif /* __KERNEL__ */
+
+#define VICE_DMA_STAT_DATA	BIT(0)
+#define VICE_DMA_STAT_MSP_CODE	BIT(1)
+#define VICE_DMA_STAT_BSP_CODE	BIT(2)
+#define VICE_DMA_STAT_BSP_TBL	BIT(3)
+#define VICE_DMA_STAT_DIR	BIT(4)	/* 0 - to VICE, 1 to system */
+
+/*
+ * VICE ioctl commands
+ */
+
+#define VICE_IOCTL_MAGIC	0x96
+#define VICE_IOCTL_MAP_DMA	_IOR(VICE_IOCTL_MAGIC,1,u32)
+#define VICE_IOCTL_MSP_RUN	_IOR(VICE_IOCTL_MAGIC,2,msp_run)
+#define VICE_IOCTL_BSP_RUN	_IOR(VICE_IOCTL_MAGIC,3,bsp_run)
+#define VICE_IOCTL_DO_DMA	_IOWR(VICE_IOCTL_MAGIC,4,dma_run)
+
+#ifdef __KERNEL__
+/* Vice wait queue */
+
+static inline void vice_write_reg(u32 reg,u64 value)
+{
+//KSEG1ADDR->CKSEG1ADDR
+	*(volatile u64*)(CKSEG1ADDR(VICE_REG(reg)))=value;
+}
+static inline u64 vice_read_reg(u32 reg)
+{
+	return *(volatile u64*)(CKSEG1ADDR(VICE_REG(reg)));
+}
+
+static inline void vice_write_32(u32 addr,u32 value)
+{
+	*(volatile u32*)(CKSEG1ADDR(VICE_REG(addr)))=value;
+}
+static inline u32 vice_read_32(u32 addr)
+{
+	return *(volatile u32*)(CKSEG1ADDR(VICE_REG(addr)));
+}
+
+static inline void vice_write_16(u32 addr,u16 value)
+{
+	*(volatile u16*)(CKSEG1ADDR(VICE_REG(addr)))=value;
+}
+static inline u16 vice_read_16(u32 addr)
+{
+	return *(volatile u16*)(CKSEG1ADDR(VICE_REG(addr)));
+}
+
+int vice_dma_map_set(vice_dev *vice,unsigned long set);
+
+/*
+ * Some DMA-related inline functions
+ */
+
+static inline int vice_dma_mem_init(vice_dev *vice)
+{
+	int i;
+	for (i=0; i<64*2;i++){
+		if(!(vice->dma_kmem[i]=
+		     pci_alloc_consistent(0,VICE_PAGE_SIZE,&(vice->dma_mem[i])))) {
+			DPRINTK("failed at page# %i\n",i);
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+static inline void vice_dma_mem_free(vice_dev *vice)
+{
+	int i;
+	for (i=0; i<64*2;i++){
+		if(vice->dma_kmem[i]) {
+			pci_free_consistent(0,VICE_PAGE_ORDER,vice->dma_kmem[i],vice->dma_mem[i]);
+			vice->dma_kmem[i]=0;
+			vice->dma_mem[i]=0;
+		}
+	}
+}
+
+int vice_msp_init(vice_dev* vice);
+int vice_bsp_init(vice_dev* vice);
+int vice_dma_init(vice_dev* vice);
+
+void vice_msp_reset(vice_dev* vice);
+void vice_bsp_reset(vice_dev* vice);
+void vice_dma_reset(vice_dev* vice);
+
+void vice_msp_cleanup(vice_dev* vice);
+void vice_bsp_cleanup(vice_dev* vice);
+void vice_dma_cleanup(vice_dev* vice);
+
+void vice_dma_done(vice_dev* vice, int channel);
+void vice_dma_err(vice_dev* vice, int channel);
+void vice_handle_msp_int(vice_dev* vice);
+void vice_handle_msp_err(vice_dev* vice);
+void vice_handle_bsp_int(vice_dev* vice);
+void vice_handle_bsp_err(vice_dev* vice);
+void vice_handle_bus_err(vice_dev* vice);
+
+int vice_dma_run(vice_dev* vice,dma_run* run);
+int vice_msp_run(vice_dev* vice,msp_run* run);
+int vice_bsp_run(vice_dev* vice,bsp_run* run);
+#endif /* __KERNEL__ */
+
+#endif /* _VICE_H_ */



      
