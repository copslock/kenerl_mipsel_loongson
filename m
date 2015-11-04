Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 11:52:05 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37392 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011195AbbKDKuemTP0w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Nov 2015 11:50:34 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 3C00E280351;
        Wed,  4 Nov 2015 11:48:44 +0100 (CET)
Received: from localhost.localdomain (p548C90D8.dip0.t-ipconnect.de [84.140.144.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  4 Nov 2015 11:48:44 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 7/9] arch: mips: ralink: dont set pm_power_off
Date:   Wed,  4 Nov 2015 11:50:12 +0100
Message-Id: <1446634214-11564-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
References: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49833
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

Setting pm_power_off is apprently wrong and makes drivers such as
gpio-poweroff not work.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/reset.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/ralink/reset.c b/arch/mips/ralink/reset.c
index 55c7ec5..ee26d45 100644
--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -98,7 +98,6 @@ static int __init mips_reboot_setup(void)
 {
 	_machine_restart = ralink_restart;
 	_machine_halt = ralink_halt;
-	pm_power_off = ralink_halt;
 
 	return 0;
 }
-- 
1.7.10.4
