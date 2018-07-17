Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 16:23:52 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:50247 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992891AbeGQOXeqKPJw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 16:23:34 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1B65B20904; Tue, 17 Jul 2018 16:23:29 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id E28AD206A6;
        Tue, 17 Jul 2018 16:23:18 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/5] spi: dw: fix possible race condition
Date:   Tue, 17 Jul 2018 16:23:10 +0200
Message-Id: <20180717142314.32337-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

It is possible to get an interrupt as soon as it is requested.  dw_spi_irq
does spi_controller_get_devdata(master) and expects it to be different than
NULL. However, spi_controller_set_devdata() is called after request_irq(),
resulting in the following crash:

CPU 0 Unable to handle kernel paging request at virtual address 00000030, epc == 8058e09c, ra == 8018ff90
[...]
Call Trace:
[<8058e09c>] dw_spi_irq+0x8/0x64
[<8018ff90>] __handle_irq_event_percpu+0x70/0x1d4
[<80190128>] handle_irq_event_percpu+0x34/0x8c
[<801901c4>] handle_irq_event+0x44/0x80
[<801951a8>] handle_level_irq+0xdc/0x194
[<8018f580>] generic_handle_irq+0x38/0x50
[<804c6924>] ocelot_irq_handler+0x104/0x1c0
[<8018f580>] generic_handle_irq+0x38/0x50
[<8075c1d8>] do_IRQ+0x18/0x24
[<804c4714>] plat_irq_dispatch+0xa4/0x150
[<80106ba8>] except_vec_vi_end+0xb8/0xc4
[<8075ba5c>] _raw_spin_unlock_irqrestore+0x14/0x20
[<801926c8>] __setup_irq+0x53c/0x8e0
[<80192e28>] request_threaded_irq+0xf4/0x1e8
[<8058ed18>] dw_spi_add_host+0x264/0x2c4
[<8058f2ec>] dw_spi_mmio_probe+0x258/0x27c
[<8051f4a4>] platform_drv_probe+0x58/0xbc
[<8051daa8>] driver_probe_device+0x308/0x40c
[<8051dc9c>] __driver_attach+0xf0/0xf8
[<8051b698>] bus_for_each_dev+0x78/0xcc
[<8051c2c0>] bus_add_driver+0x1b4/0x228
[<8051e840>] driver_register+0x84/0x154
[<801001d8>] do_one_initcall+0x54/0x1ac
[<80880e90>] kernel_init_freeable+0x1ec/0x2ac
[<80755310>] kernel_init+0x14/0x110
[<80106698>] ret_from_kernel_thread+0x14/0x1c
Code: 00000000  8ca40050  8c820008 <8c420030> 0000000f  3042003f  10400007  00000000  8ca20230

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f693bfe95ab9..a087464efdd7 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -485,6 +485,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	dws->dma_inited = 0;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
 
+	spi_controller_set_devdata(master, dws);
+
 	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
 			  master);
 	if (ret < 0) {
@@ -518,7 +520,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		}
 	}
 
-	spi_controller_set_devdata(master, dws);
 	ret = devm_spi_register_controller(dev, master);
 	if (ret) {
 		dev_err(&master->dev, "problem registering spi master\n");
-- 
2.18.0
