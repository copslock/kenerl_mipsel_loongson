Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 04:49:08 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:39577 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492001AbZGBCrf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Jul 2009 04:47:35 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n622frmO016322
	for <linux-mips@linux-mips.org>; Wed, 1 Jul 2009 19:41:53 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 19:41:52 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n622fqfw006004;
	Wed, 1 Jul 2009 19:41:52 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 07/15] APRP Patch04: Propagate final value of max_low_pfn to
	max_pfn
To:	linux-mips@linux-mips.org
Cc:	chris@mips.com
Date:	Wed, 01 Jul 2009 19:41:27 -0700
Message-ID: <20090702024127.23268.94902.stgit@linux-raghu>
In-Reply-To: <20090702023938.23268.65453.stgit@linux-raghu>
References: <20090702023938.23268.65453.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2009 02:41:53.0053 (UTC) FILETIME=[A84404D0:01C9FABE]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23599
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
