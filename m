Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 14:30:46 +0100 (CET)
Received: from mail-bn1on0066.outbound.protection.outlook.com ([157.56.110.66]:29472
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007135AbaLONapGFdzt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Dec 2014 14:30:45 +0100
Received: from BLUPR07MB388.namprd07.prod.outlook.com (10.141.27.25) by
 BLUPR07MB627.namprd07.prod.outlook.com (10.141.207.145) with Microsoft SMTP
 Server (TLS) id 15.1.31.17; Mon, 15 Dec 2014 13:30:37 +0000
Received: from alberich (2.165.246.116) by
 BLUPR07MB388.namprd07.prod.outlook.com (10.141.27.25) with Microsoft SMTP
 Server (TLS) id 15.1.31.17; Mon, 15 Dec 2014 13:30:33 +0000
Date:   Mon, 15 Dec 2014 14:30:19 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Greg KH <greg@kroah.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>
Subject: [PATCH 2/2 resend] USB: host: Introduce flag to enable use of 64-bit
 dma_mask for ehci-platform
Message-ID: <20141215133019.GC20109@alberich>
References: <20141215132628.GA20109@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20141215132628.GA20109@alberich>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.165.246.116]
X-ClientProxiedBy: AM2PR02CA0028.eurprd02.prod.outlook.com (25.160.28.166) To
 BLUPR07MB388.namprd07.prod.outlook.com (10.141.27.25)
X-Microsoft-Antispam: UriScan:;UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BLUPR07MB388;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601003);SRVR:BLUPR07MB388;
X-Forefront-PRVS: 04267075BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(199003)(189002)(23676002)(107046002)(77156002)(77096005)(46102003)(105586002)(83506001)(64706001)(110136001)(229853001)(19580405001)(19580395003)(120916001)(66066001)(68736005)(99396003)(31966008)(97736003)(122386002)(42186005)(62966003)(86362001)(50466002)(87976001)(20776003)(106356001)(4396001)(47776003)(101416001)(54356999)(21056001)(33656002)(76176999)(50986999)(92566001)(40100003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR07MB388;H:alberich;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BLUPR07MB388;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BLUPR07MB627;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44670
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
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
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
index 5b8533f..37abbe2 100644
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
