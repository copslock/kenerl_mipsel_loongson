Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 15:08:43 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:46056 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492362Ab0E0NFm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 15:05:42 +0200
Received: by pxi1 with SMTP id 1so3253521pxi.36
        for <multiple recipients>; Thu, 27 May 2010 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mCABq/PBc5QX52oKxPTUlB7RtNxe2RhcUMZHjBnTJ3U=;
        b=bN0BzjnmOVfvsXl/PZznnWLxN5kmpmVsJZSgXjxXRHoNmUGq54Ge29CdrYm1y/kY20
         QfuGCCKUtS/+UIfpuivZl/8C6zyfV6YgKrwUyIDkcdKXmNd+9bE4GrKxSmTRyV1OmLsc
         CC8m+d0M2G5ItdSefK64zmtfhGQfsP0NEAsRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MQTanARj3mMN3+1XNjPALIAUDv0S72BMgvn1N19oS+npnZl5sGHLeiYY+aJx1cnKgQ
         gR2cuoA6Yu/L0wo2VyNYGXjowoIbmVjn02Y/Gjy4iTMAB8b3ZF4TEer28oQ7m0vHHgNy
         23+1j8QRTO5Af+lSISnHisxDZJtl068ijY1po=
Received: by 10.142.6.37 with SMTP id 37mr1100874wff.129.1274965534903;
        Thu, 27 May 2010 06:05:34 -0700 (PDT)
Received: from localhost.localdomain ([114.84.70.124])
        by mx.google.com with ESMTPS id 21sm972927pzk.8.2010.05.27.06.05.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 06:05:34 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 10/12] MIPS/Perf-events: allow modules to get pmu number of counters
Date:   Thu, 27 May 2010 21:03:38 +0800
Message-Id: <1274965420-5091-11-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26879
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
 arch/mips/kernel/perf_event.c |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

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
index f05e2b1..dc3a553 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -140,6 +140,12 @@ enum mips_pmu_id mipspmu_get_pmu_id(void)
 }
 EXPORT_SYMBOL_GPL(mipspmu_get_pmu_id);
 
+int mipspmu_get_max_events(void)
+{
+	return mipspmu ? mipspmu->num_counters : 0;
+}
+EXPORT_SYMBOL_GPL(mipspmu_get_max_events);
+
 static int
 mipspmu_event_set_period(struct perf_event *event,
 			struct hw_perf_event *hwc,
-- 
1.6.3.3
