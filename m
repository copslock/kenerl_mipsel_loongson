Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 04:48:11 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:39573 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492011AbZGBCrF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Jul 2009 04:47:05 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n622fNfl016307
	for <linux-mips@linux-mips.org>; Wed, 1 Jul 2009 19:41:23 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 19:41:22 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n622fLWp006000;
	Wed, 1 Jul 2009 19:41:21 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 05/15] [MTI] MIPS secondary cache supports 64 byte line size.
To:	linux-mips@linux-mips.org
Cc:	chris@mips.com
Date:	Wed, 01 Jul 2009 19:40:56 -0700
Message-ID: <20090702024055.23268.93650.stgit@linux-raghu>
In-Reply-To: <20090702023938.23268.65453.stgit@linux-raghu>
References: <20090702023938.23268.65453.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2009 02:41:22.0397 (UTC) FILETIME=[95FE48D0:01C9FABE]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Chris Dearman <chris@mips.com>

Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index df1a92a..60c7235 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1012,6 +1012,7 @@ config MIPS_L1_CACHE_SHIFT
 	int
 	default "4" if MACH_DECSTATION || MIKROTIK_RB532
 	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM || CPU_CAVIUM_OCTEON
+	default "6" if MIPS_CPU_SCACHE
 	default "4" if PMC_MSP4200_EVAL
 	default "5"
 
