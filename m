Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 13:03:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47734 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012212AbcBCMDjztwvM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 13:03:39 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 696A8CB743F13;
        Wed,  3 Feb 2016 12:03:32 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 12:03:34 +0000
Received: from localhost (10.100.200.105) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 12:03:33 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] net: pch_gbe: Mark Minnow PHY reset GPIO active low
Date:   Wed, 3 Feb 2016 12:02:40 +0000
Message-ID: <1454500964-6256-3-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 51679
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

The Minnow PHY reset GPIO is set to 0 to enter reset & 1 to leave reset
- that is, it is an active low GPIO. In order to allow for the code to
be made more generic by further patches, indicate to the GPIO subsystem
that the GPIO is active low & invert the values it is set to such that
they reflect logically whether the device is being reset or not.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 3b98b263b..fde4c11 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -2717,7 +2717,8 @@ err_free_netdev:
  */
 static int pch_gbe_minnow_platform_init(struct pci_dev *pdev)
 {
-	unsigned long flags = GPIOF_DIR_OUT | GPIOF_INIT_HIGH | GPIOF_EXPORT;
+	unsigned long flags = GPIOF_DIR_OUT | GPIOF_INIT_LOW |
+		GPIOF_EXPORT | GPIOF_ACTIVE_LOW;
 	unsigned gpio = MINNOW_PHY_RESET_GPIO;
 	int ret;
 
@@ -2729,10 +2730,10 @@ static int pch_gbe_minnow_platform_init(struct pci_dev *pdev)
 		return ret;
 	}
 
-	gpio_set_value(gpio, 0);
-	usleep_range(1250, 1500);
 	gpio_set_value(gpio, 1);
 	usleep_range(1250, 1500);
+	gpio_set_value(gpio, 0);
+	usleep_range(1250, 1500);
 
 	return ret;
 }
-- 
2.7.0
