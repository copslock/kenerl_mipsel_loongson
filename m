Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 00:06:37 +0200 (CEST)
Received: from smtp02.mtu.ru ([62.5.255.49]:57302 "EHLO smtp02.mtu.ru")
	by lappi.linux-mips.net with ESMTP id S1100126AbYCaWG0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 00:06:26 +0200
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 04FDE451D6;
	Tue,  1 Apr 2008 02:04:01 +0400 (MSD)
Received: from localhost.localdomain (ppp85-140-79-111.pppoe.mtu-net.ru [85.140.79.111])
	by smtp02.mtu.ru (Postfix) with ESMTP id 657294565A;
	Tue,  1 Apr 2008 02:03:27 +0400 (MSD)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] [MIPS] make mips_ejtag_setup() static
Date:	Tue,  1 Apr 2008 02:03:21 +0400
Message-Id: <1207001005-2633-3-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

This change makes the needlessly global function mips_ejtag_setup() static.

Successfully build-tested using default configs for Malta, Atlas
and SEAD boards.

Runtime test successfully performed by booting the Malta 4Kc board
up to the shell prompt.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/generic/init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mips-boards/generic/init.c b/arch/mips/mips-boards/generic/init.c
index 70dd9f4..80e5504 100644
--- a/arch/mips/mips-boards/generic/init.c
+++ b/arch/mips/mips-boards/generic/init.c
@@ -238,7 +238,7 @@ static void __init mips_nmi_setup(void)
 	flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
 }
 
-void __init mips_ejtag_setup(void)
+static void __init mips_ejtag_setup(void)
 {
 	void *base;
 	extern char except_vec_ejtag_debug;
-- 
1.5.3
