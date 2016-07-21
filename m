Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jul 2016 08:28:59 +0200 (CEST)
Received: from smtpbg202.qq.com ([184.105.206.29]:41655 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992942AbcGUG2wk7dbr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jul 2016 08:28:52 +0200
X-QQ-mid: bizesmtp1t1469082496t804t181
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2016 14:27:55 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK72B00A0000000
X-QQ-FEAT: +c2Kczbw9d2yYhlXxy5xjpSJXxCFssUaQdfMKsLsJMKnZan+WLrFpc/0JIJzT
        HUH7hSaT03qGcea1TOKW9P61qim9NdYbrxFaXxtrCYfi5chDeUcySfkznvmtQ81BarNKU87
        BuJct/1KFBIRZe5/jsPOjy3z2C3YYiK87K+XYW6xJZGGkJReZWbHp808tdOVeAaXVzVNdQq
        qaN3QEBMMb3dbmXuoPtRy+mxGSPNKubSrmZzQbBux003bOTbJAtbiaRaPa/8tqWydJW+399
        dyxfKRg7wyKvXtXF5vNZu6rsc=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org,
        Heiher <r@hev.cc>
Subject: [PATCH 1/3] MIPS: Fix r4k clockevents registration
Date:   Thu, 21 Jul 2016 14:27:49 +0800
Message-Id: <1469082471-4936-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54350
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

CPUFreq need min_delta_ticks/max_delta_ticks to be initialized, and
this can be done by clockevents_config_and_register().

Cc: stable@vger.kernel.org
Signed-off-by: Heiher <r@hev.cc>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/cevt-r4k.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index e4c21bb..804d2a2 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -276,12 +276,7 @@ int r4k_clockevent_init(void)
 				  CLOCK_EVT_FEAT_C3STOP |
 				  CLOCK_EVT_FEAT_PERCPU;
 
-	clockevent_set_clock(cd, mips_hpt_frequency);
-
-	/* Calculate the min / max delta */
-	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
 	min_delta		= calculate_min_delta();
-	cd->min_delta_ns	= clockevent_delta2ns(min_delta, cd);
 
 	cd->rating		= 300;
 	cd->irq			= irq;
@@ -289,7 +284,7 @@ int r4k_clockevent_init(void)
 	cd->set_next_event	= mips_next_event;
 	cd->event_handler	= mips_event_handler;
 
-	clockevents_register_device(cd);
+	clockevents_config_and_register(cd, mips_hpt_frequency, min_delta, 0x7fffffff);
 
 	if (cp0_timer_irq_installed)
 		return 0;
-- 
2.7.0
