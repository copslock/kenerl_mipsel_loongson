Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 00:24:06 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36452 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012090AbaJUWXcQ5RlB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 00:23:32 +0200
Received: by mail-pa0-f41.google.com with SMTP id rd3so331508pab.14
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 15:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhmhHqeEkjXLalmJ9EXb3ouPfByGekDwYWjU8RYiq3w=;
        b=tyE5izA3XvJJaRSlj0NX3ju3jwyfyf0vHQdNQygtY1Xxr3plVEn0aYg1G9OiO88U1n
         3rwaoRC4cTwg5A16QRP3VZmcHT6R4K7UeVNCa3B57Q4CuLwIUFfasiUx9ixhNHBi1ZX+
         Z2YpQN2d4p0o9C13tPzZqi33w+KCS6mCYKfSy+niDy/fxzdkrY3q/0Hj/42tM3D151hX
         tutQJP4iLDDBWsECd30UVmkZYczXZ2IugfGf46Jq6cP+Q/g7SZm/lxLHUCNZD3sEJu5C
         AsGVZkYkqRCNUF4QOmlNsq+6xzKT3JaN9NPGfKe/5PfZz0yLMMjlmAfqWikgTECEVKcn
         3Tag==
X-Received: by 10.70.109.139 with SMTP id hs11mr18875217pdb.83.1413930206036;
        Tue, 21 Oct 2014 15:23:26 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id al4sm12702816pbc.19.2014.10.21.15.23.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 15:23:25 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz
Cc:     robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de,
        geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V3 02/10] tty: serial: bcm63xx: Add support for unnamed clock outputs from DT
Date:   Tue, 21 Oct 2014 15:22:58 -0700
Message-Id: <1413930186-23168-3-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

The original non-DT bcm63xx clk code ignores the struct device argument
and looks up a global clock name.  DT platforms, by contrast, often just
use a phandle to reference a clock node with no "clock-output-names"
property.  Modify the UART driver to support both schemes.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 2315190..de95573 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -824,7 +824,8 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	if (!res_irq)
 		return -ENODEV;
 
-	clk = clk_get(&pdev->dev, "periph");
+	clk = pdev->dev.of_node ? of_clk_get(pdev->dev.of_node, 0) :
+				  clk_get(&pdev->dev, "periph");
 	if (IS_ERR(clk))
 		return -ENODEV;
 
-- 
2.1.1
