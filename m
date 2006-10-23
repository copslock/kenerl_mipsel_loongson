Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 04:01:05 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:10128 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038922AbWJWDBD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Oct 2006 04:01:03 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 23 Oct 2006 12:01:02 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 682EC41860;
	Mon, 23 Oct 2006 12:01:00 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 4F1DE418AA;
	Mon, 23 Oct 2006 12:01:00 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9N30xW0085548;
	Mon, 23 Oct 2006 12:00:59 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 23 Oct 2006 12:00:59 +0900 (JST)
Message-Id: <20061023.120059.63742109.nemoto@toshiba-tops.co.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, tglx@linutronix.de,
	johnstul@us.ibm.com
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <453BC5B4.50005@ru.mvista.com>
References: <20061023.033407.104640794.anemo@mba.ocn.ne.jp>
	<453BC5B4.50005@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 22 Oct 2006 23:25:40 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >  arch/mips/au1000/common/time.c          |   98 ----------
> 
>     If the generic implementation is working well, the Alchemy code doesn't 
> need its own anymore. However, my patch that fixes the mips_hpt_frequency 
> calculation needs to be applied first before deleing this code. I'll try to 
> look into this and test some time...

Hmm, mips_hpt_frequency would be bad than lesser resolution.  Please
push your fix to Ralf again ;)

> > +static unsigned int jmr3927_hpt_read(void)
> > +{
> > +	unsigned int count;
> > +	unsigned long j;
> > +	/* read consistent jiffies and counter */
> > +	do {
> > +		count = jmr3927_tmrptr->trr;
> > +		j = jiffies;
> > +	} while (count > jmr3927_tmrptr->trr);
> > +	return j * (JMR3927_TIMER_CLK / HZ) + count;
> > +}
> 
>     That emulation trick looks very dubious. I'd suggest to implement a 
> different clocksource driver instead, since this is, after all, is not a CPU 
> counter. And this will get in the way of the clockevent implementation later. 
>   Also, it's stops to be continuous this way. And I don't understand why you 
> need this trick at all if you have the variable mips_hpt_mask...
>     And the same complaint about BCM1480 code.

This trick is due to range of TRR register.  The width of the counter
field is 24bit, but the range is not 0 - 0xffffff.  It wraps at some
non-all-F value.  So mips_hpt_mask can not help this.

But this loop is not correct indeed.  If it called without xtime_lock
and interrupt disabled, it would return wrong value.  I should think
again ...

>     Well, I'd vote against the generic implementation. It's not
> quite correct to call all the diverse timers here "MIPS", IMHO...

How about calling it "MIPS-hpt" or something?

---
Atsushi Nemoto
