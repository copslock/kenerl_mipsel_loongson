Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Sep 2016 19:06:50 +0200 (CEST)
Received: from Galois.linutronix.de ([146.0.238.70]:55705 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992249AbcIFRGZsQN2T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Sep 2016 19:06:25 +0200
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1bhJp7-0000Ly-0T; Tue, 06 Sep 2016 19:06:13 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, rt@linutronix.de,
        tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 16/21] mips: loongson: smp: Convert to hotplug state machine
Date:   Tue,  6 Sep 2016 19:04:52 +0200
Message-Id: <20160906170457.32393-17-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160906170457.32393-1-bigeasy@linutronix.de>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: <bigeasy@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bigeasy@linutronix.de
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

Install the callbacks via the state machine.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/mips/loongson64/loongson-3/smp.c | 34 ++++++++-----------------------=
---
 include/linux/cpuhotplug.h            |  1 +
 2 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/l=
oongson-3/smp.c
index 2fec6f753a35..bd7c8cf5332d 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -677,7 +677,7 @@ void play_dead(void)
 	play_dead_at_ckseg1(state_addr);
 }
=20
-void loongson3_disable_clock(int cpu)
+static int loongson3_disable_clock(unsigned int cpu)
 {
 	uint64_t core_id =3D cpu_data[cpu].core;
 	uint64_t package_id =3D cpu_data[cpu].package;
@@ -688,9 +688,10 @@ void loongson3_disable_clock(int cpu)
 		if (!(loongson_sysconf.workarounds & WORKAROUND_CPUHOTPLUG))
 			LOONGSON_FREQCTRL(package_id) &=3D ~(1 << (core_id * 4 + 3));
 	}
+	return 0;
 }
=20
-void loongson3_enable_clock(int cpu)
+static int loongson3_enable_clock(unsigned int cpu)
 {
 	uint64_t core_id =3D cpu_data[cpu].core;
 	uint64_t package_id =3D cpu_data[cpu].package;
@@ -701,34 +702,15 @@ void loongson3_enable_clock(int cpu)
 		if (!(loongson_sysconf.workarounds & WORKAROUND_CPUHOTPLUG))
 			LOONGSON_FREQCTRL(package_id) |=3D 1 << (core_id * 4 + 3);
 	}
-}
-
-#define CPU_POST_DEAD_FROZEN	(CPU_POST_DEAD | CPU_TASKS_FROZEN)
-static int loongson3_cpu_callback(struct notifier_block *nfb,
-	unsigned long action, void *hcpu)
-{
-	unsigned int cpu =3D (unsigned long)hcpu;
-
-	switch (action) {
-	case CPU_POST_DEAD:
-	case CPU_POST_DEAD_FROZEN:
-		pr_info("Disable clock for CPU#%d\n", cpu);
-		loongson3_disable_clock(cpu);
-		break;
-	case CPU_UP_PREPARE:
-	case CPU_UP_PREPARE_FROZEN:
-		pr_info("Enable clock for CPU#%d\n", cpu);
-		loongson3_enable_clock(cpu);
-		break;
-	}
-
-	return NOTIFY_OK;
+	return 0;
 }
=20
 static int register_loongson3_notifier(void)
 {
-	hotcpu_notifier(loongson3_cpu_callback, 0);
-	return 0;
+	return cpuhp_setup_state_nocalls(CPUHP_MIPS_LOONGSON_PREPARE,
+					 "mips/loongson:prepare",
+					 loongson3_enable_clock,
+					 loongson3_disable_clock);
 }
 early_initcall(register_loongson3_notifier);
=20
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 058d312fdf6f..9e56be3eaf3f 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -45,6 +45,7 @@ enum cpuhp_state {
 	CPUHP_X86_MICRCODE_PREPARE,
 	CPUHP_NOTF_ERR_INJ_PREPARE,
 	CPUHP_MIPS_CAVIUM_PREPARE,
+	CPUHP_MIPS_LOONGSON_PREPARE,
 	CPUHP_TIMERS_DEAD,
 	CPUHP_BRINGUP_CPU,
 	CPUHP_AP_IDLE_DEAD,
--=20
2.9.3
