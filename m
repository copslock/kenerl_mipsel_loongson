Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2012 19:37:29 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42429 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825870Ab2KISh2B01wn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Nov 2012 19:37:28 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/6] MIPS: lantiq: unbreak devicetree init
Date:   Fri,  9 Nov 2012 19:36:18 +0100
Message-Id: <1352486183-22576-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 34922
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

The bootmem was incorrectly freed resulting in lots of dangling pointers.
Additionally we should use of_platform_populate() as the Documentaion tells us
to do so.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/prom.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 6cfd611..9f9e875 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -87,9 +87,6 @@ void __init device_tree_init(void)
 	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
 
 	unflatten_device_tree();
-
-	/* free the space reserved for the dt blob */
-	free_bootmem(base, size);
 }
 
 void __init prom_init(void)
@@ -119,7 +116,7 @@ int __init plat_of_setup(void)
 		sizeof(of_ids[0].compatible));
 	strncpy(of_ids[1].compatible, "simple-bus",
 		sizeof(of_ids[1].compatible));
-	return of_platform_bus_probe(NULL, of_ids, NULL);
+	return of_platform_populate(NULL, of_ids, NULL, NULL);
 }
 
 arch_initcall(plat_of_setup);
-- 
1.7.10.4
