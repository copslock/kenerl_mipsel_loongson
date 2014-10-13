Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 11:07:24 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:52775
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011486AbaJPJHXEREr7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 11:07:23 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: disabling CM regions deadlocks mt7621
Date:   Mon, 13 Oct 2014 13:16:18 +0200
Message-Id: <1413198978-61926-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43298
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

While updating the mt7621 code to make use of the mips-cm i had to apply the
following patch to get the unit booting. With this patch applied the SoC boots
fine with and all 4 cores work.

The MT7621 has a broken iocu so i guess this might be related ? could someone that
actually knows what those registers do enlighten me please :)

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/kernel/mips-cm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index f76f7a0..38835c2 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -105,6 +105,7 @@ int mips_cm_probe(void)
 	write_gcr_base(base_reg);
 
 	/* disable CM regions */
+	/*
 	write_gcr_reg0_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
 	write_gcr_reg0_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
 	write_gcr_reg1_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
@@ -113,7 +114,7 @@ int mips_cm_probe(void)
 	write_gcr_reg2_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
 	write_gcr_reg3_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
 	write_gcr_reg3_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
-
+	*/
 	/* probe for an L2-only sync region */
 	mips_cm_probe_l2sync();
 
-- 
1.7.10.4
