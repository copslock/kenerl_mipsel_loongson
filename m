Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2018 11:13:19 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:44196 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992615AbeCAKNMX1unn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2018 11:13:12 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 01 Mar 2018 10:13:05 +0000
Received: from mredfearn-linux.mipstec.com (192.168.155.41) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 1 Mar 2018 01:58:25 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     <kvalo@codeaurora.org>
CC:     <zajec5@gmail.com>, <linux-wireless@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH v2] bcma: Prevent build of PCI host features in module
Date:   Thu, 1 Mar 2018 09:58:12 +0000
Message-ID: <1519898292-12155-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1519899183-637139-10612-305489-9
X-BESS-VER: 2018.2-r1802232356
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190552
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Attempting to build bcma.ko with BCMA_DRIVER_PCI_HOSTMODE=y results in
a build error due to use of symbols not exported from vmlinux:

ERROR: "pcibios_enable_device" [drivers/bcma/bcma.ko] undefined!
ERROR: "register_pci_controller" [drivers/bcma/bcma.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1

To prevent this, don't allow the host mode feature to be built if
CONFIG_BCMA=m

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

Changes in v2:
Rebase on v4.16-rc1

 drivers/bcma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
index ba8acca036df..cb0f1aad20b7 100644
--- a/drivers/bcma/Kconfig
+++ b/drivers/bcma/Kconfig
@@ -55,7 +55,7 @@ config BCMA_DRIVER_PCI
 
 config BCMA_DRIVER_PCI_HOSTMODE
 	bool "Driver for PCI core working in hostmode"
-	depends on MIPS && BCMA_DRIVER_PCI && PCI_DRIVERS_LEGACY
+	depends on MIPS && BCMA_DRIVER_PCI && PCI_DRIVERS_LEGACY && BCMA = y
 	help
 	  PCI core hostmode operation (external PCI bus).
 
-- 
2.7.4
