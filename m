Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2007 16:35:18 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.174]:30613 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022115AbXEDPfQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 May 2007 16:35:16 +0100
Received: by ug-out-1314.google.com with SMTP id 40so585612uga
        for <linux-mips@linux-mips.org>; Fri, 04 May 2007 08:35:15 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=LOqRDPmNQi9mHy6zNYfTEJ7bIDS5J8huiCcvlKdRyOsrrzq5ZemZwtqZJPN/e1JWYP8oaF8+73Z9zxGeRdUe9U6ZRSkXBR+HG6d5Umxv570Tzw0BGhMp+zJcLe3okZRzesZ5YfCj5dXnswRm7JTPyQo7zMevOiLelcPWyyblCfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=J/jIny91Ino2wqa3AfVP0RJeW9Fw198M+JFbdJq9gClVh16d9EoPKtR5WNaMB2oiRjLXDqgke42OQexgWJBj9ZavqHoLUtlHd1+MOqewsaj4bhuBCQtXQBtwkgl5u2MBi1wXc3fRdpCmOCXQF/yiBx78OKzTNkrofAo2DQLQg+g=
Received: by 10.82.187.16 with SMTP id k16mr6791308buf.1178292915444;
        Fri, 04 May 2007 08:35:15 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id c25sm94823ika.2007.05.04.08.35.12;
        Fri, 04 May 2007 08:35:13 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id BFA7023F773; Fri,  4 May 2007 17:36:46 +0200 (CEST)
To:	ralf@linux-mips.org, anemo@mba.ocn.ne.jp
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 3/3] time: implement read_persistent_clock()
Date:	Fri,  4 May 2007 17:36:46 +0200
Message-Id: <1178293006620-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <11782930063123-git-send-email-fbuihuu@gmail.com>
References: <1178293006633-git-send-email-fbuihuu@gmail.com>
 <11782930063123-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This function is needed by timekeeping subsystem.

This also removes the need to setup xtime.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/time.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 5a4fd06..0d6efda 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -326,17 +326,16 @@ static void __init init_mips_clocksource(void)
 	clocksource_register(&clocksource_mips);
 }
 
+unsigned long read_persistent_clock(void)
+{
+	return rtc_mips_get_time();
+}
+
 void __init time_init(void)
 {
 	if (!rtc_mips_set_mmss)
 		rtc_mips_set_mmss = rtc_mips_set_time;
 
-	xtime.tv_sec = rtc_mips_get_time();
-	xtime.tv_nsec = 0;
-
-	set_normalized_timespec(&wall_to_monotonic,
-	                        -xtime.tv_sec, -xtime.tv_nsec);
-
 	/* Choose appropriate high precision timer routines.  */
 	if (!cpu_has_counter && !clocksource_mips.read)
 		/* No high precision timer -- sorry.  */
-- 
1.5.1.3
