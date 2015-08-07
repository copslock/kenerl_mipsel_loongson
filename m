Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 02:34:08 +0200 (CEST)
Received: from mail-io0-f178.google.com ([209.85.223.178]:36022 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012993AbbHGAdbOJ6Pe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 02:33:31 +0200
Received: by ioeg141 with SMTP id g141so97682784ioe.3
        for <linux-mips@linux-mips.org>; Thu, 06 Aug 2015 17:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mu2CxHP1+cnW3MbWy+sZxpXxiTCxe8bbjzYHWq/pvgo=;
        b=v0DFpDYrRuxUnAyRl6kjOfD0yiWICQbI/25Ybz+YkmdMMuGM/fHzyqiOooJhyVpwOP
         KaBGUp5SEvitJeyEt5A8i9VW71Wr0OxyWbmnRcgGbDYTeeNgnjgAo3PoN4Ay0kKHJxtL
         STa2NOSI64MI/bvPliPeLlou3PDlwTYv7V4Vn+xItQ7wWwf9Du3fv4UbFr4acyRtnCAi
         QHRKF6x/0PLj99KYB3sc82CZXcV8xVRs2yLPnjOAEPuPaWOlTrZABtro6cVanQdtBW1V
         o7gdARBFlhTVT1NsmNovhacUJ0r7LL5F3f2u+4PElAYTXB3EllXOnLahaaRYLXhrNvxH
         clJA==
X-Received: by 10.107.155.12 with SMTP id d12mr5941175ioe.131.1438907605296;
        Thu, 06 Aug 2015 17:33:25 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.gmail.com with ESMTPSA id 90sm5723427iog.35.2015.08.06.17.33.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 17:33:23 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id t770XLic029693;
        Thu, 6 Aug 2015 17:33:21 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id t770XLXJ029692;
        Thu, 6 Aug 2015 17:33:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Robert Richter <rrichter@cavium.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
Date:   Thu,  6 Aug 2015 17:33:10 -0700
Message-Id: <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Find out which PHYs belong to which BGX instance in the ACPI way.

Set the MAC address of the device as provided by ACPI tables. This is
similar to the implementation for devicetree in
of_get_mac_address(). The table is searched for the device property
entries "mac-address", "local-mac-address" and "address" in that
order. The address is provided in a u64 variable and must contain a
valid 6 bytes-len mac addr.

Based on code from: Narinder Dhillon <ndhillon@cavium.com>
                    Tomasz Nowicki <tomasz.nowicki@linaro.org>
                    Robert Richter <rrichter@cavium.com>

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 137 +++++++++++++++++++++-
 1 file changed, 135 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 615b2af..2056583 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -6,6 +6,7 @@
  * as published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
@@ -26,7 +27,7 @@
 struct lmac {
 	struct bgx		*bgx;
 	int			dmac;
-	unsigned char		mac[ETH_ALEN];
+	u8			mac[ETH_ALEN];
 	bool			link_up;
 	int			lmacid; /* ID within BGX */
 	int			lmacid_bd; /* ID on board */
@@ -835,6 +836,133 @@ static void bgx_get_qlm_mode(struct bgx *bgx)
 	}
 }
 
+#ifdef CONFIG_ACPI
+
+static int bgx_match_phy_id(struct device *dev, void *data)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	u32 *phy_id = data;
+
+	if (phydev->addr == *phy_id)
+		return 1;
+
+	return 0;
+}
+
+static const char * const addr_propnames[] = {
+	"mac-address",
+	"local-mac-address",
+	"address",
+};
+
+static int acpi_get_mac_address(struct acpi_device *adev, u8 *dst)
+{
+	const union acpi_object *prop;
+	u64 mac_val;
+	u8 mac[ETH_ALEN];
+	int i, j;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(addr_propnames); i++) {
+		ret = acpi_dev_get_property(adev, addr_propnames[i],
+					    ACPI_TYPE_INTEGER, &prop);
+		if (ret)
+			continue;
+
+		mac_val = prop->integer.value;
+
+		if (mac_val & (~0ULL << 48))
+			continue;	/* more than 6 bytes */
+
+		for (j = 0; j < ARRAY_SIZE(mac); j++)
+			mac[j] = (u8)(mac_val >> (8 * j));
+		if (!is_valid_ether_addr(mac))
+			continue;
+
+		memcpy(dst, mac, ETH_ALEN);
+
+		return 0;
+	}
+
+	return ret ? ret : -EINVAL;
+}
+
+static acpi_status bgx_acpi_register_phy(acpi_handle handle,
+					 u32 lvl, void *context, void **rv)
+{
+	struct acpi_reference_args args;
+	const union acpi_object *prop;
+	struct bgx *bgx = context;
+	struct acpi_device *adev;
+	struct device *phy_dev;
+	u32 phy_id;
+
+	if (acpi_bus_get_device(handle, &adev))
+		goto out;
+
+	SET_NETDEV_DEV(&bgx->lmac[bgx->lmac_count].netdev, &bgx->pdev->dev);
+
+	acpi_get_mac_address(adev, bgx->lmac[bgx->lmac_count].mac);
+
+	bgx->lmac[bgx->lmac_count].lmacid = bgx->lmac_count;
+
+	if (acpi_dev_get_property_reference(adev, "phy-handle", 0, &args))
+		goto out;
+
+	if (acpi_dev_get_property(args.adev, "phy-channel", ACPI_TYPE_INTEGER, &prop))
+		goto out;
+
+	phy_id = prop->integer.value;
+
+	phy_dev = bus_find_device(&mdio_bus_type, NULL, (void *)&phy_id,
+				  bgx_match_phy_id);
+	if (!phy_dev)
+		goto out;
+
+	bgx->lmac[bgx->lmac_count].phydev = to_phy_device(phy_dev);
+out:
+	bgx->lmac_count++;
+	return AE_OK;
+}
+
+static acpi_status bgx_acpi_match_id(acpi_handle handle, u32 lvl,
+				     void *context, void **ret_val)
+{
+	struct acpi_buffer string = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct bgx *bgx = context;
+	char bgx_sel[5];
+
+	snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
+	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_SINGLE_NAME, &string))) {
+		pr_warn("Invalid link device\n");
+		return AE_OK;
+	}
+
+	if (strncmp(string.pointer, bgx_sel, 4))
+		return AE_OK;
+
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
+			    bgx_acpi_register_phy, NULL, bgx, NULL);
+
+	kfree(string.pointer);
+	return AE_CTRL_TERMINATE;
+}
+
+static int bgx_init_acpi_phy(struct bgx *bgx)
+{
+	acpi_get_devices(NULL, bgx_acpi_match_id, bgx, (void **)NULL);
+	return 0;
+}
+
+#else
+
+static int bgx_init_acpi_phy(struct bgx *bgx)
+{
+	return -ENODEV;
+}
+
+#endif /* CONFIG_ACPI */
+
 #if IS_ENABLED(CONFIG_OF_MDIO)
 
 static int bgx_init_of_phy(struct bgx *bgx)
@@ -882,7 +1010,12 @@ static int bgx_init_of_phy(struct bgx *bgx)
 
 static int bgx_init_phy(struct bgx *bgx)
 {
-	return bgx_init_of_phy(bgx);
+	int err = bgx_init_of_phy(bgx);
+
+	if (err != -ENODEV)
+		return err;
+
+	return bgx_init_acpi_phy(bgx);
 }
 
 static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
-- 
1.9.1
