Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:21:26 +0100 (CET)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:25502 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010172AbbAGLVYdZ5Jf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 12:21:24 +0100
X-IronPort-AV: E=Sophos;i="5.07,714,1413270000"; 
   d="scan'208";a="54298878"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw2-out.broadcom.com with ESMTP; 07 Jan 2015 03:55:51 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 7 Jan 2015 03:21:16 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 7 Jan 2015 03:21:31 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 0DC9140FE6;    Wed,  7 Jan 2015 03:20:28 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Shanghui Liu <shliu@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 01/17] MIPS: Netlogic: Fix wait for slave CPUs
Date:   Wed, 7 Jan 2015 16:58:22 +0530
Message-ID: <1420630118-17198-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44984
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

From: Shanghui Liu <shliu@broadcom.com>

For core 0, the condition of "cpu == bootcpu" is always true, so it
does not wait for other three threads to become ready. Fix this by
using correct check.

Signed-off-by: Shanghui Liu <shliu@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlp/wakeup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index e5f44d2..26d82f7 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -99,7 +99,7 @@ static int wait_for_cpus(int cpu, int bootcpu)
 	do {
 		notready = nlm_threads_per_core;
 		for (i = 0; i < nlm_threads_per_core; i++)
-			if (cpu_ready[cpu + i] || cpu == bootcpu)
+			if (cpu_ready[cpu + i] || (cpu + i) == bootcpu)
 				--notready;
 	} while (notready != 0 && --count > 0);
 
-- 
1.9.1
