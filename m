Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Mar 2015 23:37:21 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:57891 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009174AbbCSWhIrCGZ3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Mar 2015 23:37:08 +0100
Received: from [10.172.68.52] (helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1YYj3s-0006yS-DQ; Thu, 19 Mar 2015 22:37:08 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1YYj3p-0000sG-Vl; Thu, 19 Mar 2015 15:37:05 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Hemmo Nieminen <hemmo.nieminen@iki.fi>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13.y-ckt 68/80] MIPS: Fix kernel lockup or crash after CPU offline/online
Date:   Thu, 19 Mar 2015 15:35:56 -0700
Message-Id: <1426804568-2907-69-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1426804568-2907-1-git-send-email-kamal@canonical.com>
References: <1426804568-2907-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.13
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.13.11-ckt17 -stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 0a022ee..18ed112 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -109,10 +109,10 @@ asmlinkage void start_secondary(void)
 	else
 #endif /* CONFIG_MIPS_MT_SMTC */
 	cpu_probe();
-	cpu_report();
 	per_cpu_trap_init(false);
 	mips_clockevent_init();
 	mp_ops->init_secondary();
+	cpu_report();
 
 	/*
 	 * XXX parity protection should be folded in here when it's converted
-- 
1.9.1
