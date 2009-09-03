Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Sep 2009 01:11:22 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:41292 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493207AbZICXLQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Sep 2009 01:11:16 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4aa04cfb0000>; Thu, 03 Sep 2009 19:10:51 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 3 Sep 2009 16:10:54 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 3 Sep 2009 16:10:54 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n83NAnp4003116;
	Thu, 3 Sep 2009 16:10:50 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n83NAls8003115;
	Thu, 3 Sep 2009 16:10:47 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org, gregkh@suse.de
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] Staging: Octeon: Use symbolic values for irq numbers.
Date:	Thu,  3 Sep 2009 16:10:47 -0700
Message-Id: <1252019447-3090-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 03 Sep 2009 23:10:54.0871 (UTC) FILETIME=[C9D6BA70:01CA2CEB]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

In addition to being magic numbers, the irq number passed to free_irq
is incorrect.  We need to use the correct symbolic value instead.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

Octeon being a member of the mips archecture, this could merge via
Ralf's linux-mips.org tree.

 drivers/staging/octeon/ethernet-spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-spi.c b/drivers/staging/octeon/ethernet-spi.c
index 66190b0..00dc0f4 100644
--- a/drivers/staging/octeon/ethernet-spi.c
+++ b/drivers/staging/octeon/ethernet-spi.c
@@ -317,6 +317,6 @@ void cvm_oct_spi_uninit(struct net_device *dev)
 			cvmx_write_csr(CVMX_SPXX_INT_MSK(interface), 0);
 			cvmx_write_csr(CVMX_STXX_INT_MSK(interface), 0);
 		}
-		free_irq(8 + 46, &number_spi_ports);
+		free_irq(OCTEON_IRQ_RML, &number_spi_ports);
 	}
 }
-- 
1.6.0.6
