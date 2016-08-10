Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2016 10:14:52 +0200 (CEST)
Received: from mail4.hitachi.co.jp ([133.145.228.5]:49263 "EHLO
        mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992078AbcHJIOWOV9uH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Aug 2016 10:14:22 +0200
Received: from mlsw2.hitachi.co.jp (unknown [133.144.234.166])
        by mail4.hitachi.co.jp (Postfix) with ESMTP id E4A022CF4C3;
        Wed, 10 Aug 2016 17:14:19 +0900 (JST)
Received: from mfilter4.hitachi.co.jp by mlsw2.hitachi.co.jp (8.13.8/8.13.8) id u7A8EJga019269; Wed, 10 Aug 2016 17:14:19 +0900
Received: from vshuts04.hitachi.co.jp (vshuts04.hitachi.co.jp [10.201.6.86])
        by mfilter4.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id u7A8EHd6006406;
        Wed, 10 Aug 2016 17:14:18 +0900
Received: from hsdlmain.sdl.hitachi.co.jp (unknown [133.144.14.194])
        by vshuts04.hitachi.co.jp (Postfix) with ESMTP id 593D313E054;
        Wed, 10 Aug 2016 17:14:18 +0900 (JST)
Received: from [10.198.219.51] by hsdlmain.sdl.hitachi.co.jp (8.13.8/3.7W11021512) id u7A8EHEO019369; Wed, 10 Aug 2016 17:14:17 +0900
Subject: [V4 PATCH 2/2] mips/panic: Replace smp_send_stop() with kdump
 friendly version in panic path
From:   Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Corey Minyard <cminyard@mvista.com>, x86@kernel.org,
        David Daney <david.daney@cavium.com>,
        Xunlei Pang <xpang@redhat.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        linux-mips@linux-mips.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        xen-devel@lists.xenproject.org, Daniel Walker <dwalker@fifo99.com>,
        Vivek Goyal <vgoyal@redhat.com>
Date:   Wed, 10 Aug 2016 17:09:50 +0900
Message-ID: <20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
In-Reply-To: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
References: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54466
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

Daniel Walker reported problems which happens when
crash_kexec_post_notifiers kernel option is enabled
(https://lkml.org/lkml/2015/6/24/44).

In that case, smp_send_stop() is called before entering kdump routines
which assume other CPUs are still online.  As the result, kdump
routines fail to save other CPUs' registers.  Additionally for MIPS
OCTEON, it misses to stop the watchdog timer.

To fix this problem, call a new kdump friendly function,
crash_smp_send_stop(), instead of the smp_send_stop() when
crash_kexec_post_notifiers is enabled.  crash_smp_send_stop() is a
weak function, and it just call smp_send_stop().  Architecture
codes should override it so that kdump can work appropriately.
This patch provides MIPS version.

Reported-by: Daniel Walker <dwalker@fifo99.com>
Fixes: f06e5153f4ae (kernel/panic.c: add "crash_kexec_post_notifiers" option)
Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "Steven J. Hill" <steven.hill@cavium.com>
Cc: Corey Minyard <cminyard@mvista.com>

---
I'm not familiar with MIPS, and I don't have a test environment and
just did build tests only.  Please don't apply this patch until
someone does enough tests, otherwise simply drop this patch.
---
 arch/mips/cavium-octeon/setup.c  |   14 ++++++++++++++
 arch/mips/include/asm/kexec.h    |    1 +
 arch/mips/kernel/crash.c         |   18 +++++++++++++++++-
 arch/mips/kernel/machine_kexec.c |    1 +
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index cb16fcc..5537f95 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -267,6 +267,17 @@ static void octeon_crash_shutdown(struct pt_regs *regs)
 	default_machine_crash_shutdown(regs);
 }
 
+#ifdef CONFIG_SMP
+void octeon_crash_smp_send_stop(void)
+{
+	int cpu;
+
+	/* disable watchdogs */
+	for_each_online_cpu(cpu)
+		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
+}
+#endif
+
 #endif /* CONFIG_KEXEC */
 
 #ifdef CONFIG_CAVIUM_RESERVE32
@@ -911,6 +922,9 @@ void __init prom_init(void)
 	_machine_kexec_shutdown = octeon_shutdown;
 	_machine_crash_shutdown = octeon_crash_shutdown;
 	_machine_kexec_prepare = octeon_kexec_prepare;
+#ifdef CONFIG_SMP
+	_crash_smp_send_stop = octeon_crash_smp_send_stop;
+#endif
 #endif
 
 	octeon_user_io_init();
diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index ee25ebb..493a3cc 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -45,6 +45,7 @@ extern const unsigned char kexec_smp_wait[];
 extern unsigned long secondary_kexec_args[4];
 extern void (*relocated_kexec_smp_wait) (void *);
 extern atomic_t kexec_ready_to_reboot;
+extern void (*_crash_smp_send_stop)(void);
 #endif
 #endif
 
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index 610f0f3..1723b17 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -47,9 +47,14 @@ static void crash_shutdown_secondary(void *passed_regs)
 
 static void crash_kexec_prepare_cpus(void)
 {
+	static int cpus_stopped;
 	unsigned int msecs;
+	unsigned int ncpus;
 
-	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
+	if (cpus_stopped)
+		return;
+
+	ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
 
 	dump_send_ipi(crash_shutdown_secondary);
 	smp_wmb();
@@ -64,6 +69,17 @@ static void crash_kexec_prepare_cpus(void)
 		cpu_relax();
 		mdelay(1);
 	}
+
+	cpus_stopped = 1;
+}
+
+/* Override the weak function in kernel/panic.c */
+void crash_smp_send_stop(void)
+{
+	if (_crash_smp_send_stop)
+		_crash_smp_send_stop();
+
+	crash_kexec_prepare_cpus();
 }
 
 #else /* !defined(CONFIG_SMP)  */
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 50980bf3..5972520 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -25,6 +25,7 @@ void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
 #ifdef CONFIG_SMP
 void (*relocated_kexec_smp_wait) (void *);
 atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
+void (*_crash_smp_send_stop)(void) = NULL;
 #endif
 
 int
