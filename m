Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 02:02:11 +0200 (CEST)
Received: from smtp03.mtu.ru ([62.5.255.50]:48634 "EHLO smtp03.mtu.ru")
	by lappi.linux-mips.net with ESMTP id S1103055AbYDAX7T (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2008 01:59:19 +0200
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 6B21D18708A7;
	Wed,  2 Apr 2008 03:58:47 +0400 (MSD)
Received: from localhost.localdomain (ppp91-76-28-42.pppoe.mtu-net.ru [91.76.28.42])
	by smtp03.mtu.ru (Postfix) with ESMTP id 4E8531870894;
	Wed,  2 Apr 2008 03:58:47 +0400 (MSD)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] [MIPS] unexport rtc_mips_set_time()
Date:	Wed,  2 Apr 2008 03:58:37 +0400
Message-Id: <1207094318-21748-5-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

No users for the rtc_mips_set_time() routine exist outside of the
core kernel code. Therefore, EXPORT_SYMBOL(rtc_mips_set_time) is
useless, and this patch removes it.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/kernel/time.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index b45a709..d70ce5c 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -38,7 +38,6 @@ int __weak rtc_mips_set_time(unsigned long sec)
 {
 	return 0;
 }
-EXPORT_SYMBOL(rtc_mips_set_time);
 
 int __weak rtc_mips_set_mmss(unsigned long nowtime)
 {
-- 
1.5.3
