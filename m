Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:27:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54429 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007793AbcBCD1bXGxmQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:27:31 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id F0ABC46E167C;
        Wed,  3 Feb 2016 03:27:23 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:27:25 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:27:24 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Petri Gynther <pgynther@google.com>
Subject: [PATCH 2/3] MIPS: Add P6600 cases to CPU switch statements
Date:   Wed, 3 Feb 2016 03:26:38 +0000
Message-ID: <1454469999-17818-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454469999-17818-1-git-send-email-paul.burton@imgtec.com>
References: <1454469999-17818-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Add cases supporting the P6600 CPU to various switch statements in
core MIPS kernel code that define behaviour dependent upon the CPU.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/cpu-type.h     | 1 +
 arch/mips/kernel/cpu-probe.c         | 1 +
 arch/mips/kernel/perf_event_mipsxx.c | 6 ++++++
 arch/mips/kernel/spram.c             | 1 +
 arch/mips/kernel/traps.c             | 1 +
 arch/mips/mm/c-r4k.c                 | 1 +
 arch/mips/mm/sc-mips.c               | 1 +
 7 files changed, 12 insertions(+)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index abee2bf..2cb0979 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -79,6 +79,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 
 #ifdef CONFIG_SYS_HAS_CPU_MIPS64_R6
 	case CPU_I6400:
+	case CPU_P6600:
 #endif
 
 #ifdef CONFIG_SYS_HAS_CPU_R3000
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b725b71..bc54458 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -539,6 +539,7 @@ static int set_ftlb_enable(struct cpuinfo_mips *c, int enable)
 	switch (c->cputype) {
 	case CPU_PROAPTIV:
 	case CPU_P5600:
+	case CPU_P6600:
 		/* proAptiv & related cores use Config6 to enable the FTLB */
 		config = read_c0_config6();
 		/* Clear the old probability value */
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index d7b8dd4..ae378d9 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1556,6 +1556,7 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 #endif
 		break;
 	case CPU_P5600:
+	case CPU_P6600:
 	case CPU_I6400:
 		/* 8-bit event numbers */
 		raw_id = config & 0x1ff;
@@ -1718,6 +1719,11 @@ init_hw_perf_events(void)
 		mipspmu.general_event_map = &mipsxxcore_event_map2;
 		mipspmu.cache_event_map = &mipsxxcore_cache_map2;
 		break;
+	case CPU_P6600:
+		mipspmu.name = "mips/P6600";
+		mipspmu.general_event_map = &mipsxxcore_event_map2;
+		mipspmu.cache_event_map = &mipsxxcore_cache_map2;
+		break;
 	case CPU_I6400:
 		mipspmu.name = "mips/I6400";
 		mipspmu.general_event_map = &mipsxxcore_event_map2;
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index 8489c88..d6e6cf7 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -210,6 +210,7 @@ void spram_config(void)
 	case CPU_P5600:
 	case CPU_QEMU_GENERIC:
 	case CPU_I6400:
+	case CPU_P6600:
 		config0 = read_c0_config();
 		/* FIXME: addresses are Malta specific */
 		if (config0 & (1<<24)) {
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index bafcb7a..f7dfe60 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1653,6 +1653,7 @@ static inline void parity_protection_init(void)
 	case CPU_P5600:
 	case CPU_QEMU_GENERIC:
 	case CPU_I6400:
+	case CPU_P6600:
 		{
 #define ERRCTL_PE	0x80000000
 #define ERRCTL_L2P	0x00800000
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index caac3d7..2f47999 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1278,6 +1278,7 @@ static void probe_pcache(void)
 	case CPU_M5150:
 	case CPU_QEMU_GENERIC:
 	case CPU_I6400:
+	case CPU_P6600:
 		if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
 		    (c->icache.waysize > PAGE_SIZE))
 			c->icache.flags |= MIPS_CACHE_ALIASES;
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 3bd0597..91006c2 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -141,6 +141,7 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
 	case CPU_P5600:
 	case CPU_BMIPS5000:
 	case CPU_QEMU_GENERIC:
+	case CPU_P6600:
 		if (config2 & (1 << 12))
 			return 0;
 	}
-- 
2.7.0
