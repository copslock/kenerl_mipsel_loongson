Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Nov 2013 00:23:17 +0100 (CET)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:35730 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867247Ab3KYXXNnbhyf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Nov 2013 00:23:13 +0100
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id E34AE284FF;
        Mon, 25 Nov 2013 23:23:07 +0000 (GMT)
Received: from prod-mail-relay02.akamai.com (prod-mail-relay02.akamai.com [172.17.50.21])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id D01AC284FA;
        Mon, 25 Nov 2013 23:23:07 +0000 (GMT)
Received: from localhost (bos-lp77o.kendall.corp.akamai.com [172.28.13.159])
        by prod-mail-relay02.akamai.com (Postfix) with ESMTP id C6777FE069;
        Mon, 25 Nov 2013 23:23:07 +0000 (GMT)
To:     mingo@kernel.org
Cc:     benh@kernel.crashing.org, paulus@samba.org, ralf@linux-mips.org,
        akpm@linux-foundation.org, mpe@ellerman.id.au,
        felipe.contreras@gmail.com, skuribay@pobox.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Message-Id: <d19dc75fca343ec5d9ada75a1400f57330021976.1385418410.git.jbaron@akamai.com>
In-Reply-To: <cover.1385418410.git.jbaron@akamai.com>
References: <cover.1385418410.git.jbaron@akamai.com>
From:   Jason Baron <jbaron@akamai.com>
Subject: [PATCH 2/3 v3] mips: remove panic_timeout settings
Date:   Mon, 25 Nov 2013 23:23:07 +0000 (GMT)
Return-Path: <jbaron@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbaron@akamai.com
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

From: Ralf Baechle <ralf@linux-mips.org>

Now that we have a CONFIG_PANIC_TIMEOUT=x setting, remove the mips settings. The
default is 0, which means don't reboot on panic.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Acked-by: Shinya Kuribayashi <skuribay@pobox.com>
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 arch/mips/ar7/setup.c           | 1 -
 arch/mips/emma/markeins/setup.c | 3 ---
 arch/mips/netlogic/xlp/setup.c  | 1 -
 arch/mips/netlogic/xlr/setup.c  | 1 -
 arch/mips/sibyte/swarm/setup.c  | 2 --
 5 files changed, 8 deletions(-)

diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
index 9a357ff..820b7a3 100644
--- a/arch/mips/ar7/setup.c
+++ b/arch/mips/ar7/setup.c
@@ -92,7 +92,6 @@ void __init plat_mem_setup(void)
 	_machine_restart = ar7_machine_restart;
 	_machine_halt = ar7_machine_halt;
 	pm_power_off = ar7_machine_power_off;
-	panic_timeout = 3;
 
 	io_base = (unsigned long)ioremap(AR7_REGS_BASE, 0x10000);
 	if (!io_base)
diff --git a/arch/mips/emma/markeins/setup.c b/arch/mips/emma/markeins/setup.c
index d710058..9100122 100644
--- a/arch/mips/emma/markeins/setup.c
+++ b/arch/mips/emma/markeins/setup.c
@@ -111,9 +111,6 @@ void __init plat_mem_setup(void)
 	iomem_resource.start = EMMA2RH_IO_BASE;
 	iomem_resource.end = EMMA2RH_ROM_BASE - 1;
 
-	/* Reboot on panic */
-	panic_timeout = 180;
-
 	markeins_sio_setup();
 }
 
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 6d981bb..54e75c7 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -92,7 +92,6 @@ static void __init xlp_init_mem_from_bars(void)
 
 void __init plat_mem_setup(void)
 {
-	panic_timeout	= 5;
 	_machine_restart = (void (*)(char *))nlm_linux_exit;
 	_machine_halt	= nlm_linux_exit;
 	pm_power_off	= nlm_linux_exit;
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 214d123..921be5f 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -92,7 +92,6 @@ static void nlm_linux_exit(void)
 
 void __init plat_mem_setup(void)
 {
-	panic_timeout	= 5;
 	_machine_restart = (void (*)(char *))nlm_linux_exit;
 	_machine_halt	= nlm_linux_exit;
 	pm_power_off	= nlm_linux_exit;
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 41707a2..3462c83 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -134,8 +134,6 @@ void __init plat_mem_setup(void)
 #error invalid SiByte board configuration
 #endif
 
-	panic_timeout = 5;  /* For debug.  */
-
 	board_be_handler = swarm_be_handler;
 
 	if (xicor_probe())
-- 
1.8.2
