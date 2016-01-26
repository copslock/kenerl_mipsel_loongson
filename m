Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 09:39:52 +0100 (CET)
Received: from smtp4-g21.free.fr ([212.27.42.4]:32072 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010564AbcAZIjubK3-1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2016 09:39:50 +0100
Received: from localhost.localdomain (unknown [176.4.135.180])
        (Authenticated sender: albeu)
        by smtp4-g21.free.fr (Postfix) with ESMTPA id B48EB4C816F;
        Tue, 26 Jan 2016 09:38:07 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Felix Fietkau <nbd@openwrt.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH] MIPS: ath79: Use the reset controller to restart OF machines
Date:   Tue, 26 Jan 2016 09:39:30 +0100
Message-Id: <1453797570-14655-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Don't set _machine_restart() on OF machines as the reset driver
now provides a system restart handler.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/setup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index be451ee4a..2fdba24 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -215,10 +215,11 @@ void __init plat_mem_setup(void)
 	ath79_detect_sys_type();
 	ath79_ddr_ctrl_init();
 
-	if (mips_machtype != ATH79_MACH_GENERIC_OF)
+	if (mips_machtype != ATH79_MACH_GENERIC_OF) {
 		detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
-
-	_machine_restart = ath79_restart;
+		/* OF machines should use the reset driver */
+		_machine_restart = ath79_restart;
+	}
 	_machine_halt = ath79_halt;
 	pm_power_off = ath79_halt;
 }
-- 
2.0.0
