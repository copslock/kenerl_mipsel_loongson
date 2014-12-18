Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:18:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26370 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009176AbaLRPMGvoOUj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:12:06 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 22DDF95938EE4
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:58 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:12:01 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:12:00 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 26/67] MIPS: kernel: cevt-r4k: Add MIPS R6 to the c0_compare_interrupt handler
Date:   Thu, 18 Dec 2014 15:09:35 +0000
Message-ID: <1418915416-3196-27-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Just like MIPS R2, in MIPS R6 it is possible to determine if a
timer interrupt has happened or not.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/cevt-r4k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index bc127e22fdab..1bf23140ad1b 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -40,7 +40,7 @@ int cp0_timer_irq_installed;
 
 irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
 {
-	const int r2 = cpu_has_mips_r2;
+	const int r2 = cpu_has_mips_r2 | cpu_has_mips_r6;
 	struct clock_event_device *cd;
 	int cpu = smp_processor_id();
 
-- 
2.2.0
