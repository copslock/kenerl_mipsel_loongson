Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2006 15:40:26 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:46037 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28583435AbWLTPkV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Dec 2006 15:40:21 +0000
Received: from localhost (p3074-ipad206funabasi.chiba.ocn.ne.jp [222.145.77.74])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 02B90C32C; Thu, 21 Dec 2006 00:40:18 +0900 (JST)
Date:	Thu, 21 Dec 2006 00:40:17 +0900 (JST)
Message-Id: <20061221.004017.21363332.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	danieljlaird@hotmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: 2.6.19 timer API changes
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <458948C5.4050909@ru.mvista.com>
References: <7949125.post@talk.nabble.com>
	<20061220.021508.97296486.anemo@mba.ocn.ne.jp>
	<458948C5.4050909@ru.mvista.com>
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
X-archive-position: 13491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 20 Dec 2006 17:29:25 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > How about this?  You should still fix pnx8550_hpt_read() anyway, but I
> > suppose gettimeofday() on PNX8550 was broken long time.
> 
>     And nobody noticed. :-)

I changed my mind a bit.  The pre-clocksource gettimeofday() might
work well on PNX8550.  There was timerlo variable which hold COUNT
value on last timer interrupt and fixed_gettimeoffset() subtracted
timerlo from COUNT value at the time.

On Wed, 20 Dec 2006 17:29:25 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> > +static cycle_t pnx8550_hpt_read(void)
> > +{
> > +	/* FIXME: we should use timer2 or timer3 as freerun counter */
> > +	return read_c0_count();
>  > +}
> 
>     I'd suggest read_c0_count2() here, possibly adding an interrupt
> handler for it since it will interrupt upon hitting compare2
> reg. value (but we could probably just mask the IRQ off), and
> enabling the timer 2, of course (the current code disables it)...

It would be right direction.  And we should set set count2 frequency
to mips_hpt_frequency.  But I cannot test it by myself so I'd like to
leave it for others.  Good exercise ;)

---
Atsushi Nemoto
