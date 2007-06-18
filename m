Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 16:52:06 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:39884 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023259AbXFRPwE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Jun 2007 16:52:04 +0100
Received: from localhost (p3065-ipad207funabasi.chiba.ocn.ne.jp [222.145.85.65])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CC1FEB363; Tue, 19 Jun 2007 00:50:43 +0900 (JST)
Date:	Tue, 19 Jun 2007 00:51:21 +0900 (JST)
Message-Id: <20070619.005121.118948229.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, macro@linux-mips.org, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80706180238r17da4434jcdee307b0385729b@mail.gmail.com>
References: <cda58cb80706170636kbff000cw849fa1d5ccf31152@mail.gmail.com>
	<20070618.011425.93018724.anemo@mba.ocn.ne.jp>
	<cda58cb80706180238r17da4434jcdee307b0385729b@mail.gmail.com>
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
X-archive-position: 15452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 18 Jun 2007 11:38:28 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> And it should write it's own clocksource support which would use
> different timer.

I suppose so.

> It shoud result in something like this:
> 
> unsigned __init get_freq(int cpu)
> {
> 	return 27UL * ((1000000UL * n)/(m * pow2p));
> }
> 
> void __init plat_timer_init()
> {
> 	struct cp0_hpt_info info;
> 
> 	info.get_freq = get_freq;
> 	info.irq = PNX8550_INT_TIMER1;
> 	setup_cp0_hpt(&info, CLKEVT_ONLY);
> 
> 	setup_my_clocksource_using_a_different_timer();
> }
> 
> Note that 'CLKEVT_ONLY' flag currently doesn't exist.
> 
> What do you think ?

For now, I think bloating generic setup_cp0_hpt() for this particular
chip is not good.  The pnx8550 can have customized copy of cp0_hpt
routines.  But it's just a thought...

---
Atsushi Nemoto
