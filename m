From: Song Liu <songliubraving@fb.com>
Date: Thu, 12 Jul 2018 11:16:51 -0700
Subject: [PATCH] perf/core,uprobe: fix imbalanced install_breakpoint and
 remove_breakpoint
Message-ID: <20180712181651.8lFJZTcFwXy7p3UCoMhvA_CeM1icYXYyiD1mTIVc5jk@z>

When uprobes are used by perf event, it is handle as follows:

Enable path:
1. perf_event_open() => TRACE_REG_PERF_REGISTER => probe_event_enable()
2. PERF_EVENT_IOC_ENABLE => TRACE_REG_PERF_OPEN => uprobe_perf_open()

Disable path:
3. PERF_EVENT_IOC_DISABLE => TRACE_REG_PERF_CLOSE => uprobe_perf_close()
4. close(fd) => TRACE_REG_PERF_UNREGISTER => probe_event_disable()

In this routine, install_breakpoint() is called once at step 2; while
remove_breakpoint is called twice at both step 3 and step 4.

This patch tries to resolve this imbalance by passing extra flag
"restore_insn" to probe_event_disable().

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/uprobes.h     |  6 ++++--
 kernel/events/uprobes.c     | 21 +++++++++++++++------
 kernel/trace/trace_uprobe.c | 14 ++++++++++----
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e950df8..2b7a67b64877 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -124,7 +124,8 @@ extern unsigned long uprobe_get_trap_addr(struct
pt_regs *regs);
 extern int uprobe_write_opcode(struct mm_struct *mm, unsigned long
vaddr, uprobe_opcode_t);
 extern int uprobe_register(struct inode *inode, loff_t offset, struct
uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct
uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct inode *inode, loff_t offset,
struct uprobe_consumer *uc);
+extern void uprobe_unregister(struct inode *inode, loff_t offset,
+                  struct uprobe_consumer *uc, bool);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long
start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -166,7 +167,8 @@ uprobe_apply(struct inode *inode, loff_t offset,
struct uprobe_consumer *uc, boo
     return -ENOSYS;
 }
 static inline void
-uprobe_unregister(struct inode *inode, loff_t offset, struct
uprobe_consumer *uc)
+uprobe_unregister(struct inode *inode, loff_t offset, struct
uprobe_consumer *uc,
+          bool restore_insn)
 {
 }
 static inline int uprobe_mmap(struct vm_area_struct *vma)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ccc579a7d32e..988f5a5acaca 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -846,14 +846,16 @@ static int __uprobe_register(struct uprobe
*uprobe, struct uprobe_consumer *uc)
     return register_for_each_vma(uprobe, uc);
 }

-static void __uprobe_unregister(struct uprobe *uprobe, struct
uprobe_consumer *uc)
+static void __uprobe_unregister(struct uprobe *uprobe, struct
uprobe_consumer *uc,
+                bool restore_insn)
 {
-    int err;
+    int err = 0;

     if (WARN_ON(!consumer_del(uprobe, uc)))
         return;

-    err = register_for_each_vma(uprobe, NULL);
+    if (restore_insn)
+        err = register_for_each_vma(uprobe, NULL);
     /* TODO : cant unregister? schedule a worker thread */
     if (!uprobe->consumers && !err)
         delete_uprobe(uprobe);
@@ -906,7 +908,11 @@ int uprobe_register(struct inode *inode, loff_t
offset, struct uprobe_consumer *
     if (likely(uprobe_is_active(uprobe))) {
         ret = __uprobe_register(uprobe, uc);
         if (ret)
-            __uprobe_unregister(uprobe, uc);
+            /*
+             * only do remove_breakpoint (restore_insn)
+             * when failed in install_breakpoint (ret > 0)
+             */
+            __uprobe_unregister(uprobe, uc, ret > 0);
     }
     up_write(&uprobe->register_rwsem);
     put_uprobe(uprobe);
@@ -951,8 +957,11 @@ int uprobe_apply(struct inode *inode, loff_t offset,
  * @inode: the file in which the probe has to be removed.
  * @offset: offset from the start of the file.
  * @uc: identify which probe if multiple probes are colocated.
+ * @restore_insn: shall we restore original instruction with
+ *                register_for_each_vma(uprobe, NULL)
  */
-void uprobe_unregister(struct inode *inode, loff_t offset, struct
uprobe_consumer *uc)
+void uprobe_unregister(struct inode *inode, loff_t offset, struct
uprobe_consumer *uc,
+               bool restore_insn)
 {
     struct uprobe *uprobe;

@@ -961,7 +970,7 @@ void uprobe_unregister(struct inode *inode, loff_t
offset, struct uprobe_consume
         return;

     down_write(&uprobe->register_rwsem);
-    __uprobe_unregister(uprobe, uc);
+    __uprobe_unregister(uprobe, uc, restore_insn);
     up_write(&uprobe->register_rwsem);
     put_uprobe(uprobe);
 }
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index bf89a51e740d..fb6fb9d00cdc 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -938,7 +938,8 @@ probe_event_enable(struct trace_uprobe *tu, struct
trace_event_file *file,
 }

 static void
-probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
+probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file,
+            bool restore_insn)
 {
     if (!trace_probe_is_enabled(&tu->tp))
         return;
@@ -961,7 +962,8 @@ probe_event_disable(struct trace_uprobe *tu,
struct trace_event_file *file)

     WARN_ON(!uprobe_filter_is_empty(&tu->filter));

-    uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
+    uprobe_unregister(tu->inode, tu->offset, &tu->consumer,
+              restore_insn);
     tu->inode = NULL;
     tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;

@@ -1197,7 +1199,7 @@ trace_uprobe_register(struct trace_event_call
*event, enum trace_reg type,
         return probe_event_enable(tu, file, NULL);

     case TRACE_REG_UNREGISTER:
-        probe_event_disable(tu, file);
+        probe_event_disable(tu, file, true);
         return 0;

 #ifdef CONFIG_PERF_EVENTS
@@ -1205,7 +1207,11 @@ trace_uprobe_register(struct trace_event_call
*event, enum trace_reg type,
         return probe_event_enable(tu, NULL, uprobe_perf_filter);

     case TRACE_REG_PERF_UNREGISTER:
-        probe_event_disable(tu, NULL);
+        /*
+         * Don't restore instruction, as TRACE_REG_PERF_CLOSE
+         * already did that.
+         */
+        probe_event_disable(tu, NULL, false /* restore_insn */);
         return 0;

     case TRACE_REG_PERF_OPEN:
-- 
2.17.1
