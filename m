From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 20 May 2014 00:52:08 +0100
Subject: [PATCH 1/2] timer: Add cpu_get_clock_at()
Message-ID: <20140519235208.OD0Dnohmt-UpQ5EZtImetY3zngERD3rbiIQzwpPBsmo@z>

Add a new cpu_get_clock_at() which gets the VM time at a particular
specified monotonic time rather than the current monotonic time. This is
to allow for operations that may need both the current monotonic time
and the VM time based on that, such as to allow synchronisation with a
KVM CPU clock.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 cpus.c               | 23 +++++++++++++++++++++--
 include/qemu/timer.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index dd7ac13..ac906a3 100644
--- a/cpus.c
+++ b/cpus.c
@@ -186,18 +186,37 @@ int64_t cpu_get_ticks(void)
     return ticks;
 }
 
-static int64_t cpu_get_clock_locked(void)
+static int64_t cpu_get_clock_at_locked(int64_t now)
 {
     int64_t ticks;
 
     ticks = timers_state.cpu_clock_offset;
     if (timers_state.cpu_ticks_enabled) {
-        ticks += get_clock();
+        ticks += now;
     }
 
     return ticks;
 }
 
+static int64_t cpu_get_clock_locked(void)
+{
+    return cpu_get_clock_at_locked(get_clock());
+}
+
+/* return the host CPU monotonic timer and handle stop/restart */
+int64_t cpu_get_clock_at(int64_t now)
+{
+    int64_t ti;
+    unsigned start;
+
+    do {
+        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
+        ti = cpu_get_clock_at_locked(now);
+    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
+
+    return ti;
+}
+
 /* return the host CPU monotonic timer and handle stop/restart */
 int64_t cpu_get_clock(void)
 {
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 7f9a074..5b2e8c2 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -745,6 +745,7 @@ static inline int64_t get_clock(void)
 /* icount */
 int64_t cpu_get_icount(void);
 int64_t cpu_get_clock(void);
+int64_t cpu_get_clock_at(int64_t now);
 
 /*******************************************/
 /* host CPU ticks (if available) */
-- 
1.9.3


--------------030600020508020608000707
Content-Type: text/x-patch;
	name="0002-target-mips-kvm-Save-restore-KVM-timer-state.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-target-mips-kvm-Save-restore-KVM-timer-state.patch"
