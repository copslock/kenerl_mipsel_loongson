Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2014 22:07:26 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:58308 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860016AbaFPUGt1z9-w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jun 2014 22:06:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 2EA5D5A70B0;
        Mon, 16 Jun 2014 23:06:44 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id rqWQlMjzKriK; Mon, 16 Jun 2014 23:06:37 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 642115BC003;
        Mon, 16 Jun 2014 23:06:42 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/3] MIPS: OCTEON: disable SMP if the bootloader version is incorrect
Date:   Mon, 16 Jun 2014 23:06:30 +0300
Message-Id: <1402949190-28182-3-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1402949190-28182-1-git-send-email-aaro.koskinen@iki.fi>
References: <1402949190-28182-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40532
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

Disable SMP if the bootloader version is incorrect for HOTPLUG_CPU.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/smp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index ea96930..71f5505 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -88,8 +88,10 @@ static void octeon_smp_hotplug_setup(void)
 		return;
 
 	labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-	if (labi->labi_signature != LABI_SIGNATURE)
-		panic("The bootloader version on this board is incorrect.");
+	if (labi->labi_signature != LABI_SIGNATURE) {
+		setup_max_cpus = 0;
+		WARN(1, "Disabling SMP - the bootloader version on this board does not support HOTPLUG_CPU.");
+	}
 
 	octeon_bootloader_entry_addr = labi->InitTLBStart_addr;
 #endif
-- 
2.0.0
