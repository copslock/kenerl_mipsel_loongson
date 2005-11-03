Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 13:37:39 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:7893 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133847AbVKCNhV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Nov 2005 13:37:21 +0000
Received: from localhost (p4179-ipad210funabasi.chiba.ocn.ne.jp [58.88.123.179])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C23D1A2C1; Thu,  3 Nov 2005 22:38:05 +0900 (JST)
Date:	Thu, 03 Nov 2005 22:37:05 +0900 (JST)
Message-Id: <20051103.223705.74752861.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] use rtc_lock to protect RTC operations
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.55.0511031305280.24109@blysk.ds.pg.gda.pl>
References: <20051103.010115.07642880.anemo@mba.ocn.ne.jp>
	<20051103125926.GB3149@linux-mips.org>
	<Pine.LNX.4.55.0511031305280.24109@blysk.ds.pg.gda.pl>
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
X-archive-position: 9416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 3 Nov 2005 13:15:32 +0000 (GMT), "Maciej W. Rozycki" <macro@linux-mips.org> said:

>> Unlike on PC CMOS_READ on a DEC is a single read operation, so
>> atomic and so doesn't need to be protected.  I'd have to check the
>> datasheet for any other reason why it might need locking though, so
>> I apply your patch for now and leave this to Maciej for later
>> optimization.

macro>  You are correct -- unless you need to perform multiple RTC
macro> access cycles uninterrupted in a row, a lock is not needed.

Then the dec_rtc_is_updating would be one liner:

	return (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);

What good hardware!

---
Atsushi Nemoto
