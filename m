Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:30:01 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48787 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008098AbbK3Q2MZapNe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:28:12 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 0B8C9CCEC8CB1;
        Mon, 30 Nov 2015 16:28:04 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 30 Nov 2015 16:28:06 +0000
Received: from localhost (10.100.200.236) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Nov
 2015 16:28:05 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 24/28] net: pch_gbe: add device tree support
Date:   Mon, 30 Nov 2015 16:21:49 +0000
Message-ID: <1448900513-20856-25-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.236]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50205
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

 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 33 +++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 824ff9e..f2a9a38 100644
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
@@ -2594,13 +2596,41 @@ static void pch_gbe_remove(struct pci_dev *pdev)
 	free_netdev(netdev);
 }
 
+static int pch_gbe_parse_dt(struct pci_dev *pdev,
+			    struct pch_gbe_privdata **pdata)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct gpio_desc *gpio;
+
+	if (!config_enabled(CONFIG_OF) || !np)
+		return 0;
+
+	if (!*pdata)
+		*pdata = devm_kzalloc(&pdev->dev, sizeof(**pdata), GFP_KERNEL);
+	if (!*pdata)
+		return -ENOMEM;
+
+	gpio = devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_ASIS);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+
+	(*pdata)->phy_reset_gpio = gpio;
+	return 0;
+}
+
 static int pch_gbe_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *pci_id)
 {
 	struct net_device *netdev;
 	struct pch_gbe_adapter *adapter;
+	struct pch_gbe_privdata *pdata;
 	int ret;
 
+	pdata = (struct pch_gbe_privdata *)pci_id->driver_data;
+	ret = pch_gbe_parse_dt(pdev, &pdata);
+	if (ret)
+		goto err_out;
+
 	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ret;
@@ -2638,7 +2668,7 @@ static int pch_gbe_probe(struct pci_dev *pdev,
 	adapter->pdev = pdev;
 	adapter->hw.back = adapter;
 	adapter->hw.reg = pcim_iomap_table(pdev)[PCH_GBE_PCI_BAR];
-	adapter->pdata = (struct pch_gbe_privdata *)pci_id->driver_data;
+	adapter->pdata = pdata;
 	if (adapter->pdata && adapter->pdata->platform_init)
 		adapter->pdata->platform_init(pdev, pdata);
 
@@ -2729,6 +2759,7 @@ err_free_adapter:
 	pch_gbe_hal_phy_hw_reset(&adapter->hw);
 err_free_netdev:
 	free_netdev(netdev);
+err_out:
 	return ret;
 }
 
-- 
2.6.2
