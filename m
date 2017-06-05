Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 19:32:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32068 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992078AbdFERcc0mYeR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 19:32:32 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id BAE77B18D58AD;
        Mon,  5 Jun 2017 18:32:20 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Jun 2017 18:32:24
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <netdev@vger.kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Eric Dumazet <edumazet@google.com>,
        Jarod Wilson <jarod@redhat.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v4 1/7] net: pch_gbe: Mark Minnow PHY reset GPIO active low
Date:   Mon, 5 Jun 2017 10:31:30 -0700
Message-ID: <20170605173136.10795-2-paul.burton@imgtec.com>
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
X-archive-position: 58215
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
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jarod Wilson <jarod@redhat.com>
Cc: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 5ae9681a2da7..d38198718005 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -2696,7 +2696,8 @@ static int pch_gbe_probe(struct pci_dev *pdev,
  */
 static int pch_gbe_minnow_platform_init(struct pci_dev *pdev)
 {
-	unsigned long flags = GPIOF_DIR_OUT | GPIOF_INIT_HIGH | GPIOF_EXPORT;
+	unsigned long flags = GPIOF_DIR_OUT | GPIOF_INIT_LOW |
+		GPIOF_EXPORT | GPIOF_ACTIVE_LOW;
 	unsigned gpio = MINNOW_PHY_RESET_GPIO;
 	int ret;
 
@@ -2708,10 +2709,10 @@ static int pch_gbe_minnow_platform_init(struct pci_dev *pdev)
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
2.13.0
