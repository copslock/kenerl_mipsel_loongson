From: James Hogan <james.hogan@imgtec.com>
Date: Thu, 29 May 2014 14:36:20 +0100
Subject: [PATCH 2/2] target-mips: kvm: Save/restore KVM timer state
Message-ID: <20140529133620.pJJniUhhfebOBtbeCf9Wcg9D5jjma-22Jdfb2mSX-U0@z>

Save and restore KVM timer state properly. When it's saved (or VM clock
stopped) the VM clock is also recorded. When it's restored (or VM clock
restarted) it is resumed with the stored count at the saved VM clock
translated into monotonic time, i.e. current time - elapsed VM
nanoseconds. This therefore behaves correctly after the VM clock has
been stopped.

E.g.
sync state to QEMU
    takes snapshot of Count, Cause and VM time(now)
sync state back to KVM
    restores Count, Cause at translated VM time (unchanged)
    time continues from the same Count without losing time or interrupts

Or:
stop vm clock
    takes snapshot of Count, Cause and VM time

restart vm clock
    restores Count, Cause at now - (vm time(now) - saved vm time)
    time continues from the same Count but at a later monotonic time
    depending on how long the vm clock was stopped

The VM time at which the timer was stopped (count_save_time) is
saved/loaded by cpu_save and cpu_load so that it can be restarted
without losing time relative to the VM clock.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 target-mips/cpu.h     |   3 +-
 target-mips/kvm.c     | 196 +++++++++++++++++++++++++++++++++++++++++++++++---
 target-mips/machine.c |   6 ++
 3 files changed, 195 insertions(+), 10 deletions(-)

diff --git a/target-mips/cpu.h b/target-mips/cpu.h
index 67bf441..02a8da1 100644
--- a/target-mips/cpu.h
+++ b/target-mips/cpu.h
@@ -495,6 +495,7 @@ struct CPUMIPSState {
     const mips_def_t *cpu_model;
     void *irq[8];
     QEMUTimer *timer; /* Internal timer */
+    int64_t count_save_time;
 };
 
 #include "cpu-qom.h"
@@ -526,7 +527,7 @@ void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf);
 extern void cpu_wrdsp(uint32_t rs, uint32_t mask_num, CPUMIPSState *env);
 extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
 
-#define CPU_SAVE_VERSION 4
+#define CPU_SAVE_VERSION 5
 
 /* MMU modes definitions. We carefully match the indices with our
    hflags layout. */
diff --git a/target-mips/kvm.c b/target-mips/kvm.c
index 8765205..ee2dd1c 100644
--- a/target-mips/kvm.c
+++ b/target-mips/kvm.c
@@ -33,6 +33,8 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
+static void kvm_mips_update_state(void *opaque, int running, RunState state);
+
 unsigned long kvm_arch_vcpu_id(CPUState *cs)
 {
     return cs->cpu_index;
@@ -50,6 +52,9 @@ int kvm_arch_init(KVMState *s)
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret = 0;
+
+    qemu_add_vm_change_state_handler(kvm_mips_update_state, cs);
+
     DPRINTF("%s\n", __func__);
     return ret;
 }
@@ -224,6 +229,17 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int level)
 #define KVM_REG_MIPS_CP0_XCONTEXT	MIPS_CP0_64(20, 0)
 #define KVM_REG_MIPS_CP0_ERROREPC	MIPS_CP0_64(30, 0)
 
+/* CP0_Count control */
+#define KVM_REG_MIPS_COUNT_CTL          (KVM_REG_MIPS | KVM_REG_SIZE_U64 | \
+                                         0x20000 | 0)
+#define KVM_REG_MIPS_COUNT_CTL_DC       0x00000001      /* master disable */
+/* CP0_Count resume monotonic nanoseconds */
+#define KVM_REG_MIPS_COUNT_RESUME       (KVM_REG_MIPS | KVM_REG_SIZE_U64 | \
+                                         0x20000 | 1)
+/* CP0_Count rate in Hz */
+#define KVM_REG_MIPS_COUNT_HZ           (KVM_REG_MIPS | KVM_REG_SIZE_U64 | \
+                                         0x20000 | 2)
+
 static inline int kvm_mips_put_one_reg(CPUState *cs, uint64_t reg_id,
                                        int32_t *addr)
 {
@@ -248,6 +264,17 @@ static inline int kvm_mips_put_one_ulreg(CPUState *cs, uint64_t reg_id,
     return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &cp0reg);
 }
 
