Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:15:09 +0200 (CEST)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34796 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012809AbbGFLNPnG4Te (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:13:15 +0200
Received: by pdbep18 with SMTP id ep18so104421471pdb.1
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MpwKelmKm4Ak1mlep8P5kYge7gG3Xc+axBI57W56bPQ=;
        b=GBhF+VhF+nmYvwcnShgwYRVO8BHeW+A2/oDx6NiL5yM7OTHcJkFyzhLfuE0Jf7EJiI
         dPYL3d0kcNoMLZwsRtQi5GCOzeOQoYRmp7peENOX2l/NXN98GV5YH14VzLABJyhujnB9
         3iS+JRGBJoKSqaYCYIunaglH0+p0LCi8TU1QIuo9NsCkZEVACOrSRBC0ZAqSpbWd6oDj
         pNCpk8C307/zEL9C+a9fDpBizfkFaos3qxH5UopgnkOLgsMfDzKlcbjeHZOFuxHck1EC
         d2vVsAHe77ayHzt1mI/DJR/Wz2Y+b2PTSEhKqGgTlN0V2E+RFhKEvbtq+Mu040pXTDf8
         JihA==
X-Gm-Message-State: ALoCoQlnHK2HBHGE7p3Fl4EqsC9bey/Hgoj1pWg05ilsA+mVowGwBujWPx2Eo3KT4QpFePACiPZg
X-Received: by 10.68.239.70 with SMTP id vq6mr104245840pbc.157.1436181190000;
        Mon, 06 Jul 2015 04:13:10 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id i10sm17894378pdr.78.2015.07.06.04.13.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:13:09 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH 09/14] MIPS/cevt-txx9: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:42:00 +0530
Message-Id: <210da0e9fcbe1fd76e7d1613605250fea2a592ef.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48074
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

Migrate cevt-txx9 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/kernel/cevt-txx9.c | 81 ++++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/arch/mips/kernel/cevt-txx9.c b/arch/mips/kernel/cevt-txx9.c
index 723932441ecc..537eefdf838f 100644
--- a/arch/mips/kernel/cevt-txx9.c
+++ b/arch/mips/kernel/cevt-txx9.c
@@ -85,36 +85,54 @@ static void txx9tmr_stop_and_clear(struct txx9_tmr_reg __iomem *tmrptr)
 	__raw_writel(0, &tmrptr->tisr);
 }
 
-static void txx9tmr_set_mode(enum clock_event_mode mode,
-			     struct clock_event_device *evt)
+static int txx9tmr_set_state_periodic(struct clock_event_device *evt)
 {
 	struct txx9_clock_event_device *txx9_cd =
 		container_of(evt, struct txx9_clock_event_device, cd);
 	struct txx9_tmr_reg __iomem *tmrptr = txx9_cd->tmrptr;
 
 	txx9tmr_stop_and_clear(tmrptr);
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		__raw_writel(TXx9_TMITMR_TIIE | TXx9_TMITMR_TZCE,
-			     &tmrptr->itmr);
-		/* start timer */
-		__raw_writel(((u64)(NSEC_PER_SEC / HZ) * evt->mult) >>
-			     evt->shift,
-			     &tmrptr->cpra);
-		__raw_writel(TCR_BASE | TXx9_TMTCR_TCE, &tmrptr->tcr);
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-		__raw_writel(0, &tmrptr->itmr);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		__raw_writel(TXx9_TMITMR_TIIE, &tmrptr->itmr);
-		break;
-	case CLOCK_EVT_MODE_RESUME:
-		__raw_writel(TIMER_CCD, &tmrptr->ccdr);
-		__raw_writel(0, &tmrptr->itmr);
-		break;
-	}
+
+	__raw_writel(TXx9_TMITMR_TIIE | TXx9_TMITMR_TZCE, &tmrptr->itmr);
+	/* start timer */
+	__raw_writel(((u64)(NSEC_PER_SEC / HZ) * evt->mult) >> evt->shift,
+		     &tmrptr->cpra);
+	__raw_writel(TCR_BASE | TXx9_TMTCR_TCE, &tmrptr->tcr);
+	return 0;
+}
+
+static int txx9tmr_set_state_oneshot(struct clock_event_device *evt)
+{
+	struct txx9_clock_event_device *txx9_cd =
+		container_of(evt, struct txx9_clock_event_device, cd);
+	struct txx9_tmr_reg __iomem *tmrptr = txx9_cd->tmrptr;
+
+	txx9tmr_stop_and_clear(tmrptr);
+	__raw_writel(TXx9_TMITMR_TIIE, &tmrptr->itmr);
+	return 0;
+}
+
+static int txx9tmr_set_state_shutdown(struct clock_event_device *evt)
+{
+	struct txx9_clock_event_device *txx9_cd =
+		container_of(evt, struct txx9_clock_event_device, cd);
+	struct txx9_tmr_reg __iomem *tmrptr = txx9_cd->tmrptr;
+
+	txx9tmr_stop_and_clear(tmrptr);
+	__raw_writel(0, &tmrptr->itmr);
+	return 0;
+}
+
+static int txx9tmr_tick_resume(struct clock_event_device *evt)
+{
+	struct txx9_clock_event_device *txx9_cd =
+		container_of(evt, struct txx9_clock_event_device, cd);
+	struct txx9_tmr_reg __iomem *tmrptr = txx9_cd->tmrptr;
+
+	txx9tmr_stop_and_clear(tmrptr);
+	__raw_writel(TIMER_CCD, &tmrptr->ccdr);
+	__raw_writel(0, &tmrptr->itmr);
+	return 0;
 }
 
 static int txx9tmr_set_next_event(unsigned long delta,
@@ -133,12 +151,15 @@ static int txx9tmr_set_next_event(unsigned long delta,
 
 static struct txx9_clock_event_device txx9_clock_event_device = {
 	.cd = {
-		.name		= "TXx9",
-		.features	= CLOCK_EVT_FEAT_PERIODIC |
-				  CLOCK_EVT_FEAT_ONESHOT,
-		.rating		= 200,
-		.set_mode	= txx9tmr_set_mode,
-		.set_next_event = txx9tmr_set_next_event,
+		.name			= "TXx9",
+		.features		= CLOCK_EVT_FEAT_PERIODIC |
+					  CLOCK_EVT_FEAT_ONESHOT,
+		.rating			= 200,
+		.set_state_shutdown	= txx9tmr_set_state_shutdown,
+		.set_state_periodic	= txx9tmr_set_state_periodic,
+		.set_state_oneshot	= txx9tmr_set_state_oneshot,
+		.tick_resume		= txx9tmr_tick_resume,
+		.set_next_event		= txx9tmr_set_next_event,
 	},
 };
 
-- 
2.4.0
