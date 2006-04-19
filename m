Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Apr 2006 15:59:19 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:25563 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133360AbWDSO7E (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Apr 2006 15:59:04 +0100
Received: from localhost (p6027-ipad29funabasi.chiba.ocn.ne.jp [221.184.73.27])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B56CCAF80; Thu, 20 Apr 2006 00:11:36 +0900 (JST)
Date:	Thu, 20 Apr 2006 00:12:05 +0900 (JST)
Message-Id: <20060420.001205.11963701.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix ip27 build
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index cddf1ce..36b662e 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -122,7 +122,7 @@ again:
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
-		if (rtc_set_time(xtime.tv_sec) == 0) {
+		if (rtc_mips_set_time(xtime.tv_sec) == 0) {
 			last_rtc_update = xtime.tv_sec;
 		} else {
 			last_rtc_update = xtime.tv_sec - 600;
