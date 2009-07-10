Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 11:00:56 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:44641 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491922AbZGJJAs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 11:00:48 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.200])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A90gxl024323
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 02:00:42 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 02:00:41 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A90eUg021844;
	Fri, 10 Jul 2009 02:00:40 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH] APRP Patch04: Propagate final value of max_low_pfn to max_pfn
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 02:00:34 -0700
Message-ID: <20090710090034.26131.66856.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 09:00:41.0570 (UTC) FILETIME=[E6D27C20:01CA013C]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Chris Dearman <chris@mips.com>

Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/kernel/setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2950b97..1e9862d 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -326,7 +326,6 @@ static void __init bootmem_init(void)
 	/*
 	 * Determine low and high memory ranges
 	 */
-	max_pfn = max_low_pfn;
 	if (max_low_pfn > PFN_DOWN(HIGHMEM_START)) {
 #ifdef CONFIG_HIGHMEM
 		highstart_pfn = PFN_DOWN(HIGHMEM_START);
@@ -334,6 +333,8 @@ static void __init bootmem_init(void)
 #endif
 		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 	}
+	/* Propagate final value of max_low_pfn to max_pfn */
+	max_pfn = max_low_pfn;
 
 	/*
 	 * Initialize the boot-time allocator with low memory only.
