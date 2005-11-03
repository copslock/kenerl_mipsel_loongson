Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 14:13:22 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:45777 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133848AbVKCONF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Nov 2005 14:13:05 +0000
Received: from localhost (p4179-ipad210funabasi.chiba.ocn.ne.jp [58.88.123.179])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 282ADA8B5; Thu,  3 Nov 2005 23:13:51 +0900 (JST)
Date:	Thu, 03 Nov 2005 23:12:50 +0900 (JST)
Message-Id: <20051103.231250.25477564.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] remove mips_rtc_lock
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051103110552.GA3149@linux-mips.org>
References: <20051103.010240.41630907.anemo@mba.ocn.ne.jp>
	<20051103110552.GA3149@linux-mips.org>
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
X-archive-position: 9417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 3 Nov 2005 11:05:53 +0000, Ralf Baechle <ralf@linux-mips.org> said:

ralf> The difference between and get_rtc_time and rtc_get_time is less
ralf> than obvious.  Same for set_rtc_time and rtc_set_time ...

Sure.  Also I suppose majority of RTC prefer struct rtc_time than
unsigned long.  Is it time for redesign the mips RTC interface? ;-)

---
Atsushi Nemoto
