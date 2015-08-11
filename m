Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2015 02:59:30 +0200 (CEST)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37801 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012962AbbHKA6yRx7gm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2015 02:58:54 +0200
Received: by igbpg9 with SMTP id pg9so81290838igb.0
        for <linux-mips@linux-mips.org>; Mon, 10 Aug 2015 17:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZK3aKsZiMmf+C2JGbMfLNHBgzGVHFDdcQY5SMzWktYM=;
        b=CXy7BVZGB987vjjHwXVGH5qgiz0m0M/A6BU8pxyHiYWnRZk6z96a4kllDUh9DNxU6m
         SnztnUu4I2sO1LkJy9GkNsIYAWB3Mzj2rY0SCMedPLbTRwOAQ9m9mVr2POPfYBhZmfx/
         E0wHxiQcbtWGFc97+AZAOEspnPEK+YV/IMMvC2EhRuFzDQFhhV/suXZgRmfR+d45sID8
         Pv1bg3vS5aT7ietkHCcPrTSZwMO47Tp5YAlB4mOEpj4fDUsPsXVZlvMQVHeHWWTvPb8Y
         goUEv/2r5LN5BPBMSPdd3e68A1nPBfFcXvzaxoI7X8EnNESJsgsNg1EFSFyJN8GtY7a/
         qGQg==
X-Received: by 10.50.138.76 with SMTP id qo12mr15513239igb.38.1439254728751;
        Mon, 10 Aug 2015 17:58:48 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.gmail.com with ESMTPSA id r4sm7026965igh.9.2015.08.10.17.58.46
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 17:58:47 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id t7B0wjP5002919;
        Mon, 10 Aug 2015 17:58:45 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id t7B0wiq7002918;
        Mon, 10 Aug 2015 17:58:44 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Robert Richter <rrichter@cavium.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, rafael@kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 2/2] net, thunder, bgx: Add support to get MAC address from ACPI.
Date:   Mon, 10 Aug 2015 17:58:37 -0700
Message-Id: <1439254717-2875-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48761
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

Currently there is no way to get the MAC address in a firmware
independent manner, so set the MAC address of the device directly from
the ACPI tables.

The binding agrees with the proposed standard here:

http://www.uefi.org/sites/default/files/resources/nic-request-v2.pdf

Based on code from: Narinder Dhillon <ndhillon@cavium.com>
                    Tomasz Nowicki <tomasz.nowicki@linaro.org>
                    Robert Richter <rrichter@cavium.com>

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 86 ++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 615b2af..5e54186 100644
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
@@ -835,6 +836,86 @@ static void bgx_get_qlm_mode(struct bgx *bgx)
 	}
 }
 
+#ifdef CONFIG_ACPI
+
+static int acpi_get_mac_address(struct acpi_device *adev, u8 *dst)
+{
+	u8 mac[ETH_ALEN];
+	int ret;
+
+	ret = fwnode_property_read_u8_array(acpi_fwnode_handle(adev),
+					    "mac-address", mac, ETH_ALEN);
+	if (ret)
+		goto out;
+
+	if (!is_valid_ether_addr(mac)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memcpy(dst, mac, ETH_ALEN);
+out:
+	return ret;
+}
+
+/* Currently only sets the MAC address. */
+static acpi_status bgx_acpi_register_phy(acpi_handle handle,
+					 u32 lvl, void *context, void **rv)
+{
+	struct bgx *bgx = context;
+	struct acpi_device *adev;
+
+	if (acpi_bus_get_device(handle, &adev))
+		goto out;
+
+	acpi_get_mac_address(adev, bgx->lmac[bgx->lmac_count].mac);
+
+	SET_NETDEV_DEV(&bgx->lmac[bgx->lmac_count].netdev, &bgx->pdev->dev);
+
+	bgx->lmac[bgx->lmac_count].lmacid = bgx->lmac_count;
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
@@ -882,6 +963,9 @@ static int bgx_init_of_phy(struct bgx *bgx)
 
 static int bgx_init_phy(struct bgx *bgx)
 {
+	if (!acpi_disabled)
+		return bgx_init_acpi_phy(bgx);
+
 	return bgx_init_of_phy(bgx);
 }
 
-- 
1.9.1
