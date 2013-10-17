Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2013 04:16:54 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:52418 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823119Ab3JQCOtLvOIK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Oct 2013 04:14:49 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VWd6o-00047p-AY; Wed, 16 Oct 2013 21:14:42 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH 6/6] MIPS: APRP: Code formatting clean-ups.
Date:   Wed, 16 Oct 2013 21:14:30 -0500
Message-Id: <1381976070-8413-7-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com>
References: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Clean-up code according to the 'checkpatch.pl' script.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Reviewed-by: Qais Yousef <Qais.Yousef@imgtec.com>
---
 arch/mips/include/asm/amon.h     |   15 ++-
 arch/mips/include/asm/rtlx.h     |    5 +-
 arch/mips/include/asm/vpe.h      |   19 +--
 arch/mips/kernel/rtlx.c          |  134 ++++++++------------
 arch/mips/kernel/vpe-mt.c        |    6 +-
 arch/mips/kernel/vpe.c           |  252 +++++++++++++++++---------------------
 arch/mips/mti-malta/malta-amon.c |   24 ++--
 arch/mips/mti-malta/malta-int.c  |  115 +++++++++--------
 8 files changed, 250 insertions(+), 320 deletions(-)

diff --git a/arch/mips/include/asm/amon.h b/arch/mips/include/asm/amon.h
index 3bd6e76..3cc03c6 100644
--- a/arch/mips/include/asm/amon.h
+++ b/arch/mips/include/asm/amon.h
@@ -1,7 +1,12 @@
 /*
- * Amon support
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Imagination Technologies Ltd.
+ *
+ * Arbitrary Monitor Support (AMON)
  */
-
-int amon_cpu_avail(int);
-int amon_cpu_start(int, unsigned long, unsigned long,
-		   unsigned long, unsigned long);
+int amon_cpu_avail(int cpu);
+int amon_cpu_start(int cpu, unsigned long pc, unsigned long sp,
+		   unsigned long gp, unsigned long a0);
diff --git a/arch/mips/include/asm/rtlx.h b/arch/mips/include/asm/rtlx.h
index fa86dfd..c102065 100644
--- a/arch/mips/include/asm/rtlx.h
+++ b/arch/mips/include/asm/rtlx.h
@@ -1,8 +1,11 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2013 Imagination Technologies Ltd.
  */
-
 #ifndef __ASM_RTLX_H_
 #define __ASM_RTLX_H_
 
diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
index becd555..e0684f5 100644
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -1,22 +1,11 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2013 Imagination Technologies Ltd.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
  */
-
 #ifndef _ASM_VPE_H
 #define _ASM_VPE_H
 
diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index cd78618..8053b4e 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -1,46 +1,23 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2005, 06 Ralf Baechle (ralf@linux-mips.org)
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
+ * Copyright (C) 2013 Imagination Technologies Ltd.
  */
-
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
-#include <linux/init.h>
-#include <asm/uaccess.h>
-#include <linux/list.h>
-#include <linux/vmalloc.h>
-#include <linux/elf.h>
-#include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/moduleloader.h>
-#include <linux/interrupt.h>
-#include <linux/poll.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
+#include <linux/atomic.h>
 #include <asm/mipsmtregs.h>
 #include <asm/mips_mt.h>
-#include <asm/cacheflush.h>
-#include <linux/atomic.h>
-#include <asm/cpu.h>
 #include <asm/processor.h>
-#include <asm/vpe.h>
 #include <asm/rtlx.h>
 #include <asm/setup.h>
+#include <asm/vpe.h>
 
 static int sp_stopping;
 struct rtlx_info *rtlx;
@@ -53,22 +30,22 @@ static void __used dump_rtlx(void)
 {
 	int i;
 
-	printk("id 0x%lx state %d\n", rtlx->id, rtlx->state);
+	pr_info("id 0x%lx state %d\n", rtlx->id, rtlx->state);
 
 	for (i = 0; i < RTLX_CHANNELS; i++) {
 		struct rtlx_channel *chan = &rtlx->channel[i];
 
-		printk(" rt_state %d lx_state %d buffer_size %d\n",
-		       chan->rt_state, chan->lx_state, chan->buffer_size);
+		pr_info(" rt_state %d lx_state %d buffer_size %d\n",
+			chan->rt_state, chan->lx_state, chan->buffer_size);
 
-		printk(" rt_read %d rt_write %d\n",
-		       chan->rt_read, chan->rt_write);
+		pr_info(" rt_read %d rt_write %d\n",
+			chan->rt_read, chan->rt_write);
 
-		printk(" lx_read %d lx_write %d\n",
-		       chan->lx_read, chan->lx_write);
+		pr_info(" lx_read %d lx_write %d\n",
+			chan->lx_read, chan->lx_write);
 
-		printk(" rt_buffer <%s>\n", chan->rt_buffer);
-		printk(" lx_buffer <%s>\n", chan->lx_buffer);
+		pr_info(" rt_buffer <%s>\n", chan->rt_buffer);
+		pr_info(" lx_buffer <%s>\n", chan->lx_buffer);
 	}
 }
 
