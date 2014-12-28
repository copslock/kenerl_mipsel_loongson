Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Dec 2014 05:57:46 +0100 (CET)
Received: from smtpbg320.qq.com ([14.17.32.29]:39384 "EHLO smtpbg320.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007771AbaL1E5GiPbGC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 28 Dec 2014 05:57:06 +0100
X-QQ-mid: bizesmtp3t1419742591t394t132
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 28 Dec 2014 12:56:30 +0800 (CST)
X-QQ-SSF: 01100000002000F0FH42B00A0000000
X-QQ-FEAT: bwgMLqpyqeJbn6ZQTZYrT31DKvf497Ki8dfGVA1nOctRp7cCw+Pu5C9klkrvd
        6XpXCSoDSe/v3dPKO9W70WS9x4EFy0ZV4TCaW28Nih+C6xclJk42jLwoXsNKNJAuGCBD7Yb
        3m3+Hhn/ZguWdetumGSZpgQR9x+Mf4ZWEGijGswjWqSYcV+qXturKouaNm/wXj1QkvmpRp/
        trmZ2LgFbwDvu4VYHpxTn5xuM/ywR+SJbbMBmvO134w==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V6 2/8] MIPS: perf: Add hardware perf events support for Loongson-3
Date:   Sun, 28 Dec 2014 12:56:18 +0800
Message-Id: <1419742578-15047-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1419742578-15047-1-git-send-email-chenhc@lemote.com>
References: <1419742578-15047-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

This patch enable hardware performance counter support for Loongson-3's
perf events.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Kconfig                    |    2 +-
 arch/mips/kernel/perf_event_mipsxx.c |   71 ++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 185d84a..b40b9f1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2286,7 +2286,7 @@ config NODES_SHIFT
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
-	depends on PERF_EVENTS && OPROFILE=n && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP)
+	depends on PERF_EVENTS && OPROFILE=n && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP || CPU_LOONGSON3)
 	default y
 	help
 	  Enable hardware performance counter support for perf events. If
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 9466184..9efeb75 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -822,6 +822,13 @@ static const struct mips_perf_event mipsxxcore_event_map2
 	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x27, CNTR_ODD, T },
 };
 
+static const struct mips_perf_event loongson3_event_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = { 0x00, CNTR_EVEN },
+	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x00, CNTR_ODD },
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { 0x01, CNTR_EVEN },
+	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x01, CNTR_ODD },
+};
+
 static const struct mips_perf_event octeon_event_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = { 0x01, CNTR_ALL },
 	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x03, CNTR_ALL },
@@ -1005,6 +1012,61 @@ static const struct mips_perf_event mipsxxcore_cache_map2
 },
 };
 
+static const struct mips_perf_event loongson3_cache_map
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	/*
+	 * Like some other architectures (e.g. ARM), the performance
+	 * counters don't differentiate between read and write
+	 * accesses/misses, so this isn't strictly correct, but it's the
+	 * best we can do. Writes and reads get combined.
+	 */
+	[C(OP_READ)] = {
+		[C(RESULT_MISS)]        = { 0x04, CNTR_ODD },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_MISS)]        = { 0x04, CNTR_ODD },
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_MISS)]        = { 0x04, CNTR_EVEN },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_MISS)]        = { 0x04, CNTR_EVEN },
+	},
+},
+[C(DTLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_MISS)]        = { 0x09, CNTR_ODD },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_MISS)]        = { 0x09, CNTR_ODD },
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_MISS)]        = { 0x0c, CNTR_ODD },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_MISS)]        = { 0x0c, CNTR_ODD },
+	},
+},
+[C(BPU)] = {
+	/* Using the same code for *HW_BRANCH* */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]      = { 0x02, CNTR_EVEN },
+		[C(RESULT_MISS)]        = { 0x02, CNTR_ODD },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]      = { 0x02, CNTR_EVEN },
+		[C(RESULT_MISS)]        = { 0x02, CNTR_ODD },
+	},
+},
+};
+
 /* BMIPS5000 */
 static const struct mips_perf_event bmips5000_cache_map
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -1539,6 +1601,10 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 		else
 			raw_event.cntr_mask =
 				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+		break;
+	case CPU_LOONGSON3:
+		raw_event.cntr_mask = raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+	break;
 	}
 
 	raw_event.event_id = base_id;
@@ -1669,6 +1735,11 @@ init_hw_perf_events(void)
 		mipspmu.general_event_map = &mipsxxcore_event_map;
 		mipspmu.cache_event_map = &mipsxxcore_cache_map;
 		break;
+	case CPU_LOONGSON3:
+		mipspmu.name = "mips/loongson3";
+		mipspmu.general_event_map = &loongson3_event_map;
+		mipspmu.cache_event_map = &loongson3_cache_map;
+		break;
 	case CPU_CAVIUM_OCTEON:
 	case CPU_CAVIUM_OCTEON_PLUS:
 	case CPU_CAVIUM_OCTEON2:
-- 
1.7.7.3
