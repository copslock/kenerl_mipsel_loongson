Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2015 19:50:12 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:41176 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014630AbbAOSuCxWa9P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2015 19:50:02 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 5391D5A6EE3;
        Thu, 15 Jan 2015 20:49:53 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id Hjn-Ez6HmBk1; Thu, 15 Jan 2015 20:49:48 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 6F4485BC00A;
        Thu, 15 Jan 2015 20:49:57 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Hemmo Nieminen <hemmo.nieminen@iki.fi>, stable@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/2] MIPS: fix kernel lockup or crash after CPU offline/online
Date:   Thu, 15 Jan 2015 20:49:27 +0200
Message-Id: <1421347767-21740-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1421347767-21740-1-git-send-email-aaro.koskinen@iki.fi>
References: <1421347767-21740-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

From: Hemmo Nieminen <hemmo.nieminen@iki.fi>

As printk() invocation can cause e.g. a TLB miss, printk() cannot be
called before the exception handlers have been properly initialized.
This can happen e.g. when netconsole has been loaded as a kernel module
and the TLB table has been cleared when a CPU was offline.

Call cpu_report() in start_secondary() only after the exception handlers
have been initialized to fix this.

Without the patch the kernel will randomly either lockup or crash
after a CPU is onlined and the console driver is a module.

Signed-off-by: Hemmo Nieminen <hemmo.nieminen@iki.fi>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: stable@vger.kernel.org
---
 arch/mips/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index c94c4e9..1c0d8c5 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -123,10 +123,10 @@ asmlinkage void start_secondary(void)
 	unsigned int cpu;
 
 	cpu_probe();
-	cpu_report();
 	per_cpu_trap_init(false);
 	mips_clockevent_init();
 	mp_ops->init_secondary();
+	cpu_report();
 
 	/*
 	 * XXX parity protection should be folded in here when it's converted
-- 
2.2.0
