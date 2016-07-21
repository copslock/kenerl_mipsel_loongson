Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jul 2016 08:30:36 +0200 (CEST)
Received: from smtpbgbr2.qq.com ([54.207.22.56]:50787 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992773AbcGUGa0xB6Cr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jul 2016 08:30:26 +0200
X-QQ-mid: bizesmtp1t1469082585t630t136
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2016 14:29:11 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK72B00A0000000
X-QQ-FEAT: +c2Kczbw9d3FakwKD+tuhb9mYVS5i7qnMZrCtc6KJBBQXiRChirbvz99h/2S1
        HHBZ3vKZIJZjvnGm5iJlYsLz/g8MS1SVCN3kUwbg2Wo/VSTuE9eYS1xr0HF6fFp3u4w/97y
        QUXVfN21mvAiiNyn26Q5nSMaAKRQKIkDn2ZvXzZmsDHcg0dDhNruEf+pwR+QEe7gfKdGHbT
        7vhnHlxOCNMvZWi2zo1cfOEL2Ecmse0GNC+MD74ahQ4VNQlpRICN7pekz4Wh+edpZW/7D7b
        kPIK+oN7Wicq7pmLLPm9r3XU4=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH 3/3] MIPS: hpet: Increase HPET_MIN_PROG_DELTA and decrease HPET_MIN_CYCLES
Date:   Thu, 21 Jul 2016 14:27:51 +0800
Message-Id: <1469082471-4936-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1469082471-4936-1-git-send-email-chenhc@lemote.com>
References: <1469082471-4936-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

At first, we prefer to use mips clockevent device, so we decrease the
rating of hpet clockevent device.

For hpet, if HPET_MIN_PROG_DELTA (minimum delta of hpet programming) is
too small and HPET_MIN_CYCLES (threshold of -ETIME checking) is too
large, then hpet_next_event() can easily return -ETIME. After commit
c6eb3f70d44828 ("hrtimer: Get rid of hrtimer softirq") this will cause
a RCU stall.

So, HPET_MIN_PROG_DELTA must be sufficient that we don't re-trip the
-ETIME check -- if we do, we will return -ETIME, forward the next event
time, try to set it, return -ETIME again, and basically lock the system
up. Meanwhile, HPET_MIN_CYCLES doesn't need to be too large, 16 cycles
is enough.

This solution is similar to commit f9eccf24615672 ("clocksource/drivers
/vt8500: Increase the minimum delta").

By the way, this patch ensures hpet count/compare to be 32-bit long.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/loongson-3/hpet.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/hpet.c b/arch/mips/loongson64/loongson-3/hpet.c
index 249039a..4788bea 100644
--- a/arch/mips/loongson64/loongson-3/hpet.c
+++ b/arch/mips/loongson64/loongson-3/hpet.c
@@ -13,8 +13,8 @@
 #define SMBUS_PCI_REG64		0x64
 #define SMBUS_PCI_REGB4		0xb4
 
-#define HPET_MIN_CYCLES		64
-#define HPET_MIN_PROG_DELTA	(HPET_MIN_CYCLES + (HPET_MIN_CYCLES >> 1))
+#define HPET_MIN_CYCLES		16
+#define HPET_MIN_PROG_DELTA	(HPET_MIN_CYCLES * 12)
 
 static DEFINE_SPINLOCK(hpet_lock);
 DEFINE_PER_CPU(struct clock_event_device, hpet_clockevent_device);
@@ -157,14 +157,14 @@ static int hpet_tick_resume(struct clock_event_device *evt)
 static int hpet_next_event(unsigned long delta,
 		struct clock_event_device *evt)
 {
-	unsigned int cnt;
-	int res;
+	u32 cnt;
+	s32 res;
 
 	cnt = hpet_read(HPET_COUNTER);
-	cnt += delta;
+	cnt += (u32) delta;
 	hpet_write(HPET_T0_CMP, cnt);
 
-	res = (int)(cnt - hpet_read(HPET_COUNTER));
+	res = (s32)(cnt - hpet_read(HPET_COUNTER));
 
 	return res < HPET_MIN_CYCLES ? -ETIME : 0;
 }
@@ -230,7 +230,7 @@ void __init setup_hpet_timer(void)
 
 	cd = &per_cpu(hpet_clockevent_device, cpu);
 	cd->name = "hpet";
-	cd->rating = 320;
+	cd->rating = 100;
 	cd->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	cd->set_state_shutdown = hpet_set_state_shutdown;
 	cd->set_state_periodic = hpet_set_state_periodic;
-- 
2.7.0
