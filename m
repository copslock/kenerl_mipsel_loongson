Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2017 21:31:23 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:55868 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993859AbdDQT3zWfAk8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Apr 2017 21:29:55 +0200
Received: from hauke-desktop.lan (p200300862804440050AB64DAC865B1E7.dip0.t-ipconnect.de [IPv6:2003:86:2804:4400:50ab:64da:c865:b1e7])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 8EDA610031D;
        Mon, 17 Apr 2017 21:29:54 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/13] MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD
Date:   Mon, 17 Apr 2017 21:29:34 +0200
Message-Id: <20170417192942.32219-6-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170417192942.32219-1-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index 177769dbb0e8..f5db4a426568 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -17,6 +17,7 @@ config SOC_XWAY
 	bool "XWAY"
 	select SOC_TYPE_XWAY
 	select HW_HAS_PCI
+	select MFD_SYSCON
 
 config SOC_FALCON
 	bool "FALCON"
-- 
2.11.0
