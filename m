Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 19:33:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3863 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993459AbdFERcvZhqAR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 19:32:51 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E9ACCBB0C0F;
        Mon,  5 Jun 2017 18:32:38 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Jun 2017 18:32:42
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <netdev@vger.kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Eric Dumazet <edumazet@google.com>,
        Jarod Wilson <jarod@redhat.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v4 2/7] net: pch_gbe: Pull PHY GPIO handling out of Minnow code
Date:   Mon, 5 Jun 2017 10:31:31 -0700
Message-ID: <20170605173136.10795-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170605173136.10795-1-paul.burton@imgtec.com>
References: <20170602234042.22782-1-paul.burton@imgtec.com>
 <20170605173136.10795-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58216
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

The MIPS Boston development board uses the Intel EG20T Platform
Controller Hub, including its gigabit ethernet controller, and requires
that its RTL8211E PHY be reset much like the Minnow platform. Pull the
PHY reset GPIO handling out of Minnow-specific code such that it can be
shared by later patches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jarod Wilson <jarod@redhat.com>
Cc: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
---

Changes in v4: None

Changes in v3:
- Use adapter->pdata as arg to platform_init, to fix bisectability.

Changes in v2: None

 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h    |  4 ++-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 33 +++++++++++++++-------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
index 8d710a3b4db0..de1dd08050f4 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
@@ -580,15 +580,17 @@ struct pch_gbe_hw_stats {
 
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
+	int (*platform_init)(struct pci_dev *, struct pch_gbe_privdata *);
 };
 
 /**
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index d38198718005..cb9b904786e4 100644
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
@@ -2601,7 +2611,14 @@ static int pch_gbe_probe(struct pci_dev *pdev,
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
 
 	adapter->ptp_pdev = pci_get_bus_and_slot(adapter->pdev->bus->number,
 					       PCI_DEVFN(12, 4));
@@ -2694,7 +2711,8 @@ static int pch_gbe_probe(struct pci_dev *pdev,
 /* The AR803X PHY on the MinnowBoard requires a physical pin to be toggled to
  * ensure it is awake for probe and init. Request the line and reset the PHY.
  */
-static int pch_gbe_minnow_platform_init(struct pci_dev *pdev)
+static int pch_gbe_minnow_platform_init(struct pci_dev *pdev,
+					struct pch_gbe_privdata *pdata)
 {
 	unsigned long flags = GPIOF_DIR_OUT | GPIOF_INIT_LOW |
 		GPIOF_EXPORT | GPIOF_ACTIVE_LOW;
@@ -2703,16 +2721,11 @@ static int pch_gbe_minnow_platform_init(struct pci_dev *pdev)
 
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
2.13.0
