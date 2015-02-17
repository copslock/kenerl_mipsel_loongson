Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2015 12:35:37 +0100 (CET)
Received: from ip4-83-240-67-251.cust.nbox.cz ([83.240.67.251]:34034 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013444AbbBQLfZSqHMF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Feb 2015 12:35:25 +0100
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.85)
        (envelope-from <jslaby@suse.cz>)
        id 1YNgQo-0005Hu-GJ; Tue, 17 Feb 2015 12:35:10 +0100
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 062/122] MIPS: Fix kernel lockup or crash after CPU offline/online
Date:   Tue, 17 Feb 2015 12:34:09 +0100
Message-Id: <3b92dcea2b0907fa77662d4f97751d502a4d90d9.1424099973.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <09e6fe32192a77f6e2e60cc0f4103e630c7ecf20.1424099973.git.jslaby@suse.cz>
References: <09e6fe32192a77f6e2e60cc0f4103e630c7ecf20.1424099973.git.jslaby@suse.cz>
In-Reply-To: <cover.1424099973.git.jslaby@suse.cz>
References: <cover.1424099973.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 5c208ed8f856..57b89cba1624 100644
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
2.2.2
