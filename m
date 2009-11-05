Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 20:40:59 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8070 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492952AbZKETkx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2009 20:40:53 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4af329e70000>; Thu, 05 Nov 2009 11:39:24 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Nov 2009 11:38:34 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Nov 2009 11:38:34 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id nA5JcWVi028004;
	Thu, 5 Nov 2009 11:38:32 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id nA5JcWD6028002;
	Thu, 5 Nov 2009 11:38:32 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] netdev: Fix compile error in Octeon MGMT driver.
Date:	Thu,  5 Nov 2009 11:38:32 -0800
Message-Id: <1257449912-27978-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 05 Nov 2009 19:38:34.0356 (UTC) FILETIME=[8FECAB40:01CA5E4F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Explicitly include linux/capability.h.  Under some configurations it
wasn't being indirectly included.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
This fixes a minor problem for the (already approved) patches that
Ralf has queued for 2.6.33.  It should probably be added to Ralf's
queue.

 drivers/net/octeon/octeon_mgmt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/octeon/octeon_mgmt.c b/drivers/net/octeon/octeon_mgmt.c
index 83a636d..050538b 100644
--- a/drivers/net/octeon/octeon_mgmt.c
+++ b/drivers/net/octeon/octeon_mgmt.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2009 Cavium Networks
  */
 
+#include <linux/capability.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-- 
1.6.0.6
