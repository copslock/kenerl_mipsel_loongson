Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2017 17:50:08 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:48594 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993539AbdDDPt7VcPuT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2017 17:49:59 +0200
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1cvQhg-0001w1-Bp; Tue, 04 Apr 2017 17:49:08 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] CPUFREQ: Loongson2: drop set_cpus_allowed_ptr()
Date:   Tue,  4 Apr 2017 17:49:57 +0200
Message-Id: <20170404154957.19678-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: <bigeasy@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57561
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

It is pure mystery to me why we need to be on a specific CPU while
looking up a value in an array.
My best shot at this is that before commit d4019f0a92ab ("cpufreq: move
freq change notifications to cpufreq core") it was required to invoke
cpufreq_notify_transition() on a special CPU.

Since it looks like a waste, remove it.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/cpufreq/loongson2_cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson=
2_cpufreq.c
index 6bbdac1065ff..9ac27b22476c 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -51,19 +51,12 @@ static int loongson2_cpu_freq_notifier(struct notifier_=
block *nb,
 static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
 				     unsigned int index)
 {
-	unsigned int cpu =3D policy->cpu;
-	cpumask_t cpus_allowed;
 	unsigned int freq;
=20
-	cpus_allowed =3D current->cpus_allowed;
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
-
 	freq =3D
 	    ((cpu_clock_freq / 1000) *
 	     loongson2_clockmod_table[index].driver_data) / 8;
=20
-	set_cpus_allowed_ptr(current, &cpus_allowed);
-
 	/* setting the cpu frequency */
 	clk_set_rate(policy->clk, freq * 1000);
=20
--=20
2.11.0
