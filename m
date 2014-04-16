Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:57:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:55414 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834702AbaDPM5Du2CiQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:57:03 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3108A89233F5
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:56:55 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 16 Apr
 2014 13:56:57 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:56:56 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:56:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 10/39] MIPS: allow R4K clockevent device to function regardless of GIC
Date:   Wed, 16 Apr 2014 13:53:01 +0100
Message-ID: <1397652810-4336-11-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Having the GIC clockevent driver compiled should not prevent the R4K
timer clockevent driver from functioning. One will be selected as the
CPU local timer based upon their priorities and the other may simply be
unused or in the case of the GIC timer may be used as the tick broadcast
device.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/cevt-r4k.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index f3c549c..4dcd1fb 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -72,9 +72,6 @@ irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
 		/* Clear Count/Compare Interrupt */
 		write_c0_compare(read_c0_compare());
 		cd = &per_cpu(mips_clockevent_device, cpu);
-#ifdef CONFIG_CEVT_GIC
-		if (!gic_present)
-#endif
 		cd->event_handler(cd);
 	}
 
@@ -212,9 +209,6 @@ int r4k_clockevent_init(void)
 	cd->set_mode		= mips_set_clock_mode;
 	cd->event_handler	= mips_event_handler;
 
-#ifdef CONFIG_CEVT_GIC
-	if (!gic_present)
-#endif
 	clockevents_register_device(cd);
 
 	if (cp0_timer_irq_installed)
-- 
1.8.5.3
