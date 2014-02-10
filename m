Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2014 19:43:01 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:48465 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816199AbaBJSm7jwknl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Feb 2014 19:42:59 +0100
Received: from cpc3-craw6-2-0-cust180.croy.cable.virginm.net ([77.100.248.181] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <colin.king@canonical.com>)
        id 1WCvon-0003zg-LN; Mon, 10 Feb 2014 18:42:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     David.Daney@caviumnetworks.com
Subject: [PATCH] MIPS: Octeon: fix fall through on bar type OCTEON_DMA_BAR_TYPE_SMALL
Date:   Mon, 10 Feb 2014 18:42:57 +0000
Message-Id: <1392057777-14919-1-git-send-email-colin.king@canonical.com>
X-Mailer: git-send-email 1.9.rc1
Return-Path: <colin.king@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin.king@canonical.com
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

From: Colin Ian King <colin.king@canonical.com>

Bar type OCTEON_DMA_BAR_TYPE_SMALL assigns lo and hi addresses and
then falls through to OCTEON_DMA_BAR_TYPE_BIG that re-assignes lo and
hi addresses with totally different values. Add a break so we don't
fall through.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/pci/msi-octeon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index d37be36..2b91b0e 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -150,6 +150,7 @@ msi_irq_allocated:
 		msg.address_lo =
 			((128ul << 20) + CVMX_PCI_MSI_RCV) & 0xffffffff;
 		msg.address_hi = ((128ul << 20) + CVMX_PCI_MSI_RCV) >> 32;
+		break;
 	case OCTEON_DMA_BAR_TYPE_BIG:
 		/* When using big bar, Bar 0 is based at 0 */
 		msg.address_lo = (0 + CVMX_PCI_MSI_RCV) & 0xffffffff;
-- 
1.9.rc1
