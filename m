Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 10:55:15 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:46633 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491944AbZGJIyi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 10:54:38 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.200])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A8sWeW024175
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 01:54:32 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 01:54:31 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A8sVMi021824;
	Fri, 10 Jul 2009 01:54:31 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 3/3] Avoid accessing GCMP registers when they are not present
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 01:54:25 -0700
Message-ID: <20090710085425.25918.68710.stgit@linux-raghu>
In-Reply-To: <20090710085338.25918.37597.stgit@linux-raghu>
References: <20090710085338.25918.37597.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 08:54:31.0994 (UTC) FILETIME=[0A89A9A0:01CA013C]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23705
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
index 377a925..4c3fca1 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -411,6 +411,11 @@ static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
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
 
@@ -479,9 +484,14 @@ void __init arch_init_irq(void)
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
