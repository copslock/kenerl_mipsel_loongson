Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:08:32 +0200 (CEST)
Received: from mail-pd0-f202.google.com ([209.85.192.202]:33329 "EHLO
        mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011987AbaJTTEVWGm2H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:21 +0200
Received: by mail-pd0-f202.google.com with SMTP id fp1so953599pdb.5
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jNMiUBogV2aiF4Zs9fM4Qk/jh6/jKi/IuCi/JJI4fKc=;
        b=AyWlHgn/pLviv+6T/OeYbYgAM6h0lnVchEsOvOF9hGAmqWZxSLW086MOBM5XtaaFCH
         CWMJ/0j1wLatu32st/smDTQAcPTy5qN3hZLrt4MhBe8piZ21ho8KEFc4UEFdEdkWw2Qo
         zUv7uW09E3tgZ11Rllz7nk+9ya4+pPkueIq6fpllaZFYbv2VygxTrf1A339B0BrG0juT
         daWcxaz4QqraYzwcQAKLNeZmnhz7ba1AvwFOTtwyNopTW4WZolUQWp8ABqAL5jYp89zh
         N3TkVxieWmgSrjbylF+KxT+woE8TOtFy9a1T3XDUXWI1RmUiXIqSBqdj88hLqHA99Rlg
         w+zQ==
X-Gm-Message-State: ALoCoQlECgMJL9QnFoZdTIRDoQL9ejTn8WKr7R+RaM2yxWrjx62EB6KkHTUFObP6iY8GjoaxCgCg
X-Received: by 10.70.37.200 with SMTP id a8mr19030179pdk.1.1413831854669;
        Mon, 20 Oct 2014 12:04:14 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t28si436278yhb.4.2014.10.20.12.04.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:14 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id SSPIjhGM.4; Mon, 20 Oct 2014 12:04:14 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id B4342220B55; Mon, 20 Oct 2014 12:04:13 -0700 (PDT)
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
Subject: [PATCH 14/19] clocksource: mips-gic: Move gic_frequency to clocksource driver
Date:   Mon, 20 Oct 2014 12:04:01 -0700
Message-Id: <1413831846-32100-15-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43374
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

There's no reason for gic_frequency to be global any more and it
certainly doesn't belong in the GIC irqchip driver, so move it to
the GIC clocksource driver.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/mti-malta/malta-time.c     | 2 ++
 drivers/clocksource/mips-gic-timer.c | 3 +++
 drivers/irqchip/irq-mips-gic.c       | 1 -
 include/linux/irqchip/mips-gic.h     | 1 -
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 028fae0..ce02dbd 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -46,6 +46,8 @@ static int mips_cpu_timer_irq;
 static int mips_cpu_perf_irq;
 extern int cp0_perfcount_irq;
 
+static unsigned int gic_frequency;
+
 static void mips_timer_dispatch(void)
 {
 	do_IRQ(mips_cpu_timer_irq);
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 2603f50..bced17d 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -17,6 +17,7 @@
 
 static DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
 static int gic_timer_irq_installed;
+static unsigned int gic_frequency;
 
 static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
 {
@@ -112,6 +113,8 @@ static struct clocksource gic_clocksource = {
 
 void __init gic_clocksource_init(unsigned int frequency)
 {
+	gic_frequency = frequency;
+
 	/* Set clocksource mask. */
 	gic_clocksource.mask = CLOCKSOURCE_MASK(gic_get_count_width());
 
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 5c856e6..2949a9c 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -18,7 +18,6 @@
 #include <asm/setup.h>
 #include <asm/traps.h>
 
-unsigned int gic_frequency;
 unsigned int gic_present;
 
 struct gic_pcpu_mask {
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 0350eff..420f77b 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -230,7 +230,6 @@
 #define GIC_HWIRQ_TO_SHARED(x)	((x) - GIC_SHARED_HWIRQ_BASE)
 
 extern unsigned int gic_present;
-extern unsigned int gic_frequency;
 
 extern void gic_init(unsigned long gic_base_addr,
 	unsigned long gic_addrspace_size, unsigned int cpu_vec,
-- 
2.1.0.rc2.206.gedb03e5
