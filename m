Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jul 2015 03:21:33 +0200 (CEST)
Received: from mail9.hitachi.co.jp ([133.145.228.44]:41786 "EHLO
        mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011054AbbGXBVNZeKsa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jul 2015 03:21:13 +0200
Received: from mlsv7.hitachi.co.jp (unknown [133.144.234.166])
        by mail9.hitachi.co.jp (Postfix) with ESMTP id E8808109BD82;
        Fri, 24 Jul 2015 10:21:10 +0900 (JST)
Received: from mfilter06.hitachi.co.jp by mlsv7.hitachi.co.jp (8.13.1/8.13.1) id t6O1LAqM001629; Fri, 24 Jul 2015 10:21:10 +0900
Received: from vshuts02.hitachi.co.jp (vshuts02.hitachi.co.jp [10.201.6.84])
        by mfilter06.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t6O1L9vl022877;
        Fri, 24 Jul 2015 10:21:10 +0900
Received: from hsdlmain.sdl.hitachi.co.jp (unknown [133.144.14.194])
        by vshuts02.hitachi.co.jp (Postfix) with ESMTP id 50EB449004D;
        Fri, 24 Jul 2015 10:21:09 +0900 (JST)
Received: from hsdlvgate2.sdl.hitachi.co.jp by hsdlmain.sdl.hitachi.co.jp (8.13.8/3.7W11021512) id t6O1L9TM004726; Fri, 24 Jul 2015 10:21:09 +0900
X-AuditID: 85900ec0-9e1cab9000001a57-6e-55b192d96968
Received: from sdl99w.sdl.hitachi.co.jp (sdl99w.yrl.intra.hitachi.co.jp [133.144.14.250])
        by hsdlvgate2.sdl.hitachi.co.jp (Symantec Mail Security) with ESMTP id 25823236561;
        Fri, 24 Jul 2015 10:20:25 +0900 (JST)
Received: from mailb.sdl.hitachi.co.jp (sdl99b.yrl.intra.hitachi.co.jp [133.144.14.197])
        by sdl99w.sdl.hitachi.co.jp (Postfix) with ESMTP id CA3CA53C21A;
        Fri, 24 Jul 2015 10:21:08 +0900 (JST)
Received: from [10.198.220.54] (unknown [10.198.220.54])
        by mailb.sdl.hitachi.co.jp (Postfix) with ESMTP id 93FB2495B93;
        Fri, 24 Jul 2015 10:21:08 +0900 (JST)
X-Mailbox-Line: From nobody Fri Jul 24 10:16:15 2015
Subject: [RFC V2 PATCH 1/1] panic/x86: Replace smp_send_stop() with crash_kexec
 version
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>
From:   Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc:     linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Daniel Walker <dwalker@fifo99.com>,
        Ingo Molnar <mingo@kernel.org>
Date:   Fri, 24 Jul 2015 10:16:15 +0900
Message-ID: <20150724011615.6834.97850.stgit@softrs>
In-Reply-To: <20150724011615.6834.79628.stgit@softrs>
References: <20150724011615.6834.79628.stgit@softrs>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAA==
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hidehiro.kawai.ez@hitachi.com
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

This patch fixes one of the problems reported by Daniel Walker
(https://lkml.org/lkml/2015/6/24/44).

If "crash_kexec_post_notifiers" boot option is specified,
other cpus are stopped by smp_send_stop() before entering
crash_kexec(), while usually machine_crash_shutdown() called by
crash_kexec() does that.  This behavior change leads two problems.

 Problem 1:
 Some functions in the crash_kexec() path depend on other cpus being
 still online.  If other cpus have been offlined already, they
 doesn't work properly.

  Example (MIPS OCTEON case):
   panic()
    crash_kexec()
     machine_crash_shutdown()
      octeon_generic_shutdown() // shutdown watchdog for ONLINE cpus
     machine_kexec()

 Problem 2:
 Most of architectures stop other cpus in the machine_crash_shutdown()
 path and save register information at that time.  However, if
 smp_send_stop() is called before that, we can't save the register
 information.

This patch solves the problem 2 by replacing smp_send_stop() in
panic() with panic_smp_stop_cpus() which is a weak function and can be
replaced with suitable version for crash_kexec context.  In fact,
x86 replaces it with a function based on kdump_nmi_shootdown_cpus() to
stop other cpus and save their states.

Please note that crash_kexec() can be called directly without
entering panic().  A stop-other-cpus procedure is still needed
by crash_kexec().

Changes in V2:
- Replace smp_send_stop() call with crash_kexec version which
  saves cpu states and cleans up VMX/SVM
- Drop a fix for Problem 1 at this moment

Reported-by: Daniel Walker <dwalker@fifo99.com>
Fixes: f06e5153f4ae (kernel/panic.c: add "crash_kexec_post_notifiers" option
Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
---
 arch/x86/kernel/crash.c |   16 +++++++++++-----
 kernel/panic.c          |   29 +++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e068d66..913c621 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -130,16 +130,22 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
 	disable_local_APIC();
 }
 
-static void kdump_nmi_shootdown_cpus(void)
+/* Please see the comment on the weak version in kernel/panic.c */
+void panic_smp_stop_cpus(void)
 {
+	static int cpus_stopped;
+
 	in_crash_kexec = 1;
-	nmi_shootdown_cpus(kdump_nmi_callback);
 
-	disable_local_APIC();
+	if (!cpus_stopped) {
+		nmi_shootdown_cpus(kdump_nmi_callback);
+		disable_local_APIC();
+		cpus_stopped = 1;
+	}
 }
 
 #else
-static void kdump_nmi_shootdown_cpus(void)
+void panic_smp_stop_cpus(void)
 {
 	/* There are no cpus to shootdown */
 }
@@ -158,7 +164,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	/* The kernel is broken so disable interrupts */
 	local_irq_disable();
 
-	kdump_nmi_shootdown_cpus();
+	panic_smp_stop_cpus();
 
 	/*
 	 * VMCLEAR VMCSs loaded on this cpu if needed.
diff --git a/kernel/panic.c b/kernel/panic.c
index 04e91ff..a507637 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -60,6 +60,28 @@ void __weak panic_smp_self_stop(void)
 		cpu_relax();
 }
 
+/*
+ * Stop other cpus in panic.  Architecture code may override this to
+ * with more suitable version.  Moreover, if the architecture supports
+ * crash dump, it should also save the states of stopped cpus.
+ *
+ * This function should be called only once.
+ */
+void __weak panic_smp_stop_cpus(void)
+{
+	static int cpus_stopped;
+
+	if (!cpus_stopped) {
+		/*
+		 * Note smp_send_stop is the usual smp shutdown function,
+		 * which unfortunately means it may not be hardened to
+		 * work in a panic situation.
+		 */
+		smp_send_stop();
+		cpus_stopped = 1;
+	}
+}
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -120,12 +142,7 @@ void panic(const char *fmt, ...)
 	if (!crash_kexec_post_notifiers)
 		crash_kexec(NULL);
 
-	/*
-	 * Note smp_send_stop is the usual smp shutdown function, which
-	 * unfortunately means it may not be hardened to work in a panic
-	 * situation.
-	 */
-	smp_send_stop();
+	panic_smp_stop_cpus();
 
 	/*
 	 * Run any panic handlers, including those that might need to
