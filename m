Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jul 2015 17:52:22 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:54048 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010724AbbGPPwUj7fOh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jul 2015 17:52:20 +0200
Received: from faui49t (faui49t.informatik.uni-erlangen.de [131.188.42.17])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id AF96F58C4AE;
        Thu, 16 Jul 2015 17:52:18 +0200 (CEST)
Received: by faui49t (sSMTP sendmail emulation); Thu, 16 Jul 2015 17:52:18 +0200
From:   Andreas Ruprecht <andreas.ruprecht@fau.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        valentinrothberg@gmail.com, stefan.hengelein@fau.de,
        pebolle@tiscali.nl, Andreas Ruprecht <andreas.ruprecht@fau.de>
Subject: [PATCH] MIPS: sibyte: Fix Kconfig dependencies of SIBYTE_BUS_WATCHER
Date:   Thu, 16 Jul 2015 17:52:11 +0200
Message-Id: <1437061931-24754-1-git-send-email-andreas.ruprecht@fau.de>
X-Mailer: git-send-email 1.9.1
Return-Path: <andreas.ruprecht@fau.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.ruprecht@fau.de
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

Commit 6793f55cbc84 ("MIPS: sibyte: Amend dependencies for
SIBYTE_BUS_WATCHER") changed the dependencies for
SIBYTE_BUS_WATCHER to make it visible only if SIBYTE_BCM112X
or SIBYTE_SB1250 are enabled.

In the code in arch/mips/sibyte/common/bus_watcher, however,
a #if defined() check suggests that this functionality should
also be available for SIBYTE_BCM1x55 and SIBYTE_BCM1x80.

Make it selectable by extending the dependencies of
SIBYTE_BUS_WATCHER in arch/mips/sibyte/Kconfig.

Reported-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Signed-off-by: Andreas Ruprecht <andreas.ruprecht@fau.de>
---
I found this inconsistency using the undertaker and
undertaker-checkpatch tools (https://undertaker.cs.fau.de/).

 arch/mips/sibyte/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/sibyte/Kconfig b/arch/mips/sibyte/Kconfig
index cb9a095..707b884 100644
--- a/arch/mips/sibyte/Kconfig
+++ b/arch/mips/sibyte/Kconfig
@@ -143,7 +143,8 @@ config SIBYTE_CFE_CONSOLE
 config SIBYTE_BUS_WATCHER
 	bool "Support for Bus Watcher statistics"
 	depends on SIBYTE_SB1xxx_SOC && \
-		(SIBYTE_BCM112X || SIBYTE_SB1250)
+		(SIBYTE_BCM112X || SIBYTE_SB1250 || \
+		 SIBYTE_BCM1x55 || SIBYTE_BCM1x80)
 	help
 	  Handle and keep statistics on the bus error interrupts (COR_ECC,
 	  BAD_ECC, IO_BUS).
-- 
1.9.1
