Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 00:08:46 +0200 (CEST)
Received: from smtp02.mtu.ru ([62.5.255.49]:15832 "EHLO smtp02.mtu.ru")
	by lappi.linux-mips.net with ESMTP id S1100129AbYCaWHH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 00:07:07 +0200
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 6A49945350;
	Tue,  1 Apr 2008 02:05:25 +0400 (MSD)
Received: from localhost.localdomain (ppp85-140-79-111.pppoe.mtu-net.ru [85.140.79.111])
	by smtp02.mtu.ru (Postfix) with ESMTP id 5ECE6439E1;
	Tue,  1 Apr 2008 02:03:30 +0400 (MSD)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] [MIPS] make mdesc and prom_getmdesc() static
Date:	Tue,  1 Apr 2008 02:03:22 +0400
Message-Id: <1207001005-2633-4-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Neither the mdesc[] array nor the prom_getmdesc() function need to
be global. This patch makes them static.

Successfully build-tested using default configs for Malta, Atlas
and SEAD boards.

Runtime test successfully performed by booting the Malta 4Kc board
up to the shell prompt.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/generic/memory.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mips-boards/generic/memory.c b/arch/mips/mips-boards/generic/memory.c
index dc272c1..5e443bb 100644
--- a/arch/mips/mips-boards/generic/memory.c
+++ b/arch/mips/mips-boards/generic/memory.c
@@ -37,7 +37,7 @@ enum yamon_memtypes {
 	yamon_prom,
 	yamon_free,
 };
-struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];
+static struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];
 
 #ifdef DEBUG
 static char *mtypes[3] = {
@@ -50,7 +50,7 @@ static char *mtypes[3] = {
 /* determined physical memory size, not overridden by command line args  */
 unsigned long physical_memsize = 0L;
 
-struct prom_pmemblock * __init prom_getmdesc(void)
+static struct prom_pmemblock * __init prom_getmdesc(void)
 {
 	char *memsize_str;
 	unsigned int memsize;
-- 
1.5.3
