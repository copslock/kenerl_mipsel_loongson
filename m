Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 01:29:01 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:32289
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225397AbUBCB3A>; Tue, 3 Feb 2004 01:29:00 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 3 Feb 2004 01:29:54 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i131TQ1x002169;
	Tue, 3 Feb 2004 10:29:26 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Tue, 03 Feb 2004 10:30:25 +0900 (JST)
Message-Id: <20040203.103025.78702251.nemoto@toshiba-tops.co.jp>
To: jsun@mvista.com
Cc: macro@ds2.pg.gda.pl, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] enable genrtc for MIPS
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20040202131950.I18155@mvista.com>
References: <Pine.LNX.4.55.0401302012200.10311@jurand.ds.pg.gda.pl>
	<20040201.203005.74756858.anemo@mba.ocn.ne.jp>
	<20040202131950.I18155@mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 2 Feb 2004 13:19:50 -0800, Jun Sun <jsun@mvista.com> said:
>> By the way, with this patch, individual board can not implement
>> it's own genrtc routines.  How about making gen_rtc_time,
>> etc. pointer to functions to allow overrides?

jsun> Is this necessary?  How about letting us wait until there is a
jsun> sensible need?

OK, we can wait.  But still I suppose gen_rtc_time will become a
pointer sooner or later....

Anyway, I think using genrtc instead of mips-rtc is very good idea.
Thank you.

jsun> If I understand you correctly, you like to have board rtc read
jsun> routines to return a rtc structure instead of the unsigned long
jsun> integer.

jsun> There are actually boards which makes the current implementation
jsun> more efficient.  See vr4181.

I see.

jsun> In general, however, this is not a bad idea, just involving a
jsun> lot more board level changes.  I think it deserves another patch
jsun> or even debate.

Though I'm not have a real code yet, how about this idea?

1. Provide std_rtc_get_time (returns ulong) implemented with
   get_rtc_time (returns rtc struct) pointer.
2. Provide std_get_rtc_time (returns rtc struct) implemented with
   rtc_get_time returns ulong) pointer.
3. Each board implement its own rtc_get_time or get_rtc_time.
4. In generic time_init(), initialize rtc_get_time pointer or
   get_rtc_time pointer with std_rtc_get_time or std_get_rtc_time if
   they were NULL.

---
Atsushi Nemoto
