Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 17:51:44 +0200 (CEST)
Received: from smtp03.mtu.ru ([62.5.255.50]:4291 "EHLO smtp03.mtu.ru")
	by lappi.linux-mips.net with ESMTP id S525390AbYDBPvh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2008 17:51:37 +0200
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 74A76187078E;
	Wed,  2 Apr 2008 19:51:06 +0400 (MSD)
Received: from localhost.localdomain (ppp91-76-28-42.pppoe.mtu-net.ru [91.76.28.42])
	by smtp03.mtu.ru (Postfix) with ESMTP id 59765187077A;
	Wed,  2 Apr 2008 19:51:06 +0400 (MSD)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/5] [MIPS] op_model_mipsxx.c: make the save_perf_irq variable static
Date:	Wed,  2 Apr 2008 19:51:05 +0400
Message-Id: <1207151465-29257-1-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

The function pointer save_perf_irq introduced by the previous
patch in this series can become static.

Thanks for Atsushi Nemoto for pointing out the possibility.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
Hi Ralf,

If you find that the series is worth it, please pick up this
patch too. Thank you.

Dmitri

 arch/mips/oprofile/op_model_mipsxx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 12e840f..0a11727 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -31,7 +31,7 @@
 
 #define M_COUNTER_OVERFLOW		(1UL      << 31)
 
-int (*save_perf_irq)(void);
+static int (*save_perf_irq)(void);
 
 #ifdef CONFIG_MIPS_MT_SMP
 #define WHAT		(M_TC_EN_VPE | M_PERFCTL_VPEID(smp_processor_id()))
-- 
1.5.3
