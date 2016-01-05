Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 06:55:12 +0100 (CET)
Received: from smtpbgbr2.qq.com ([54.207.22.56]:58188 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007756AbcAEFymb20x- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jan 2016 06:54:42 +0100
X-QQ-mid: bizesmtp4t1451973259t477t237
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 05 Jan 2016 13:54:18 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: 6dXuswn9i1WH/haHjx3o3rncjOeg7iU0Yo1/B22sY3SGf1zXdMU3NkT0yTW8W
        M/JVEOMrbfC24rNBCqixU5U/GCkeFrrB0Okv/9imLBUiPMuTC/H8DWoZqqrhdpVdpt2V0vq
        2wh8H7J+JD37IURcamT5RnTqShBzdctu8+cfSWXaz05aRER4Ys+NXiO+88mzX3MeTaFDS83
        wV3+uXU85VBgDtQbLrwm0MmVmgT6bdLdQnNAdMS5m4r8GiWFeDQER5vMkP/frqj7HsOvzr4
        3De8tRumEie+GN
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, <stable@vger.kernel.org>
Subject: [PATCH 4/6] MIPS: hpet: Choose a safe value for the ETIME check
Date:   Tue,  5 Jan 2016 13:59:07 +0800
Message-Id: <1451973549-16198-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1451973549-16198-1-git-send-email-chenhc@lemote.com>
References: <1451973549-16198-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50898
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

This patch is borrowed from x86 hpet driver and explaind below:

Due to the overly intelligent design of HPETs, we need to workaround
the problem that the compare value which we write is already behind
the actual counter value at the point where the value hits the real
compare register. This happens for two reasons:

1) We read out the counter, add the delta and write the result to the
   compare register. When a NMI hits between the read out and the write
   then the counter can be ahead of the event already.

2) The write to the compare register is delayed by up to two HPET
   cycles in AMD chipsets.

We can work around this by reading back the compare register to make
sure that the written value has hit the hardware. But that is bad
performance wise for the normal case where the event is far enough in
the future.

As we already know that the write can be delayed by up to two cycles
we can avoid the read back of the compare register completely if we
make the decision whether the delta has elapsed already or not based
on the following calculation:

  cmp = event - actual_count;

If cmp is less than 64 HPET clock cycles, then we decide that the event
has happened already and return -ETIME. That covers the above #1 and #2
problems which would cause a wait for HPET wraparound (~306 seconds).

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/loongson-3/hpet.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/hpet.c b/arch/mips/loongson64/loongson-3/hpet.c
index bf9f1a7..a2631a5 100644
--- a/arch/mips/loongson64/loongson-3/hpet.c
+++ b/arch/mips/loongson64/loongson-3/hpet.c
@@ -13,6 +13,9 @@
 #define SMBUS_PCI_REG64		0x64
 #define SMBUS_PCI_REGB4		0xb4
 
+#define HPET_MIN_CYCLES		64
+#define HPET_MIN_PROG_DELTA	(HPET_MIN_CYCLES + (HPET_MIN_CYCLES >> 1))
+
 static DEFINE_SPINLOCK(hpet_lock);
 DEFINE_PER_CPU(struct clock_event_device, hpet_clockevent_device);
 
@@ -161,8 +164,9 @@ static int hpet_next_event(unsigned long delta,
 	cnt += delta;
 	hpet_write(HPET_T0_CMP, cnt);
 
-	res = ((int)(hpet_read(HPET_COUNTER) - cnt) > 0) ? -ETIME : 0;
-	return res;
+	res = (int)(cnt - hpet_read(HPET_COUNTER));
+
+	return res < HPET_MIN_CYCLES ? -ETIME : 0;
 }
 
 static irqreturn_t hpet_irq_handler(int irq, void *data)
@@ -237,7 +241,7 @@ void __init setup_hpet_timer(void)
 	cd->cpumask = cpumask_of(cpu);
 	clockevent_set_clock(cd, HPET_FREQ);
 	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
-	cd->min_delta_ns = 5000;
+	cd->min_delta_ns = clockevent_delta2ns(HPET_MIN_PROG_DELTA, cd);
 
 	clockevents_register_device(cd);
 	setup_irq(HPET_T0_IRQ, &hpet_irq);
-- 
2.4.6
