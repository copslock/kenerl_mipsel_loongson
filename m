Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2016 05:47:13 +0200 (CEST)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:54481 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992955AbcGVDrGcmJEf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jul 2016 05:47:06 +0200
X-QQ-mid: bizesmtp5t1469159205t135t041
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2016 11:46:38 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK72B00A0000000
X-QQ-FEAT: 3GtnPQ8BMmYhHmgSL0HkQe05E3ifocbiAdP519Dfm2wmOS3wYFc4NAElrDnDq
        gLzaK/xAvENsQwxFw35P2ZH2QM4tJ14kZVbETN8oTlUS98eWvY1TCh+ChfJEEA4Q02wkZ+s
        wfYHPQj0f7LR80A9N62q+EpJjDv04Pxctcx6olGJYQ+hBrHvuF4M9SY6niZ6Rts7nwHkeD2
        bIA5gJwdZ/8qzD+lnOkNa/Zjl/h6WS/7e9vp24amrYtuNG3JRDmpWZ9EujMNWsmbB89BlmU
        cU77wJV0blcOsAw9pC0N66nOY=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V2] MIPS: Don't register r4k sched clock when CPUFREQ enabled
Date:   Fri, 22 Jul 2016 11:46:31 +0800
Message-Id: <1469159191-4452-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54357
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

Don't register r4k sched clock when CPUFREQ enabled because sched clock
need a constant frequency.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/csrc-r4k.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index 1f91056..d76275d 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -23,7 +23,7 @@ static struct clocksource clocksource_mips = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u64 notrace r4k_read_sched_clock(void)
+static u64 __maybe_unused notrace r4k_read_sched_clock(void)
 {
 	return read_c0_count();
 }
@@ -82,7 +82,9 @@ int __init init_r4k_clocksource(void)
 
 	clocksource_register_hz(&clocksource_mips, mips_hpt_frequency);
 
+#ifndef CONFIG_CPU_FREQ
 	sched_clock_register(r4k_read_sched_clock, 32, mips_hpt_frequency);
+#endif
 
 	return 0;
 }
-- 
2.7.0
