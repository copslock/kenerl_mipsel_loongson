Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2018 23:21:43 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:34380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993981AbeGVVU3idQ2S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2018 23:20:29 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5254AFD4;
        Sun, 22 Jul 2018 21:20:22 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH 11/15] spi: img-spfi: Set device select bits for SPFI port state
Date:   Sun, 22 Jul 2018 23:20:06 +0200
Message-Id: <20180722212010.3979-12-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <afaerber@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: afaerber@suse.de
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

From: Ionela Voinescu <ionela.voinescu@imgtec.com>

Even if the chip select line is not controlled by the SPFI
hardware, the device select bits need to be set to specify
the chip select line in use for the hardware to know what
parameters to use for the current transfer.

Signed-off-by: Ionela Voinescu <ionela.voinescu@imgtec.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/spi/spi-img-spfi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index c845a505bae6..0d73d31a6a2b 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -438,6 +438,9 @@ static int img_spfi_prepare(struct spi_master *master, struct spi_message *msg)
 	u32 val;
 
 	val = spfi_readl(spfi, SPFI_PORT_STATE);
+	val &= ~(SPFI_PORT_STATE_DEV_SEL_MASK <<
+		 SPFI_PORT_STATE_DEV_SEL_SHIFT);
+	val |= msg->spi->chip_select << SPFI_PORT_STATE_DEV_SEL_SHIFT;
 	if (msg->spi->mode & SPI_CPHA)
 		val |= SPFI_PORT_STATE_CK_PHASE(msg->spi->chip_select);
 	else
-- 
2.16.4
