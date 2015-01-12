Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 16:06:17 +0100 (CET)
Received: from mail-bl2on0055.outbound.protection.outlook.com ([65.55.169.55]:21328
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011228AbbALPGPlx8X7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Jan 2015 16:06:15 +0100
Received: from alberich (2.165.201.17) by
 BN1PR07MB392.namprd07.prod.outlook.com (10.141.58.151) with Microsoft SMTP
 Server (TLS) id 15.1.49.12; Mon, 12 Jan 2015 15:06:05 +0000
Date:   Mon, 12 Jan 2015 16:05:52 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH resend v3] USB: host: Introduce flag to enable use of 64-bit
 dma_mask for ehci-platform
Message-ID: <20150112150552.GA21637@alberich>
References: <20141215132628.GA20109@alberich>
 <20150106124644.GA4194@alberich>
 <20150106125015.GC4194@alberich>
 <20150109203027.GA5772@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20150109203027.GA5772@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.165.201.17]
X-ClientProxiedBy: AM3PR07CA0037.eurprd07.prod.outlook.com (10.141.45.165) To
 BN1PR07MB392.namprd07.prod.outlook.com (10.141.58.151)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-DmarcAction-Test: None
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(3005003);SRVR:BN1PR07MB392;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:(601004);SRVR:BN1PR07MB392;
X-Forefront-PRVS: 0454444834
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(164054003)(199003)(189002)(2950100001)(47776003)(64706001)(101416001)(229853001)(83506001)(19580395003)(77156002)(87976001)(62966003)(110136001)(23676002)(40100003)(92566002)(122386002)(106356001)(50466002)(33716001)(86362001)(50986999)(66066001)(33656002)(19580405001)(97736003)(76176999)(54356999)(93886004)(105586002)(46102003)(68736005)(77096005)(42186005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR07MB392;H:alberich;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB392;
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2015 15:06:05.4428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR07MB392
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45089
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
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 arch/mips/cavium-octeon/octeon-platform.c |    4 +---
 drivers/usb/host/ehci-platform.c          |    3 ++-
 include/linux/usb/ehci_pdriver.h          |    1 +
 3 files changed, 4 insertions(+), 4 deletions(-)


Patch rebased on usb-testing as of v3.19-rc2-21-g1d97869.


Thanks,

Andreas


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
index 28aae64..63f2622 100644
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
index 6287b39..db0431b 100644
--- a/include/linux/usb/ehci_pdriver.h
+++ b/include/linux/usb/ehci_pdriver.h
@@ -48,6 +48,7 @@ struct usb_ehci_pdata {
 	unsigned	big_endian_mmio:1;
 	unsigned	no_io_watchdog:1;
 	unsigned	reset_on_resume:1;
+	unsigned	dma_mask_64:1;
 
 	/* Turn on all power and clocks */
 	int (*power_on)(struct platform_device *pdev);
-- 
1.7.9.5
