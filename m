Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2015 17:36:45 +0100 (CET)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:43851
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27006951AbbBWQgZnjz21 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Feb 2015 17:36:25 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH 2/2] MIPS: ralink: add missing symbol for RALINK_ILL_ACC
Date:   Mon, 23 Feb 2015 06:17:33 +0100
Message-Id: <1424668653-60990-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1424668653-60990-1-git-send-email-blogic@openwrt.org>
References: <1424668653-60990-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

A driver was added in commit 5433acd81e87 ("MIPS: ralink: add illegal access
driver") without the Kconfig section being added. Fix this by adding the symbol
to the Kconfig file.

Signed-off-by: John Crispin <blogic@openwrt.org>
Reported-by: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-mips@linux-mips.org
---
 arch/mips/ralink/Kconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index b1c52ca..e9bc8c9 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -7,6 +7,11 @@ config CLKEVT_RT3352
 	select CLKSRC_OF
 	select CLKSRC_MMIO
 
+config RALINK_ILL_ACC
+	bool
+	depends on SOC_RT305X
+	default y
+
 choice
 	prompt "Ralink SoC selection"
 	default SOC_RT305X
-- 
1.7.10.4
