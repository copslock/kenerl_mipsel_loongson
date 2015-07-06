Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:13:58 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36645 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012173AbbGFLM5SMVde (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:12:57 +0200
Received: by pddu5 with SMTP id u5so16958031pdd.3
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TAPqEtd9pb8n7I28As6EnQ7M2RHLdJRFgr7ZAozGo1Y=;
        b=iNHJIzJk8nE7fgnfWNcdZNxKH5TnQoBD/hiMyYc215OxKaEIFNqrzwjB6jep4PxJCx
         H+cBag6SsbqgPcJsxjURh5TakxiduwE2ySyy+XorKIEd+K1xuI6O4I+EymhPuL9sYsvw
         j7vVhmpLJdVSl7TuxF3LUp1paDvYMadPVZrc3FSRpGyrnChGXhQ2dDR1AyyEXIomUBIF
         jOVZcwtwbdLRDybHv5oDfEwwucQuIZBEcQ80/vK9pvwEuCeI4/QT8vRiR6EWXZy2NunS
         Gqko0w10XVE2i/2O23S/z1S9poXgJzJR72b4DiHvnNZ8QwS82sof6YTcwGek3gNTQr7N
         J53A==
X-Gm-Message-State: ALoCoQlZq2G/aG7qvzAaISSDMpDNc/JKPkt69+mpVJfFVWIcse9Ua+qXUIu0///yA+BSnGOUOFHl
X-Received: by 10.70.20.196 with SMTP id p4mr104646164pde.58.1436181171613;
        Mon, 06 Jul 2015 04:12:51 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id r4sm17943858pap.8.2015.07.06.04.12.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:12:50 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/14] MIPS/cevt-ds1287: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:41:56 +0530
Message-Id: <ab4133a15d3ce040542c3016c28a7d043a27b641.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

Migrate cevt-ds1287 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/kernel/cevt-ds1287.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/cevt-ds1287.c b/arch/mips/kernel/cevt-ds1287.c
index ff1f01b72270..77a5ddf53f57 100644
--- a/arch/mips/kernel/cevt-ds1287.c
+++ b/arch/mips/kernel/cevt-ds1287.c
@@ -59,27 +59,32 @@ static int ds1287_set_next_event(unsigned long delta,
 	return -EINVAL;
 }
 
-static void ds1287_set_mode(enum clock_event_mode mode,
-			    struct clock_event_device *evt)
+static int ds1287_shutdown(struct clock_event_device *evt)
 {
 	u8 val;
 
 	spin_lock(&rtc_lock);
 
 	val = CMOS_READ(RTC_REG_B);
+	val &= ~RTC_PIE;
+	CMOS_WRITE(val, RTC_REG_B);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		val |= RTC_PIE;
-		break;
-	default:
-		val &= ~RTC_PIE;
-		break;
-	}
+	spin_unlock(&rtc_lock);
+	return 0;
+}
 
+static int ds1287_set_periodic(struct clock_event_device *evt)
+{
+	u8 val;
+
+	spin_lock(&rtc_lock);
+
+	val = CMOS_READ(RTC_REG_B);
+	val |= RTC_PIE;
 	CMOS_WRITE(val, RTC_REG_B);
 
 	spin_unlock(&rtc_lock);
+	return 0;
 }
 
 static void ds1287_event_handler(struct clock_event_device *dev)
@@ -87,11 +92,13 @@ static void ds1287_event_handler(struct clock_event_device *dev)
 }
 
 static struct clock_event_device ds1287_clockevent = {
-	.name		= "ds1287",
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
-	.set_next_event = ds1287_set_next_event,
-	.set_mode	= ds1287_set_mode,
-	.event_handler	= ds1287_event_handler,
+	.name			= "ds1287",
+	.features		= CLOCK_EVT_FEAT_PERIODIC,
+	.set_next_event		= ds1287_set_next_event,
+	.set_state_shutdown	= ds1287_shutdown,
+	.set_state_periodic	= ds1287_set_periodic,
+	.tick_resume		= ds1287_shutdown,
+	.event_handler		= ds1287_event_handler,
 };
 
 static irqreturn_t ds1287_interrupt(int irq, void *dev_id)
-- 
2.4.0
