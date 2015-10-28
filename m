Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:42:14 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37647 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011840AbbJ1WiAhLsXO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:38:00 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id 2ECA6100037;
        Wed, 28 Oct 2015 23:38:00 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 15/15] MIPS: lantiq: fix check for return value of request_mem_region()
Date:   Wed, 28 Oct 2015 23:37:44 +0100
Message-Id: <1446071865-21936-16-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49757
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

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

request_mem_region() returns a pointer and not an integer with an error
value. A check for "< 0" on a pointer will cause problems, replace it
with not null checks instead. This was found with sparse.

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/lantiq/irq.c          |  8 ++++----
 arch/mips/lantiq/xway/reset.c   |  2 +-
 arch/mips/lantiq/xway/sysctrl.c | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 2c218c3..2e7f60c 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -369,8 +369,8 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 		if (of_address_to_resource(node, i, &res))
 			panic("Failed to get icu memory range");
 
-		if (request_mem_region(res.start, resource_size(&res),
-					res.name) < 0)
+		if (!request_mem_region(res.start, resource_size(&res),
+					res.name))
 			pr_err("Failed to request icu memory");
 
 		ltq_icu_membase[i] = ioremap_nocache(res.start,
@@ -449,8 +449,8 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 		if (ret != exin_avail)
 			panic("failed to load external irq resources");
 
-		if (request_mem_region(res.start, resource_size(&res),
-							res.name) < 0)
+		if (!request_mem_region(res.start, resource_size(&res),
+							res.name))
 			pr_err("Failed to request eiu memory");
 
 		ltq_eiu_membase = ioremap_nocache(res.start,
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 1e23cee..55c278f 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -287,7 +287,7 @@ static int __init mips_reboot_setup(void)
 	if (of_address_to_resource(ltq_rcu_np, 0, &res))
 		panic("Failed to get rcu memory range");
 
-	if (request_mem_region(res.start, resource_size(&res), res.name) < 0)
+	if (!request_mem_region(res.start, resource_size(&res), res.name))
 		pr_err("Failed to request rcu memory");
 
 	ltq_rcu_membase = ioremap_nocache(res.start, resource_size(&res));
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 945f867..7ddae3e 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -421,12 +421,12 @@ void __init ltq_soc_init(void)
 			of_address_to_resource(np_ebu, 0, &res_ebu))
 		panic("Failed to get core resources");
 
-	if ((request_mem_region(res_pmu.start, resource_size(&res_pmu),
-				res_pmu.name) < 0) ||
-		(request_mem_region(res_cgu.start, resource_size(&res_cgu),
-				res_cgu.name) < 0) ||
-		(request_mem_region(res_ebu.start, resource_size(&res_ebu),
-				res_ebu.name) < 0))
+	if (!request_mem_region(res_pmu.start, resource_size(&res_pmu),
+				res_pmu.name) ||
+		!request_mem_region(res_cgu.start, resource_size(&res_cgu),
+				res_cgu.name) ||
+		!request_mem_region(res_ebu.start, resource_size(&res_ebu),
+				res_ebu.name))
 		pr_err("Failed to request core resources");
 
 	pmu_membase = ioremap_nocache(res_pmu.start, resource_size(&res_pmu));
-- 
2.6.1
