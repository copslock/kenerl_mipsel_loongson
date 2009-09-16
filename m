Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Sep 2009 08:02:57 +0200 (CEST)
Received: from rs1.rw-gmbh.net ([213.239.201.58]:42231 "EHLO rs1.rw-gmbh.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492281AbZIPGCu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Sep 2009 08:02:50 +0200
Received: from pd951a7a4.dip0.t-ipconnect.de ([217.81.167.164] helo=localhost.localdomain)
	by rs1.rw-gmbh.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <ralf.roesch@rw-gmbh.de>)
	id 1MnnbJ-0007Ss-KL
	for linux-mips@linux-mips.org; Wed, 16 Sep 2009 08:02:45 +0200
From:	Ralf Roesch <ralf.roesch@rw-gmbh.de>
To:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: TXx9: Fix error handling / Fix for noenexisting gpio_remove.
Date:	Wed, 16 Sep 2009 08:01:20 +0200
Message-Id: <1253080880-11123-1-git-send-email-ralf.roesch@rw-gmbh.de>
X-Mailer: git-send-email 1.6.3.3
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

error was introduced by commit 0385d1f3d394c6814be0b165c153fc3fc254469a

Signed-off-by: Ralf Roesch <ralf.roesch@rw-gmbh.de>
---
 arch/mips/txx9/generic/setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index ed794c1..cff5578 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -835,7 +835,8 @@ void __init txx9_iocled_init(unsigned long baseaddr,
 out_pdev:
 	platform_device_put(pdev);
 out_gpio:
-	gpio_remove(&iocled->chip);
+	if (gpiochip_remove(&iocled->chip))
+		return;
 out_unmap:
 	iounmap(iocled->mmioaddr);
 out_free:
-- 
1.6.3.3
