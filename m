Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2010 17:40:37 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:52735 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491984Ab0EOPij (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 May 2010 17:38:39 +0200
Received: by mail-pw0-f49.google.com with SMTP id 3so708651pwi.36
        for <multiple recipients>; Sat, 15 May 2010 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6eG9XzsTH5bBH3ry1aK7V8cCWV45lzJC5vOj13WlBYw=;
        b=LHF/bMl1K7lbN0AY3ksXXchp9PRQnksG0t3ntYcDrHgWlso+U1GHFxUMFrAttoXmCn
         l6zsminc/BW81chKFWyE3cZSH+Gdw4oejR7JqQvoWEuR1/R6j/dRQTJ12ezT6vpOShPz
         pQeCqF4SXCkRPOQ6hJusUWFoq3c8PrqM9R3JM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i6t9x2aVbqhXK7SxkBxc5XbLUpRRqEKZmb0/38o8mTFX4S/lfPsGVaREhyJxSRdiBO
         P+HzMRLy1b80vnTuTaa8GTMag5+gQKDf3nbgRYOiMPjygEUNH+41AACq3sGNqQcsaqxb
         xOBKs2YtrdGBB1oIx8CenVzNs5VBmEElyXdmQ=
Received: by 10.114.19.19 with SMTP id 19mr2385706was.17.1273937918545;
        Sat, 15 May 2010 08:38:38 -0700 (PDT)
Received: from localhost.localdomain ([114.84.90.117])
        by mx.google.com with ESMTPS id n32sm30648683wae.10.2010.05.15.08.38.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 08:38:37 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v4 7/9] MIPS/perf-events: allow modules to get pmu number of counters
Date:   Sat, 15 May 2010 23:36:53 +0800
Message-Id: <1273937815-4781-8-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Oprofile module needs a function to get the number of pmu counters in its
high level interfaces.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/include/asm/pmu.h   |    1 +
 arch/mips/kernel/perf_event.c |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
index 16d4fcd..023a915 100644
--- a/arch/mips/include/asm/pmu.h
+++ b/arch/mips/include/asm/pmu.h
@@ -114,5 +114,6 @@ enum mips_pmu_id {
 extern const char *mips_pmu_names[];
 
 extern enum mips_pmu_id mipspmu_get_pmu_id(void);
+extern int mipspmu_get_max_events(void);
 
 #endif /* __MIPS_PMU_H__ */
diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 67d301d..6f95220 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -145,6 +145,17 @@ enum mips_pmu_id mipspmu_get_pmu_id(void)
 }
 EXPORT_SYMBOL_GPL(mipspmu_get_pmu_id);
 
+int mipspmu_get_max_events(void)
+{
+	int max_events = 0;
+
+	if (mipspmu)
+		max_events = mipspmu->num_counters;
+
+	return max_events;
+}
+EXPORT_SYMBOL_GPL(mipspmu_get_max_events);
+
 static int
 mipspmu_event_set_period(struct perf_event *event,
 			struct hw_perf_event *hwc,
-- 
1.6.3.3
