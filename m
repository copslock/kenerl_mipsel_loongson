Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2017 21:47:49 +0200 (CEST)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:36601
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992881AbdC3Trkg-KuC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2017 21:47:40 +0200
Received: by mail-wr0-x243.google.com with SMTP id k6so13679830wre.3;
        Thu, 30 Mar 2017 12:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rki3yzvNk/v45SHbAkSnKkrAoc/R7iQG62rRGifhjW4=;
        b=KoJh+FPyl2zG3opopCJ69X7X0M3nReOXZKKEMoWVbDDp0KsuOhcd4ubaNi+uK6BcJb
         TOEHx+Gs/OY0aehSwDFuk581ga0ETgplHS/H7Urt5A6dDCvJZfLWxSBo75x57piGaHnG
         Yf6/h94BYBOT7yhr/6m7r2mT2fLIMepKWIGvS+wbjmIJoatKJrhne9n1deCpD3fKy8jf
         K2L+nnGKSoCy+pab2zoR7K7Vah3rpq+c3kgUVwGWt7fH4MRWzMXO6u/yVsm5PoPcTqvu
         x3kq/uRB5+2DLFvA9MJyX5ogf6cBVpc8/C7C1AEVJQKaNy1V0z3OlmqVdZlHxcAtyLvY
         3F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rki3yzvNk/v45SHbAkSnKkrAoc/R7iQG62rRGifhjW4=;
        b=GXud1Nh+SqwGTwG5MW80BFCWphgeQnyuITb+gGplFvrbpfYqz+NFzx6cWpA4JjSzJ1
         yvrhSOIyICZ6z/dXl5KQONzZtGXOOCG0mwC1DTVSkN0iyap9p7YAyEFrOAqK6gpHg/Mi
         JK2yo8ftMhzlkAbfg+xKgBYMQZx4BDuVqwavpNrNira6vhPcY0QSWe5LMaidxDUFeGo+
         sYvnLWiUbERJmesoCxUuS6D/F52vx+RJPBj1MVdTOThHFAkThAMTOGkwIHiKI80yGMdM
         BWsYFI+CfUVK8Gr51TMWr9tPOn5r25oU/7CEHKq7tFZT7KWWkhRWHmTAwidw2eQO3J9D
         K24A==
X-Gm-Message-State: AFeK/H3AfnZODUxpGAVR4x0YOQ+XGEDpx2ZuA+tIf5BDbJkYnveMSw8t+NQA8xdgBhnB+g==
X-Received: by 10.28.68.69 with SMTP id r66mr4868725wma.115.1490903255150;
        Thu, 30 Mar 2017 12:47:35 -0700 (PDT)
Received: from localhost (x4e32a5fb.dyn.telefonica.de. [78.50.165.251])
        by smtp.gmail.com with ESMTPSA id y22sm3924009wry.51.2017.03.30.12.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Mar 2017 12:47:34 -0700 (PDT)
From:   Nicolai Stange <nicstange@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        John Crispin <john@phrozen.org>
Cc:     John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        Nicolai Stange <nicstange@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        James Hogan <james.hogan@imgtec.com>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: clockevent drivers: set ->min_delta_ticks and ->max_delta_ticks
Date:   Thu, 30 Mar 2017 21:47:32 +0200
Message-Id: <20170330194732.7126-1-nicstange@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170326134403.16226-1-nicstange@gmail.com>
References: <20170326134403.16226-1-nicstange@gmail.com>
Return-Path: <nicstange@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicstange@gmail.com
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

In preparation for making the clockevents core NTP correction aware,
all clockevent device drivers must set ->min_delta_ticks and
->max_delta_ticks rather than ->min_delta_ns and ->max_delta_ns: a
clockevent device's rate is going to change dynamically and thus, the
ratio of ns to ticks ceases to stay invariant.

Make the MIPS arch's clockevent drivers initialize these fields properly.

