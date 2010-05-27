Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 15:07:28 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:49437 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492355Ab0E0NFS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 15:05:18 +0200
Received: by pvg13 with SMTP id 13so295947pvg.36
        for <multiple recipients>; Thu, 27 May 2010 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WXxqyayXSAQHH376X6vbRFajnYhtR8d5pgYcxW1MMCA=;
        b=BGkxtVpu+ZLrjyGQlv+qr27r4QgEHGCUNnFUvHKpXMvyMZfVhLFn2cV1Jwgv88WH8i
         XbCYEIwNZjJXIxXacwLx+rwuMz/nvtNOafWQsq+NBFEgHYWKzNl0gOzoBRbfMlkFRroE
         dtDOPswjVrStCwFFMLmbdsdsKj+u8kbDADyDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HM5/1BdmgtZG0RZ0LgnhnDV6+pKD12vEcsXnU6Sh19vEBBUr7ZfAh2eDkXwLgd261b
         bQtf7biyBA0X/uZC1NKjNc4L80EmNHkui4Hozk3MoI5/74iiEYst+ykYpK8wSu8yDjc0
         zt0bHHoXvoHSXxaSAf1/k2c6N/CJEzmopqJb8=
Received: by 10.142.121.1 with SMTP id t1mr7094873wfc.100.1274965510984;
        Thu, 27 May 2010 06:05:10 -0700 (PDT)
Received: from localhost.localdomain ([114.84.70.124])
        by mx.google.com with ESMTPS id 21sm972927pzk.8.2010.05.27.06.05.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 06:05:10 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 07/12] MIPS/Perf-events: add raw event support for mipsxx 24K/34K/74K/1004K
Date:   Thu, 27 May 2010 21:03:35 +0800
Message-Id: <1274965420-5091-8-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Raw event is an important part of Perf-events. It helps the user collect
performance data for events that are not listed as the generic hardware
events and cache events but ARE supported by the CPU's PMU.

This patch adds this feature for mipsxx 24K/34K/74K/1004K. For how to use
it, please refer to processor core software user's manual and the
comments for mipsxx_pmu_map_raw_event() for more details.

Please note that this is a "precise" implementation, which means the
kernel will check whether the requested raw events are supported by this
CPU and which hardware counters can be assigned for them.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/kernel/perf_event.c        |    4 +
 arch/mips/kernel/perf_event_mipsxx.c |  152 +++++++++++++++++++++++++++++++++-
 2 files changed, 155 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 4c9b741..24e07f8 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -81,6 +81,9 @@ struct mips_perf_event {
 #endif
 };
 
+static struct mips_perf_event raw_event;
+static DEFINE_MUTEX(raw_event_mutex);
+
 #define UNSUPPORTED_PERF_EVENT_ID 0xffffffff
 #define C(x) PERF_COUNT_HW_CACHE_##x
 
@@ -96,6 +99,7 @@ struct mips_pmu {
 	void		(*write_counter)(unsigned int idx, unsigned int val);
 	void		(*enable_event)(struct hw_perf_event *evt, int idx);
 	void		(*disable_event)(int idx);
+	const struct mips_perf_event *(*map_raw_event)(u64 config);
 	const struct mips_perf_event (*general_event_map)[PERF_COUNT_HW_MAX];
 	const struct mips_perf_event (*cache_event_map)
 				[PERF_COUNT_HW_CACHE_MAX]
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 87103bf..802d98e 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -367,13 +367,20 @@ static int __hw_perf_event_init(struct perf_event *event)
 		pev = mipspmu_map_general_event(event->attr.config);
 	} else if (PERF_TYPE_HW_CACHE == event->attr.type) {
 		pev = mipspmu_map_cache_event(event->attr.config);
+	} else if (PERF_TYPE_RAW == event->attr.type) {
+		/* We are working on the global raw event. */
+		mutex_lock(&raw_event_mutex);
+		pev = mipspmu->map_raw_event(event->attr.config);
 	} else {
 		/* The event type is not (yet) supported. */
 		return -EOPNOTSUPP;
 	}
 
