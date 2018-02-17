Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 21:16:03 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:49480 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994653AbeBQUOSVLUhG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 21:14:18 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 20:14:13 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018
 12:09:34 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     <netdev@vger.kernel.org>
CC:     Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v5 04/14] net: pch_gbe: Add device tree support
Date:   Sat, 17 Feb 2018 12:10:27 -0800
Message-ID: <20180217201037.3006-5-paul.burton@mips.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180217201037.3006-1-paul.burton@mips.com>
References: <20180217201037.3006-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1518898452-298554-1111-67022-4
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190134
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Introduce support for retrieving the PHY reset GPIO from device tree,
which will be used on the MIPS Boston development board. This requires
support for probe deferral in order to work correctly, since the order
of device probe is not guaranteed & typically the EG20T GPIO controller
device will be probed after the ethernet MAC.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
---

Changes in v5: None
Changes in v4:
- Use ERR_CAST(), thanks kbuild test robot/Fengguang!

Changes in v3: None
Changes in v2:
- Tidy up handling of parsing private data, drop err_out.

 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 31 +++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 712ac2f7bb2c..11e8ced4a0f4 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -23,6 +23,8 @@
 #include <linux/net_tstamp.h>
 #include <linux/ptp_classify.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of_gpio.h>
 
 #define DRV_VERSION     "1.01"
 const char pch_driver_version[] = DRV_VERSION;
@@ -2556,13 +2558,40 @@ static void pch_gbe_remove(struct pci_dev *pdev)
 	free_netdev(netdev);
 }
 
+static struct pch_gbe_privdata *
+pch_gbe_get_priv(struct pci_dev *pdev, const struct pci_device_id *pci_id)
+{
+	struct pch_gbe_privdata *pdata;
+	struct gpio_desc *gpio;
+
+	if (!IS_ENABLED(CONFIG_OF))
+		return (struct pch_gbe_privdata *)pci_id->driver_data;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	gpio = devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_ASIS);
+	if (!IS_ERR(gpio))
+		pdata->phy_reset_gpio = gpio;
+	else if (PTR_ERR(gpio) != -ENOENT)
+		return ERR_CAST(gpio);
+
+	return pdata;
+}
+
 static int pch_gbe_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *pci_id)
 {
 	struct net_device *netdev;
 	struct pch_gbe_adapter *adapter;
+	struct pch_gbe_privdata *pdata;
 	int ret;
 
+	pdata = pch_gbe_get_priv(pdev, pci_id);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
 	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ret;
@@ -2600,7 +2629,7 @@ static int pch_gbe_probe(struct pci_dev *pdev,
 	adapter->pdev = pdev;
 	adapter->hw.back = adapter;
 	adapter->hw.reg = pcim_iomap_table(pdev)[PCH_GBE_PCI_BAR];
-	adapter->pdata = (struct pch_gbe_privdata *)pci_id->driver_data;
+	adapter->pdata = pdata;
 	if (adapter->pdata && adapter->pdata->platform_init)
 		adapter->pdata->platform_init(pdev, adapter->pdata);
 
-- 
2.16.1
