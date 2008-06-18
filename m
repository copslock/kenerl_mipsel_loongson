Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2008 08:18:04 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:11190 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20025229AbYFRHRO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2008 08:17:14 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 70902C801D;
	Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id 1viIa908sWll; Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 34406C80D9;
	Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id A75BBB4046; Wed, 18 Jun 2008 10:18:23 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 2/5] [MIPS] Namespace clean-up in arch/mips/pci/pci.c
Date:	Wed, 18 Jun 2008 10:18:20 +0300
Message-Id: <1213773503-23536-3-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The following symbols

	hose_head
	hose_tail

are needlessly defined global in arch/mips/pci/pci.c, and
this patch makes them static.

The variable pci_isa_hose is not used, and is removed by
this patch.

Spotted by namespacecheck. Tested by booting a Malta 4Kc
board up to the shell prompt.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/pci/pci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 358ad62..d7d6cb0 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -29,8 +29,7 @@ unsigned int pci_probe = PCI_ASSIGN_ALL_BUSSES;
  * The PCI controller list.
  */
 
-struct pci_controller *hose_head, **hose_tail = &hose_head;
-struct pci_controller *pci_isa_hose;
+static struct pci_controller *hose_head, **hose_tail = &hose_head;
 
 unsigned long PCIBIOS_MIN_IO	= 0x0000;
 unsigned long PCIBIOS_MIN_MEM	= 0;
-- 
1.5.5.GIT
