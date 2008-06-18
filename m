Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2008 08:19:14 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:13494 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20025325AbYFRHRU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2008 08:17:20 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 99853C80D8;
	Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id a4jR73frvyIf; Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 3F387C80DD;
	Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id A6C20B4049; Wed, 18 Jun 2008 10:18:22 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 1/5] [MIPS] 8253: make the pit_clockevent variable static
Date:	Wed, 18 Jun 2008 10:18:19 +0300
Message-Id: <1213773503-23536-2-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The pit_clockevent symbol is needlessly defined global. This patch makes
that variable static.

Spotted by sparse. Compile-tested using Malta defconfig.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/kernel/i8253.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/i8253.c b/arch/mips/kernel/i8253.c
index 38fa1a1..b6ac551 100644
--- a/arch/mips/kernel/i8253.c
+++ b/arch/mips/kernel/i8253.c
@@ -80,7 +80,7 @@ static int pit_next_event(unsigned long delta, struct clock_event_device *evt)
  * registered. This mechanism replaces the previous #ifdef LOCAL_APIC -
  * !using_apic_timer decisions in do_timer_interrupt_hook()
  */
-struct clock_event_device pit_clockevent = {
+static struct clock_event_device pit_clockevent = {
 	.name		= "pit",
 	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_mode	= init_pit_timer,
-- 
1.5.5.GIT
