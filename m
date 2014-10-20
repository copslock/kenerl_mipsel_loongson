Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:04:34 +0200 (CEST)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:32778 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011956AbaJTTEOvUW00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:14 +0200
Received: by mail-ie0-f202.google.com with SMTP id rd18so827966iec.5
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=quLP4pZT3GEbwfIP9gQS3FwxClBMesm9TMDXWZsv8XM=;
        b=boRZblYuyoPuNONJ3HDHYhcuJOmGCJyT8S97dxn+Xe/p798ULmRrs4qbXl85Q+Gd9P
         acuCqYldI91gRZUDaYsAXbkZjcTj+LKSeey5vxuy9m7Wn8QynXlPVMJYE0FObpsd4N7R
         v66YFzlXUdv9mkpdJuzqSZwzmxAUT88V6Ns2x4Ky4pxZlSbwGC1TDDXW658EmCmJM3aB
         OqmAZdrjVZDreAwQo4GCx2nHKsdQkIARf72rAMqNC3lOnuuTI7KZxjCXONZ9aCjVn2SW
         1UX9t53Q7AzGSq5psPWjwPOSRYsvJW/8EJxDrSbG/W4SlNhk6NAg+kXCX99WJUs3YP5N
         RsTA==
X-Gm-Message-State: ALoCoQkOFj2N0XCczg2tBbW0rpapkrVutcgPSGp8yMwTrMxLQXdetGbbBwQ/rfpkDHvXqm1WYOOc
X-Received: by 10.50.12.7 with SMTP id u7mr13039385igb.5.1413831848529;
        Mon, 20 Oct 2014 12:04:08 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si437275yhe.3.2014.10.20.12.04.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:08 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id kDwmhpfE.1; Mon, 20 Oct 2014 12:04:08 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 648C9220B55; Mon, 20 Oct 2014 12:04:07 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/19] MIPS: Malta: Use gic_read_count() to read GIC timer
Date:   Mon, 20 Oct 2014 12:03:48 -0700
Message-Id: <1413831846-32100-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Instead of reading the GIC registers directly, use the interface the GIC
driver already exposes for reading the global timer.  Also get rid of
the unnecessary #ifdefs.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/mti-malta/malta-time.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index f6ca8ea..39f3902 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -70,9 +70,7 @@ static void __init estimate_frequencies(void)
 {
 	unsigned long flags;
 	unsigned int count, start;
-#ifdef CONFIG_MIPS_GIC
-	unsigned int giccount = 0, gicstart = 0;
-#endif
+	cycle_t giccount = 0, gicstart = 0;
 
 #if defined(CONFIG_KVM_GUEST) && CONFIG_KVM_GUEST_TIMER_FREQ
 	mips_hpt_frequency = CONFIG_KVM_GUEST_TIMER_FREQ * 1000000;
@@ -87,32 +85,26 @@ static void __init estimate_frequencies(void)
 
 	/* Initialize counters. */
 	start = read_c0_count();
-#ifdef CONFIG_MIPS_GIC
 	if (gic_present)
-		GICREAD(GIC_REG(SHARED, GIC_SH_COUNTER_31_00), gicstart);
-#endif
+		gicstart = gic_read_count();
 
 	/* Read counter exactly on falling edge of update flag. */
 	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
 	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
 
 	count = read_c0_count();
-#ifdef CONFIG_MIPS_GIC
 	if (gic_present)
-		GICREAD(GIC_REG(SHARED, GIC_SH_COUNTER_31_00), giccount);
-#endif
+		giccount = gic_read_count();
 
 	local_irq_restore(flags);
 
 	count -= start;
 	mips_hpt_frequency = count;
 
-#ifdef CONFIG_MIPS_GIC
 	if (gic_present) {
 		giccount -= gicstart;
 		gic_frequency = giccount;
 	}
-#endif
 }
 
 void read_persistent_clock(struct timespec *ts)
-- 
2.1.0.rc2.206.gedb03e5
