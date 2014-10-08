Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:10:37 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:53914
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010975AbaJIPIJiYg7X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:08:09 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 09/10] MIPS: ralink: add rt3883 wmac clock
Date:   Thu,  9 Oct 2014 01:53:04 +0200
Message-Id: <1412812385-64820-10-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
References: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43145
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

Register the wireless mac clock on rti3883. This is required by the wifi driver.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/rt3883.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index b474ac2..58b5b9f 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -204,6 +204,7 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10000b00.spi", sys_rate);
 	ralink_clk_add("10000c00.uartlite", 40000000);
 	ralink_clk_add("10100000.ethernet", sys_rate);
+	ralink_clk_add("10180000.wmac", 40000000);
 }
 
 void __init ralink_of_remap(void)
-- 
1.7.10.4
