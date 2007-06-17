Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jun 2007 18:22:42 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:51419 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023025AbXFQRWk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Jun 2007 18:22:40 +0100
Received: from localhost (p1058-ipad201funabasi.chiba.ocn.ne.jp [222.146.64.58])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C1506AF49; Mon, 18 Jun 2007 02:22:36 +0900 (JST)
Date:	Mon, 18 Jun 2007 02:23:14 +0900 (JST)
Message-Id: <20070618.022314.108738340.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070617000448.GA30807@linux-mips.org>
References: <11818164024053-git-send-email-fbuihuu@gmail.com>
	<20070614.212913.82089068.nemoto@toshiba-tops.co.jp>
	<20070617000448.GA30807@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 17 Jun 2007 01:04:48 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> [MIPS] Switch from to_tm to rtc_time_to_tm
> 
> This replaces the MIPS-specific to_tm function with the generic
> rtc_time_to_tm function.  The big difference between the two functions is
> that rtc_time_to_tm uses epoch 70 while to_tm uses 1970, so the result of
> rtc_time_to_tm needs to be fixed up.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Thanks, looks good to me except a few things.

>  arch/mips/momentum/jaguar_atx/setup.c  |    8 ++++-

Zombie? ;)

>  arch/mips/momentum/ocelot_c/setup.c    |    8 ++++-

Likely zombie?

>  include/asm-mips/time.h                |    7 ----
>  12 files changed, 36 insertions(+), 73 deletions(-)

And on more.

diff --git a/include/asm-mips/rtc.h b/include/asm-mips/rtc.h
index 82ad401..42d049f 100644
--- a/include/asm-mips/rtc.h
+++ b/include/asm-mips/rtc.h
@@ -33,8 +33,7 @@ static inline unsigned int get_rtc_time(struct rtc_time *time)
 	unsigned long nowtime;
 
 	nowtime = rtc_mips_get_time();
-	to_tm(nowtime, time);
-	time->tm_year -= 1900;
+	rtc_time_to_tm(nowtime, time);
 
 	return RTC_24H;
 }

---
Atsushi Nemoto
