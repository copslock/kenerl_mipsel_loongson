Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2009 22:35:27 +0200 (CEST)
Received: from mail.upwardaccess.com ([70.89.180.121]:2199 "EHLO
	upwardaccess.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493444AbZIWUfU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Sep 2009 22:35:20 +0200
Received: from hawaii.upwardaccess.com (unverified [10.61.7.126]) 
	by upwardaccess.com (SurgeMail 3.9e) with ESMTP id 913858-1847469 
	for multiple; Wed, 23 Sep 2009 13:34:46 -0700
Received: by hawaii.upwardaccess.com (Postfix, from userid 500)
	id E25F235425B; Wed, 23 Sep 2009 13:35:09 -0700 (PDT)
From:	Mark Mason <mmason@upwardaccess.com>
To:	ralf@linux-mips.org, glowingpurple@gmail.com,
	linux-mips@linux-mips.org
Cc:	Mark Mason <mmason@upwardaccess.com>
Subject: [PATCH] Sibyte: fix compilation error.
Date:	Wed, 23 Sep 2009 13:35:09 -0700
Message-Id: <1253738109-29457-1-git-send-email-mmason@upwardaccess.com>
X-Mailer: git-send-email 1.6.0.2
X-Originating-IP: 10.61.7.126
X-Authenticated-User: mmason@upwardaccess.com 
Return-Path: <mason@upwardaccess.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmason@upwardaccess.com
Precedence: bulk
X-list: linux-mips

---
 arch/mips/sibyte/swarm/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 623ffc9..5277aac 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -106,7 +106,7 @@ void read_persistent_clock(struct timespec *ts)
 		break;
 	}
 	ts->tv_sec = sec;
-	tv->tv_nsec = 0;
+	ts->tv_nsec = 0;
 }
 
 int rtc_mips_set_time(unsigned long sec)
-- 
1.6.0.2