This patch alone doesn't introduce any change in functionality as the
clockevents core still looks exclusively at the (untouched) ->min_delta_ns
and ->max_delta_ns. As soon as this has changed, a followup patch will
purge the initialization of ->min_delta_ns and ->max_delta_ns from these
drivers.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---

Notes:
    This prerequisite patch is part of a larger effort to feed NTP
    corrections into the clockevent devices' frequencies and thus
    avoiding their notion of time to diverge from the system's
    one. If you're interested, the current state of the whole series
    can be found at [1].
    
    If you haven't got any objections and these prerequisites get
    merged by 4.12 everywhere, I'll proceed with the remainder of
    this series in 4.13.
    
    Applicable to next-20170324 as well as to John' Stultz tree [2].
    
    [1]
      git://nicst.de/linux.git cev-freq-adj.v10.fortglx-4.12-time
      https://nicst.de/git/?p=linux.git;a=shortlog;h=refs/heads/cev-freq-adj.v10.fortglx-4.12-time
    
    [2]
      https://git.linaro.org/people/john.stultz/linux.git fortglx/4.12/time

 arch/mips/alchemy/common/time.c                   | 4 +++-
 arch/mips/jz4740/time.c                           | 2 ++
 arch/mips/kernel/cevt-bcm1480.c                   | 2 ++
 arch/mips/kernel/cevt-ds1287.c                    | 2 ++
 arch/mips/kernel/cevt-gt641xx.c                   | 2 ++
 arch/mips/kernel/cevt-sb1250.c                    | 2 ++
 arch/mips/kernel/cevt-txx9.c                      | 2 ++
 arch/mips/loongson32/common/time.c                | 2 ++
 arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c | 2 ++
 arch/mips/loongson64/loongson-3/hpet.c            | 2 ++
 arch/mips/ralink/cevt-rt3352.c                    | 2 ++
 arch/mips/sgi-ip27/ip27-timer.c                   | 2 ++
 12 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index e1bec5a77c39..32d1333bb243 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -138,7 +138,9 @@ static int __init alchemy_time_init(unsigned int m2int)
 	cd->shift = 32;
 	cd->mult = div_sc(32768, NSEC_PER_SEC, cd->shift);
 	cd->max_delta_ns = clockevent_delta2ns(0xffffffff, cd);
-	cd->min_delta_ns = clockevent_delta2ns(9, cd);	/* ~0.28ms */
+	cd->max_delta_ticks = 0xffffffff;
+	cd->min_delta_ns = clockevent_delta2ns(9, cd);
+	cd->min_delta_ticks = 9;	/* ~0.28ms */
 	clockevents_register_device(cd);
 	setup_irq(m2int, &au1x_rtcmatch2_irqaction);
 
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index bcf8f8c62737..bb1ad5119da4 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -145,7 +145,9 @@ void __init plat_time_init(void)
 
 	clockevent_set_clock(&jz4740_clockevent, clk_rate);
 	jz4740_clockevent.min_delta_ns = clockevent_delta2ns(100, &jz4740_clockevent);
+	jz4740_clockevent.min_delta_ticks = 100;
 	jz4740_clockevent.max_delta_ns = clockevent_delta2ns(0xffff, &jz4740_clockevent);
+	jz4740_clockevent.max_delta_ticks = 0xffff;
 	jz4740_clockevent.cpumask = cpumask_of(0);
 
 	clockevents_register_device(&jz4740_clockevent);
diff --git a/arch/mips/kernel/cevt-bcm1480.c b/arch/mips/kernel/cevt-bcm1480.c
index 940ac00e9129..8f9f2daf06a3 100644
--- a/arch/mips/kernel/cevt-bcm1480.c
+++ b/arch/mips/kernel/cevt-bcm1480.c
@@ -123,7 +123,9 @@ void sb1480_clockevent_init(void)
 				  CLOCK_EVT_FEAT_ONESHOT;
 	clockevent_set_clock(cd, V_SCD_TIMER_FREQ);
 	cd->max_delta_ns	= clockevent_delta2ns(0x7fffff, cd);
