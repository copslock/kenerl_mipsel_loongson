Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Feb 2004 11:24:28 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:2277 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225278AbUBALY1>; Sun, 1 Feb 2004 11:24:27 +0000
Received: from localhost (p5005-ipad32funabasi.chiba.ocn.ne.jp [221.189.137.5])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CA8926523; Sun,  1 Feb 2004 20:24:23 +0900 (JST)
Date: Sun, 01 Feb 2004 20:30:05 +0900 (JST)
Message-Id: <20040201.203005.74756858.anemo@mba.ocn.ne.jp>
To: macro@ds2.pg.gda.pl
Cc: jsun@mvista.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] enable genrtc for MIPS
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.55.0401302012200.10311@jurand.ds.pg.gda.pl>
References: <20040130103913.E31937@mvista.com>
	<Pine.LNX.4.55.0401302012200.10311@jurand.ds.pg.gda.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 30 Jan 2004 20:13:38 +0100 (CET), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:

>> Of course, individual board is still free to choose the old rtc.c
>> or implement some peculiar ones of its own - although I can't see
>> why. :)

macro>  s/old/full-featured/

No, I suppose s/rtc/mips-rtc/ is what the original patch means.

By the way, with this patch, individual board can not implement it's
own genrtc routines.  How about making gen_rtc_time, etc. pointer to
functions to allow overrides?

I think implementing rtc_get_time (mips specific) with get_rtc_time
(genrtc) is more efficient than implementing get_rtc_time with
rtc_get_time for most RTC chips.

---
Atsushi Nemoto
