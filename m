Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 02:45:24 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:49437 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013120AbaKJBpWVRLet (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 02:45:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=rstmHanik4SFB088XCH5ss8vhZYy8GlZ5bzRAjizuNY=;
        b=ENGi9K+xfIejqx9VFrxqQFRId6Xet2mPRcNhmXmjFwLhrTnqvhI8YI53acNW/4Wftd3CbFozBY8RV+EKgWhRzXh84ytl27zTo9GOCIgTgd4qfcg5GrO5iaaLZ67wciYXfW+sOfkn32NY5mG0OvbRqnv+YliR5o7QZE2+f94F00c=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1Xne2e-000XaY-99
        for linux-mips@linux-mips.org; Mon, 10 Nov 2014 01:45:16 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36329 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1Xne2M-000W7w-MI; Mon, 10 Nov 2014 01:45:00 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: [PATCH v6 40/48] mips: Register with kernel power-off handler
Date:   Sun,  9 Nov 2014 17:42:57 -0800
Message-Id: <1415583785-6980-41-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A02020A.546018AC.008B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 266
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Register with kernel power-off handler instead of setting pm_power_off
directly.

If there is an indication that there can be more than one power-off handler,
use register_power_off_handler, otherwise use register_power_off_handler_simple
to register the power-off handler.

If the power-off handler only resets or stops the system, select the fallback
priority to indicate that the power-off handler is one of last resort.
If the power-off handler powers off the system, select the default priority,
unless the power-off handler installation code suggests that there can be
more than one power-off handler and the new handler is only installed
conditionally. In this case, install the handler with low priority.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- This patch: No change.
  Global: Replaced priority defines with enum.
v5:
- Rebase to v3.18-rc3
v4:
- Do not use notifiers but internal functions and data structures to manage
  the list of power-off handlers. Drop unused parameters from callbacks, and
  make the power-off function type void
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use defines to specify poweroff handler priorities

 arch/mips/alchemy/board-gpr.c          |  3 ++-
 arch/mips/alchemy/board-mtx1.c         |  3 ++-
 arch/mips/alchemy/board-xxs1500.c      |  3 ++-
 arch/mips/alchemy/devboards/platform.c | 14 ++++++++++++--
 arch/mips/ar7/setup.c                  |  3 ++-
 arch/mips/ath79/setup.c                |  3 ++-
 arch/mips/bcm47xx/setup.c              |  3 ++-
 arch/mips/bcm63xx/setup.c              |  3 ++-
 arch/mips/cobalt/setup.c               |  3 ++-
 arch/mips/dec/setup.c                  |  3 ++-
 arch/mips/emma/markeins/setup.c        |  3 ++-
 arch/mips/jz4740/reset.c               |  3 ++-
 arch/mips/lantiq/falcon/reset.c        |  3 ++-
 arch/mips/lantiq/xway/reset.c          |  3 ++-
 arch/mips/lasat/reset.c                |  3 ++-
 arch/mips/loongson/common/reset.c      |  3 ++-
 arch/mips/loongson1/common/reset.c     |  3 ++-
 arch/mips/mti-malta/malta-reset.c      |  3 ++-
 arch/mips/mti-sead3/sead3-reset.c      |  3 ++-
 arch/mips/netlogic/xlp/setup.c         |  3 ++-
 arch/mips/netlogic/xlr/setup.c         |  3 ++-
 arch/mips/pmcs-msp71xx/msp_setup.c     |  3 ++-
 arch/mips/pnx833x/common/setup.c       |  3 ++-
 arch/mips/ralink/reset.c               |  3 ++-
 arch/mips/rb532/setup.c                |  3 ++-
 arch/mips/sgi-ip22/ip22-reset.c        |  3 ++-
 arch/mips/sgi-ip27/ip27-reset.c        |  3 ++-
 arch/mips/sgi-ip32/ip32-reset.c        |  3 ++-
 arch/mips/sibyte/common/cfe.c          |  3 ++-
 arch/mips/sni/setup.c                  |  3 ++-
 arch/mips/txx9/generic/setup.c         |  3 ++-
 arch/mips/vr41xx/common/pmu.c          |  3 ++-
 32 files changed, 74 insertions(+), 33 deletions(-)

diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
index acf9a2a..abfc93a 100644
--- a/arch/mips/alchemy/board-gpr.c
+++ b/arch/mips/alchemy/board-gpr.c
@@ -89,7 +89,8 @@ void __init board_setup(void)
 {
 	printk(KERN_INFO "Trapeze ITS GPR board\n");
 
-	pm_power_off = gpr_power_off;
+	register_power_off_handler_simple(gpr_power_off,
+					  POWER_OFF_PRIORITY_FALLBACK);
 	_machine_halt = gpr_power_off;
 	_machine_restart = gpr_reset;
 
diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index 1e3b102..a78df2c 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -98,7 +98,8 @@ void __init board_setup(void)
 	alchemy_gpio_direction_output(211, 1);	/* green on */
 	alchemy_gpio_direction_output(212, 0);	/* red off */
 
-	pm_power_off = mtx1_power_off;
+	register_power_off_handler_simple(mtx1_power_off,
+					  POWER_OFF_PRIORITY_FALLBACK);
 	_machine_halt = mtx1_power_off;
 	_machine_restart = mtx1_reset;
 
diff --git a/arch/mips/alchemy/board-xxs1500.c b/arch/mips/alchemy/board-xxs1500.c
index 0fc53e0..6c413db 100644
--- a/arch/mips/alchemy/board-xxs1500.c
+++ b/arch/mips/alchemy/board-xxs1500.c
@@ -79,7 +79,8 @@ void __init board_setup(void)
 {
 	u32 pin_func;
 
-	pm_power_off = xxs1500_power_off;
+	register_power_off_handler_simple(xxs1500_power_off,
+					  POWER_OFF_PRIORITY_FALLBACK);
 	_machine_halt = xxs1500_power_off;
 	_machine_restart = xxs1500_reset;
 
diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
index be139a0..75eab8a 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -64,10 +64,20 @@ static void db1x_reset(char *c)
 	bcsr_write(BCSR_SYSTEM, 0);
 }
 
+static void db1x_power_off_handler(struct power_off_handler_block *this)
+{
+	db1x_power_off();
+}
+
+static struct power_off_handler_block db1x_power_off_hb = {
+	.handler = db1x_power_off_handler,
+	.priority = POWER_OFF_PRIORITY_LOW,
+};
+
 static int __init db1x_late_setup(void)
 {
-	if (!pm_power_off)
-		pm_power_off = db1x_power_off;
+	if (register_power_off_handler(&db1x_power_off_hb))
+		pr_warn("dbx1: Failed to register power-off handler\n");
 	if (!_machine_halt)
 		_machine_halt = db1x_power_off;
 	if (!_machine_restart)
diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
index 820b7a3..7093266 100644
--- a/arch/mips/ar7/setup.c
+++ b/arch/mips/ar7/setup.c
@@ -91,7 +91,8 @@ void __init plat_mem_setup(void)
 
 	_machine_restart = ar7_machine_restart;
 	_machine_halt = ar7_machine_halt;
-	pm_power_off = ar7_machine_power_off;
+	register_power_off_handler_simple(ar7_machine_power_off,
+					  POWER_OFF_PRIORITY_DEFAULT);
 
 	io_base = (unsigned long)ioremap(AR7_REGS_BASE, 0x10000);
 	if (!io_base)
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 64807a4..66fe138 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -203,7 +203,8 @@ void __init plat_mem_setup(void)
 
 	_machine_restart = ath79_restart;
 	_machine_halt = ath79_halt;
-	pm_power_off = ath79_halt;
+	register_power_off_handler_simple(ath79_halt,
+					  POWER_OFF_PRIORITY_FALLBACK);
 }
 
 void __init plat_time_init(void)
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index c00585d..d0a142c 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -246,7 +246,8 @@ void __init plat_mem_setup(void)
 
 	_machine_restart = bcm47xx_machine_restart;
 	_machine_halt = bcm47xx_machine_halt;
-	pm_power_off = bcm47xx_machine_halt;
+	register_power_off_handler_simple(bcm47xx_machine_halt,
+					  POWER_OFF_PRIORITY_FALLBACK);
 	bcm47xx_board_detect();
 	mips_set_machine_name(bcm47xx_board_get_name());
 }
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 6660c7d..5050a19 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -149,7 +149,8 @@ void __init plat_mem_setup(void)
 
 	_machine_halt = bcm63xx_machine_halt;
 	_machine_restart = __bcm63xx_machine_reboot;
-	pm_power_off = bcm63xx_machine_halt;
+	register_power_off_handler_simple(bcm63xx_machine_halt,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 	set_io_port_base(0);
 	ioport_resource.start = 0;
diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index 9a8c2fe..527f331 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -78,7 +78,8 @@ void __init plat_mem_setup(void)
 
 	_machine_restart = cobalt_machine_restart;
 	_machine_halt = cobalt_machine_halt;
-	pm_power_off = cobalt_machine_halt;
+	register_power_off_handler_simple(cobalt_machine_halt,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 	set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
 
diff --git a/arch/mips/dec/setup.c b/arch/mips/dec/setup.c
index 41bbffd..b5d3200 100644
--- a/arch/mips/dec/setup.c
+++ b/arch/mips/dec/setup.c
@@ -158,7 +158,8 @@ void __init plat_mem_setup(void)
 
 	_machine_restart = dec_machine_restart;
 	_machine_halt = dec_machine_halt;
-	pm_power_off = dec_machine_power_off;
+	register_power_off_handler_simple(dec_machine_power_off,
+					  POWER_OFF_PRIORITY_DEFAULT);
 
 	ioport_resource.start = ~0UL;
 	ioport_resource.end = 0UL;
diff --git a/arch/mips/emma/markeins/setup.c b/arch/mips/emma/markeins/setup.c
index 9100122..4ea7ffb 100644
--- a/arch/mips/emma/markeins/setup.c
+++ b/arch/mips/emma/markeins/setup.c
@@ -103,7 +103,8 @@ void __init plat_mem_setup(void)
 
 	_machine_restart = markeins_machine_restart;
 	_machine_halt = markeins_machine_halt;
-	pm_power_off = markeins_machine_power_off;
+	register_power_off_handler_simple(markeins_machine_power_off,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 	/* setup resource limits */
 	ioport_resource.start = EMMA2RH_PCI_IO_BASE;
diff --git a/arch/mips/jz4740/reset.c b/arch/mips/jz4740/reset.c
index b6c6343..157e0e2 100644
--- a/arch/mips/jz4740/reset.c
+++ b/arch/mips/jz4740/reset.c
@@ -114,5 +114,6 @@ void jz4740_reset_init(void)
 {
 	_machine_restart = jz4740_restart;
 	_machine_halt = jz4740_halt;
-	pm_power_off = jz4740_power_off;
+	register_power_off_handler_simple(jz4740_power_off,
+					  POWER_OFF_PRIORITY_DEFAULT);
 }
diff --git a/arch/mips/lantiq/falcon/reset.c b/arch/mips/lantiq/falcon/reset.c
index 5682482..7b60d36 100644
--- a/arch/mips/lantiq/falcon/reset.c
+++ b/arch/mips/lantiq/falcon/reset.c
@@ -83,7 +83,8 @@ static int __init mips_reboot_setup(void)
 {
 	_machine_restart = machine_restart;
 	_machine_halt = machine_halt;
-	pm_power_off = machine_power_off;
+	register_power_off_handler_simple(machine_power_off,
+					  POWER_OFF_PRIORITY_FALLBACK);
 	return 0;
 }
 
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 1fa0f17..9b37cc1 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -157,7 +157,8 @@ static int __init mips_reboot_setup(void)
 
 	_machine_restart = ltq_machine_restart;
 	_machine_halt = ltq_machine_halt;
-	pm_power_off = ltq_machine_power_off;
+	register_power_off_handler_simple(ltq_machine_power_off,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 	return 0;
 }
diff --git a/arch/mips/lasat/reset.c b/arch/mips/lasat/reset.c
index e21f0b9..91dab32 100644
--- a/arch/mips/lasat/reset.c
+++ b/arch/mips/lasat/reset.c
@@ -56,5 +56,6 @@ void lasat_reboot_setup(void)
 {
 	_machine_restart = lasat_machine_restart;
 	_machine_halt = lasat_machine_halt;
-	pm_power_off = lasat_machine_halt;
+	register_power_off_handler_simple(lasat_machine_halt,
+					  POWER_OFF_PRIORITY_FALLBACK);
 }
diff --git a/arch/mips/loongson/common/reset.c b/arch/mips/loongson/common/reset.c
index a60715e..32b2de8 100644
--- a/arch/mips/loongson/common/reset.c
+++ b/arch/mips/loongson/common/reset.c
@@ -84,7 +84,8 @@ static int __init mips_reboot_setup(void)
 {
 	_machine_restart = loongson_restart;
 	_machine_halt = loongson_halt;
-	pm_power_off = loongson_poweroff;
+	register_power_off_handler_simple(loongson_poweroff,
+					  POWER_OFF_PRIORITY_DEFAULT);
 
 	return 0;
 }
diff --git a/arch/mips/loongson1/common/reset.c b/arch/mips/loongson1/common/reset.c
index 547f34b..8a3cdd8 100644
--- a/arch/mips/loongson1/common/reset.c
+++ b/arch/mips/loongson1/common/reset.c
@@ -38,7 +38,8 @@ static int __init ls1x_reboot_setup(void)
 {
 	_machine_restart = ls1x_restart;
 	_machine_halt = ls1x_halt;
-	pm_power_off = ls1x_power_off;
+	register_power_off_handler_simple(ls1x_power_off,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 	return 0;
 }
diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
index 2fd2cc2..2e4489f 100644
--- a/arch/mips/mti-malta/malta-reset.c
+++ b/arch/mips/mti-malta/malta-reset.c
@@ -40,7 +40,8 @@ static int __init mips_reboot_setup(void)
 {
 	_machine_restart = mips_machine_restart;
 	_machine_halt = mips_machine_halt;
-	pm_power_off = mips_machine_power_off;
+	register_power_off_handler_simple(mips_machine_power_off,
+					  POWER_OFF_PRIORITY_DEFAULT);
 
 	return 0;
 }
diff --git a/arch/mips/mti-sead3/sead3-reset.c b/arch/mips/mti-sead3/sead3-reset.c
index e6fb244..039aaf6 100644
--- a/arch/mips/mti-sead3/sead3-reset.c
+++ b/arch/mips/mti-sead3/sead3-reset.c
@@ -33,7 +33,8 @@ static int __init mips_reboot_setup(void)
 {
 	_machine_restart = mips_machine_restart;
 	_machine_halt = mips_machine_halt;
-	pm_power_off = mips_machine_halt;
+	register_power_off_handler_simple(mips_machine_halt,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 	return 0;
 }
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 4fdd9fd..68529dd 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -106,7 +106,8 @@ void __init plat_mem_setup(void)
 #endif
 	_machine_restart = (void (*)(char *))nlm_linux_exit;
 	_machine_halt	= nlm_linux_exit;
-	pm_power_off	= nlm_linux_exit;
+	register_power_off_handler_simple(nlm_linux_exit,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 	/* memory and bootargs from DT */
 	xlp_early_init_devtree();
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index d118b9a..898e950 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -75,7 +75,8 @@ void __init plat_mem_setup(void)
 {
 	_machine_restart = (void (*)(char *))nlm_linux_exit;
 	_machine_halt	= nlm_linux_exit;
-	pm_power_off	= nlm_linux_exit;
+	register_power_off_handler_simple(nlm_linux_exit,
+					  POWER_OFF_PRIORITY_FALLBACK);
 }
 
 const char *get_system_type(void)
diff --git a/arch/mips/pmcs-msp71xx/msp_setup.c b/arch/mips/pmcs-msp71xx/msp_setup.c
index 4f925e0..a2b4722 100644
--- a/arch/mips/pmcs-msp71xx/msp_setup.c
+++ b/arch/mips/pmcs-msp71xx/msp_setup.c
@@ -144,7 +144,8 @@ void __init plat_mem_setup(void)
 {
 	_machine_restart = msp_restart;
 	_machine_halt = msp_halt;
-	pm_power_off = msp_power_off;
+	register_power_off_handler_simple(msp_power_off,
+					  POWER_OFF_PRIORITY_FALLBACK);
 }
 
 void __init prom_init(void)
diff --git a/arch/mips/pnx833x/common/setup.c b/arch/mips/pnx833x/common/setup.c
index 99b4d94..55f7a22 100644
--- a/arch/mips/pnx833x/common/setup.c
+++ b/arch/mips/pnx833x/common/setup.c
@@ -51,7 +51,8 @@ int __init plat_mem_setup(void)
 
 	_machine_restart = pnx833x_machine_restart;
 	_machine_halt = pnx833x_machine_halt;
-	pm_power_off = pnx833x_machine_power_off;
+	register_power_off_handler_simple(pnx833x_machine_power_off,
+					  POWER_OFF_PRIORITY_DEFAULT);
 
 	/* IO/MEM resources. */
 	set_io_port_base(KSEG1);
diff --git a/arch/mips/ralink/reset.c b/arch/mips/ralink/reset.c
index 55c7ec5..7b6dfdf3 100644
--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -98,7 +98,8 @@ static int __init mips_reboot_setup(void)
 {
 	_machine_restart = ralink_restart;
 	_machine_halt = ralink_halt;
-	pm_power_off = ralink_halt;
+	register_power_off_handler_simple(ralink_halt,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 	return 0;
 }
diff --git a/arch/mips/rb532/setup.c b/arch/mips/rb532/setup.c
index d0c64e7..1b95326b 100644
--- a/arch/mips/rb532/setup.c
+++ b/arch/mips/rb532/setup.c
@@ -44,7 +44,8 @@ void __init plat_mem_setup(void)
 
 	_machine_restart = rb_machine_restart;
 	_machine_halt = rb_machine_halt;
-	pm_power_off = rb_machine_halt;
+	register_power_off_handler_simple(rb_machine_halt,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 	set_io_port_base(KSEG1);
 
diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index 063c2dd..ecd1970 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -188,7 +188,8 @@ static int __init reboot_setup(void)
 
 	_machine_restart = sgi_machine_restart;
 	_machine_halt = sgi_machine_halt;
-	pm_power_off = sgi_machine_power_off;
+	register_power_off_handler_simple(sgi_machine_power_off,
+					  POWER_OFF_PRIORITY_DEFAULT);
 
 	res = request_irq(SGI_PANEL_IRQ, panel_int, 0, "Front Panel", NULL);
 	if (res) {
diff --git a/arch/mips/sgi-ip27/ip27-reset.c b/arch/mips/sgi-ip27/ip27-reset.c
index ac37e54..e695975 100644
--- a/arch/mips/sgi-ip27/ip27-reset.c
+++ b/arch/mips/sgi-ip27/ip27-reset.c
@@ -76,5 +76,6 @@ void ip27_reboot_setup(void)
 {
 	_machine_restart = ip27_machine_restart;
 	_machine_halt = ip27_machine_halt;
-	pm_power_off = ip27_machine_power_off;
+	register_power_off_handler_simple(ip27_machine_power_off,
+					  POWER_OFF_PRIORITY_FALLBACK);
 }
diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
index 1f823da..e3522fd 100644
--- a/arch/mips/sgi-ip32/ip32-reset.c
+++ b/arch/mips/sgi-ip32/ip32-reset.c
@@ -189,7 +189,8 @@ static __init int ip32_reboot_setup(void)
 
 	_machine_restart = ip32_machine_restart;
 	_machine_halt = ip32_machine_halt;
-	pm_power_off = ip32_machine_power_off;
+	register_power_off_handler_simple(ip32_machine_power_off,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 	init_timer(&blink_timer);
 	blink_timer.function = blink_timeout;
diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index 588e180..bf47de7 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -245,7 +245,8 @@ void __init prom_init(void)
 
 	_machine_restart   = cfe_linux_restart;
 	_machine_halt	   = cfe_linux_halt;
-	pm_power_off = cfe_linux_halt;
+	register_power_off_handler_simple(cfe_linux_halt,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 	/*
 	 * Check if a loader was used; if NOT, the 4 arguments are
diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
index efad85c..d278f0f 100644
--- a/arch/mips/sni/setup.c
+++ b/arch/mips/sni/setup.c
@@ -225,7 +225,8 @@ void __init plat_mem_setup(void)
 	}
 
 	_machine_restart = sni_machine_restart;
-	pm_power_off = sni_machine_power_off;
+	register_power_off_handler_simple(sni_machine_power_off,
+					  POWER_OFF_PRIORITY_DEFAULT);
 
 	sni_display_setup();
 	sni_console_setup();
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 2791b86..cb48e06 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -555,7 +555,8 @@ void __init plat_mem_setup(void)
 	/* fallback restart/halt routines */
 	_machine_restart = (void (*)(char *))txx9_machine_halt;
 	_machine_halt = txx9_machine_halt;
-	pm_power_off = txx9_machine_halt;
+	register_power_off_handler_simple(txx9_machine_halt,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 #ifdef CONFIG_PCI
 	pcibios_plat_setup = txx9_pcibios_setup;
diff --git a/arch/mips/vr41xx/common/pmu.c b/arch/mips/vr41xx/common/pmu.c
index d7f7558..cd9a20d 100644
--- a/arch/mips/vr41xx/common/pmu.c
+++ b/arch/mips/vr41xx/common/pmu.c
@@ -127,7 +127,8 @@ static int __init vr41xx_pmu_init(void)
 	cpu_wait = vr41xx_cpu_wait;
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
-	pm_power_off = vr41xx_halt;
+	register_power_off_handler_simple(vr41xx_halt,
+					  POWER_OFF_PRIORITY_FALLBACK);
 
 	return 0;
 }
-- 
1.9.1
