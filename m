Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 15:08:19 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:65074 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492361Ab0E0NFg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 15:05:36 +0200
Received: by pxi1 with SMTP id 1so3253440pxi.36
        for <multiple recipients>; Thu, 27 May 2010 06:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4REyA9aPUL8TjFO3dZqu+J5BjYzILZTZ3UA5VGMY1UE=;
        b=aSp+LZu85Sd4vO2u/b6nT1W2/iJ6Zbcq1nYV1LSqEDbSp47etMdj55J9vbzve/p46Q
         iBgniiEl4Kav4baqKdLZLiDg6wq/MDvwkK/HEehpi3kgO4KKoXvCc+y6NbUiMxr4vZUI
         kUdo0QEY8prW+7LXPAGab5FOx3bldwg25m+Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uSzhNMLHdxRQh0sbTTJ2vlBIuKwNsozhwIcjQgnKcPHk55/bo/KvxTsp4hZyYtM0Ek
         rYCujFHTA+QH6JXMgasD4G99Y/sdoqY+xzgR4jA8yg5toN4Vdo30wIraFFm8MaRZqnJg
         S/ZarBAwpQuh2gw6/4wo1xoCs8zmMcgcPX4eU=
Received: by 10.142.7.13 with SMTP id 13mr6851692wfg.122.1274965527354;
        Thu, 27 May 2010 06:05:27 -0700 (PDT)
Received: from localhost.localdomain ([114.84.70.124])
        by mx.google.com with ESMTPS id 21sm972927pzk.8.2010.05.27.06.05.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 06:05:26 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 09/12] MIPS/Perf-events: replace pmu names with numeric IDs
Date:   Thu, 27 May 2010 21:03:37 +0800
Message-Id: <1274965420-5091-10-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Using Perf-events as the backend, clients such as Oprofile will need to
enquire the pmu names. A convenient way to do this is to use pmu id to
index the exported name array. And this is what we are doing here.

NOTE: While using scripts/checkpatch.pl to check this patch, a style
warning is reported. I suppose it is a false positive, and will report to
the maintainer. The message is:
=======================================
WARNING:
EXPORT_SYMBOL(foo); should immediately follow its function/variable
#81: FILE: arch/mips/kernel/perf_event.c:112:
+EXPORT_SYMBOL_GPL(mips_pmu_names);
=======================================

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/include/asm/pmu.h          |   26 ++++++++++++++++++++++++++
 arch/mips/kernel/perf_event.c        |   31 ++++++++++++++++++++++++++++++-
 arch/mips/kernel/perf_event_mipsxx.c |   12 +++++++-----
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
index 2822810..16d4fcd 100644
--- a/arch/mips/include/asm/pmu.h
+++ b/arch/mips/include/asm/pmu.h
@@ -89,4 +89,30 @@ extern unsigned int rm9000_perfcount_irq;
 
 #endif /* CONFIG_CPU_* */
 
+/* MIPS PMU IDs for use by internal perf clients. */
+enum mips_pmu_id {
+	/* mipsxx */
+	MIPS_PMU_ID_20K = 0,
+	MIPS_PMU_ID_24K,
+	MIPS_PMU_ID_25K,
+	MIPS_PMU_ID_1004K,
+	MIPS_PMU_ID_34K,
+	MIPS_PMU_ID_74K,
+	MIPS_PMU_ID_5K,
+	MIPS_PMU_ID_R10000V2,
+	MIPS_PMU_ID_R10000,
+	MIPS_PMU_ID_R12000,
+	MIPS_PMU_ID_SB1,
+	/* rm9000 */
+	MIPS_PMU_ID_RM9000,
+	/* loongson2 */
+	MIPS_PMU_ID_LOONGSON2,
+	/* unsupported */
+	MIPS_PMU_ID_UNSUPPORTED,
+};
+
+extern const char *mips_pmu_names[];
+
+extern enum mips_pmu_id mipspmu_get_pmu_id(void);
+
 #endif /* __MIPS_PMU_H__ */
diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 0ef54e6..f05e2b1 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -88,8 +88,31 @@ static DEFINE_MUTEX(raw_event_mutex);
 #define UNSUPPORTED_PERF_EVENT_ID 0xffffffff
 #define C(x) PERF_COUNT_HW_CACHE_##x
 
+/* MIPS PMU names */
+const char *mips_pmu_names[] = {
+	/* mipsxx */
+	[MIPS_PMU_ID_20K]		= "mips/20K",
+	[MIPS_PMU_ID_24K]		= "mips/24K",
+	[MIPS_PMU_ID_25K]		= "mips/25K",
+	[MIPS_PMU_ID_1004K]		= "mips/1004K",
+	[MIPS_PMU_ID_34K]		= "mips/34K",
+	[MIPS_PMU_ID_74K]		= "mips/74K",
+	[MIPS_PMU_ID_5K]		= "mips/5K",
+	[MIPS_PMU_ID_R10000V2]		= "mips/r10000-v2.x",
+	[MIPS_PMU_ID_R10000]		= "mips/r10000",
+	[MIPS_PMU_ID_R12000]		= "mips/r12000",
+	[MIPS_PMU_ID_SB1]		= "mips/sb1",
+	/* rm9000 */
+	[MIPS_PMU_ID_RM9000]		= "mips/rm9000",
+	/* loongson2 */
+	[MIPS_PMU_ID_LOONGSON2]		= "mips/loongson2",
+	/* unsupported */
+	[MIPS_PMU_ID_UNSUPPORTED]	= NULL,
+};
+EXPORT_SYMBOL_GPL(mips_pmu_names);
+
 struct mips_pmu {
-	const char	*name;
+	enum mips_pmu_id id;
 	irqreturn_t	(*handle_irq)(int irq, void *dev);
 	int		(*handle_shared_irq)(void);
 	void		(*start)(void);
@@ -111,6 +134,12 @@ struct mips_pmu {
 
 static const struct mips_pmu *mipspmu;
 
+enum mips_pmu_id mipspmu_get_pmu_id(void)
+{
+	return mipspmu ? mipspmu->id : MIPS_PMU_ID_UNSUPPORTED;
+}
+EXPORT_SYMBOL_GPL(mipspmu_get_pmu_id);
+
 static int
 mipspmu_event_set_period(struct perf_event *event,
 			struct hw_perf_event *hwc,
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 1c92917..4e37a3a 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -962,22 +962,22 @@ init_hw_perf_events(void)
 
 	switch (current_cpu_type()) {
 	case CPU_24K:
-		mipsxxcore_pmu.name = "mips/24K";
+		mipsxxcore_pmu.id = MIPS_PMU_ID_24K;
 		mipsxxcore_pmu.num_counters = counters;
 		mipspmu = &mipsxxcore_pmu;
 		break;
 	case CPU_34K:
-		mipsxxcore_pmu.name = "mips/34K";
+		mipsxxcore_pmu.id = MIPS_PMU_ID_34K;
 		mipsxxcore_pmu.num_counters = counters;
 		mipspmu = &mipsxxcore_pmu;
 		break;
 	case CPU_74K:
-		mipsxx74Kcore_pmu.name = "mips/74K";
+		mipsxx74Kcore_pmu.id = MIPS_PMU_ID_74K;
 		mipsxx74Kcore_pmu.num_counters = counters;
 		mipspmu = &mipsxx74Kcore_pmu;
 		break;
 	case CPU_1004K:
-		mipsxxcore_pmu.name = "mips/1004K";
+		mipsxxcore_pmu.id = MIPS_PMU_ID_1004K;
 		mipsxxcore_pmu.num_counters = counters;
 		mipspmu = &mipsxxcore_pmu;
 		break;
@@ -989,7 +989,9 @@ init_hw_perf_events(void)
 
 	if (mipspmu)
 		pr_cont("%s PMU enabled, %d counters available to each "
-			"CPU\n", mipspmu->name, mipspmu->num_counters);
+			"CPU\n",
+			mips_pmu_names[mipspmu->id],
+			mipspmu->num_counters);
 
 	return 0;
 }
-- 
1.6.3.3
