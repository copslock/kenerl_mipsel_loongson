Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 19:20:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3932 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027304AbcDVRTiLH0HU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2016 19:19:38 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 8B681271741A4;
        Fri, 22 Apr 2016 18:19:28 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 18:19:31 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 18:19:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 2/4] MIPS: malta-time: Take seconds into account
Date:   Fri, 22 Apr 2016 18:19:15 +0100
Message-ID: <1461345557-2763-3-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 53214
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

When estimating the clock frequency based on the RTC, take seconds into
account in case the Update In Progress (UIP) bit wasn't seen. This can
happen in virtual machines (which may get pre-empted by the hypervisor
at inopportune times) with QEMU emulating the RTC (and in fact not
setting the UIP bit for very long), especially on slow hosts such as
FPGA systems and hardware emulators. This results in several seconds
actually having elapsed before seeing the UIP bit instead of just one
second, and exaggerated timer frequencies.

While updating the comments, they're also fixed to match the code in
that the rising edge of the update flag is detected first, not the
falling edge.

The rising edge gives a more precise point to read the counters in a
virtualised system than the falling edge, resulting in a more accurate
frequency.

It does however mean that we have to also wait for the falling edge
before doing the read of the RTC seconds register, otherwise it seems to
be possible in slow hardware emulation to stray into the interval when
the RTC time is undefined during the update (at least 244uS after the
rising edge of the update flag). This can result in both seconds values
reading the same, and it wrapping to 60 seconds, vastly underestimating
the frequency.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mti-malta/malta-time.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 2539687b77f6..7407da04f8d6 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -21,6 +21,7 @@
 #include <linux/i8253.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
+#include <linux/math64.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
@@ -72,6 +73,8 @@ static void __init estimate_frequencies(void)
 {
 	unsigned long flags;
 	unsigned int count, start;
+	unsigned char secs1, secs2, ctrl;
+	int secs;
 	cycle_t giccount = 0, gicstart = 0;
 
 #if defined(CONFIG_KVM_GUEST) && CONFIG_KVM_GUEST_TIMER_FREQ
@@ -84,29 +87,48 @@ static void __init estimate_frequencies(void)
 	if (gic_present)
 		gic_start_count();
 
-	/* Read counter exactly on falling edge of update flag. */
+	/*
+	 * Read counters exactly on rising edge of update flag.
+	 * This helps get an accurate reading under virtualisation.
+	 */
 	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
 	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
-
 	start = read_c0_count();
 	if (gic_present)
 		gicstart = gic_read_count();
 
-	/* Read counter exactly on falling edge of update flag. */
+	/* Wait for falling edge before reading RTC. */
 	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
-	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
+	secs1 = CMOS_READ(RTC_SECONDS);
 
+	/* Read counters again exactly on rising edge of update flag. */
+	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
 	count = read_c0_count();
 	if (gic_present)
 		giccount = gic_read_count();
 
+	/* Wait for falling edge before reading RTC again. */
+	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
+	secs2 = CMOS_READ(RTC_SECONDS);
+
+	ctrl = CMOS_READ(RTC_CONTROL);
+
 	local_irq_restore(flags);
 
+	if (!(ctrl & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+		secs1 = bcd2bin(secs1);
+		secs2 = bcd2bin(secs2);
+	}
+	secs = secs2 - secs1;
+	if (secs < 1)
+		secs += 60;
+
 	count -= start;
+	count /= secs;
 	mips_hpt_frequency = count;
 
 	if (gic_present) {
-		giccount -= gicstart;
+		giccount = div_u64(giccount - gicstart, secs);
 		gic_frequency = giccount;
 	}
 }
-- 
2.4.10
