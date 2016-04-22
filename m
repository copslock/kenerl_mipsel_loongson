Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 19:20:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16866 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027309AbcDVRTjz4PqU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2016 19:19:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 20D07CB6C327E;
        Fri, 22 Apr 2016 18:19:30 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 18:19:33 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 18:19:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] MIPS: cevt-r4k: Dynamically calculate min_delta_ns
Date:   Fri, 22 Apr 2016 18:19:17 +0100
Message-ID: <1461345557-2763-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1461345557-2763-1-git-send-email-james.hogan@imgtec.com>
References: <1461345557-2763-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Calculate the MIPS clockevent device's min_delta_ns dynamically based on
the time it takes to perform the mips_next_event() sequence.

Virtualisation in particular makes the current fixed min_delta of 0x300
inappropriate under some circumstances, as the CP0_Count and CP0_Compare
registers may be being emulated by the hypervisor, and the frequency may
not correspond directly to the CPU frequency.

We actually use twice the median of multiple 75th percentiles of
multiple measurements of how long the mips_next_event() sequence takes,
in order to fairly efficiently eliminate outliers due to unexpected
hypervisor latency (which would need handling with retries when it
occurs during normal operation anyway).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/kernel/cevt-r4k.c | 82 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 8dfe6a6e1480..e4c21bbf9422 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -28,6 +28,83 @@ static int mips_next_event(unsigned long delta,
 	return res;
 }
 
+/**
+ * calculate_min_delta() - Calculate a good minimum delta for mips_next_event().
+ *
+ * Running under virtualisation can introduce overhead into mips_next_event() in
+ * the form of hypervisor emulation of CP0_Count/CP0_Compare registers,
+ * potentially with an unnatural frequency, which makes a fixed min_delta_ns
+ * value inappropriate as it may be too small.
+ *
+ * It can also introduce occasional latency from the guest being descheduled.
+ *
+ * This function calculates a good minimum delta based roughly on the 75th
+ * percentile of the time taken to do the mips_next_event() sequence, in order
+ * to handle potentially higher overhead while also eliminating outliers due to
+ * unpredictable hypervisor latency (which can be handled by retries).
+ *
+ * Return:	An appropriate minimum delta for the clock event device.
+ */
+static unsigned int calculate_min_delta(void)
+{
+	unsigned int cnt, i, j, k, l;
+	unsigned int buf1[4], buf2[3];
+	unsigned int min_delta;
+
+	/*
+	 * Calculate the median of 5 75th percentiles of 5 samples of how long
+	 * it takes to set CP0_Compare = CP0_Count + delta.
+	 */
+	for (i = 0; i < 5; ++i) {
+		for (j = 0; j < 5; ++j) {
+			/*
+			 * This is like the code in mips_next_event(), and
+			 * directly measures the borderline "safe" delta.
+			 */
+			cnt = read_c0_count();
+			write_c0_compare(cnt);
+			cnt = read_c0_count() - cnt;
+
+			/* Sorted insert into buf1 */
+			for (k = 0; k < j; ++k) {
+				if (cnt < buf1[k]) {
+					l = min_t(unsigned int,
+						  j, ARRAY_SIZE(buf1) - 1);
+					for (; l > k; --l)
+						buf1[l] = buf1[l - 1];
+					break;
+				}
+			}
+			if (k < ARRAY_SIZE(buf1))
+				buf1[k] = cnt;
+		}
+
+		/* Sorted insert of 75th percentile into buf2 */
+		for (k = 0; k < i; ++k) {
+			if (buf1[ARRAY_SIZE(buf1) - 1] < buf2[k]) {
+				l = min_t(unsigned int,
+					  i, ARRAY_SIZE(buf2) - 1);
+				for (; l > k; --l)
+					buf2[l] = buf2[l - 1];
+				break;
+			}
+		}
+		if (k < ARRAY_SIZE(buf2))
+			buf2[k] = buf1[ARRAY_SIZE(buf1) - 1];
+	}
+
+	/* Use 2 * median of 75th percentiles */
+	min_delta = buf2[ARRAY_SIZE(buf2) - 1] * 2;
+
+	/* Don't go too low */
+	if (min_delta < 0x300)
+		min_delta = 0x300;
+
+	pr_debug("%s: median 75th percentile=%#x, min_delta=%#x\n",
+		 __func__, buf2[ARRAY_SIZE(buf2) - 1], min_delta);
+	return min_delta;
+}
+
 DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
 int cp0_timer_irq_installed;
 
@@ -177,7 +254,7 @@ int r4k_clockevent_init(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *cd;
-	unsigned int irq;
+	unsigned int irq, min_delta;
 
 	if (!cpu_has_counter || !mips_hpt_frequency)
 		return -ENXIO;
@@ -203,7 +280,8 @@ int r4k_clockevent_init(void)
 
 	/* Calculate the min / max delta */
 	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
-	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
+	min_delta		= calculate_min_delta();
+	cd->min_delta_ns	= clockevent_delta2ns(min_delta, cd);
 
 	cd->rating		= 300;
 	cd->irq			= irq;
-- 
2.4.10
