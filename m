From: Kevin D. Kissell <kevink@mips.com>
Date: Wed, 16 Apr 2008 11:56:31 +0200
Subject: [PATCH] Functional Fixes and a little reformatting of APRP Support for MIPS MT
Message-ID: <20080416095631.cX8JrBiQNAnzoGFkefx6x74FCyNqU5ijYgY47luIfhE@z>


Signed-off-by: Kevin D. Kissell <kevink@mips.com>
---
 arch/mips/kernel/Makefile |    2 +-
 arch/mips/kernel/kspd.c   |    5 ++-
 arch/mips/kernel/rtlx.c   |  101 +++++++++++++++++++++++++++------------------
 include/asm-mips/rtlx.h   |    4 +-
 4 files changed, 68 insertions(+), 44 deletions(-)

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index ffa0836..0ce7bca 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -51,9 +51,9 @@ obj-$(CONFIG_MIPS_MT_FPAFF)	+= mips-mt-fpaff.o
 obj-$(CONFIG_MIPS_MT_SMTC)	+= smtc.o smtc-asm.o smtc-proc.o
 obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 
-obj-$(CONFIG_MIPS_APSP_KSPD)	+= kspd.o
 obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
 obj-$(CONFIG_MIPS_VPE_APSP_API)	+= rtlx.o
+obj-$(CONFIG_MIPS_APSP_KSPD)	+= kspd.o
 
 obj-$(CONFIG_I8259)		+= i8259.o
 obj-$(CONFIG_IRQ_CPU)		+= irq_cpu.o
diff --git a/arch/mips/kernel/kspd.c b/arch/mips/kernel/kspd.c
index d2c2e00..5e86c3a 100644
--- a/arch/mips/kernel/kspd.c
+++ b/arch/mips/kernel/kspd.c
@@ -257,7 +257,7 @@ void sp_work_handle_request(void)
 
 		vcwd = vpe_getcwd(tclimit);
 
- 		/* change to the cwd of the process that loaded the SP program */
+ 		/* change to cwd of the process that loaded the SP program */
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
 		sys_chdir(vcwd);
@@ -323,6 +323,9 @@ static void sp_cleanup(void)
 			set >>= 1;
 		}
 	}
+
+	/* Put daemon cwd back to root to avoid umount problems */
+	sys_chdir("/");
 }
 
 static int channel_open = 0;
diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index 1ba00c1..c0bb347 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -73,6 +73,15 @@ static void rtlx_dispatch(void)
 static irqreturn_t rtlx_interrupt(int irq, void *dev_id)
 {
 	int i;
+	unsigned int flags, vpeflags;
+
+	/* Ought not to be strictly necessary for SMTC builds */
+	local_irq_save(flags);
+	vpeflags = dvpe();
+	set_c0_status(0x100 << MIPS_CPU_RTLX_IRQ);
+	irq_enable_hazard();
+	evpe(vpeflags);
+	local_irq_restore(flags);
 
 	for (i = 0; i < RTLX_CHANNELS; i++) {
 			wake_up(&channel_wqs[i].lx_queue);
@@ -109,7 +118,8 @@ static void __used dump_rtlx(void)
 static int rtlx_init(struct rtlx_info *rtlxi)
 {
 	if (rtlxi->id != RTLX_ID) {
-		printk(KERN_ERR "no valid RTLX id at 0x%p 0x%lx\n", rtlxi, rtlxi->id);
+		printk(KERN_ERR "no valid RTLX id at 0x%p 0x%lx\n", 
+			rtlxi, rtlxi->id);
 		return -ENOEXEC;
 	}
 
@@ -163,51 +173,51 @@ int rtlx_open(int index, int can_sleep)
 
 	if (rtlx == NULL) {
 		if( (p = vpe_get_shared(tclimit)) == NULL) {
-			if (can_sleep) {
-				__wait_event_interruptible(channel_wqs[index].lx_queue,
-				                           (p = vpe_get_shared(tclimit)),
-				                           ret);
-				if (ret)
-					goto out_fail;
-			} else {
-				printk(KERN_DEBUG "No SP program loaded, and device "
-					"opened with O_NONBLOCK\n");
-				ret = -ENOSYS;
+		    if (can_sleep) {
+			__wait_event_interruptible(channel_wqs[index].lx_queue,
+				(p = vpe_get_shared(tclimit)), ret);
+			if (ret)
 				goto out_fail;
-			}
+		    } else {
+			printk(KERN_DEBUG "No SP program loaded, and device "
+					"opened with O_NONBLOCK\n");
+			ret = -ENOSYS;
+			goto out_fail;
+		    }
 		}
 
 		smp_rmb();
 		if (*p == NULL) {
-			if (can_sleep) {
-				DEFINE_WAIT(wait);
-
-				for (;;) {
-					prepare_to_wait(&channel_wqs[index].lx_queue, &wait, TASK_INTERRUPTIBLE);
-					smp_rmb();
-					if (*p != NULL)
-						break;
-					if (!signal_pending(current)) {
-						schedule();
-						continue;
-					}
-					ret = -ERESTARTSYS;
-					goto out_fail;
+		    if (can_sleep) {
+			DEFINE_WAIT(wait);
+
+			for (;;) {
+				prepare_to_wait(&channel_wqs[index].lx_queue, 
+						&wait, TASK_INTERRUPTIBLE);
+				smp_rmb();
+				if (*p != NULL)
+					break;
+				if (!signal_pending(current)) {
+					schedule();
+					continue;
 				}
-				finish_wait(&channel_wqs[index].lx_queue, &wait);
-			} else {
-				printk(" *vpe_get_shared is NULL. "
-				       "Has an SP program been loaded?\n");
-				ret = -ENOSYS;
+				ret = -ERESTARTSYS;
 				goto out_fail;
 			}
+			finish_wait(&channel_wqs[index].lx_queue, &wait);
+		    } else {
+			printk(" *vpe_get_shared is NULL. "
+			       "Has an SP program been loaded?\n");
+				ret = -ENOSYS;
+				goto out_fail;
+		    }
 		}
 
 		if ((unsigned int)*p < KSEG0) {
-			printk(KERN_WARNING "vpe_get_shared returned an invalid pointer "
-			       "maybe an error code %d\n", (int)*p);
-			ret = -ENOSYS;
-			goto out_fail;
+		    printk(KERN_WARNING "vpe_get_shared returned an invalid "
+			"pointer maybe an error code %d\n", (int)*p);
+		    ret = -ENOSYS;
+		    goto out_fail;
 		}
 
 		if ((ret = rtlx_init(*p)) < 0)
@@ -233,6 +243,10 @@ out_ret:
 
 int rtlx_release(int index)
 {
+ 	if (rtlx == NULL) {
+		printk("rtlx_release() with null rtlx\n");
+ 		return 0;
+	}
 	rtlx->channel[index].lx_state = RTLX_STATE_UNUSED;
 	return 0;
 }
@@ -252,8 +266,8 @@ unsigned int rtlx_read_poll(int index, int can_sleep)
 			int ret = 0;
 
 			__wait_event_interruptible(channel_wqs[index].lx_queue,
-			                           chan->lx_read != chan->lx_write || sp_stopping,
-			                           ret);
+				(chan->lx_read != chan->lx_write) 
+				|| sp_stopping, ret);
 			if (ret)
 				return ret;
 
@@ -283,7 +297,9 @@ static inline int write_spacefree(int read, int write, int size)
 unsigned int rtlx_write_poll(int index)
 {
 	struct rtlx_channel *chan = &rtlx->channel[index];
-	return write_spacefree(chan->rt_read, chan->rt_write, chan->buffer_size);
+
+	return write_spacefree(chan->rt_read, chan->rt_write, 
+				chan->buffer_size);
 }
 
 ssize_t rtlx_read(int index, void __user *buff, size_t count)
@@ -345,8 +361,8 @@ ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
 	rt_read = rt->rt_read;
 
 	/* total number of bytes to copy */
-	count = min(count,
-		    (size_t)write_spacefree(rt_read, rt->rt_write, rt->buffer_size));
+	count = min(count, (size_t)write_spacefree(rt_read, rt->rt_write, 
+							rt->buffer_size));
 
 	/* first bit from write pointer to the end of the buffer, or count */
 	fl = min(count, (size_t) rt->buffer_size - rt->rt_write);
@@ -515,6 +531,11 @@ static int __init rtlx_module_init(void)
 
 	if (cpu_has_vint)
 		set_vi_handler(MIPS_CPU_RTLX_IRQ, rtlx_dispatch);
+	else {
+		printk("APRP RTLX init on non-vectored-interrupt processor\n");
+		err = -ENODEV;
+		goto out_chrdev;
+	}
 
 	rtlx_irq.dev_id = rtlx;
 	setup_irq(rtlx_irq_num, &rtlx_irq);
diff --git a/include/asm-mips/rtlx.h b/include/asm-mips/rtlx.h
index 65778c8..20b6660 100644
--- a/include/asm-mips/rtlx.h
+++ b/include/asm-mips/rtlx.h
@@ -29,13 +29,13 @@ extern unsigned int rtlx_read_poll(int index, int can_sleep);
 extern unsigned int rtlx_write_poll(int index);
 
 enum rtlx_state {
-	RTLX_STATE_UNUSED,
+	RTLX_STATE_UNUSED = 0,
 	RTLX_STATE_INITIALISED,
 	RTLX_STATE_REMOTE_READY,
 	RTLX_STATE_OPENED
 };
 
-#define RTLX_BUFFER_SIZE 1024
+#define RTLX_BUFFER_SIZE 2048
 
 /* each channel supports read and write.
    linux (vpe0) reads lx_buffer  and writes rt_buffer
-- 
1.5.3.3


--------------030103020306010003010808--
