Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 22:38:39 +0100 (CET)
Received: from mail-bn1on0091.outbound.protection.outlook.com ([157.56.110.91]:52688
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013647AbaKMViXk7U-o (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Nov 2014 22:38:23 +0100
Received: from BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141) by
 BN1PR07MB008.namprd07.prod.outlook.com (10.255.225.38) with Microsoft SMTP
 Server (TLS) id 15.1.16.15; Thu, 13 Nov 2014 21:38:15 +0000
Received: from localhost.localdomain (2.165.41.20) by
 BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141) with Microsoft SMTP
 Server (TLS) id 15.1.16.15; Thu, 13 Nov 2014 21:38:13 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: [PATCH 3/3] USB: host: Introduce flag to enable use of 64-bit dma_mask for ehci-platform
Date:   Thu, 13 Nov 2014 22:36:30 +0100
Message-ID: <1415914590-31647-4-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2.165.41.20]
X-ClientProxiedBy: AM2PR03CA0029.eurprd03.prod.outlook.com (25.160.207.39) To
 BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141)
X-Microsoft-Antispam: UriScan:;UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB389;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB389;
X-Forefront-PRVS: 0394259C80
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(6009001)(189002)(199003)(120916001)(110136001)(4396001)(97736003)(76176999)(33646002)(102836001)(87286001)(50466002)(88136002)(122386002)(2171001)(87976001)(50226001)(19580395003)(89996001)(104166001)(50986999)(19580405001)(47776003)(92726001)(92566001)(64706001)(86362001)(93916002)(48376002)(95666004)(42186005)(40100003)(106356001)(66066001)(21056001)(101416001)(20776003)(62966003)(229853001)(77096003)(77156002)(36756003)(107046002)(31966008)(46102003)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR07MB389;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB389;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB008;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

ehci-octeon driver used a 64-bit dma_mask. With removal of ehci-octeon
and usage of ehci-platform ehci dma_mask is now limited to 32 bits
(coerced in ehci_platform_probe).

Provide a flag in ehci platform data to allow use of 64 bits for
dma_mask.

Cc: David Daney <david.daney@cavium.com>
Cc: Alex Smith <alex.smith@imgtec.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-platform.c |    4 +---
 drivers/usb/host/ehci-platform.c          |    3 ++-
 include/linux/usb/ehci_pdriver.h          |    1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index eea60b6..12410a2 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -310,6 +310,7 @@ static struct usb_ehci_pdata octeon_ehci_pdata = {
 #ifdef __BIG_ENDIAN
 	.big_endian_mmio	= 1,
 #endif
+	.dma_mask_64	= 1,
 	.power_on	= octeon_ehci_power_on,
 	.power_off	= octeon_ehci_power_off,
 };
@@ -331,8 +332,6 @@ static void __init octeon_ehci_hw_start(struct device *dev)
 	octeon2_usb_clocks_stop();
 }
 
-static u64 octeon_ehci_dma_mask = DMA_BIT_MASK(64);
-
 static int __init octeon_ehci_device_init(void)
 {
 	struct platform_device *pd;
@@ -347,7 +346,6 @@ static int __init octeon_ehci_device_init(void)
 	if (!pd)
 		return 0;
 
-	pd->dev.dma_mask = &octeon_ehci_dma_mask;
 	pd->dev.platform_data = &octeon_ehci_pdata;
 	octeon_ehci_hw_start(&pd->dev);
 
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 2da18ea..6df808b 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -155,7 +155,8 @@ static int ehci_platform_probe(struct platform_device *dev)
 	if (!pdata)
 		pdata = &ehci_platform_defaults;
 
-	err = dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
+	err = dma_coerce_mask_and_coherent(&dev->dev,
+		pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
 	if (err)
 		return err;
 
diff --git a/include/linux/usb/ehci_pdriver.h b/include/linux/usb/ehci_pdriver.h
index 7eb4dcd..f69529e 100644
--- a/include/linux/usb/ehci_pdriver.h
+++ b/include/linux/usb/ehci_pdriver.h
@@ -45,6 +45,7 @@ struct usb_ehci_pdata {
 	unsigned	big_endian_desc:1;
 	unsigned	big_endian_mmio:1;
 	unsigned	no_io_watchdog:1;
+	unsigned	dma_mask_64:1;
 
 	/* Turn on all power and clocks */
 	int (*power_on)(struct platform_device *pdev);
-- 
1.7.9.5
