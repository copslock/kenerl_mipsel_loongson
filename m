Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:02:47 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:45926 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251748AbYJXA6K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:58:10 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d660006>; Thu, 23 Oct 2008 20:57:10 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:10 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:09 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v52d005637;
	Thu, 23 Oct 2008 17:57:05 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v5Yh005636;
	Thu, 23 Oct 2008 17:57:05 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 19/37] Cavium OCTEON: increase MAX_DMA address.
Date:	Thu, 23 Oct 2008 17:56:43 -0700
Message-Id: <1224809821-5532-20-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:09.0735 (UTC) FILETIME=[716E8770:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

There is not a fundamental limit like an old ISA board where DMA can
be only to an address < 16M, so set the MAX_DMA_ADDRESS accordingly.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/dma.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/dma.h b/arch/mips/include/asm/dma.h
index 1353c81..1706089 100644
--- a/arch/mips/include/asm/dma.h
+++ b/arch/mips/include/asm/dma.h
@@ -87,6 +87,13 @@
 #if defined(CONFIG_SGI_IP22) || defined(CONFIG_SGI_IP28)
 /* don't care; ISA bus master won't work, ISA slave DMA supports 32bit addr */
 #define MAX_DMA_ADDRESS		PAGE_OFFSET
+#elif defined(CONFIG_CPU_CAVIUM_OCTEON)
+/* Octeon can support DMA to any memory installed */
+#ifdef CONFIG_64BIT
+#define MAX_DMA_ADDRESS		(PAGE_OFFSET + (1ull<<32))
+#else
+#define MAX_DMA_ADDRESS		(PAGE_OFFSET + (1ul<<30))
+#endif
 #else
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET + 0x01000000)
 #endif
-- 
1.5.5.1
