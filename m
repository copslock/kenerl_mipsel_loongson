Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2010 03:19:30 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10746 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491108Ab0DBBS6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Apr 2010 03:18:58 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bb5460c0001>; Thu, 01 Apr 2010 18:19:08 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 1 Apr 2010 18:18:07 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 1 Apr 2010 18:18:07 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o321I3q3012794;
        Thu, 1 Apr 2010 18:18:03 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o321I3sH012793;
        Thu, 1 Apr 2010 18:18:03 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Cc:     davem@davemloft.net, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] staging: octeon-ethernet: Use proper phy addresses for Movidis hardware.
Date:   Thu,  1 Apr 2010 18:17:55 -0700
Message-Id: <1270171075-12741-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1270171075-12741-1-git-send-email-ddaney@caviumnetworks.com>
References: <1270171075-12741-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 02 Apr 2010 01:18:07.0584 (UTC) FILETIME=[5A09CE00:01CAD202]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/staging/octeon/cvmx-helper-board.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/octeon/cvmx-helper-board.c b/drivers/staging/octeon/cvmx-helper-board.c
index 3085e38..00a555b 100644
--- a/drivers/staging/octeon/cvmx-helper-board.c
+++ b/drivers/staging/octeon/cvmx-helper-board.c
@@ -153,6 +153,14 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
 		 * through switch.
 		 */
 		return -1;
+
+	case CVMX_BOARD_TYPE_CUST_WSX16:
+		if (ipd_port >= 0 && ipd_port <= 3)
+			return ipd_port;
+		else if (ipd_port >= 16 && ipd_port <= 19)
+			return ipd_port - 16 + 4;
+		else
+			return -1;
 	}
 
 	/* Some unknown board. Somebody forgot to update this function... */
-- 
1.6.6.1