-	if (IS_ERR(pev))
+	if (IS_ERR(pev)) {
+		if (PERF_TYPE_RAW == event->attr.type)
+			mutex_unlock(&raw_event_mutex);
 		return PTR_ERR(pev);
+	}
 
 	/*
 	 * We allow max flexibility on how each individual counter shared
@@ -386,6 +393,8 @@ static int __hw_perf_event_init(struct perf_event *event)
 		check_and_calc_range(event, pev);
 
 	hwc->event_base = mipspmu_perf_event_encode(pev);
+	if (PERF_TYPE_RAW == event->attr.type)
+		mutex_unlock(&raw_event_mutex);
 
 	if (!attr->exclude_user)
 		hwc->config_base |= M_PERFCTL_USER;
@@ -632,6 +641,145 @@ mipsxx_pmu_disable_event(int idx)
 	local_irq_restore(flags);
 }
 
+/* 24K */
+#define IS_UNSUPPORTED_24K_EVENT(r, b)					\
+	((b) == 12 || (r) == 151 || (r) == 152 || (b) == 26 ||		\
+	 (b) == 27 || (r) == 28 || (r) == 158 || (b) == 31 ||		\
+	 (b) == 32 || (b) == 34 || (b) == 36 || (r) == 168 ||		\
+	 (r) == 172 || (b) == 47 || ((b) >= 56 && (b) <= 63) ||		\
+	 ((b) >= 68 && (b) <= 127))
+#define IS_BOTH_COUNTERS_24K_EVENT(b)					\
+	((b) == 0 || (b) == 1 || (b) == 11)
+
+/* 34K */
+#define IS_UNSUPPORTED_34K_EVENT(r, b)					\
+	((b) == 12 || (r) == 27 || (r) == 158 || (b) == 36 ||		\
+	 (b) == 38 || (r) == 175 || ((b) >= 56 && (b) <= 63) ||		\
+	 ((b) >= 68 && (b) <= 127))
+#define IS_BOTH_COUNTERS_34K_EVENT(b)					\
+	((b) == 0 || (b) == 1 || (b) == 11)
+#ifdef CONFIG_MIPS_MT_SMP
+#define IS_RANGE_P_34K_EVENT(r, b)					\
+	((b) == 0 || (r) == 18 || (b) == 21 || (b) == 22 ||		\
+	 (b) == 25 || (b) == 39 || (r) == 44 || (r) == 174 ||		\
+	 (r) == 176 || ((b) >= 50 && (b) <= 55) ||			\
+	 ((b) >= 64 && (b) <= 67))
+#define IS_RANGE_V_34K_EVENT(r)	((r) == 47)
+#endif
+
+/* 74K */
+#define IS_UNSUPPORTED_74K_EVENT(r, b)					\
+	((r) == 5 || ((r) >= 135 && (r) <= 137) ||			\
+	 ((b) >= 10 && (b) <= 12) || (b) == 22 || (b) == 27 ||		\
+	 (b) == 33 || (b) == 34 || ((b) >= 47 && (b) <= 49) ||		\
+	 (r) == 178 || (b) == 55 || (b) == 57 || (b) == 60 ||		\
+	 (b) == 61 || (r) == 62 || (r) == 191 ||			\
+	 ((b) >= 64 && (b) <= 127))
+#define IS_BOTH_COUNTERS_74K_EVENT(b)					\
+	((b) == 0 || (b) == 1)
+
+/* 1004K */
+#define IS_UNSUPPORTED_1004K_EVENT(r, b)				\
+	((b) == 12 || (r) == 27 || (r) == 158 || (b) == 38 ||		\
+	 (r) == 175 || (b) == 63 || ((b) >= 68 && (b) <= 127))
+#define IS_BOTH_COUNTERS_1004K_EVENT(b)					\
+	((b) == 0 || (b) == 1 || (b) == 11)
+#ifdef CONFIG_MIPS_MT_SMP
+#define IS_RANGE_P_1004K_EVENT(r, b)					\
+	((b) == 0 || (r) == 18 || (b) == 21 || (b) == 22 ||		\
+	 (b) == 25 || (b) == 36 || (b) == 39 || (r) == 44 ||		\
+	 (r) == 174 || (r) == 176 || ((b) >= 50 && (b) <= 59) ||	\
+	 (r) == 188 || (b) == 61 || (b) == 62 ||			\
+	 ((b) >= 64 && (b) <= 67))
+#define IS_RANGE_V_1004K_EVENT(r)	((r) == 47)
+#endif
+
+/*
+ * User can use 0-255 raw events, where 0-127 for the events of even
+ * counters, and 128-255 for odd counters. Note that bit 7 is used to
+ * indicate the parity. So, for example, when user wants to take the
+ * Event Num of 15 for odd counters (by referring to the user manual),
+ * then 128 needs to be added to 15 as the input for the event config,
+ * i.e., 143 (0x8F) to be used.
+ */
+static const struct mips_perf_event *
+mipsxx_pmu_map_raw_event(u64 config)
+{
+	unsigned int raw_id = config & 0xff;
+	unsigned int base_id = raw_id & 0x7f;
+
+	switch (current_cpu_type()) {
+	case CPU_24K:
+		if (IS_UNSUPPORTED_24K_EVENT(raw_id, base_id))
+			return ERR_PTR(-EOPNOTSUPP);
+		raw_event.event_id = base_id;
+		if (IS_BOTH_COUNTERS_24K_EVENT(base_id))
+			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		else
+			raw_event.cntr_mask =
+				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+#ifdef CONFIG_MIPS_MT_SMP
+		/*
+		 * This is actually doing nothing. Non-multithreading
+		 * CPUs will not check and calculate the range.
+		 */
+		raw_event.range = P;
+#endif
+		break;
+	case CPU_34K:
+		if (IS_UNSUPPORTED_34K_EVENT(raw_id, base_id))
+			return ERR_PTR(-EOPNOTSUPP);
+		raw_event.event_id = base_id;
+		if (IS_BOTH_COUNTERS_34K_EVENT(base_id))
+			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		else
+			raw_event.cntr_mask =
+				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+#ifdef CONFIG_MIPS_MT_SMP
+		if (IS_RANGE_P_34K_EVENT(raw_id, base_id))
+			raw_event.range = P;
+		else if (unlikely(IS_RANGE_V_34K_EVENT(raw_id)))
+			raw_event.range = V;
+		else
+			raw_event.range = T;
+#endif
+		break;
+	case CPU_74K:
+		if (IS_UNSUPPORTED_74K_EVENT(raw_id, base_id))
+			return ERR_PTR(-EOPNOTSUPP);
+		raw_event.event_id = base_id;
+		if (IS_BOTH_COUNTERS_74K_EVENT(base_id))
+			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		else
+			raw_event.cntr_mask =
+				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+#ifdef CONFIG_MIPS_MT_SMP
+		raw_event.range = P;
+#endif
+		break;
+	case CPU_1004K:
+		if (IS_UNSUPPORTED_1004K_EVENT(raw_id, base_id))
+			return ERR_PTR(-EOPNOTSUPP);
+		raw_event.event_id = base_id;
+		if (IS_BOTH_COUNTERS_1004K_EVENT(base_id))
+			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		else
+			raw_event.cntr_mask =
+				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+#ifdef CONFIG_MIPS_MT_SMP
+		if (IS_RANGE_P_1004K_EVENT(raw_id, base_id))
+			raw_event.range = P;
+		else if (unlikely(IS_RANGE_V_1004K_EVENT(raw_id)))
+			raw_event.range = V;
+		else
+			raw_event.range = T;
+#endif
+		break;
+	}
+
+	return &raw_event;
+}
+
 static struct mips_pmu mipsxxcore_pmu = {
 	.handle_irq = mipsxx_pmu_handle_irq,
 	.handle_shared_irq = mipsxx_pmu_handle_shared_irq,
@@ -642,6 +790,7 @@ static struct mips_pmu mipsxxcore_pmu = {
 	.write_counter = mipsxx_pmu_write_counter,
 	.enable_event = mipsxx_pmu_enable_event,
 	.disable_event = mipsxx_pmu_disable_event,
+	.map_raw_event = mipsxx_pmu_map_raw_event,
 	.general_event_map = &mipsxxcore_event_map,
 	.cache_event_map = &mipsxxcore_cache_map,
 };
@@ -656,6 +805,7 @@ static struct mips_pmu mipsxx74Kcore_pmu = {
 	.write_counter = mipsxx_pmu_write_counter,
 	.enable_event = mipsxx_pmu_enable_event,
 	.disable_event = mipsxx_pmu_disable_event,
+	.map_raw_event = mipsxx_pmu_map_raw_event,
 	.general_event_map = &mipsxx74Kcore_event_map,
 	.cache_event_map = &mipsxx74Kcore_cache_map,
 };
-- 
1.6.3.3
