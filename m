Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:26:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61204 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007943AbbK3QZaY0Cne (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:25:30 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTP id 00E8794280D56;
        Mon, 30 Nov 2015 16:25:21 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 30 Nov 2015 16:25:24 +0000
Received: from localhost (10.100.200.236) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Nov
 2015 16:25:24 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <linux-gpio@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/28] gpio: pch: allow use from device tree
Date:   Mon, 30 Nov 2015 16:21:38 +0000
Message-ID: <1448900513-20856-14-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 50194
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

Allow GPIOs from the gpio-pch driver to be referenced from device tree
by simply setting the struct gpio_chip of_node pointer to that of the
struct pci_dev.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/gpio/gpio-pch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
index 34ed176..56c9be4 100644
--- a/drivers/gpio/gpio-pch.c
+++ b/drivers/gpio/gpio-pch.c
@@ -394,6 +394,7 @@ static int pch_gpio_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, chip);
 	spin_lock_init(&chip->spinlock);
 	pch_gpio_setup(chip);
+	chip->gpio.of_node = pdev->dev.of_node;
 	ret = gpiochip_add(&chip->gpio);
 	if (ret) {
 		dev_err(&pdev->dev, "PCH gpio: Failed to register GPIO\n");
-- 
2.6.2
