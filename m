Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 13:14:25 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:40377 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006567AbbKDMOX2YAlc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Nov 2015 13:14:23 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id F15AF28098D;
        Wed,  4 Nov 2015 13:12:32 +0100 (CET)
Received: from localhost.localdomain (p548C90D8.dip0.t-ipconnect.de [84.140.144.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  4 Nov 2015 13:12:32 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 1/4] arch: mips: lantiq: return correct value for fpi clock on ar9
Date:   Wed,  4 Nov 2015 13:14:13 +0100
Message-Id: <1446639256-22526-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49837
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

Some configurations of AR9 reported the incorrect speed for the fpi bus.

Signed-off-by: Ben Mulvihill <ben.mulvihill@gmail.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/clk.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/xway/clk.c b/arch/mips/lantiq/xway/clk.c
index 8750dc0..2ebe062 100644
--- a/arch/mips/lantiq/xway/clk.c
+++ b/arch/mips/lantiq/xway/clk.c
@@ -87,8 +87,9 @@ unsigned long ltq_ar9_fpi_hz(void)
 	unsigned long sys = ltq_ar9_sys_hz();
 
 	if (ltq_cgu_r32(CGU_SYS) & BIT(0))
-		return sys;
-	return sys >> 1;
+		return sys / 3;
+	else
+		return sys / 2;
 }
 
 unsigned long ltq_ar9_cpu_hz(void)
-- 
1.7.10.4
