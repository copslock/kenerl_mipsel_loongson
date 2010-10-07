Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 01:05:27 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18299 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491184Ab0JGXE7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 01:04:59 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cae50d60000>; Thu, 07 Oct 2010 18:59:36 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:22 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:22 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o97N49At026980;
        Thu, 7 Oct 2010 16:04:09 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o97N49cg026979;
        Thu, 7 Oct 2010 16:04:09 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Subject: [PATCH 12/14] ata: pata_octeon_cf: Use I/O clock rate for timing calculations.
Date:   Thu,  7 Oct 2010 16:03:51 -0700
Message-Id: <1286492633-26885-13-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2010 23:04:22.0840 (UTC) FILETIME=[FAFDCB80:01CB6673]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The creation of the I/O clock domain requires some adjustments.  Since
the CF bus timing logic is clocked by the I/O clock, use its rate for
delay calculations.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/pata_octeon_cf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 06ddd91..74b8298 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -60,7 +60,7 @@ static unsigned int ns_to_tim_reg(unsigned int tim_mult, unsigned int nsecs)
 	 * Compute # of eclock periods to get desired duration in
 	 * nanoseconds.
 	 */
-	val = DIV_ROUND_UP(nsecs * (octeon_get_clock_rate() / 1000000),
+	val = DIV_ROUND_UP(nsecs * (octeon_get_io_clock_rate() / 1000000),
 			  1000 * tim_mult);
 
 	return val;
-- 
1.7.2.3
