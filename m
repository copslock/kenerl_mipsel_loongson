Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 04:51:40 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:39589 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492014AbZGBCtJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Jul 2009 04:49:09 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n622hQJc016361
	for <linux-mips@linux-mips.org>; Wed, 1 Jul 2009 19:43:26 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 19:43:26 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n622hQWL006016;
	Wed, 1 Jul 2009 19:43:26 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 13/15] Avoid accessing GCMP registers when they are not present
To:	linux-mips@linux-mips.org
Cc:	chris@mips.com
Date:	Wed, 01 Jul 2009 19:43:00 -0700
Message-ID: <20090702024300.23268.72873.stgit@linux-raghu>
In-Reply-To: <20090702023938.23268.65453.stgit@linux-raghu>
References: <20090702023938.23268.65453.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2009 02:43:26.0365 (UTC) FILETIME=[DFE24CD0:01C9FABE]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Jaidev Patwardhan <jaidev@mips.com>

Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/mti-malta/malta-int.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 92e3b56..63e7161 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -413,6 +413,11 @@ static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
  */
 int __init gcmp_probe(unsigned long addr, unsigned long size)
 {
+	if (mips_revision_sconid != MIPS_REVISION_SCON_ROCIT) {
+		gcmp_present = 0;
+		return gcmp_present;
+	}
+
 	if (gcmp_present >= 0)
 		return gcmp_present;
 
@@ -481,9 +486,14 @@ void __init arch_init_irq(void)
 		GCMPGCB(GICBA) = GIC_BASE_ADDR | GCMP_GCB_GICBA_EN_MSK;
 		gic_present = 1;
 	} else {
-		_msc01_biu_base = (unsigned long) ioremap_nocache(MSC01_BIU_REG_BASE, MSC01_BIU_ADDRSPACE_SZ);
-		gic_present = (REG(_msc01_biu_base, MSC01_SC_CFG) &
-		MSC01_SC_CFG_GICPRES_MSK) >> MSC01_SC_CFG_GICPRES_SHF;
+		if (mips_revision_sconid == MIPS_REVISION_SCON_ROCIT) {
+			_msc01_biu_base = (unsigned long)
+					ioremap_nocache(MSC01_BIU_REG_BASE,
+						MSC01_BIU_ADDRSPACE_SZ);
+			gic_present = (REG(_msc01_biu_base, MSC01_SC_CFG) &
+					MSC01_SC_CFG_GICPRES_MSK) >>
+					MSC01_SC_CFG_GICPRES_SHF;
+		}
 	}
 	if (gic_present)
 		pr_debug("GIC present\n");
