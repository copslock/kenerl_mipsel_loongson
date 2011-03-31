Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2011 20:51:43 +0200 (CEST)
Received: from smtp-out-109.synserver.de ([212.40.185.109]:1107 "HELO
        smtp-out-109.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491762Ab1CaSvk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Mar 2011 20:51:40 +0200
Received: (qmail 20413 invoked by uid 0); 31 Mar 2011 18:51:37 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 20313
Received: from p4fc35957.dip.t-dialin.net (HELO lars-laptop.hh.ccc.de) [79.195.89.87]
  by 217.119.54.81 with SMTP; 31 Mar 2011 18:51:37 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MIPS: JZ4740: Set one-shot feature flag for the clockevent
Date:   Thu, 31 Mar 2011 20:52:20 +0200
Message-Id: <1301597540-12181-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.7.2.5
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

The code for supporting one-shot mode for the clockevent is already there, only
the feature flag was not set.
This patch allows the kernel to run in tickless mode.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
It would be nice if the patch could go into 2.6.39, it is not required for
stable though.
---
 arch/mips/jz4740/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index fe01678..eaa853a 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -89,7 +89,7 @@ static int jz4740_clockevent_set_next(unsigned long evt,
 
 static struct clock_event_device jz4740_clockevent = {
 	.name = "jz4740-timer",
-	.features = CLOCK_EVT_FEAT_PERIODIC,
+	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_next_event = jz4740_clockevent_set_next,
 	.set_mode = jz4740_clockevent_set_mode,
 	.rating = 200,
-- 
1.7.2.5
