Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 13:04:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32767 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012217AbcBCMEXxCWVM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 13:04:23 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 3C71D79541927;
        Wed,  3 Feb 2016 12:04:15 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 12:04:17 +0000
Received: from localhost (10.100.200.105) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 12:04:16 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/6] net: pch_gbe: Add device tree support
Date:   Wed, 3 Feb 2016 12:02:43 +0000
Message-ID: <1454500964-6256-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454500964-6256-1-git-send-email-paul.burton@imgtec.com>
References: <1454500964-6256-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.105]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2:
- Tidy up handling of parsing private data, drop err_out.

 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 824ff9e..00ef83c 100644
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
@@ -2594,13 +2596,39 @@ static void pch_gbe_remove(struct pci_dev *pdev)
 	free_netdev(netdev);
 }
 
+static struct pch_gbe_privdata *
+pch_gbe_get_priv(struct pci_dev *pdev, const struct pci_device_id *pci_id)
+{
+	struct pch_gbe_privdata *pdata;
+	struct gpio_desc *gpio;
+
+	if (!config_enabled(CONFIG_OF))
+		return (struct pch_gbe_privdata *)pci_id->driver_data;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	gpio = devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_ASIS);
+	if (IS_ERR(gpio))
+		return ERR_PTR(PTR_ERR(gpio));
+	pdata->phy_reset_gpio = gpio;
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
@@ -2638,7 +2666,7 @@ static int pch_gbe_probe(struct pci_dev *pdev,
 	adapter->pdev = pdev;
 	adapter->hw.back = adapter;
 	adapter->hw.reg = pcim_iomap_table(pdev)[PCH_GBE_PCI_BAR];
-	adapter->pdata = (struct pch_gbe_privdata *)pci_id->driver_data;
+	adapter->pdata = pdata;
 	if (adapter->pdata && adapter->pdata->platform_init)
 		adapter->pdata->platform_init(pdev, pdata);
 
-- 
2.7.0
