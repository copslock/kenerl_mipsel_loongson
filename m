Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Sep 2013 00:47:01 +0200 (CEST)
Received: from fifo99.com ([67.223.236.141]:36604 "EHLO fifo99.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822681Ab3ITWq5zzyJU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Sep 2013 00:46:57 +0200
Received: from zorba.lan (adsl-99-25-115-217.dsl.pltn13.sbcglobal.net [99.25.115.217])
        (Authenticated sender: dwalker)
        by fifo99.com (Postfix) with ESMTPSA id A4828327D3AF;
        Fri, 20 Sep 2013 15:46:45 -0700 (PDT)
From:   Daniel Walker <dwalker@fifo99.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Doug Thompson <dougthompson@xmission.com>
Cc:     linux-edac@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drivers: edac: octeon: fix lack of opstate_init
Date:   Fri, 20 Sep 2013 15:46:40 -0700
Message-Id: <1379717202-26990-1-git-send-email-dwalker@fifo99.com>
X-Mailer: git-send-email 1.8.1.2
Return-Path: <dwalker@fifo99.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwalker@fifo99.com
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

If the opstate_init() isn't called the driver won't start properly.

I just added it in what appears to be an appropriate place.

Signed-off-by: Daniel Walker <dwalker@fifo99.com>
---
 drivers/edac/octeon_edac-lmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/octeon_edac-lmc.c b/drivers/edac/octeon_edac-lmc.c
index 93412d6..4881ad0 100644
--- a/drivers/edac/octeon_edac-lmc.c
+++ b/drivers/edac/octeon_edac-lmc.c
@@ -92,6 +92,8 @@ static int octeon_lmc_edac_probe(struct platform_device *pdev)
 	struct edac_mc_layer layers[1];
 	int mc = pdev->id;
 
+	opstate_init();
+
 	layers[0].type = EDAC_MC_LAYER_CHANNEL;
 	layers[0].size = 1;
 	layers[0].is_virt_csrow = false;
-- 
1.8.1.2
