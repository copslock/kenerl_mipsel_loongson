Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 16:55:42 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:50942 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22303015AbYJXPzd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 16:55:33 +0100
Received: from localhost (p4039-ipad210funabasi.chiba.ocn.ne.jp [58.88.123.39])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 02E42A8F0; Sat, 25 Oct 2008 00:55:26 +0900 (JST)
Date:	Sat, 25 Oct 2008 00:55:44 +0900 (JST)
Message-Id: <20081025.005544.92344156.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4900B6A8.30705@ru.mvista.com>
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
	<4900B6A8.30705@ru.mvista.com>
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
X-archive-position: 20935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 23 Oct 2008 21:38:48 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +	unsigned int sp = (cr >> 4) & 3;
> > +	unsigned int clock = gbus_clock / (4 - sp);
> > +	unsigned int cycle = 1000000000 / clock;
> 
>     Hm, couldn't all these values be calculated only once?
> 
> > +	unsigned int wt, shwt;
> > +
> > +	/* Minimum DIOx- active time */
> > +	wt = DIV_ROUND_UP(t->act8b, cycle) - 2;
> > +	/* IORDY setup time: 35ns */
> > +	wt = max(wt, DIV_ROUND_UP(35, cycle));
> 
>     Same comment about calculating only once...

Yes.  But are there any good place to hold calculated values?  I don't
think it is not worth to allocate a local structure just for holding
such values.  And this is not a critical path anyway :-)

> > +	/* actual wait-cycle is max(wt & ~1, 1) */
> > +	if (wt > 2 && (wt & 1))
> > +		wt++;
> > +	wt &= ~1;
> > +	/* Address-valid to DIOR/DIOW setup */
> 
>     It's really address valid to -CSx assertion and -CSx to -DIOx assertion
> setup time, and contrarywise, -DIOx to -CSx release and -CSx release to 
> address invalid hold time, so it actualy applies 4 times and so constitutes 
> -DIOx recovery time. It's worth to check if the minimum cycle time is reached 
> with the setup time -- for PIO mode 0, minimum setup is 70 ns, multiplying 
> that by 4 gives 280 ns recovery and adding 290 ns active time gives 570 ns 
> cycle while the minimum is 600 ns.  Luckily, PIO0 seems the only problematic 
> mode as I doubt that EBUS controller can do back-to-back IDE reads/writes 
> keeping address and/or -CSx asserted in-between amounting to recovery time 
> being only 2x/3x setup times -- in the worst, 2x case PIO mode 3 would also 
> have too little cycle/recovery time...

Oh I had not considered the total cycle time at all...  I agree with
your analysis that PIO0 is the only problematic case.

And I also noticed that the calculated shwt value can be begger than 7
(which is max SHWT value) on fast GBUS and slow drive.  I will add
some check for it.


I'll address all other issues too (and send incremental patch).
Thanks!

---
Atsushi Nemoto
