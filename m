Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2009 09:34:59 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:31958 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24053316AbZAFJey (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Jan 2009 09:34:54 +0000
Received: (qmail 8452 invoked from network); 6 Jan 2009 10:34:53 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 6 Jan 2009 10:34:53 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] Alchemy: time.c build fix
Date:	Tue,  6 Jan 2009 10:34:52 +0100
Message-Id: <1231234492-25733-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.6
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

in Linus' current -git the cpumask member is now a pointer.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 307514f..183180a 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -69,7 +69,7 @@ static struct clock_event_device au1x_rtcmatch2_clockdev = {
 	.irq		= AU1000_RTC_MATCH2_INT,
 	.set_next_event	= au1x_rtcmatch2_set_next_event,
 	.set_mode	= au1x_rtcmatch2_set_mode,
-	.cpumask	= CPU_MASK_ALL,
+	.cpumask	= CPU_MASK_ALL_PTR,
 };
 
 static struct irqaction au1x_rtcmatch2_irqaction = {
-- 
1.6.0.6
