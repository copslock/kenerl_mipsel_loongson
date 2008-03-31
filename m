Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 00:10:17 +0200 (CEST)
Received: from smtp02.mtu.ru ([62.5.255.49]:33753 "EHLO smtp02.mtu.ru")
	by lappi.linux-mips.net with ESMTP id S1100135AbYCaWHr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 00:07:47 +0200
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 4CC3644161;
	Tue,  1 Apr 2008 02:04:40 +0400 (MSD)
Received: from localhost.localdomain (ppp85-140-79-111.pppoe.mtu-net.ru [85.140.79.111])
	by smtp02.mtu.ru (Postfix) with ESMTP id C1FE044654;
	Tue,  1 Apr 2008 02:03:33 +0400 (MSD)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] [MIPS] make plat_perf_setup() static
Date:	Tue,  1 Apr 2008 02:03:23 +0400
Message-Id: <1207001005-2633-5-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

There is no need for the plat_perf_setup() function to be global,
so make it static.

Successfully build-tested using default configs for Malta, Atlas
and SEAD boards.

Runtime test successfully performed by booting the Malta 4Kc board
up to the shell prompt.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/generic/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
index b50e0fc..a6eece7 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -127,7 +127,7 @@ unsigned long read_persistent_clock(void)
 	return mc146818_get_cmos_time();
 }
 
-void __init plat_perf_setup(void)
+static void __init plat_perf_setup(void)
 {
 	cp0_perfcount_irq = -1;
 
-- 
1.5.3
