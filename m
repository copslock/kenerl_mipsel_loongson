Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 21:15:12 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:34924 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994647AbeBQUOJxH-9G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 21:14:09 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 20:14:05 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018
 12:09:32 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     <netdev@vger.kernel.org>
CC:     Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v5 02/14] net: pch_gbe: Pull PHY GPIO handling out of Minnow code
Date:   Sat, 17 Feb 2018 12:10:25 -0800
Message-ID: <20180217201037.3006-3-paul.burton@mips.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180217201037.3006-1-paul.burton@mips.com>
References: <20180217201037.3006-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1518898445-452059-7116-95644-2
X-BESS-VER: 2018.2.1-r1802152107
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
X-archive-position: 62586
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

The MIPS Boston development board uses the Intel EG20T Platform
Controller Hub, including its gigabit ethernet controller, and requires
that its RTL8211E PHY be reset much like the Minnow platform. Pull the
PHY reset GPIO handling out of Minnow-specific code such that it can be
shared by later patches.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
---

Changes in v5:
- Name struct pch_gbe_privdata's platform_init pdata arg, per checkpatch.

Changes in v4: None
Changes in v3:
- Use adapter->pdata as arg to platform_init, to fix bisectability.

Changes in v2: None

 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h    |  5 +++-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 33 +++++++++++++++-------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
index 697e29dd4bd3..8ba9ced2d1fd 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
@@ -580,15 +580,18 @@ struct pch_gbe_hw_stats {
 
 /**
  * struct pch_gbe_privdata - PCI Device ID driver data
+ * @phy_reset_gpio:		PHY reset GPIO descriptor.
  * @phy_tx_clk_delay:		Bool, configure the PHY TX delay in software
  * @phy_disable_hibernate:	Bool, disable PHY hibernation
  * @platform_init:		Platform initialization callback, called from
  *				probe, prior to PHY initialization.
  */
 struct pch_gbe_privdata {
+	struct gpio_desc *phy_reset_gpio;
 	bool phy_tx_clk_delay;
 	bool phy_disable_hibernate;
-	int (*platform_init)(struct pci_dev *pdev);
+	int (*platform_init)(struct pci_dev *pdev,
+			     struct pch_gbe_privdata *pdata);
 };
 
 /**
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index d5c6f2e2d3a2..712ac2f7bb2c 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -360,6 +360,16 @@ static void pch_gbe_mac_mar_set(struct pch_gbe_hw *hw, u8 * addr, u32 index)
 	pch_gbe_wait_clr_bit(&hw->reg->ADDR_MASK, PCH_GBE_BUSY);
 }
 
+static void pch_gbe_phy_set_reset(struct pch_gbe_hw *hw, int value)
+{
+	struct pch_gbe_adapter *adapter = pch_gbe_hw_to_adapter(hw);
+
+	if (!adapter->pdata || !adapter->pdata->phy_reset_gpio)
+		return;
+
+	gpiod_set_value(adapter->pdata->phy_reset_gpio, value);
+}
+
 /**
  * pch_gbe_mac_reset_hw - Reset hardware
  * @hw:	Pointer to the HW structure
@@ -2592,7 +2602,14 @@ static int pch_gbe_probe(struct pci_dev *pdev,
 	adapter->hw.reg = pcim_iomap_table(pdev)[PCH_GBE_PCI_BAR];
 	adapter->pdata = (struct pch_gbe_privdata *)pci_id->driver_data;
 	if (adapter->pdata && adapter->pdata->platform_init)
-		adapter->pdata->platform_init(pdev);
+		adapter->pdata->platform_init(pdev, adapter->pdata);
+
+	if (adapter->pdata && adapter->pdata->phy_reset_gpio) {
+		pch_gbe_phy_set_reset(&adapter->hw, 1);
+		usleep_range(1250, 1500);
+		pch_gbe_phy_set_reset(&adapter->hw, 0);
+		usleep_range(1250, 1500);
+	}
 
 	adapter->ptp_pdev =
 		pci_get_domain_bus_and_slot(pci_domain_nr(adapter->pdev->bus),
@@ -2686,7 +2703,8 @@ static int pch_gbe_probe(struct pci_dev *pdev,
 /* The AR803X PHY on the MinnowBoard requires a physical pin to be toggled to
  * ensure it is awake for probe and init. Request the line and reset the PHY.
  */
-static int pch_gbe_minnow_platform_init(struct pci_dev *pdev)
+static int pch_gbe_minnow_platform_init(struct pci_dev *pdev,
+					struct pch_gbe_privdata *pdata)
 {
 	unsigned long flags = GPIOF_DIR_OUT | GPIOF_INIT_LOW |
 		GPIOF_EXPORT | GPIOF_ACTIVE_LOW;
@@ -2695,16 +2713,11 @@ static int pch_gbe_minnow_platform_init(struct pci_dev *pdev)
 
 	ret = devm_gpio_request_one(&pdev->dev, gpio, flags,
 				    "minnow_phy_reset");
-	if (ret) {
+	if (!ret)
+		pdata->phy_reset_gpio = gpio_to_desc(gpio);
+	else
 		dev_err(&pdev->dev,
 			"ERR: Can't request PHY reset GPIO line '%d'\n", gpio);
-		return ret;
-	}
-
-	gpio_set_value(gpio, 1);
-	usleep_range(1250, 1500);
-	gpio_set_value(gpio, 0);
-	usleep_range(1250, 1500);
 
 	return ret;
 }
-- 
2.16.1
