Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:24:32 +0100 (CET)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:25502 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010454AbbAGLVecywxU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 12:21:34 +0100
X-IronPort-AV: E=Sophos;i="5.07,714,1413270000"; 
   d="scan'208";a="54298907"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw2-out.broadcom.com with ESMTP; 07 Jan 2015 03:56:08 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 7 Jan 2015 03:21:33 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 7 Jan 2015 03:21:48 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 602AB40FE6;    Wed,  7 Jan 2015 03:20:45 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Prem Mallappa <pmallapp@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 11/17] MIPS: Netlogic: Added HugeTLB as default
Date:   Wed, 7 Jan 2015 16:58:32 +0530
Message-ID: <1420630118-17198-12-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Prem Mallappa <pmallapp@broadcom.com>

Enable CPU_SUPPORTS_HUGEPAGES for XLP processors.

Signed-off-by: Prem Mallappa <pmallapp@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3289969..74a76da 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1532,6 +1532,7 @@ config CPU_XLP
 	select WEAK_REORDERING_BEYOND_LLSC
 	select CPU_HAS_PREFETCH
 	select CPU_MIPSR2
+	select CPU_SUPPORTS_HUGEPAGES
 	help
 	  Netlogic Microsystems XLP processors.
 endchoice
-- 
1.9.1
