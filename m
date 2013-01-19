Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jan 2013 10:57:08 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42354 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833241Ab3ASJ5E2Uaqa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Jan 2013 10:57:04 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/5] MIPS: lantiq: trivial typo fix
Date:   Sat, 19 Jan 2013 10:54:23 +0100
Message-Id: <1358589267-11514-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35495
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
Return-Path: <linux-mips-bounce@linux-mips.org>

"nodes" is written with a single "s"

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/sysctrl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 3925e66..1aaa726 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -305,7 +305,7 @@ void __init ltq_soc_init(void)
 
 	/* check if all the core register ranges are available */
 	if (!np_pmu || !np_cgu || !np_ebu)
-		panic("Failed to load core nodess from devicetree");
+		panic("Failed to load core nodes from devicetree");
 
 	if (of_address_to_resource(np_pmu, 0, &res_pmu) ||
 			of_address_to_resource(np_cgu, 0, &res_cgu) ||
-- 
1.7.10.4