+static inline int kvm_mips_put_one_reg64(CPUState *cs, uint64_t reg_id,
+                                         uint64_t *addr)
+{
+    struct kvm_one_reg cp0reg = {
+        .id = reg_id,
+        .addr = (uintptr_t)addr
+    };
+
+    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &cp0reg);
+}
+
 static inline int kvm_mips_get_one_reg(CPUState *cs, uint64_t reg_id,
                                        int32_t *addr)
 {
@@ -286,6 +313,151 @@ static inline int kvm_mips_get_one_ulreg(CPUState *cs, uint64 reg_id,
     return ret;
 }
 
+static inline int kvm_mips_get_one_reg64(CPUState *cs, uint64 reg_id,
+                                         uint64_t *addr)
+{
+    int ret;
+    struct kvm_one_reg cp0reg = {
+        .id = reg_id,
+        .addr = (uintptr_t)addr
+    };
+
+    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &cp0reg);
+    return ret;
+}
+
+/*
+ * We freeze the KVM timer when either the VM clock is stopped or the state is
+ * saved (the state is dirty).
+ */
+
+/*
+ * Save the state of the KVM timer when VM clock is stopped or state is synced
+ * to QEMU.
+ */
+static int kvm_mips_save_count(CPUState *cs)
+{
+    MIPSCPU *cpu = MIPS_CPU(cs);
+    CPUMIPSState *env = &cpu->env;
+    uint64_t count_ctl, count_resume;
+    int ret;
+
+    /* freeze KVM timer */
+    ret = kvm_mips_get_one_reg64(cs, KVM_REG_MIPS_COUNT_CTL, &count_ctl);
+    if (ret < 0) {
+        return ret;
+    }
+    if (!(count_ctl & KVM_REG_MIPS_COUNT_CTL_DC)) {
+        count_ctl |= KVM_REG_MIPS_COUNT_CTL_DC;
+        ret = kvm_mips_put_one_reg64(cs, KVM_REG_MIPS_COUNT_CTL, &count_ctl);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    /* read CP0_Cause */
+    ret = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CAUSE, &env->CP0_Cause);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* read CP0_Count */
+    ret = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_COUNT, &env->CP0_Count);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* read COUNT_RESUME */
+    ret = kvm_mips_get_one_reg64(cs, KVM_REG_MIPS_COUNT_RESUME,
+                                 &count_resume);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* translate monotonic COUNT_RESUME to VM time */
+    env->count_save_time = cpu_get_clock_at(count_resume);
+
+    return ret;
+}
+
+/*
+ * Restore the state of the KVM timer when VM clock is restarted or state is
+ * synced to KVM.
+ */
+static int kvm_mips_restore_count(CPUState *cs)
+{
+    MIPSCPU *cpu = MIPS_CPU(cs);
+    CPUMIPSState *env = &cpu->env;
+    uint64_t count_ctl, count_resume;
+    int64_t now = get_clock();
+    int ret = 0;
+
+    /* check the timer is frozen */
+    ret = kvm_mips_get_one_reg64(cs, KVM_REG_MIPS_COUNT_CTL, &count_ctl);
+    if (ret < 0) {
+        return ret;
+    }
+    if (!(count_ctl & KVM_REG_MIPS_COUNT_CTL_DC)) {
+        /* freeze timer (sets COUNT_RESUME for us) */
+        count_ctl |= KVM_REG_MIPS_COUNT_CTL_DC;
+        ret = kvm_mips_put_one_reg64(cs, KVM_REG_MIPS_COUNT_CTL, &count_ctl);
+        if (ret < 0) {
+            return ret;
+        }
+    } else {
+        /* find time to resume the saved timer at */
+        now = get_clock();
+        count_resume = now - (cpu_get_clock_at(now) - env->count_save_time);
+        ret = kvm_mips_put_one_reg64(cs, KVM_REG_MIPS_COUNT_RESUME,
+                                     &count_resume);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    /* load CP0_Cause */
+    ret = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_CAUSE, &env->CP0_Cause);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* load CP0_Count */
+    ret = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_COUNT, &env->CP0_Count);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* resume KVM timer */
+    count_ctl &= ~KVM_REG_MIPS_COUNT_CTL_DC;
+    ret = kvm_mips_put_one_reg64(cs, KVM_REG_MIPS_COUNT_CTL, &count_ctl);
+    return ret;
+}
+
+/*
+ * Handle the VM clock being started or stopped
+ */
+static void kvm_mips_update_state(void *opaque, int running, RunState state)
+{
+    CPUState *cs = opaque;
+    int ret;
+
+    /*
+     * If state is already dirty (synced to QEMU) then the KVM timer state is
+     * already saved and can be restored when it is synced back to KVM.
+     */
+    if (!cs->kvm_vcpu_dirty) {
+        if (running) {
+            ret = kvm_mips_restore_count(cs);
+        } else {
+            ret = kvm_mips_save_count(cs);
+        }
+        if (ret < 0) {
+            fprintf(stderr, "Failed update count (running=%d)\n",
+                    running);
+        }
+    }
+}
+
 static int kvm_mips_put_cp0_registers(CPUState *cs, int level)
 {
     MIPSCPU *cpu = MIPS_CPU(cs);
@@ -322,15 +494,16 @@ static int kvm_mips_put_cp0_registers(CPUState *cs, int level)
         fprintf(stderr, "Failed to put BADVADDR\n");
         return ret;
     }
