Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2008 21:47:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:32183 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23872713AbYIUUrV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2008 21:47:21 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8LKlHfQ030506;
	Sun, 21 Sep 2008 22:47:18 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8LKlG1P030504;
	Sun, 21 Sep 2008 22:47:16 +0200
Date:	Sun, 21 Sep 2008 22:47:16 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	bzolnier@gmail.com, linux-ide@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] Swarm: Fix crash due to missing initialization
Message-ID: <20080921204716.GA29927@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

If things are just right this will result in the hws[0]->parent being
passed to ide_host_add() being non-zero and an ooops a little later.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---

This patch is needed for 2.6.27 only

diff --git a/drivers/ide/mips/swarm.c b/drivers/ide/mips/swarm.c
index badf79f..39c9ee9 100644
--- a/drivers/ide/mips/swarm.c
+++ b/drivers/ide/mips/swarm.c
@@ -107,6 +107,7 @@ static int __devinit swarm_ide_probe(struct device *dev)
 
 	base = ioremap(offset, size);
 
+	memset(&hw, 0, sizeof(hw));
 	for (i = 0; i <= 7; i++)
 		hw.io_ports_array[i] =
 				(unsigned long)(base + ((0x1f0 + i) << 5));
