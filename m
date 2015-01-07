Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:22:15 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:2763 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010208AbbAGLVZbfgOd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 12:21:25 +0100
X-IronPort-AV: E=Sophos;i="5.07,714,1413270000"; 
   d="scan'208";a="54466604"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 07 Jan 2015 05:25:15 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 7 Jan 2015 03:21:34 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 7 Jan 2015 03:21:34 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 29A4740FE5;    Wed,  7 Jan 2015 03:20:31 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 03/17] MIPS: Netlogic: Fix cop0 prid check in AHCI init
Date:   Wed, 7 Jan 2015 16:58:24 +0530
Message-ID: <1420630118-17198-4-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

PRID register should be masked with IMP_MASK to get processor ID.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlp/ahci-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/netlogic/xlp/ahci-init.c b/arch/mips/netlogic/xlp/ahci-init.c
index a9d0fae..92be1a3 100644
--- a/arch/mips/netlogic/xlp/ahci-init.c
+++ b/arch/mips/netlogic/xlp/ahci-init.c
@@ -151,7 +151,7 @@ static void nlm_sata_firmware_init(int node)
 static int __init nlm_ahci_init(void)
 {
 	int node = 0;
-	int chip = read_c0_prid() & PRID_REV_MASK;
+	int chip = read_c0_prid() & PRID_IMP_MASK;
 
 	if (chip == PRID_IMP_NETLOGIC_XLP3XX)
 		nlm_sata_firmware_init(node);
-- 
1.9.1