-    if (level != KVM_PUT_RUNTIME_STATE) {
-        /* don't write guest count during runtime or the clock might drift */
-        ret |= kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_COUNT,
-                                    &env->CP0_Count);
+
+    /* If VM clock stopped then state will be restored when it is restarted */
+    if (runstate_is_running()) {
+        ret = kvm_mips_restore_count(cs);
         if (ret < 0) {
-            fprintf(stderr, "Failed to put COMPARE\n");
+            fprintf(stderr, "Failed to put COUNT\n");
             return ret;
         }
     }
+
     ret |= kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_ENTRYHI,
                                   &env->CP0_EntryHi);
     if (ret < 0) {
@@ -397,10 +570,6 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
     if (ret < 0) {
         return ret;
     }
-    ret |= kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_COUNT, &env->CP0_Count);
-    if (ret < 0) {
-        return ret;
-    }
     ret |= kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_ENTRYHI,
                                   &env->CP0_EntryHi);
     if (ret < 0) {
@@ -419,6 +588,15 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
     if (ret < 0) {
         return ret;
     }
+
+    /* If VM clock stopped then state was already saved when it was stopped */
+    if (runstate_is_running()) {
+        ret = kvm_mips_save_count(cs);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     ret |= kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_EPC, &env->CP0_EPC);
     if (ret < 0) {
         return ret;
diff --git a/target-mips/machine.c b/target-mips/machine.c
index 0f36c9e..4916b13 100644
--- a/target-mips/machine.c
+++ b/target-mips/machine.c
@@ -150,6 +150,8 @@ void cpu_save(QEMUFile *f, void *opaque)
         save_tc(f, &env->tcs[i]);
     for (i = 0; i < MIPS_FPU_MAX; i++)
         save_fpu(f, &env->fpus[i]);
+
+    qemu_put_sbe64s(f, &env->count_save_time);
 }
 
 static void load_tc(QEMUFile *f, TCState *tc, int version_id)
@@ -310,5 +312,9 @@ int cpu_load(QEMUFile *f, void *opaque, int version_id)
 
     /* XXX: ensure compatibility for halted bit ? */
     tlb_flush(CPU(cpu), 1);
+
+    if (version_id >= 5) {
+        qemu_get_sbe64s(f, &env->count_save_time);
+    }
     return 0;
 }
-- 
1.9.3


--------------030600020508020608000707--
