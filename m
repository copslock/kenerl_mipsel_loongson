Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2008 23:47:14 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:31147 "EHLO elvis.franken.de")
	by lappi.linux-mips.net with ESMTP id S537508AbYDHVrK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2008 23:47:10 +0200
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JjLbj-0000LK-01; Tue, 08 Apr 2008 23:43:59 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 17E39C2C04; Tue,  8 Apr 2008 23:43:57 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP27: Fix clockevent setup
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080408214357.17E39C2C04@solo.franken.de>
Date:	Tue,  8 Apr 2008 23:43:57 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Fix breakage introduced by converting hub_rt to clockevent.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sgi-ip27/ip27-smp.c   |    5 ++++-
 arch/mips/sgi-ip27/ip27-timer.c |   27 +++++++++++++--------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
index f15fc93..ba5cdeb 100644
--- a/arch/mips/sgi-ip27/ip27-smp.c
+++ b/arch/mips/sgi-ip27/ip27-smp.c
@@ -176,11 +176,14 @@ static void ip27_send_ipi_mask(cpumask_t mask, unsigned int action)
 static void __cpuinit ip27_init_secondary(void)
 {
 	per_cpu_init();
-	local_irq_enable();
 }
 
 static void __cpuinit ip27_smp_finish(void)
 {
+	extern void hub_rt_clock_event_init(void);
+
+	hub_rt_clock_event_init();
+	local_irq_enable();
 }
 
 static void __init ip27_cpus_done(void)
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 25d3baf..ffde7e1 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -160,10 +160,13 @@ static void rt_set_mode(enum clock_event_mode mode,
 
 unsigned int rt_timer_irq;
 
+static DEFINE_PER_CPU(struct clock_event_device, hub_rt_clockevent);
+static DEFINE_PER_CPU(char [11], hub_rt_name);
+
 static irqreturn_t hub_rt_counter_handler(int irq, void *dev_id)
 {
-	struct clock_event_device *cd = dev_id;
 	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *cd = &per_cpu(hub_rt_clockevent, cpu);
 	int slice = cputoslice(cpu);
 
 	/*
@@ -192,10 +195,7 @@ struct irqaction hub_rt_irqaction = {
 #define NSEC_PER_CYCLE		800
 #define CYCLES_PER_SEC		(NSEC_PER_SEC / NSEC_PER_CYCLE)
 
-static DEFINE_PER_CPU(struct clock_event_device, hub_rt_clockevent);
-static DEFINE_PER_CPU(char [11], hub_rt_name);
-
-static void __cpuinit hub_rt_clock_event_init(void)
+void __cpuinit hub_rt_clock_event_init(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *cd = &per_cpu(hub_rt_clockevent, cpu);
@@ -203,17 +203,16 @@ static void __cpuinit hub_rt_clock_event_init(void)
 	int irq = rt_timer_irq;
 
 	sprintf(name, "hub-rt %d", cpu);
-	cd->name		= "HUB-RT",
-	cd->features		= CLOCK_EVT_FEAT_ONESHOT,
+	cd->name		= name;
+	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
 	clockevent_set_clock(cd, CYCLES_PER_SEC);
 	cd->max_delta_ns        = clockevent_delta2ns(0xfffffffffffff, cd);
 	cd->min_delta_ns        = clockevent_delta2ns(0x300, cd);
-	cd->rating		= 200,
-	cd->irq			= irq,
-	cd->cpumask		= cpumask_of_cpu(cpu),
-	cd->rating		= 300,
-	cd->set_next_event	= rt_next_event,
-	cd->set_mode		= rt_set_mode,
+	cd->rating		= 200;
+	cd->irq			= irq;
+	cd->cpumask		= cpumask_of_cpu(cpu);
+	cd->set_next_event	= rt_next_event;
+	cd->set_mode		= rt_set_mode;
 	clockevents_register_device(cd);
 }
 
@@ -261,6 +260,7 @@ void __init plat_time_init(void)
 {
 	hub_rt_clocksource_init();
 	hub_rt_clock_event_global_init();
+	hub_rt_clock_event_init();
 }
 
 void __cpuinit cpu_time_init(void)
@@ -281,7 +281,6 @@ void __cpuinit cpu_time_init(void)
 
 	printk("CPU %d clock is %dMHz.\n", smp_processor_id(), cpu->cpu_speed);
 
-	hub_rt_clock_event_init();
 	set_c0_status(SRB_TIMOCLK);
 }
 
