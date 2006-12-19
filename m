Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2006 14:34:21 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:60610 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28576869AbWLSOeQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2006 14:34:16 +0000
Received: from localhost (p7053-ipad211funabasi.chiba.ocn.ne.jp [58.91.163.53])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CB604BA43; Tue, 19 Dec 2006 23:34:10 +0900 (JST)
Date:	Tue, 19 Dec 2006 23:34:10 +0900 (JST)
Message-Id: <20061219.233410.25911550.anemo@mba.ocn.ne.jp>
To:	danieljlaird@hotmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.19 timer API changes
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <7943218.post@talk.nabble.com>
References: <7925588.post@talk.nabble.com>
	<7943218.post@talk.nabble.com>
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
X-archive-position: 13466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 19 Dec 2006 00:17:24 -0800 (PST), Daniel Laird <danieljlaird@hotmail.com> wrote:
> When I run the kernel it hangs in the calibrate_delay function. 
> Eventually the complete kernel does run but it runs very slow. 
> This is usually an issue with the Timer Interuppt setup etc.  But I have
> looked at the other MIPS ports and seem to have made the same changes. 
> 
> On the PNX8550 it does not use the CP0 timer but use a different timer (the
> Custom MIPS core has 3 extra timers) 

Hmm, do the TIMER1 and CP0_COUNTER run at same speed?  If no, the
PNX8550 port should be broken (i.e. gettimeofday() did not work
properly) even without the timer API changes.  You should provide
custom clocksource.mips_read (previously named mips_hpt_read) function
which returns TIMER1 counter value.  If the TIMER1 was not 32-bit
free-run counter, some trick would be required.  Refer sb1250 or
jmr3927 for example.

---
Atsushi Nemoto
