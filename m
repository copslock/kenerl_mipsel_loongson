Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 14:18:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56945 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026696AbbEMMSNyBZ5g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 14:18:13 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6379E63073429;
        Wed, 13 May 2015 13:18:08 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 13 May 2015 13:18:10 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 13 May 2015 13:18:09 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH 2/2] MIPS: malta-time: Take seconds into account
Date:   Wed, 13 May 2015 13:17:53 +0100
Message-ID: <1431519473-24049-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1431519473-24049-1-git-send-email-james.hogan@imgtec.com>
References: <1431519473-24049-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47371
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
FPGA systems and emulators. This results in several seconds actually
having passed before seeing the UIP bit instead of just one second, and
exaggerated timer frequencies.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mti-malta/malta-time.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index a030d41eb5a1..1aaa56162ba0 100644
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
@@ -91,6 +94,7 @@ static void __init estimate_frequencies(void)
 		gic_start_count();
 		gicstart = gic_read_count();
 	}
+	secs1 = CMOS_READ(RTC_SECONDS);
 
 	/* Read counter exactly on falling edge of update flag. */
 	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
@@ -99,14 +103,25 @@ static void __init estimate_frequencies(void)
 	count = read_c0_count();
 	if (gic_present)
 		giccount = gic_read_count();
+	secs2 = CMOS_READ(RTC_SECONDS);
+	ctrl = CMOS_READ(RTC_CONTROL);
 
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
2.3.6
