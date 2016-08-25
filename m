Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2016 23:22:47 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:59968 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992196AbcHYVWk122uW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2016 23:22:40 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <steven.hill@cavium.com>)
        id 1bd1xs-0005bF-2G; Thu, 25 Aug 2016 16:13:32 -0500
Subject: [PATCH] MIPS: Octeon: mark GPIO controller node not populated IRQ,
 init.
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
From:   "Steven J. Hill" <steven.hill@cavium.com>
Message-ID: <422712ab-4b0d-2b6d-4600-b917c2d327a9@cavium.com>
Date:   Thu, 25 Aug 2016 16:22:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <steven.hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

We clear the OF_POPULATED flag for the GPIO controller node, otherwise
the GPIO lines used by the MMC driver are never probed.

Fixes: 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt controllers as populated")
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 5a9b87b..41d12d4 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1619,6 +1619,13 @@ static int __init octeon_irq_init_gpio(
 		return -ENOMEM;
 	}
 
+	/*
+	 * Clear the OF_POPULATED flag that was set above for the
+	 * GPIO controller so that the lines used by the MMC driver
+	 * will not be skipped.
+	 */
+	of_node_clear_flag(gpio_node, OF_POPULATED);
+
 	return 0;
 }
 /*
-- 
1.9.1
