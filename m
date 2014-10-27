Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 22:38:35 +0100 (CET)
Received: from mail-oi0-f73.google.com ([209.85.218.73]:35442 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011440AbaJ0VieAndhB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 22:38:34 +0100
Received: by mail-oi0-f73.google.com with SMTP id e131so275091oig.4
        for <linux-mips@linux-mips.org>; Mon, 27 Oct 2014 14:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BsyGu7hnjSe2AxlQ8RQKWM/2G2fXjhQjifrSXTesV+0=;
        b=TcOE4CLVKiC8JhbP03IGJk9OIAMB4FkYIDvCv0TKxaMlCZend6zj7GZRXSGGyim9RQ
         b3dPGFAaDnghv2Fs546fE1mlWg8hXSM4aPclPq88BhOIg6SznozSYvHyZ8gGrhLsNzrr
         vYgZsGER2s2ZPP2rXjK6Rrnqkht5ci6A+Dj6X1UDm6O+s/N9sGPWU7I3N3br9RUEhiJs
         gnhMZg/3fPjQEZAFIJG8mzASjObKhLUyiKduof7/7JF8COEsEtXJj9kXiu0CArdtYojr
         uPJdM3mcE+04mJeDvBHQCmiw1Fot/wMEQjo/55BNCPbJHo8jrry5ojdXPtM77OSINVNY
         iqig==
X-Gm-Message-State: ALoCoQkTXvExYpCawG5Q3AjX05aGaKH6CyELcU7O6lISQX3CwUkDoONREukOUlgOnPnisJ35y+Go
X-Received: by 10.50.73.201 with SMTP id n9mr86061igv.8.1414445907523;
        Mon, 27 Oct 2014 14:38:27 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id k66si697945yho.7.2014.10.27.14.38.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 14:38:27 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 6QTSKQ7M.1; Mon, 27 Oct 2014 14:38:27 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id A342C220B9D; Mon, 27 Oct 2014 14:38:26 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Qais Yousef <qais.yousef@imgtec.com>, linux-mips@linux-mips.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 1/3] MIPS: Malta: Use __raw_{readl,writel} to access MSC registers
Date:   Mon, 27 Oct 2014 14:38:22 -0700
Message-Id: <1414445904-4781-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

No byte swapping is necessary for accesses to the MSC registers.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/mti-malta/malta-int.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 6ea4033..d1392f8 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -295,9 +295,10 @@ void __init arch_init_irq(void)
 		if (mips_revision_sconid == MIPS_REVISION_SCON_ROCIT) {
 			_msc01_biu_base = ioremap_nocache(MSC01_BIU_REG_BASE,
 						MSC01_BIU_ADDRSPACE_SZ);
-			gic_present = (readl(_msc01_biu_base + MSC01_SC_CFG_OFS) &
-					MSC01_SC_CFG_GICPRES_MSK) >>
-					MSC01_SC_CFG_GICPRES_SHF;
+			gic_present =
+			  (__raw_readl(_msc01_biu_base + MSC01_SC_CFG_OFS) &
+			   MSC01_SC_CFG_GICPRES_MSK) >>
+			  MSC01_SC_CFG_GICPRES_SHF;
 		}
 	}
 	if (gic_present)
@@ -335,8 +336,8 @@ void __init arch_init_irq(void)
 			 MIPS_GIC_IRQ_BASE);
 		if (!mips_cm_present()) {
 			/* Enable the GIC */
-			i = readl(_msc01_biu_base + MSC01_SC_CFG_OFS);
-			writel(i | (0x1 << MSC01_SC_CFG_GICENA_SHF),
+			i = __raw_readl(_msc01_biu_base + MSC01_SC_CFG_OFS);
+			__raw_writel(i | (0x1 << MSC01_SC_CFG_GICENA_SHF),
 				 _msc01_biu_base + MSC01_SC_CFG_OFS);
 			pr_debug("GIC Enabled\n");
 		}
-- 
2.1.0.rc2.206.gedb03e5
