Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 00:30:25 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:36771
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011125AbaJJW3QmJoZE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 00:29:16 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 04/10] MIPS: lantiq: add support for xrx200 firmware depending on soc type
Date:   Sat, 11 Oct 2014 00:02:28 +0200
Message-Id: <1412978554-31344-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
References: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

VR9 needs different firmware files for the various phy/soc revisions. Some
boards are ship with older and newer SoC revisions. To be able to boot a single
image on all versions we need to define both firmware files inside the
devicetree.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/xrx200_phy_fw.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/xrx200_phy_fw.c b/arch/mips/lantiq/xway/xrx200_phy_fw.c
index d4d9d31..7c1e54c 100644
--- a/arch/mips/lantiq/xway/xrx200_phy_fw.c
+++ b/arch/mips/lantiq/xway/xrx200_phy_fw.c
@@ -24,7 +24,28 @@ static dma_addr_t xway_gphy_load(struct platform_device *pdev)
 	void *fw_addr;
 	size_t size;
 
-	if (of_property_read_string(pdev->dev.of_node, "firmware", &fw_name)) {
+	if (of_get_property(pdev->dev.of_node, "firmware1", NULL) ||
+		of_get_property(pdev->dev.of_node, "firmware2", NULL)) {
+		switch (ltq_soc_type()) {
+		case SOC_TYPE_VR9:
+			if (of_property_read_string(pdev->dev.of_node,
+						    "firmware1", &fw_name)) {
+				dev_err(&pdev->dev,
+					"failed to load firmware filename\n");
+				return 0;
+			}
+			break;
+		case SOC_TYPE_VR9_2:
+			if (of_property_read_string(pdev->dev.of_node,
+						    "firmware2", &fw_name)) {
+				dev_err(&pdev->dev,
+					"failed to load firmware filename\n");
+				return 0;
+			}
+			break;
+		}
+	} else if (of_property_read_string(pdev->dev.of_node,
+					 "firmware", &fw_name)) {
 		dev_err(&pdev->dev, "failed to load firmware filename\n");
 		return 0;
 	}
-- 
1.7.10.4
