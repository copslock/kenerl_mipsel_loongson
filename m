Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 03:13:34 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:44072 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022210AbXJYCN0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 03:13:26 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 25 Oct 2007 11:13:24 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id BD91D42BEB;
	Thu, 25 Oct 2007 11:12:54 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id B2F3242BE2;
	Thu, 25 Oct 2007 11:12:54 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l9P2CjAF091071;
	Thu, 25 Oct 2007 11:12:52 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 25 Oct 2007 11:12:44 +0900 (JST)
Message-Id: <20071025.111244.126572117.nemoto@toshiba-tops.co.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] txx9tmr clockevent/clocksource driver (take 2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <471F9655.2010702@ru.mvista.com>
References: <20071025.013409.26096880.anemo@mba.ocn.ne.jp>
	<471F9655.2010702@ru.mvista.com>
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
X-archive-position: 17203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 24 Oct 2007 23:00:37 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +	if (tx4927_ccfgptr->ccfg & TX4927_CCFG_TINTDIS)
> > +		txx9_clockevent_init(TX4927_TMR_REG(0) & 0xfffffffffULL,
> > +				     TXX9_IRQ_BASE + 17,
> > +				     50000000);
> 
>     Wait, you're not registering TXx9 clocksource anyway, so it's only taking 
> space indeed.  Maybe we should register clock source/event regardless of the 
> value of CCFG.TINTDIS, and let them be selected according to rating?

Yes, I did not intentionally.  If new board developers wanted to use
txx9_clocksource (for some mysterious reason), he can register it.

For existing tx49 platform, no good reason to use txx9_clocksource.
The standard mips_clocksource can be used regardless of TINTDIS, and
mips_clocksource is _always_ has higher precision (and lightweight)
than txx9_clocksource.

And if you only registered txx9 clock source/event and did not use
them, those timer modules cannot be used for other purpose (for
example, pulse generator) anymore.  It looks overkill for me.

---
Atsushi Nemoto
