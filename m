Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2016 17:26:39 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:59758 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992843AbcGZP0cIQL0L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jul 2016 17:26:32 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <steven.hill@cavium.com>)
        id 1bS46V-00043h-NC; Tue, 26 Jul 2016 10:17:08 -0500
Subject: [PATCH] MIPS: Octeon: Put restrictions on DMA descriptors.
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
From:   "Steven J. Hill" <steven.hill@cavium.com>
Message-ID: <5797811F.1000709@cavium.com>
Date:   Tue, 26 Jul 2016 10:26:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <steven.hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54378
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

Set the DMA mask such that all descriptors stay in the
lower 4GB of memory.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-platform.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 7aeafed..c9359fd 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -311,7 +311,11 @@ static struct usb_ehci_pdata octeon_ehci_pdata = {
 #ifdef __BIG_ENDIAN
 	.big_endian_mmio	= 1,
 #endif
-	.dma_mask_64	= 1,
+	/*
+	 * We can DMA from anywhere. But the descriptors must be in
+	 * the lower 4GB.
+	 */
+	.dma_mask_64	= 0,
 	.power_on	= octeon_ehci_power_on,
 	.power_off	= octeon_ehci_power_off,
 };
-- 
1.9.1