@@ -76,8 +53,7 @@ static void __used dump_rtlx(void)
 static int rtlx_init(struct rtlx_info *rtlxi)
 {
 	if (rtlxi->id != RTLX_ID) {
-		printk(KERN_ERR "no valid RTLX id at 0x%p 0x%lx\n",
-			rtlxi, rtlxi->id);
+		pr_err("no valid RTLX id at 0x%p 0x%lx\n", rtlxi, rtlxi->id);
 		return -ENOEXEC;
 	}
 
@@ -93,7 +69,7 @@ void rtlx_starting(int vpe)
 	sp_stopping = 0;
 
 	/* force a reload of rtlx */
-	rtlx=NULL;
+	rtlx = NULL;
 
 	/* wake up any sleeping rtlx_open's */
 	for (i = 0; i < RTLX_CHANNELS; i++)
@@ -118,30 +94,31 @@ int rtlx_open(int index, int can_sleep)
 	int ret = 0;
 
 	if (index >= RTLX_CHANNELS) {
-		printk(KERN_DEBUG "rtlx_open index out of range\n");
+		pr_debug("rtlx_open index out of range\n");
 		return -ENOSYS;
 	}
 
 	if (atomic_inc_return(&channel_wqs[index].in_open) > 1) {
-		printk(KERN_DEBUG "rtlx_open channel %d already opened\n",
-		       index);
+		pr_debug("rtlx_open channel %d already opened\n", index);
 		ret = -EBUSY;
 		goto out_fail;
 	}
 
 	if (rtlx == NULL) {
-		if( (p = vpe_get_shared(tclimit)) == NULL) {
-		    if (can_sleep) {
-			__wait_event_interruptible(channel_wqs[index].lx_queue,
-				(p = vpe_get_shared(tclimit)), ret);
-			if (ret)
+		p = vpe_get_shared(aprp_cpu_index());
+		if (p == NULL) {
+			if (can_sleep) {
+				__wait_event_interruptible(
+					channel_wqs[index].lx_queue,
+					(p = vpe_get_shared(aprp_cpu_index())),
+					ret);
+				if (ret)
+					goto out_fail;
+			} else {
+				pr_debug("No SP program loaded, and device opened with O_NONBLOCK\n");
+				ret = -ENOSYS;
 				goto out_fail;
-		    } else {
-			printk(KERN_DEBUG "No SP program loaded, and device "
-					"opened with O_NONBLOCK\n");
-			ret = -ENOSYS;
-			goto out_fail;
-		    }
+			}
 		}
 
 		smp_rmb();
@@ -163,24 +140,24 @@ int rtlx_open(int index, int can_sleep)
 					ret = -ERESTARTSYS;
 					goto out_fail;
 				}
-				finish_wait(&channel_wqs[index].lx_queue, &wait);
+				finish_wait(&channel_wqs[index].lx_queue,
+					    &wait);
 			} else {
-				pr_err(" *vpe_get_shared is NULL. "
-				       "Has an SP program been loaded?\n");
+				pr_err(" *vpe_get_shared is NULL. Has an SP program been loaded?\n");
 				ret = -ENOSYS;
 				goto out_fail;
 			}
 		}
 
 		if ((unsigned int)*p < KSEG0) {
-			printk(KERN_WARNING "vpe_get_shared returned an "
-			       "invalid pointer maybe an error code %d\n",
-			       (int)*p);
+			pr_warn("vpe_get_shared returned an invalid pointer maybe an error code %d\n",
+				(int)*p);
 			ret = -ENOSYS;
 			goto out_fail;
 		}
 
-		if ((ret = rtlx_init(*p)) < 0)
+		ret = rtlx_init(*p);
+		if (ret < 0)
 			goto out_ret;
 	}
 
@@ -312,7 +289,7 @@ ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
 	size_t fl;
 
 	if (rtlx == NULL)
-		return(-ENOSYS);
+		return -ENOSYS;
 
 	rt = &rtlx->channel[index];
 
@@ -321,8 +298,8 @@ ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
 	rt_read = rt->rt_read;
 
 	/* total number of bytes to copy */
-	count = min(count, (size_t)write_spacefree(rt_read, rt->rt_write,
-							rt->buffer_size));
+	count = min_t(size_t, count, write_spacefree(rt_read, rt->rt_write,
+						     rt->buffer_size));
 
 	/* first bit from write pointer to the end of the buffer, or count */
 	fl = min(count, (size_t) rt->buffer_size - rt->rt_write);
@@ -332,9 +309,8 @@ ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
 		goto out;
 
 	/* if there's any left copy to the beginning of the buffer */
-	if (count - fl) {
+	if (count - fl)
 		failed = copy_from_user(rt->rt_buffer, buffer + fl, count - fl);
-	}
 
 out:
 	count -= failed;
@@ -360,7 +336,7 @@ static int file_release(struct inode *inode, struct file *filp)
 	return rtlx_release(iminor(inode));
 }
 
-static unsigned int file_poll(struct file *file, poll_table * wait)
+static unsigned int file_poll(struct file *file, poll_table *wait)
 {
 	int minor = iminor(file_inode(file));
 	unsigned int mask = 0;
@@ -382,21 +358,20 @@ static unsigned int file_poll(struct file *file, poll_table * wait)
 	return mask;
 }
 
-static ssize_t file_read(struct file *file, char __user * buffer, size_t count,
-			 loff_t * ppos)
+static ssize_t file_read(struct file *file, char __user *buffer, size_t count,
+			 loff_t *ppos)
 {
 	int minor = iminor(file_inode(file));
 
 	/* data available? */
-	if (!rtlx_read_poll(minor, (file->f_flags & O_NONBLOCK) ? 0 : 1)) {
-		return 0;	// -EAGAIN makes cat whinge
-	}
+	if (!rtlx_read_poll(minor, (file->f_flags & O_NONBLOCK) ? 0 : 1))
+		return 0;	/* -EAGAIN makes 'cat' whine */
 
 	return rtlx_read(minor, buffer, count);
 }
 
