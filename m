Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2016 22:40:26 +0200 (CEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:47828 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992213AbcILUjQiIQ2X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Sep 2016 22:39:16 +0200
Received: from localhost.localdomain (85-76-14-194-nat.elisa-mobile.fi [85.76.14.194])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 465001A272B;
        Mon, 12 Sep 2016 23:39:16 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 3/3] MIPS: OCTEON: fix PCI interrupt routing on D-Link DSR-500N
Date:   Mon, 12 Sep 2016 23:39:10 +0300
Message-Id: <20160912203910.1164-4-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160912203910.1164-1-aaro.koskinen@iki.fi>
References: <20160912203910.1164-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Fix PCI interrupt routing on D-Link DSR-500N.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/pci/pci-octeon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index c258cd4..308d051 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -204,6 +204,8 @@ const char *octeon_get_pci_interrupts(void)
 	 * Interrupt Number (INTA# = 0, INTB# = 1, INTC# = 2, and
 	 * INTD# = 3)
 	 */
+	if (of_machine_is_compatible("dlink,dsr-500n"))
+		return "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC";
 	switch (octeon_bootinfo->board_type) {
 	case CVMX_BOARD_TYPE_NAO38:
 		/* This is really the NAC38 */
-- 
2.9.2
