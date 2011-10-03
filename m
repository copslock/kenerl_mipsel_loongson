Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2011 01:31:43 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13332 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491909Ab1JCXbg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Oct 2011 01:31:36 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e8a46190001>; Mon, 03 Oct 2011 16:32:45 -0700
Received: from casmarthost.caveonetworks.com ([192.168.16.225]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 3 Oct 2011 16:31:25 -0700
Received: from localhost (webpowersw-sdk106.caveonetworks.com [10.18.162.106])
        by casmarthost.caveonetworks.com (8.13.8/8.13.8) with ESMTP id p93NVLTW022242;
        Mon, 3 Oct 2011 16:31:23 -0700
From:   Venkat Subbiah <venkat.subbiah@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-rt-users@vger.kernel.org, david.daney@cavium.com
Subject: [PATCH] MIPS: Octeon: Mark octeon_wdt interrupt as IRQF_NO_THREAD
Date:   Mon,  3 Oct 2011 16:30:28 -0700
Message-Id: <1317684628-17488-1-git-send-email-venkat.subbiah@cavium.com>
X-Mailer: git-send-email 1.7.0.4
X-OriginalArrivalTime: 03 Oct 2011 23:31:25.0100 (UTC) FILETIME=[910EC6C0:01CC8224]
X-archive-position: 31206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: venkat.subbiah@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1636

This is to exclude it from force threading to allow RT patch set to work.

The watchdog timers are per-CPU and the addresses of register that reset
the timer are calculated based on the current CPU.  Therefore we cannot
allow it to run on a thread on a different CPU.  Also we only do a
single register write, which is much faster than scheduling a handler
thread.

And while on this line remove IRQF_DISABLED as this flag is a NOP.


Signed-off-by: Venkat Subbiah <venkat.subbiah@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 drivers/watchdog/octeon-wdt-main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 945ee83..7c0d863 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -402,7 +402,7 @@ static void octeon_wdt_setup_interrupt(int cpu)
 	irq = OCTEON_IRQ_WDOG0 + core;
 
 	if (request_irq(irq, octeon_wdt_poke_irq,
-			IRQF_DISABLED, "octeon_wdt", octeon_wdt_poke_irq))
+			IRQF_NO_THREAD, "octeon_wdt", octeon_wdt_poke_irq))
 		panic("octeon_wdt: Couldn't obtain irq %d", irq);
 
 	cpumask_set_cpu(cpu, &irq_enabled_cpus);
-- 
1.7.0.4
