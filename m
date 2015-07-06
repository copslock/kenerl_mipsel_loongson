Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:16:43 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34023 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008589AbbGFLNkZ8Pve (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:13:40 +0200
Received: by pdbep18 with SMTP id ep18so104427029pdb.1
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xbpc74CDtRdjYaByjd/awMRCw42tqKhVLktRYasHfx8=;
        b=lGEKADP5Z6fSswPhWMTAUBXpgrAaWxcTDqzSMLykGrpLxnaYME738jLgeagxGCuPsZ
         MgbOJmxV7sCsqIkjLZ2DR5XRQ3DGTfJNfhl5A9YTPtO1zVy6UPmEX6VuCnfOGNUY9ywS
         wUFRFotFxykru+6ZLtfcC/CAR5CymXbMolBPSXPErXUX6yEo1jXpH8Z0JjdaRyoazfSX
         fUTZFhfF4PrMD1JnfNAaFt4Y2R/dCh21UJElEukLjLhRxF1FRa9A2f7qbIhrWKoWM2s1
         2l6SGucOrkiIivRdJtz9Okw3ASO5C47RZCwTXyFqPx88PZEYFuRxRjQHE9q2VUyIXZL+
         W1eA==
X-Gm-Message-State: ALoCoQnT9m63L+yheR/BfUBtxKhZrS0OeNVGNRaVvc5OI/PX3mjDX9JEsNIE5GG00UZBi4oQkURL
X-Received: by 10.68.135.73 with SMTP id pq9mr104372543pbb.46.1436181214770;
        Mon, 06 Jul 2015 04:13:34 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id pc9sm17920319pdb.6.2015.07.06.04.13.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:13:33 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 14/14] MIPS/sni/time: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:42:05 +0530
Message-Id: <85a280fa4e403529fb597e7dffd31aaabfe5c613.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48079
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

Migrate sni driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/sni/time.c | 49 +++++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index cf8ec568b9df..fb4b3520cdc6 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -14,44 +14,33 @@
 #define SNI_COUNTER2_DIV	64
 #define SNI_COUNTER0_DIV	((SNI_CLOCK_TICK_RATE / SNI_COUNTER2_DIV) / HZ)
 
-static void a20r_set_mode(enum clock_event_mode mode,
-			  struct clock_event_device *evt)
+static int a20r_set_periodic(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		*(volatile u8 *)(A20R_PT_CLOCK_BASE + 12) = 0x34;
-		wmb();
-		*(volatile u8 *)(A20R_PT_CLOCK_BASE +  0) = SNI_COUNTER0_DIV;
-		wmb();
-		*(volatile u8 *)(A20R_PT_CLOCK_BASE +  0) = SNI_COUNTER0_DIV >> 8;
-		wmb();
-
-		*(volatile u8 *)(A20R_PT_CLOCK_BASE + 12) = 0xb4;
-		wmb();
-		*(volatile u8 *)(A20R_PT_CLOCK_BASE +  8) = SNI_COUNTER2_DIV;
-		wmb();
-		*(volatile u8 *)(A20R_PT_CLOCK_BASE +  8) = SNI_COUNTER2_DIV >> 8;
-		wmb();
+	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 12) = 0x34;
+	wmb();
+	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 0) = SNI_COUNTER0_DIV;
+	wmb();
+	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 0) = SNI_COUNTER0_DIV >> 8;
+	wmb();
 
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		break;
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 12) = 0xb4;
+	wmb();
+	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 8) = SNI_COUNTER2_DIV;
+	wmb();
+	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 8) = SNI_COUNTER2_DIV >> 8;
+	wmb();
+	return 0;
 }
 
 static struct clock_event_device a20r_clockevent_device = {
-	.name		= "a20r-timer",
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.name			= "a20r-timer",
+	.features		= CLOCK_EVT_FEAT_PERIODIC,
 
 	/* .mult, .shift, .max_delta_ns and .min_delta_ns left uninitialized */
 
-	.rating		= 300,
-	.irq		= SNI_A20R_IRQ_TIMER,
-	.set_mode	= a20r_set_mode,
+	.rating			= 300,
+	.irq			= SNI_A20R_IRQ_TIMER,
+	.set_state_periodic	= a20r_set_periodic,
 };
 
 static irqreturn_t a20r_interrupt(int irq, void *dev_id)
-- 
2.4.0