+	cd->max_delta_ticks	= 0x7fffff;
 	cd->min_delta_ns	= clockevent_delta2ns(2, cd);
+	cd->min_delta_ticks	= 2;
 	cd->rating		= 200;
 	cd->irq			= irq;
 	cd->cpumask		= cpumask_of(cpu);
diff --git a/arch/mips/kernel/cevt-ds1287.c b/arch/mips/kernel/cevt-ds1287.c
index 77a5ddf53f57..61ad9079fa16 100644
--- a/arch/mips/kernel/cevt-ds1287.c
+++ b/arch/mips/kernel/cevt-ds1287.c
@@ -128,7 +128,9 @@ int __init ds1287_clockevent_init(int irq)
 	cd->irq = irq;
 	clockevent_set_clock(cd, 32768);
 	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
+	cd->max_delta_ticks = 0x7fffffff;
 	cd->min_delta_ns = clockevent_delta2ns(0x300, cd);
+	cd->min_delta_ticks = 0x300;
 	cd->cpumask = cpumask_of(0);
 
 	clockevents_register_device(&ds1287_clockevent);
diff --git a/arch/mips/kernel/cevt-gt641xx.c b/arch/mips/kernel/cevt-gt641xx.c
index 66040051151d..fd90c82dc17d 100644
--- a/arch/mips/kernel/cevt-gt641xx.c
+++ b/arch/mips/kernel/cevt-gt641xx.c
@@ -152,7 +152,9 @@ static int __init gt641xx_timer0_clockevent_init(void)
 	cd->rating = 200 + gt641xx_base_clock / 10000000;
 	clockevent_set_clock(cd, gt641xx_base_clock);
 	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
+	cd->max_delta_ticks = 0x7fffffff;
 	cd->min_delta_ns = clockevent_delta2ns(0x300, cd);
+	cd->min_delta_ticks = 0x300;
 	cd->cpumask = cpumask_of(0);
 
 	clockevents_register_device(&gt641xx_timer0_clockevent);
diff --git a/arch/mips/kernel/cevt-sb1250.c b/arch/mips/kernel/cevt-sb1250.c
index 3d860efd63b9..9d1edb5938b8 100644
--- a/arch/mips/kernel/cevt-sb1250.c
+++ b/arch/mips/kernel/cevt-sb1250.c
@@ -123,7 +123,9 @@ void sb1250_clockevent_init(void)
 				  CLOCK_EVT_FEAT_ONESHOT;
 	clockevent_set_clock(cd, V_SCD_TIMER_FREQ);
 	cd->max_delta_ns	= clockevent_delta2ns(0x7fffff, cd);
+	cd->max_delta_ticks	= 0x7fffff;
 	cd->min_delta_ns	= clockevent_delta2ns(2, cd);
+	cd->min_delta_ticks	= 2;
 	cd->rating		= 200;
 	cd->irq			= irq;
 	cd->cpumask		= cpumask_of(cpu);
