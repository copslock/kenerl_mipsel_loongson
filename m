Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 20:25:24 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:57800 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014440AbcADTYTMvC9F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 20:24:19 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id E810A280520;
        Mon,  4 Jan 2016 20:23:48 +0100 (CET)
Received: from localhost.localdomain (p548C87BE.dip0.t-ipconnect.de [84.140.135.190])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Mon,  4 Jan 2016 20:23:48 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 5/8] MIPS: ralink: fix invalid assignment of SoC type
Date:   Mon,  4 Jan 2016 20:23:58 +0100
Message-Id: <1451935441-40803-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
References: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50871
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

Commit 418d29c87061 ("MIPS: ralink: Unify SoC id handling") introduced
broken code. We obviously need to assign the value.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/rt288x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index 844f5cd..3c84166 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -119,5 +119,5 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	soc_info->mem_size_max = RT2880_MEM_SIZE_MAX;
 
 	rt2880_pinmux_data = rt2880_pinmux_data_act;
-	ralink_soc == RT2880_SOC;
+	ralink_soc = RT2880_SOC;
 }
-- 
1.7.10.4
