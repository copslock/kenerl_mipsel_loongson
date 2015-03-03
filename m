Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 00:21:37 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52958 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007914AbbCCXVfQjpSV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 00:21:35 +0100
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1YSw83-0000ea-Lt; Tue, 03 Mar 2015 23:21:31 +0000
Received: from ben by deadeye with local (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1YSw7y-0006qU-Cb; Tue, 03 Mar 2015 23:21:26 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Hemmo Nieminen" <hemmo.nieminen@iki.fi>,
        "David Daney" <david.daney@cavium.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>
Date:   Tue, 03 Mar 2015 22:11:28 +0000
Message-ID: <lsq.1425420688.351602696@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 09/24] MIPS: Fix kernel lockup or crash after CPU
 offline/online
In-Reply-To: <lsq.1425420688.806916072@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.68-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hemmo Nieminen <hemmo.nieminen@iki.fi>

commit c7754e75100ed5e3068ac5085747f2bfc386c8d6 upstream.

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
Cc: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/8953/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -105,10 +105,10 @@ asmlinkage __cpuinit void start_secondar
 	if ((read_c0_tcbind() & TCBIND_CURTC) == 0)
 #endif /* CONFIG_MIPS_MT_SMTC */
 	cpu_probe();
-	cpu_report();
 	per_cpu_trap_init();
 	mips_clockevent_init();
 	mp_ops->init_secondary();
+	cpu_report();
 
 	/*
 	 * XXX parity protection should be folded in here when it's converted
