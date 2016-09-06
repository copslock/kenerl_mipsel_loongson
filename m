Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Sep 2016 19:06:29 +0200 (CEST)
Received: from Galois.linutronix.de ([146.0.238.70]:55676 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992214AbcIFRGVtRDxT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Sep 2016 19:06:21 +0200
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1bhJp5-0000Ly-Vc; Tue, 06 Sep 2016 19:06:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, rt@linutronix.de,
        tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 15/21] mips: octeon: smp: Convert to hotplug state machine
Date:   Tue,  6 Sep 2016 19:04:51 +0200
Message-Id: <20160906170457.32393-16-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160906170457.32393-1-bigeasy@linutronix.de>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: <bigeasy@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55042
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
 arch/mips/cavium-octeon/smp.c | 24 +++---------------------
 include/linux/cpuhotplug.h    |  1 +
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 4d457d602d3b..228c1cab2912 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -380,29 +380,11 @@ static int octeon_update_boot_vector(unsigned int cpu)
 	return 0;
 }
=20
-static int octeon_cpu_callback(struct notifier_block *nfb,
-	unsigned long action, void *hcpu)
-{
-	unsigned int cpu =3D (unsigned long)hcpu;
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_UP_PREPARE:
-		octeon_update_boot_vector(cpu);
-		break;
-	case CPU_ONLINE:
-		pr_info("Cpu %d online\n", cpu);
-		break;
-	case CPU_DEAD:
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-
 static int register_cavium_notifier(void)
 {
-	hotcpu_notifier(octeon_cpu_callback, 0);
-	return 0;
+	return cpuhp_setup_state_nocalls(CPUHP_MIPS_CAVIUM_PREPARE,
+					 "mips/cavium:prepare",
+					 octeon_update_boot_vector, NULL);
 }
 late_initcall(register_cavium_notifier);
=20
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 4cbf88c955d6..058d312fdf6f 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -44,6 +44,7 @@ enum cpuhp_state {
 	CPUHP_SH_SH3X_PREPARE,
 	CPUHP_X86_MICRCODE_PREPARE,
 	CPUHP_NOTF_ERR_INJ_PREPARE,
+	CPUHP_MIPS_CAVIUM_PREPARE,
 	CPUHP_TIMERS_DEAD,
 	CPUHP_BRINGUP_CPU,
 	CPUHP_AP_IDLE_DEAD,
--=20
2.9.3
