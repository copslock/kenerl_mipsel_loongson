Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 13:43:30 +0100 (BST)
Received: from p549F7458.dip.t-dialin.net ([84.159.116.88]:40876 "EHLO
	p549F7458.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S28580347AbYGPMn2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jul 2008 13:43:28 +0100
Received: from smtp.movial.fi ([62.236.91.34]:23965 "EHLO smtp.movial.fi")
	by lappi.linux-mips.net with ESMTP id S1098338AbYGORCl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2008 19:02:41 +0200
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 96B19C80ED;
	Tue, 15 Jul 2008 19:57:32 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id KFMP7Mrd1pzq; Tue, 15 Jul 2008 19:57:32 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 5DFA2C80FE;
	Tue, 15 Jul 2008 19:57:32 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id 35EEFB404A; Tue, 15 Jul 2008 19:57:31 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] [MIPS] make the pcibios_max_latency variable static
Date:	Tue, 15 Jul 2008 19:57:30 +0300
Message-Id: <1216141052-28005-2-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1216141052-28005-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1216141052-28005-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The pcibios_max_latency variable is needlessly defined global,
and this patch makes it static.

Build-tested using malta_defconfig.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/pci/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 358ad62..0187b8c 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -205,7 +205,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
  *  If we set up a device for bus mastering, we need to check the latency
  *  timer as certain crappy BIOSes forget to set it properly.
  */
-unsigned int pcibios_max_latency = 255;
+static unsigned int pcibios_max_latency = 255;
 
 void pcibios_set_master(struct pci_dev *dev)
 {
-- 
1.5.6
