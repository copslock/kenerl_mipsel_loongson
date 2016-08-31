Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 12:49:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3864 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992257AbcHaKpIZmI3D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 12:45:08 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0A1E84A90F8BA;
        Wed, 31 Aug 2016 11:44:50 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 31 Aug 2016 11:44:52 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 10/10] cpuidle: cpuidle-cps: Enable use with MIPSr6 CPUs.
Date:   Wed, 31 Aug 2016 11:44:39 +0100
Message-ID: <1472640279-26593-11-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
References: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

This patch enables the MIPS CPS driver for MIPSr6 CPUs.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>

---

 drivers/cpuidle/Kconfig.mips  | 2 +-
 drivers/cpuidle/cpuidle-cps.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.mips b/drivers/cpuidle/Kconfig.mips
index 4102be01d06a..512ee37b374b 100644
--- a/drivers/cpuidle/Kconfig.mips
+++ b/drivers/cpuidle/Kconfig.mips
@@ -5,7 +5,7 @@ config MIPS_CPS_CPUIDLE
 	bool "CPU Idle driver for MIPS CPS platforms"
 	depends on CPU_IDLE && MIPS_CPS
 	depends on SYS_SUPPORTS_MIPS_CPS
-	select ARCH_NEEDS_CPU_IDLE_COUPLED if MIPS_MT
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if MIPS_MT || CPU_MIPSR6
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select MIPS_CPS_PM
 	default y
diff --git a/drivers/cpuidle/cpuidle-cps.c b/drivers/cpuidle/cpuidle-cps.c
index 1adb6980b707..926ba9871c62 100644
--- a/drivers/cpuidle/cpuidle-cps.c
+++ b/drivers/cpuidle/cpuidle-cps.c
@@ -163,7 +163,7 @@ static int __init cps_cpuidle_init(void)
 		core = cpu_data[cpu].core;
 		device = &per_cpu(cpuidle_dev, cpu);
 		device->cpu = cpu;
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 		cpumask_copy(&device->coupled_cpus, &cpu_sibling_map[cpu]);
 #endif
 
-- 
2.7.4
