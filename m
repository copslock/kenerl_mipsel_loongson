Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:27:09 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61397 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007995AbbK3QZ7of0Ne (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:25:59 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id AFCE6A79C8471;
        Mon, 30 Nov 2015 16:25:51 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 30 Nov 2015 16:25:54 +0000
Received: from localhost (10.100.200.236) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Nov
 2015 16:25:53 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        <linux-i2c@vger.kernel.org>
Subject: [PATCH 15/28] i2c: eg20t: set i2c_adapter->dev.of_node
Date:   Mon, 30 Nov 2015 16:21:40 +0000
Message-ID: <1448900513-20856-16-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 50196
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

Set the I2C adapter devices of_node to that of the PCI device, such that
I2C clients may be instantiated via device tree.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/i2c/busses/i2c-eg20t.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 76e699f..137125b 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -795,6 +795,7 @@ static int pch_i2c_probe(struct pci_dev *pdev,
 		/* base_addr + offset; */
 		adap_info->pch_data[i].pch_base_address = base_addr + 0x100 * i;
 
+		pch_adap->dev.of_node = pdev->dev.of_node;
 		pch_adap->dev.parent = &pdev->dev;
 
 		pch_i2c_init(&adap_info->pch_data[i]);
-- 
2.6.2
