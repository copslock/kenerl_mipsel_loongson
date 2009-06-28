Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Jun 2009 18:33:21 +0200 (CEST)
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:1190 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492473AbZF1QdN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Jun 2009 18:33:13 +0200
Received: from localhost.localdomain ([192.168.1.158])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id KAA00818;
	Sat, 27 Jun 2009 10:34:34 -0700
From:	Joe Perches <joe@perches.com>
To:	linux-kernel@vger.kernel.org
Cc:	trivial@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 04/62] arch/mips/kernel/vpe.c: Remove unnecessary semicolons
Date:	Sun, 28 Jun 2009 09:26:09 -0700
Message-Id: <012172308c2e751761b89ec3c38fbc64b8137495.1246173680.git.joe@perches.com>
X-Mailer: git-send-email 1.6.3.1.10.g659a0.dirty
In-Reply-To: <cover.1246173664.git.joe@perches.com>
References: <cover.1246173664.git.joe@perches.com>
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/kernel/vpe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 3ca5f42..07b9ec2 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -1387,7 +1387,7 @@ static ssize_t store_ntcs(struct device *dev, struct device_attribute *attr,
 	return len;
 
 out_einval:
-	return -EINVAL;;
+	return -EINVAL;
 }
 
 static struct device_attribute vpe_class_attributes[] = {
-- 
1.6.3.1.10.g659a0.dirty
