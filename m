Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 16:08:23 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993387AbcHROHv70jZI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 16:07:51 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9B9EC9F3;
        Thu, 18 Aug 2016 14:07:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 130/138] MIPS: hpet: Increase HPET_MIN_PROG_DELTA and decrease HPET_MIN_CYCLES
Date:   Thu, 18 Aug 2016 15:59:00 +0200
Message-Id: <20160818135612.869180865@linuxfoundation.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160818135553.377018690@linuxfoundation.org>
References: <20160818135553.377018690@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 3ef06653987d4c4536b408321edf0e5caa2a317f upstream.

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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J . Hill <Steven.Hill@imgtec.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13819/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/loongson64/loongson-3/hpet.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

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
@@ -157,14 +157,14 @@ static int hpet_tick_resume(struct clock
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
