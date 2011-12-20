Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2011 17:37:51 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:58111 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903705Ab1LTQhj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Dec 2011 17:37:39 +0100
Received: by eekc13 with SMTP id c13so5719268eek.36
        for <multiple recipients>; Tue, 20 Dec 2011 08:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=NLLY6KTY0ahn4kqTCQFjRHbE0GODDmEI5IgWtsS+HJI=;
        b=Z66l0qZUs/BiizggylwUNsBcKB78+IFYavTovPwpc/f1uYjm16iYN3+PKxS7onX4vT
         lx68dkMNO/avqppuSftFM0Sn5+XJoOeYUIGjDTHtUbpbaOxLENOYP1ueH0PCrOE+yZ2e
         192cFqeWb2AZNehWN8TTQak0vTWfOuoFPcuEo=
Received: by 10.213.114.140 with SMTP id e12mr685592ebq.78.1324399054253;
        Tue, 20 Dec 2011 08:37:34 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-146-24.adsl.highway.telekom.at. [188.22.146.24])
        by mx.google.com with ESMTPS id j20sm8683364eej.8.2011.12.20.08.37.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 08:37:33 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] MIPS: Alchemy: increase minimum timeout for 32kHz timer.
Date:   Tue, 20 Dec 2011 17:37:29 +0100
Message-Id: <1324399049-6410-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.8
X-archive-position: 32150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16183

Since a clocksource change post 3.2-rc1, tasks on my DB1500 board
hang after random amounts of time (from a few minutes to a few hours),
regardless of load.  Debugging showed that the compare-match register
value is a few seconds lower than the current counter value.

The minimum value of 8 was initialy determined by a trial-and-error
approach.  Currently it is sufficient for all Alchemys (without PCI
apparently), independent of CPU clock;  only the DB1500 and DB1550
boards experience these timer-related tasks hangs now.

This patch increases the minimum timeout by 1 (to 9 counter ticks)
which seems sufficient since the systems are still working perfectly
fine after over 24 hours.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Please consider for 3.2

 arch/mips/alchemy/common/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index a594a85..63ba51f 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -146,7 +146,7 @@ static int __init alchemy_time_init(unsigned int m2int)
 	cd->shift = 32;
 	cd->mult = div_sc(32768, NSEC_PER_SEC, cd->shift);
 	cd->max_delta_ns = clockevent_delta2ns(0xffffffff, cd);
-	cd->min_delta_ns = clockevent_delta2ns(8, cd);	/* ~0.25ms */
+	cd->min_delta_ns = clockevent_delta2ns(9, cd);	/* ~0.28ms */
 	clockevents_register_device(cd);
 	setup_irq(m2int, &au1x_rtcmatch2_irqaction);
 
-- 
1.7.8
