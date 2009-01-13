Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 13:53:05 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:16794 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21103556AbZAMNxC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jan 2009 13:53:02 +0000
Received: (qmail 18397 invoked by uid 1000); 13 Jan 2009 14:49:58 +0100
Date:	Tue, 13 Jan 2009 14:49:58 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: [PATCH] Alchemy: time.c compile fix (cpumask)
Message-ID: <20090113134958.GA18314@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

The 'cpumask' member of struct clock_event_device is a pointer now.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 3288014..6fd441d 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -89,7 +89,7 @@ static struct clock_event_device au1x_rtcmatch2_clockdev = {
 	.irq		= AU1000_RTC_MATCH2_INT,
 	.set_next_event	= au1x_rtcmatch2_set_next_event,
 	.set_mode	= au1x_rtcmatch2_set_mode,
-	.cpumask	= CPU_MASK_ALL,
+	.cpumask	= CPU_MASK_ALL_PTR,
 };
 
 static struct irqaction au1x_rtcmatch2_irqaction = {
-- 
1.6.1
