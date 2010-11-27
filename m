Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Nov 2010 17:47:35 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:53696 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492333Ab0K0QqX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Nov 2010 17:46:23 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id F2DBA8799;
        Sat, 27 Nov 2010 17:46:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t0xzRX+V+-Nc; Sat, 27 Nov 2010 17:46:20 +0100 (CET)
Received: from localhost.localdomain (host-091-097-248-055.ewe-ip-backbone.de [91.97.248.55])
        by hauke-m.de (Postfix) with ESMTPSA id D1DB287AC;
        Sat, 27 Nov 2010 17:46:14 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] MIPS: BCM47xx: Swap serial console if ttyS1 was specified.
Date:   Sat, 27 Nov 2010 17:46:01 +0100
Message-Id: <1290876361-4297-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1290876361-4297-1-git-send-email-hauke@hauke-m.de>
References: <1290876361-4297-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

Some devices like the Netgear WGT634U are using ttyS1 for default
console output. We should switch to that console if it was given in
the kernel_args parameters.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 87a3055..c95f90b 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -169,12 +169,28 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 void __init plat_mem_setup(void)
 {
 	int err;
+	char buf[100];
+	struct ssb_mipscore *mcore;
 
 	err = ssb_bus_ssbbus_register(&ssb_bcm47xx, SSB_ENUM_BASE,
 				      bcm47xx_get_invariants);
 	if (err)
 		panic("Failed to initialize SSB bus (err %d)\n", err);
 
+	mcore = &ssb_bcm47xx.mipscore;
+	if (nvram_getenv("kernel_args", buf, sizeof(buf)) >= 0) {
+		if (strstr(buf, "console=ttyS1")) {
+			struct ssb_serial_port port;
+
+			printk(KERN_DEBUG "Swapping serial ports!\n");
+			/* swap serial ports */
+			memcpy(&port, &mcore->serial_ports[0], sizeof(port));
+			memcpy(&mcore->serial_ports[0], &mcore->serial_ports[1],
+			       sizeof(port));
+			memcpy(&mcore->serial_ports[1], &port, sizeof(port));
+		}
+	}
+
 	_machine_restart = bcm47xx_machine_restart;
 	_machine_halt = bcm47xx_machine_halt;
 	pm_power_off = bcm47xx_machine_halt;
-- 
1.7.1
