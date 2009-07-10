Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 10:54:25 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:34009 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491959AbZGJIyI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 10:54:08 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.200])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A8s1KG024156
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 01:54:01 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 01:54:01 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A8s0Eo021820;
	Fri, 10 Jul 2009 01:54:00 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 1/3] Fix accesses to device registers on MIPS boards
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 01:53:54 -0700
Message-ID: <20090710085354.25918.5090.stgit@linux-raghu>
In-Reply-To: <20090710085338.25918.37597.stgit@linux-raghu>
References: <20090710085338.25918.37597.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 08:54:01.0213 (UTC) FILETIME=[F830DAD0:01CA013B]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Chris Dearman <chris@mips.com>

This fixes the remaining problems introduced by
f197465384bf7ef1af184c2ed1a4e268911a91e3 (incorrect access length &
byteswapping in bigendian mode)

Signed-off-by: Chris Dearman (chris@mips.com)
---

 arch/mips/mti-malta/malta-int.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 3e0a9b3..e568d0d 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -87,7 +87,7 @@ static inline int mips_pcibios_iack(void)
 		dummy = BONITO_PCIMAP_CFG;
 		iob();    /* sync */
 
-		irq = readl((u32 *)_pcictrl_bonito_pcicfg);
+		irq = __raw_readl((u32 *)_pcictrl_bonito_pcicfg);
 		iob();    /* sync */
 		irq &= 0xff;
 		BONITO_PCIMAP_CFG = 0;
