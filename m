Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2011 17:38:38 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45794 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491924Ab1F0PiD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jun 2011 17:38:03 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5RFc0bm019378;
        Mon, 27 Jun 2011 16:38:00 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5RFc05c019377;
        Mon, 27 Jun 2011 16:38:00 +0100
Message-Id: <e77003c9b2855be37d9206cb34f541fb594f021d.1309182743.git.ralf@linux-mips.org>
In-Reply-To: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Steffen Klassert <klassert@mathematik.tu-chemnitz.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Date:   Sun, 26 Jun 2011 12:22:09 +0100
Subject: [PATCH 03/12] NET: 3c59x: Fix section mismatch.
X-archive-position: 30522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21966

WARNING: drivers/net/3c59x.o(.data+0x40): Section mismatch in reference from the variable vortex_eisa_driver to the function .init.text:vortex_eisa_probe()
The variable vortex_eisa_driver references
the function __init vortex_eisa_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/net/3c59x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
index 8cc2256..f33fecc 100644
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -908,7 +908,7 @@ static struct eisa_device_id vortex_eisa_ids[] = {
 };
 MODULE_DEVICE_TABLE(eisa, vortex_eisa_ids);
 
-static int __init vortex_eisa_probe(struct device *device)
+static int __devinit vortex_eisa_probe(struct device *device)
 {
 	void __iomem *ioaddr;
 	struct eisa_device *edev;
-- 
1.7.4.4
