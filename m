Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 08:27:34 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:34464 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008947AbcAZH1cfIx08 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2016 08:27:32 +0100
Received: from localhost.localdomain (unknown [78.54.17.127])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 17BF5A628C;
        Tue, 26 Jan 2016 08:25:45 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Felix Fietkau <nbd@openwrt.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 1/2] MIPS: ath79: Add support for DTB passed using the UHI boot protocol
Date:   Tue, 26 Jan 2016 08:27:15 +0100
Message-Id: <1453793236-10890-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51390
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

This is needed for bootloader supporting UHI and to support appended
DTB.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 2fdba24..2895e45 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -203,6 +203,8 @@ void __init plat_mem_setup(void)
 	fdt_start = fw_getenvl("fdt_start");
 	if (fdt_start)
 		__dt_setup_arch((void *)KSEG0ADDR(fdt_start));
+	else if (fw_arg0 == -2)
+		__dt_setup_arch((void *)KSEG0ADDR(fw_arg1));
 #ifdef CONFIG_BUILTIN_DTB
 	else
 		__dt_setup_arch(__dtb_start);
-- 
2.0.0
