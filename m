Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jul 2016 08:29:33 +0200 (CEST)
Received: from smtpbg65.qq.com ([103.7.28.233]:18989 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992773AbcGUG3YqxL0r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jul 2016 08:29:24 +0200
X-QQ-mid: bizesmtp1t1469082550t306t136
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2016 14:28:18 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK72B00A0000000
X-QQ-FEAT: 46uEpRkUNob1MuCHb4QmEk/U4kAI7oZ3aSK/4NNfnBsT2pD8NaAfC5t2Alqxg
        dlLqVWD9bUymjmRbQsQHBAqVs7fq4d2C35nln0sTXZnN7jNQADO9atsgN32hjCHhtyg98Jt
        bINvE6j5H7OGeFwhF/L0hZLE41o26c1rgryuo6oUgfC5Fudv6+3cyrnPxX8VMKbiYF+WTHC
        gxdZYXpQE3EMdMr+fHhktwwPEtcY86LHRl3K7NtVZhp+IEVRx0RyLYCjg0lqhAhg66g3DRf
        pjw2yVuHnN1LyYW2d+quvy7JY=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH 2/3] MIPS: Don't register r4k sched clock when CPUFREQ enabled
Date:   Thu, 21 Jul 2016 14:27:50 +0800
Message-Id: <1469082471-4936-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1469082471-4936-1-git-send-email-chenhc@lemote.com>
References: <1469082471-4936-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54351
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
 arch/mips/kernel/csrc-r4k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index 1f91056..5131b98 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -82,7 +82,9 @@ int __init init_r4k_clocksource(void)
 
 	clocksource_register_hz(&clocksource_mips, mips_hpt_frequency);
 
+#ifndef CONFIG_CPUFREQ
 	sched_clock_register(r4k_read_sched_clock, 32, mips_hpt_frequency);
+#endif
 
 	return 0;
 }
-- 
2.7.0