-static ssize_t file_write(struct file *file, const char __user * buffer,
-			  size_t count, loff_t * ppos)
+static ssize_t file_write(struct file *file, const char __user *buffer,
+			  size_t count, loff_t *ppos)
 {
 	int minor = iminor(file_inode(file));
 
@@ -419,11 +394,11 @@ static ssize_t file_write(struct file *file, const char __user * buffer,
 
 const struct file_operations rtlx_fops = {
 	.owner =   THIS_MODULE,
-	.open =	   file_open,
+	.open =    file_open,
 	.release = file_release,
 	.write =   file_write,
-	.read =	   file_read,
-	.poll =	   file_poll,
+	.read =    file_read,
+	.poll =    file_poll,
 	.llseek =  noop_llseek,
 };
 
@@ -433,4 +408,3 @@ module_exit(rtlx_module_exit);
 MODULE_DESCRIPTION("MIPS RTLX");
 MODULE_AUTHOR("Elizabeth Oldham, MIPS Technologies, Inc.");
 MODULE_LICENSE("GPL");
-
diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
index 323ca69..daccee4 100644
--- a/arch/mips/kernel/vpe-mt.c
+++ b/arch/mips/kernel/vpe-mt.c
@@ -28,7 +28,7 @@ static int hw_tcs, hw_vpes;
 int vpe_run(struct vpe *v)
 {
 	unsigned long flags, val, dmt_flag;
-	struct vpe_notifications *n;
+	struct vpe_notifications *notifier;
 	unsigned int vpeflags;
 	struct tc *t;
 
@@ -141,8 +141,8 @@ int vpe_run(struct vpe *v)
 	emt(dmt_flag);
 	local_irq_restore(flags);
 
-	list_for_each_entry(n, &v->notify, list)
-		n->start(VPE_MODULE_MINOR);
+	list_for_each_entry(notifier, &v->notify, list)
+		notifier->start(VPE_MODULE_MINOR);
 
 	return 0;
 }
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 61dfd5b..42d3ca0 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -1,37 +1,22 @@
 /*
- * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- */
-
-/*
- * VPE support module
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- * Provides support for loading a MIPS SP program on VPE1.
- * The SP environment is rather simple, no tlb's.  It needs to be relocatable
- * (or partially linked). You should initialise your stack in the startup
- * code. This loader looks for the symbol __start and sets up
- * execution to resume from there. The MIPS SDE kit contains suitable examples.
+ * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2013 Imagination Technologies Ltd.
  *
- * To load and run, simply cat a SP 'program file' to /dev/vpe1.
- * i.e cat spapp >/dev/vpe1.
+ * VPE spport module for loading a MIPS SP program into VPE1. The SP
+ * environment is rather simple since there are no TLBs. It needs
+ * to be relocatable (or partiall linked). Initialize your stack in
+ * the startup-code. The loader looks for the symbol __start and sets
+ * up the execution to resume from there. To load and run, simply do
+ * a cat SP 'binary' to the /dev/vpe1 device.
  */
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/init.h>
-#include <asm/uaccess.h>
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/vmalloc.h>
@@ -46,7 +31,6 @@
 #include <asm/mipsmtregs.h>
 #include <asm/cacheflush.h>
 #include <linux/atomic.h>
-#include <asm/cpu.h>
 #include <asm/mips_mt.h>
 #include <asm/processor.h>
 #include <asm/vpe.h>
@@ -109,8 +93,9 @@ struct vpe *alloc_vpe(int minor)
 {
 	struct vpe *v;
 
-	if ((v = kzalloc(sizeof(struct vpe), GFP_KERNEL)) == NULL)
-		return NULL;
+	v = kzalloc(sizeof(struct vpe), GFP_KERNEL);
+	if (v == NULL)
+		goto out;
 
 	INIT_LIST_HEAD(&v->tc);
 	spin_lock(&vpecontrol.vpe_list_lock);
@@ -120,6 +105,7 @@ struct vpe *alloc_vpe(int minor)
 	INIT_LIST_HEAD(&v->notify);
 	v->minor = VPE_MODULE_MINOR;
 
+out:
 	return v;
 }
 
@@ -128,7 +114,8 @@ struct tc *alloc_tc(int index)
 {
 	struct tc *tc;
 
-	if ((tc = kzalloc(sizeof(struct tc), GFP_KERNEL)) == NULL)
+	tc = kzalloc(sizeof(struct tc), GFP_KERNEL);
+	if (tc == NULL)
 		goto out;
 
 	INIT_LIST_HEAD(&tc->tc);
@@ -151,7 +138,7 @@ void release_vpe(struct vpe *v)
 	kfree(v);
 }
 
-/* Find some VPE program space	*/
+/* Find some VPE program space */
 void *alloc_progmem(unsigned long len)
 {
 	void *addr;
@@ -179,7 +166,7 @@ void release_progmem(void *ptr)
 }
 
 /* Update size with this section: return offset. */
-static long get_offset(unsigned long *size, Elf_Shdr * sechdr)
+static long get_offset(unsigned long *size, Elf_Shdr *sechdr)
 {
 	long ret;
 
@@ -192,8 +179,8 @@ static long get_offset(unsigned long *size, Elf_Shdr * sechdr)
    might -- code, read-only data, read-write data, small data.	Tally
    sizes, and place the offsets into sh_entsize fields: high bit means it
    belongs in init. */
-static void layout_sections(struct module *mod, const Elf_Ehdr * hdr,
-			    Elf_Shdr * sechdrs, const char *secstrings)
+static void layout_sections(struct module *mod, const Elf_Ehdr *hdr,
+			    Elf_Shdr *sechdrs, const char *secstrings)
 {
 	static unsigned long const masks[][2] = {
 		/* NOTE: all executable code must be the first section
@@ -213,7 +200,6 @@ static void layout_sections(struct module *mod, const Elf_Ehdr * hdr,
 		for (i = 0; i < hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &sechdrs[i];
 
-			//  || strncmp(secstrings + s->sh_name, ".init", 5) == 0)
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL)
@@ -228,7 +214,6 @@ static void layout_sections(struct module *mod, const Elf_Ehdr * hdr,
 	}
 }
 
-
 /* from module-elf32.c, but subverted a little */
 
 struct mips_hi16 {
@@ -251,20 +236,18 @@ static int apply_r_mips_gprel16(struct module *me, uint32_t *location,
 {
 	int rel;
 
-	if( !(*location & 0xffff) ) {
+	if (!(*location & 0xffff)) {
 		rel = (int)v - gp_addr;
-	}
-	else {
+	} else {
 		/* .sbss + gp(relative) + offset */
 		/* kludge! */
 		rel =  (int)(short)((int)v + gp_offs +
 				    (int)(short)(*location & 0xffff) - gp_addr);
 	}
 
-	if( (rel > 32768) || (rel < -32768) ) {
-		printk(KERN_DEBUG "VPE loader: apply_r_mips_gprel16: "
-		       "relative address 0x%x out of range of gp register\n",
-		       rel);
+	if ((rel > 32768) || (rel < -32768)) {
+		pr_debug("VPE loader: apply_r_mips_gprel16: relative address 0x%x out of range of gp register\n",
+			 rel);
 		return -ENOEXEC;
 	}
 
@@ -278,12 +261,12 @@ static int apply_r_mips_pc16(struct module *me, uint32_t *location,
 {
 	int rel;
 	rel = (((unsigned int)v - (unsigned int)location));
-	rel >>= 2;		// because the offset is in _instructions_ not bytes.
-	rel -= 1;		// and one instruction less due to the branch delay slot.
+	rel >>= 2; /* because the offset is in _instructions_ not bytes. */
+	rel -= 1;  /* and one instruction less due to the branch delay slot. */
 
-	if( (rel > 32768) || (rel < -32768) ) {
-		printk(KERN_DEBUG "VPE loader: "
-		       "apply_r_mips_pc16: relative address out of range 0x%x\n", rel);
+	if ((rel > 32768) || (rel < -32768)) {
+		pr_debug("VPE loader: apply_r_mips_pc16: relative address out of range 0x%x\n",
+			 rel);
 		return -ENOEXEC;
 	}
 
@@ -304,8 +287,7 @@ static int apply_r_mips_26(struct module *me, uint32_t *location,
 			   Elf32_Addr v)
 {
 	if (v % 4) {
-		printk(KERN_DEBUG "VPE loader: apply_r_mips_26 "
-		       " unaligned relocation\n");
+		pr_debug("VPE loader: apply_r_mips_26: unaligned relocation\n");
 		return -ENOEXEC;
 	}
 
@@ -336,7 +318,7 @@ static int apply_r_mips_hi16(struct module *me, uint32_t *location,
 	 * the carry we need to add.  Save the information, and let LO16 do the
 	 * actual relocation.
 	 */
-	n = kmalloc(sizeof *n, GFP_KERNEL);
+	n = kmalloc(sizeof(*n), GFP_KERNEL);
 	if (!n)
 		return -ENOMEM;
 
@@ -368,9 +350,7 @@ static int apply_r_mips_lo16(struct module *me, uint32_t *location,
 			 * The value for the HI16 had best be the same.
 			 */
 			if (v != l->value) {
-				printk(KERN_DEBUG "VPE loader: "
-				       "apply_r_mips_lo16/hi16: \t"
-				       "inconsistent value information\n");
+				pr_debug("VPE loader: apply_r_mips_lo16/hi16: inconsistent value information\n");
 				goto out_free;
 			}
 
@@ -466,20 +446,19 @@ static int apply_relocations(Elf32_Shdr *sechdrs,
 			+ ELF32_R_SYM(r_info);
 
 		if (!sym->st_value) {
-			printk(KERN_DEBUG "%s: undefined weak symbol %s\n",
-			       me->name, strtab + sym->st_name);
+			pr_debug("%s: undefined weak symbol %s\n",
+				 me->name, strtab + sym->st_name);
 			/* just print the warning, dont barf */
 		}
 
 		v = sym->st_value;
 
 		res = reloc_handlers[ELF32_R_TYPE(r_info)](me, location, v);
-		if( res ) {
+		if (res) {
 			char *r = rstrs[ELF32_R_TYPE(r_info)];
-			printk(KERN_WARNING "VPE loader: .text+0x%x "
-			       "relocation type %s for symbol \"%s\" failed\n",
-			       rel[i].r_offset, r ? r : "UNKNOWN",
-			       strtab + sym->st_name);
+			pr_warn("VPE loader: .text+0x%x relocation type %s for symbol \"%s\" failed\n",
+				rel[i].r_offset, r ? r : "UNKNOWN",
+				strtab + sym->st_name);
 			return res;
 		}
 	}
@@ -494,10 +473,8 @@ static inline void save_gp_address(unsigned int secbase, unsigned int rel)
 }
 /* end module-elf32.c */
 
-
-
 /* Change all symbols so that sh_value encodes the pointer directly. */
-static void simplify_symbols(Elf_Shdr * sechdrs,
+static void simplify_symbols(Elf_Shdr *sechdrs,
 			    unsigned int symindex,
 			    const char *strtab,
 			    const char *secstrings,
@@ -538,18 +515,16 @@ static void simplify_symbols(Elf_Shdr * sechdrs,
 			break;
 
 		case SHN_MIPS_SCOMMON:
-			printk(KERN_DEBUG "simplify_symbols: ignoring SHN_MIPS_SCOMMON "
-			       "symbol <%s> st_shndx %d\n", strtab + sym[i].st_name,
-			       sym[i].st_shndx);
-			// .sbss section
+			pr_debug("simplify_symbols: ignoring SHN_MIPS_SCOMMON symbol <%s> st_shndx %d\n",
+				 strtab + sym[i].st_name, sym[i].st_shndx);
+			/* .sbss section */
 			break;
 
 		default:
 			secbase = sechdrs[sym[i].st_shndx].sh_addr;
 
-			if (strncmp(strtab + sym[i].st_name, "_gp", 3) == 0) {
+			if (strncmp(strtab + sym[i].st_name, "_gp", 3) == 0)
 				save_gp_address(secbase, sym[i].st_value);
-			}
 
 			sym[i].st_value += secbase;
 			break;
@@ -558,21 +533,21 @@ static void simplify_symbols(Elf_Shdr * sechdrs,
 }
 
 #ifdef DEBUG_ELFLOADER
-static void dump_elfsymbols(Elf_Shdr * sechdrs, unsigned int symindex,
+static void dump_elfsymbols(Elf_Shdr *sechdrs, unsigned int symindex,
 			    const char *strtab, struct module *mod)
 {
 	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
 	unsigned int i, n = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
 
-	printk(KERN_DEBUG "dump_elfsymbols: n %d\n", n);
+	pr_debug("dump_elfsymbols: n %d\n", n);
 	for (i = 1; i < n; i++) {
-		printk(KERN_DEBUG " i %d name <%s> 0x%x\n", i,
-		       strtab + sym[i].st_name, sym[i].st_value);
+		pr_debug(" i %d name <%s> 0x%x\n", i, strtab + sym[i].st_name,
+			 sym[i].st_value);
 	}
 }
 #endif
 
-static int find_vpe_symbols(struct vpe * v, Elf_Shdr * sechdrs,
+static int find_vpe_symbols(struct vpe *v, Elf_Shdr *sechdrs,
 				      unsigned int symindex, const char *strtab,
 				      struct module *mod)
 {
@@ -580,16 +555,14 @@ static int find_vpe_symbols(struct vpe * v, Elf_Shdr * sechdrs,
 	unsigned int i, n = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
 
 	for (i = 1; i < n; i++) {
-		if (strcmp(strtab + sym[i].st_name, "__start") == 0) {
+		if (strcmp(strtab + sym[i].st_name, "__start") == 0)
 			v->__start = sym[i].st_value;
-		}
 
-		if (strcmp(strtab + sym[i].st_name, "vpe_shared") == 0) {
+		if (strcmp(strtab + sym[i].st_name, "vpe_shared") == 0)
 			v->shared_ptr = (void *)sym[i].st_value;
-		}
 	}
 
-	if ( (v->__start == 0) || (v->shared_ptr == NULL))
+	if ((v->__start == 0) || (v->shared_ptr == NULL))
 		return -1;
 
 	return 0;
@@ -600,14 +573,14 @@ static int find_vpe_symbols(struct vpe * v, Elf_Shdr * sechdrs,
  * contents of the program (p)buffer performing relocatations/etc, free's it
  * when finished.
  */
-static int vpe_elfload(struct vpe * v)
+static int vpe_elfload(struct vpe *v)
 {
 	Elf_Ehdr *hdr;
 	Elf_Shdr *sechdrs;
 	long err = 0;
 	char *secstrings, *strtab = NULL;
 	unsigned int len, i, symindex = 0, strindex = 0, relocate = 0;
-	struct module mod;	// so we can re-use the relocations code
+	struct module mod; /* so we can re-use the relocations code */
 
 	memset(&mod, 0, sizeof(struct module));
 	strcpy(mod.name, "VPE loader");
@@ -621,8 +594,7 @@ static int vpe_elfload(struct vpe * v)
 	    || (hdr->e_type != ET_REL && hdr->e_type != ET_EXEC)
 	    || !elf_check_arch(hdr)
 	    || hdr->e_shentsize != sizeof(*sechdrs)) {
-		printk(KERN_WARNING
-		       "VPE loader: program wrong arch or weird elf version\n");
+		pr_warn("VPE loader: program wrong arch or weird elf version\n");
 
 		return -ENOEXEC;
 	}
@@ -631,8 +603,7 @@ static int vpe_elfload(struct vpe * v)
 		relocate = 1;
 
 	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr)) {
-		printk(KERN_ERR "VPE loader: program length %u truncated\n",
-		       len);
+		pr_err("VPE loader: program length %u truncated\n", len);
 
 		return -ENOEXEC;
 	}
@@ -647,22 +618,24 @@ static int vpe_elfload(struct vpe * v)
 
 	if (relocate) {
 		for (i = 1; i < hdr->e_shnum; i++) {
-			if (sechdrs[i].sh_type != SHT_NOBITS
-			    && len < sechdrs[i].sh_offset + sechdrs[i].sh_size) {
-				printk(KERN_ERR "VPE program length %u truncated\n",
+			if ((sechdrs[i].sh_type != SHT_NOBITS) &&
+			    (len < sechdrs[i].sh_offset + sechdrs[i].sh_size)) {
+				pr_err("VPE program length %u truncated\n",
 				       len);
 				return -ENOEXEC;
 			}
 
 			/* Mark all sections sh_addr with their address in the
 			   temporary image. */
-			sechdrs[i].sh_addr = (size_t) hdr + sechdrs[i].sh_offset;
+			sechdrs[i].sh_addr = (size_t) hdr +
+				sechdrs[i].sh_offset;
 
 			/* Internal symbols and strings. */
 			if (sechdrs[i].sh_type == SHT_SYMTAB) {
 				symindex = i;
 				strindex = sechdrs[i].sh_link;
-				strtab = (char *)hdr + sechdrs[strindex].sh_offset;
+				strtab = (char *)hdr +
+					sechdrs[strindex].sh_offset;
 			}
 		}
 		layout_sections(&mod, hdr, sechdrs, secstrings);
@@ -689,8 +662,9 @@ static int vpe_elfload(struct vpe * v)
 			/* Update sh_addr to point to copy in image. */
 			sechdrs[i].sh_addr = (unsigned long)dest;
 
-			printk(KERN_DEBUG " section sh_name %s sh_addr 0x%x\n",
-			       secstrings + sechdrs[i].sh_name, sechdrs[i].sh_addr);
+			pr_debug(" section sh_name %s sh_addr 0x%x\n",
+				 secstrings + sechdrs[i].sh_name,
+				 sechdrs[i].sh_addr);
 		}
 
 		/* Fix up syms, so that st_value is a pointer to location. */
@@ -711,17 +685,18 @@ static int vpe_elfload(struct vpe * v)
 				continue;
 
 			if (sechdrs[i].sh_type == SHT_REL)
-				err = apply_relocations(sechdrs, strtab, symindex, i,
-							&mod);
+				err = apply_relocations(sechdrs, strtab,
+							symindex, i, &mod);
 			else if (sechdrs[i].sh_type == SHT_RELA)
-				err = apply_relocate_add(sechdrs, strtab, symindex, i,
-							 &mod);
+				err = apply_relocate_add(sechdrs, strtab,
+							 symindex, i, &mod);
 			if (err < 0)
 				return err;
 
 		}
 	} else {
-		struct elf_phdr *phdr = (struct elf_phdr *) ((char *)hdr + hdr->e_phoff);
+		struct elf_phdr *phdr = (struct elf_phdr *)
+						((char *)hdr + hdr->e_phoff);
 
 		for (i = 0; i < hdr->e_phnum; i++) {
 			if (phdr->p_type == PT_LOAD) {
@@ -739,11 +714,15 @@ static int vpe_elfload(struct vpe * v)
 			if (sechdrs[i].sh_type == SHT_SYMTAB) {
 				symindex = i;
 				strindex = sechdrs[i].sh_link;
-				strtab = (char *)hdr + sechdrs[strindex].sh_offset;
-
-				/* mark the symtab's address for when we try to find the
-				   magic symbols */
-				sechdrs[i].sh_addr = (size_t) hdr + sechdrs[i].sh_offset;
+				strtab = (char *)hdr +
+					sechdrs[strindex].sh_offset;
+
+				/*
+				 * mark symtab's address for when we try
+				 * to find the magic symbols
+				 */
+				sechdrs[i].sh_addr = (size_t) hdr +
+					sechdrs[i].sh_offset;
 			}
 		}
 	}
@@ -754,18 +733,16 @@ static int vpe_elfload(struct vpe * v)
 
 	if ((find_vpe_symbols(v, sechdrs, symindex, strtab, &mod)) < 0) {
 		if (v->__start == 0) {
-			printk(KERN_WARNING "VPE loader: program does not contain "
-			       "a __start symbol\n");
+			pr_warn("VPE loader: program does not contain a __start symbol\n");
 			return -ENOEXEC;
 		}
 
 		if (v->shared_ptr == NULL)
-			printk(KERN_WARNING "VPE loader: "
-			       "program does not contain vpe_shared symbol.\n"
-			       " Unable to use AMVP (AP/SP) facilities.\n");
+			pr_warn("VPE loader: program does not contain vpe_shared symbol.\n"
+				" Unable to use AMVP (AP/SP) facilities.\n");
 	}
 
-	printk(" elf loaded\n");
+	pr_info(" elf loaded\n");
 	return 0;
 }
 
@@ -788,30 +765,30 @@ static int getcwd(char *buff, int size)
 static int vpe_open(struct inode *inode, struct file *filp)
 {
 	enum vpe_state state;
-	struct vpe_notifications *not;
+	struct vpe_notifications *notifier;
 	struct vpe *v;
 	int ret;
 
 	if (VPE_MODULE_MINOR != iminor(inode)) {
 		/* assume only 1 device at the moment. */
-		pr_warning("VPE loader: only vpe1 is supported\n");
+		pr_warn("VPE loader: only vpe1 is supported\n");
 
 		return -ENODEV;
 	}
 
-	if ((v = get_vpe(aprp_cpu_index())) == NULL) {
-		pr_warning("VPE loader: unable to get vpe\n");
+	v = get_vpe(aprp_cpu_index());
+	if (v == NULL) {
+		pr_warn("VPE loader: unable to get vpe\n");
 
 		return -ENODEV;
 	}
 
 	state = xchg(&v->state, VPE_STATE_INUSE);
 	if (state != VPE_STATE_UNUSED) {
-		printk(KERN_DEBUG "VPE loader: tc in use dumping regs\n");
+		pr_debug("VPE loader: tc in use dumping regs\n");
 
-		list_for_each_entry(not, &v->notify, list) {
-			not->stop(aprp_cpu_index());
-		}
+		list_for_each_entry(notifier, &v->notify, list)
+			notifier->stop(aprp_cpu_index());
 
 		release_progmem(v->load_addr);
 		cleanup_tc(get_tc(aprp_cpu_index()));
@@ -820,7 +797,7 @@ static int vpe_open(struct inode *inode, struct file *filp)
 	/* this of-course trashes what was there before... */
 	v->pbuffer = vmalloc(P_SIZE);
 	if (!v->pbuffer) {
-		pr_warning("VPE loader: unable to allocate memory\n");
+		pr_warn("VPE loader: unable to allocate memory\n");
 		return -ENOMEM;
 	}
 	v->plen = P_SIZE;
@@ -833,7 +810,7 @@ static int vpe_open(struct inode *inode, struct file *filp)
 	v->cwd[0] = 0;
 	ret = getcwd(v->cwd, VPE_PATH_MAX);
 	if (ret < 0)
-		printk(KERN_WARNING "VPE loader: open, getcwd returned %d\n", ret);
+		pr_warn("VPE loader: open, getcwd returned %d\n", ret);
 
 	v->shared_ptr = NULL;
 	v->__start = 0;
@@ -856,11 +833,11 @@ static int vpe_release(struct inode *inode, struct file *filp)
 		if ((vpe_elfload(v) >= 0) && vpe_run) {
 			vpe_run(v);
 		} else {
-			printk(KERN_WARNING "VPE loader: ELF load failed.\n");
+			pr_warn("VPE loader: ELF load failed.\n");
 			ret = -ENOEXEC;
 		}
 	} else {
-		printk(KERN_WARNING "VPE loader: only elf files are supported\n");
+		pr_warn("VPE loader: only elf files are supported\n");
 		ret = -ENOEXEC;
 	}
 
@@ -878,8 +855,8 @@ static int vpe_release(struct inode *inode, struct file *filp)
 	return ret;
 }
 
-static ssize_t vpe_write(struct file *file, const char __user * buffer,
-			 size_t count, loff_t * ppos)
+static ssize_t vpe_write(struct file *file, const char __user *buffer,
+			 size_t count, loff_t *ppos)
 {
 	size_t ret = count;
 	struct vpe *v;
@@ -888,12 +865,12 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 		return -ENODEV;
 
 	v = get_vpe(aprp_cpu_index());
+
 	if (v == NULL)
 		return -ENODEV;
 
 	if ((count + v->len) > v->plen) {
-		printk(KERN_WARNING
-		       "VPE loader: elf size too big. Perhaps strip uneeded symbols\n");
+		pr_warn("VPE loader: elf size too big. Perhaps strip uneeded symbols\n");
 		return -ENOMEM;
 	}
 
@@ -915,63 +892,58 @@ const struct file_operations vpe_fops = {
 
 void *vpe_get_shared(int index)
 {
-	struct vpe *v;
+	struct vpe *v = get_vpe(index);
 
-	if ((v = get_vpe(index)) == NULL)
+	if (v == NULL)
 		return NULL;
 
 	return v->shared_ptr;
 }
-
 EXPORT_SYMBOL(vpe_get_shared);
 
 int vpe_getuid(int index)
 {
-	struct vpe *v;
+	struct vpe *v = get_vpe(index);
 
-	if ((v = get_vpe(index)) == NULL)
+	if (v == NULL)
 		return -1;
 
 	return v->uid;
 }
-
 EXPORT_SYMBOL(vpe_getuid);
 
 int vpe_getgid(int index)
 {
-	struct vpe *v;
+	struct vpe *v = get_vpe(index);
 
-	if ((v = get_vpe(index)) == NULL)
+	if (v == NULL)
 		return -1;
 
 	return v->gid;
 }
-
 EXPORT_SYMBOL(vpe_getgid);
 
 int vpe_notify(int index, struct vpe_notifications *notify)
 {
-	struct vpe *v;
+	struct vpe *v = get_vpe(index);
 
-	if ((v = get_vpe(index)) == NULL)
+	if (v == NULL)
 		return -1;
 
 	list_add(&notify->list, &v->notify);
 	return 0;
 }
-
 EXPORT_SYMBOL(vpe_notify);
 
 char *vpe_getcwd(int index)
 {
-	struct vpe *v;
+	struct vpe *v = get_vpe(index);
 
-	if ((v = get_vpe(index)) == NULL)
+	if (v == NULL)
 		return NULL;
 
 	return v->cwd;
 }
-
 EXPORT_SYMBOL(vpe_getcwd);
 
 module_init(vpe_module_init);
diff --git a/arch/mips/mti-malta/malta-amon.c b/arch/mips/mti-malta/malta-amon.c
index 917df6d..0319ad8 100644
--- a/arch/mips/mti-malta/malta-amon.c
+++ b/arch/mips/mti-malta/malta-amon.c
@@ -1,30 +1,20 @@
 /*
- * Copyright (C) 2007  MIPS Technologies, Inc.
- *	All rights reserved.
-
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ * Copyright (C) 2007 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2013 Imagination Technologies Ltd.
  *
- * Arbitrary Monitor interface
+ * Arbitrary Monitor Interface
  */
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/smp.h>
 
 #include <asm/addrspace.h>
-#include <asm/mips-boards/launch.h>
 #include <asm/mipsmtregs.h>
+#include <asm/mips-boards/launch.h>
 #include <asm/vpe.h>
 
 int amon_cpu_avail(int cpu)
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index ea9338d..efa2289 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -1,26 +1,16 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
  * Copyright (C) 2001 Ralf Baechle
  * Copyright (C) 2013 Imagination Technologies Ltd.
  *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
  * Routines for generic manipulation of the interrupts found on the MIPS
- * Malta board.
- * The interrupt controller is located in the South Bridge a PIIX4 device
- * with two internal 82C95 interrupt controllers.
+ * Malta board. The interrupt controller is located in the South Bridge
+ * a PIIX4 device with two internal 82C95 interrupt controllers.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
@@ -92,7 +82,7 @@ static inline int mips_pcibios_iack(void)
 		BONITO_PCIMAP_CFG = 0;
 		break;
 	default:
-		printk(KERN_WARNING "Unknown system controller.\n");
+		pr_emerg("Unknown system controller.\n");
 		return -1;
 	}
 	return irq;
@@ -156,11 +146,11 @@ static void corehi_irqdispatch(void)
 	unsigned int intrcause, datalo, datahi;
 	struct pt_regs *regs = get_irq_regs();
 
-	printk(KERN_EMERG "CoreHI interrupt, shouldn't happen, we die here!\n");
-	printk(KERN_EMERG "epc	 : %08lx\nStatus: %08lx\n"
-			"Cause : %08lx\nbadVaddr : %08lx\n",
-			regs->cp0_epc, regs->cp0_status,
-			regs->cp0_cause, regs->cp0_badvaddr);
+	pr_emerg("CoreHI interrupt, shouldn't happen, we die here!\n");
+	pr_emerg("epc	 : %08lx\nStatus: %08lx\n"
+		 "Cause : %08lx\nbadVaddr : %08lx\n",
+		 regs->cp0_epc, regs->cp0_status,
+		 regs->cp0_cause, regs->cp0_badvaddr);
 
 	/* Read all the registers and then print them as there is a
 	   problem with interspersed printk's upsetting the Bonito controller.
@@ -178,8 +168,8 @@ static void corehi_irqdispatch(void)
 		intrcause = GT_READ(GT_INTRCAUSE_OFS);
 		datalo = GT_READ(GT_CPUERR_ADDRLO_OFS);
 		datahi = GT_READ(GT_CPUERR_ADDRHI_OFS);
-		printk(KERN_EMERG "GT_INTRCAUSE = %08x\n", intrcause);
-		printk(KERN_EMERG "GT_CPUERR_ADDR = %02x%08x\n",
+		pr_emerg("GT_INTRCAUSE = %08x\n", intrcause);
+		pr_emerg("GT_CPUERR_ADDR = %02x%08x\n",
 				datahi, datalo);
 		break;
 	case MIPS_REVISION_SCON_BONITO:
@@ -191,14 +181,14 @@ static void corehi_irqdispatch(void)
 		intedge = BONITO_INTEDGE;
 		intsteer = BONITO_INTSTEER;
 		pcicmd = BONITO_PCICMD;
-		printk(KERN_EMERG "BONITO_INTISR = %08x\n", intisr);
-		printk(KERN_EMERG "BONITO_INTEN = %08x\n", inten);
-		printk(KERN_EMERG "BONITO_INTPOL = %08x\n", intpol);
-		printk(KERN_EMERG "BONITO_INTEDGE = %08x\n", intedge);
-		printk(KERN_EMERG "BONITO_INTSTEER = %08x\n", intsteer);
-		printk(KERN_EMERG "BONITO_PCICMD = %08x\n", pcicmd);
-		printk(KERN_EMERG "BONITO_PCIBADADDR = %08x\n", pcibadaddr);
-		printk(KERN_EMERG "BONITO_PCIMSTAT = %08x\n", pcimstat);
+		pr_emerg("BONITO_INTISR = %08x\n", intisr);
+		pr_emerg("BONITO_INTEN = %08x\n", inten);
+		pr_emerg("BONITO_INTPOL = %08x\n", intpol);
+		pr_emerg("BONITO_INTEDGE = %08x\n", intedge);
+		pr_emerg("BONITO_INTSTEER = %08x\n", intsteer);
+		pr_emerg("BONITO_PCICMD = %08x\n", pcicmd);
+		pr_emerg("BONITO_PCIBADADDR = %08x\n", pcibadaddr);
+		pr_emerg("BONITO_PCIMSTAT = %08x\n", pcimstat);
 		break;
 	}
 
@@ -377,13 +367,13 @@ static struct irqaction corehi_irqaction = {
 	.flags = IRQF_NO_THREAD,
 };
 
-static msc_irqmap_t __initdata msc_irqmap[] = {
+static msc_irqmap_t msc_irqmap[] __initdata = {
 	{MSC01C_INT_TMR,		MSC01_IRQ_EDGE, 0},
 	{MSC01C_INT_PCI,		MSC01_IRQ_LEVEL, 0},
 };
-static int __initdata msc_nr_irqs = ARRAY_SIZE(msc_irqmap);
+static int msc_nr_irqs __initdata = ARRAY_SIZE(msc_irqmap);
 
-static msc_irqmap_t __initdata msc_eicirqmap[] = {
+static msc_irqmap_t msc_eicirqmap[] __initdata = {
 	{MSC01E_INT_SW0,		MSC01_IRQ_LEVEL, 0},
 	{MSC01E_INT_SW1,		MSC01_IRQ_LEVEL, 0},
 	{MSC01E_INT_I8259A,		MSC01_IRQ_LEVEL, 0},
@@ -396,7 +386,7 @@ static msc_irqmap_t __initdata msc_eicirqmap[] = {
 	{MSC01E_INT_CPUCTR,		MSC01_IRQ_LEVEL, 0}
 };
 
-static int __initdata msc_nr_eicirqs = ARRAY_SIZE(msc_eicirqmap);
+static int msc_nr_eicirqs __initdata = ARRAY_SIZE(msc_eicirqmap);
 
 /*
  * This GIC specific tabular array defines the association between External
@@ -443,9 +433,12 @@ int __init gcmp_probe(unsigned long addr, unsigned long size)
 	if (gcmp_present >= 0)
 		return gcmp_present;
 
-	_gcmp_base = (unsigned long) ioremap_nocache(GCMP_BASE_ADDR, GCMP_ADDRSPACE_SZ);
-	_msc01_biu_base = (unsigned long) ioremap_nocache(MSC01_BIU_REG_BASE, MSC01_BIU_ADDRSPACE_SZ);
-	gcmp_present = (GCMPGCB(GCMPB) & GCMP_GCB_GCMPB_GCMPBASE_MSK) == GCMP_BASE_ADDR;
+	_gcmp_base = (unsigned long) ioremap_nocache(GCMP_BASE_ADDR,
+		GCMP_ADDRSPACE_SZ);
+	_msc01_biu_base = (unsigned long) ioremap_nocache(MSC01_BIU_REG_BASE,
+		MSC01_BIU_ADDRSPACE_SZ);
+	gcmp_present = ((GCMPGCB(GCMPB) & GCMP_GCB_GCMPB_GCMPBASE_MSK) ==
+		GCMP_BASE_ADDR);
 
 	if (gcmp_present)
 		pr_debug("GCMP present\n");
@@ -455,9 +448,8 @@ int __init gcmp_probe(unsigned long addr, unsigned long size)
 /* Return the number of IOCU's present */
 int __init gcmp_niocu(void)
 {
-  return gcmp_present ?
-    (GCMPGCB(GC) & GCMP_GCB_GC_NUMIOCU_MSK) >> GCMP_GCB_GC_NUMIOCU_SHF :
-    0;
+	return gcmp_present ? ((GCMPGCB(GC) & GCMP_GCB_GC_NUMIOCU_MSK) >>
+		GCMP_GCB_GC_NUMIOCU_SHF) : 0;
 }
 
 /* Set GCMP region attributes */
@@ -605,11 +597,14 @@ void __init arch_init_irq(void)
 			set_vi_handler(MIPSCPU_INT_IPI1, malta_ipi_irqdispatch);
 		}
 		/* Argh.. this really needs sorting out.. */
-		printk("CPU%d: status register was %08x\n", smp_processor_id(), read_c0_status());
+		pr_info("CPU%d: status register was %08x\n",
+			smp_processor_id(), read_c0_status());
 		write_c0_status(read_c0_status() | STATUSF_IP3 | STATUSF_IP4);
-		printk("CPU%d: status register now %08x\n", smp_processor_id(), read_c0_status());
+		pr_info("CPU%d: status register now %08x\n",
+			smp_processor_id(), read_c0_status());
 		write_c0_status(0x1100dc00);
-		printk("CPU%d: status register frc %08x\n", smp_processor_id(), read_c0_status());
+		pr_info("CPU%d: status register frc %08x\n",
+			smp_processor_id(), read_c0_status());
 		for (i = 0; i < NR_CPUS; i++) {
 			arch_init_ipiirq(MIPS_GIC_IRQ_BASE +
 					 GIC_RESCHED_INT(i), &irq_resched);
@@ -627,11 +622,15 @@ void __init arch_init_irq(void)
 			cpu_ipi_call_irq = MSC01E_INT_SW1;
 		} else {
 			if (cpu_has_vint) {
-				set_vi_handler (MIPS_CPU_IPI_RESCHED_IRQ, ipi_resched_dispatch);
-				set_vi_handler (MIPS_CPU_IPI_CALL_IRQ, ipi_call_dispatch);
+				set_vi_handler (MIPS_CPU_IPI_RESCHED_IRQ,
+					ipi_resched_dispatch);
+				set_vi_handler (MIPS_CPU_IPI_CALL_IRQ,
+					ipi_call_dispatch);
 			}
-			cpu_ipi_resched_irq = MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_RESCHED_IRQ;
-			cpu_ipi_call_irq = MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_CALL_IRQ;
+			cpu_ipi_resched_irq = MIPS_CPU_IRQ_BASE +
+				MIPS_CPU_IPI_RESCHED_IRQ;
+			cpu_ipi_call_irq = MIPS_CPU_IRQ_BASE +
+				MIPS_CPU_IPI_CALL_IRQ;
 		}
 		arch_init_ipiirq(cpu_ipi_resched_irq, &irq_resched);
 		arch_init_ipiirq(cpu_ipi_call_irq, &irq_call);
@@ -641,9 +640,7 @@ void __init arch_init_irq(void)
 
 void malta_be_init(void)
 {
-	if (gcmp_present) {
-		/* Could change CM error mask register */
-	}
+	/* Could change CM error mask register. */
 }
 
 
@@ -723,14 +720,14 @@ int malta_be_handler(struct pt_regs *regs, int is_fixup)
 			if (cause < 16) {
 				unsigned long cca_bits = (cm_error >> 15) & 7;
 				unsigned long tr_bits = (cm_error >> 12) & 7;
-				unsigned long mcmd_bits = (cm_error >> 7) & 0x1f;
+				unsigned long cmd_bits = (cm_error >> 7) & 0x1f;
 				unsigned long stag_bits = (cm_error >> 3) & 15;
 				unsigned long sport_bits = (cm_error >> 0) & 7;
 
 				snprintf(buf, sizeof(buf),
 					 "CCA=%lu TR=%s MCmd=%s STag=%lu "
 					 "SPort=%lu\n",
-					 cca_bits, tr[tr_bits], mcmd[mcmd_bits],
+					 cca_bits, tr[tr_bits], mcmd[cmd_bits],
 					 stag_bits, sport_bits);
 			} else {
 				/* glob state & sresp together */
@@ -739,7 +736,7 @@ int malta_be_handler(struct pt_regs *regs, int is_fixup)
 				unsigned long c1_bits = (cm_error >> 12) & 7;
 				unsigned long c0_bits = (cm_error >> 9) & 7;
 				unsigned long sc_bit = (cm_error >> 8) & 1;
-				unsigned long mcmd_bits = (cm_error >> 3) & 0x1f;
+				unsigned long cmd_bits = (cm_error >> 3) & 0x1f;
 				unsigned long sport_bits = (cm_error >> 0) & 7;
 				snprintf(buf, sizeof(buf),
 					 "C3=%s C2=%s C1=%s C0=%s SC=%s "
@@ -747,16 +744,16 @@ int malta_be_handler(struct pt_regs *regs, int is_fixup)
 					 core[c3_bits], core[c2_bits],
 					 core[c1_bits], core[c0_bits],
 					 sc_bit ? "True" : "False",
-					 mcmd[mcmd_bits], sport_bits);
+					 mcmd[cmd_bits], sport_bits);
 			}
 
 			ocause = (cm_other & GCMP_GCB_GMEO_ERROR_2ND_MSK) >>
 				 GCMP_GCB_GMEO_ERROR_2ND_SHF;
 
-			printk("CM_ERROR=%08lx %s <%s>\n", cm_error,
+			pr_err("CM_ERROR=%08lx %s <%s>\n", cm_error,
 			       causes[cause], buf);
-			printk("CM_ADDR =%08lx\n", cm_addr);
-			printk("CM_OTHER=%08lx %s\n", cm_other, causes[ocause]);
+			pr_err("CM_ADDR =%08lx\n", cm_addr);
+			pr_err("CM_OTHER=%08lx %s\n", cm_other, causes[ocause]);
 
 			/* reprime cause register */
 			GCMPGCB(GCMEC) = 0;
-- 
1.7.9.5