diff --git a/arch/mips/kernel/cevt-txx9.c b/arch/mips/kernel/cevt-txx9.c
index aaca60d6ffc3..7b17c8f5009d 100644
--- a/arch/mips/kernel/cevt-txx9.c
+++ b/arch/mips/kernel/cevt-txx9.c
@@ -196,7 +196,9 @@ void __init txx9_clockevent_init(unsigned long baseaddr, int irq,
 	clockevent_set_clock(cd, TIMER_CLK(imbusclk));
 	cd->max_delta_ns =
 		clockevent_delta2ns(0xffffffff >> (32 - TXX9_TIMER_BITS), cd);
+	cd->max_delta_ticks = 0xffffffff >> (32 - TXX9_TIMER_BITS);
 	cd->min_delta_ns = clockevent_delta2ns(0xf, cd);
+	cd->min_delta_ticks = 0xf;
 	cd->irq = irq;
 	cd->cpumask = cpumask_of(0),
 	clockevents_register_device(cd);
diff --git a/arch/mips/loongson32/common/time.c b/arch/mips/loongson32/common/time.c
index e6f972d35252..1c4332a26cf1 100644
--- a/arch/mips/loongson32/common/time.c
+++ b/arch/mips/loongson32/common/time.c
@@ -199,7 +199,9 @@ static void __init ls1x_time_init(void)
 
 	clockevent_set_clock(cd, mips_hpt_frequency);
 	cd->max_delta_ns = clockevent_delta2ns(0xffffff, cd);
+	cd->max_delta_ticks = 0xffffff;
 	cd->min_delta_ns = clockevent_delta2ns(0x000300, cd);
+	cd->min_delta_ticks = 0x000300;
 	cd->cpumask = cpumask_of(smp_processor_id());
 	clockevents_register_device(cd);
 
diff --git a/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c b/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
index b817d6d3a060..a6adcc4f8960 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
@@ -123,7 +123,9 @@ void __init setup_mfgpt0_timer(void)
 	cd->cpumask = cpumask_of(cpu);
 	clockevent_set_clock(cd, MFGPT_TICK_RATE);
 	cd->max_delta_ns = clockevent_delta2ns(0xffff, cd);
+	cd->max_delta_ticks = 0xffff;
 	cd->min_delta_ns = clockevent_delta2ns(0xf, cd);
+	cd->min_delta_ticks = 0xf;
 
 	/* Enable MFGPT0 Comparator 2 Output to the Interrupt Mapper */
 	_wrmsr(DIVIL_MSR_REG(MFGPT_IRQ), 0, 0x100);
diff --git a/arch/mips/loongson64/loongson-3/hpet.c b/arch/mips/loongson64/loongson-3/hpet.c
index 24afe364637b..4df9d4b7356a 100644
--- a/arch/mips/loongson64/loongson-3/hpet.c
+++ b/arch/mips/loongson64/loongson-3/hpet.c
@@ -241,7 +241,9 @@ void __init setup_hpet_timer(void)
 	cd->cpumask = cpumask_of(cpu);
 	clockevent_set_clock(cd, HPET_FREQ);
 	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
+	cd->max_delta_ticks = 0x7fffffff;
 	cd->min_delta_ns = clockevent_delta2ns(HPET_MIN_PROG_DELTA, cd);
+	cd->min_delta_ticks = HPET_MIN_PROG_DELTA;
 
 	clockevents_register_device(cd);
 	setup_irq(HPET_T0_IRQ, &hpet_irq);
diff --git a/arch/mips/ralink/cevt-rt3352.c b/arch/mips/ralink/cevt-rt3352.c
index f24eee04e16a..b8a1376165b0 100644
--- a/arch/mips/ralink/cevt-rt3352.c
+++ b/arch/mips/ralink/cevt-rt3352.c
@@ -129,7 +129,9 @@ static int __init ralink_systick_init(struct device_node *np)
 	systick.dev.name = np->name;
 	clockevents_calc_mult_shift(&systick.dev, SYSTICK_FREQ, 60);
 	systick.dev.max_delta_ns = clockevent_delta2ns(0x7fff, &systick.dev);
+	systick.dev.max_delta_ticks = 0x7fff;
 	systick.dev.min_delta_ns = clockevent_delta2ns(0x3, &systick.dev);
+	systick.dev.min_delta_ticks = 0x3;
 	systick.dev.irq = irq_of_parse_and_map(np, 0);
 	if (!systick.dev.irq) {
 		pr_err("%s: request_irq failed", np->name);
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 695c51bdd7dc..a53f0c8c901e 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -113,7 +113,9 @@ void hub_rt_clock_event_init(void)
 	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
 	clockevent_set_clock(cd, CYCLES_PER_SEC);
 	cd->max_delta_ns	= clockevent_delta2ns(0xfffffffffffff, cd);
+	cd->max_delta_ticks	= 0xfffffffffffff;
 	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
+	cd->min_delta_ticks	= 0x300;
 	cd->rating		= 200;
 	cd->irq			= irq;
 	cd->cpumask		= cpumask_of(cpu);
-- 
2.12.0
