Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 03:16:03 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:10004 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20026025AbXJWCPz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 03:15:55 +0100
Received: by mo.po.2iij.net (mo32) id l9N2EbLa078915; Tue, 23 Oct 2007 11:14:37 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l9N2EYBa016911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Oct 2007 11:14:35 +0900
Message-Id: <200710230214.l9N2EYBa016911@po-mbox301.hop.2iij.net>
Date:	Tue, 23 Oct 2007 11:15:58 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] add GT641xx timer0 clockevent
In-Reply-To: <20071023.100645.74754145.nemoto@toshiba-tops.co.jp>
References: <20071022194315.f75738ba.yoichi_yuasa@tripeaks.co.jp>
	<20071022.234755.45745247.anemo@mba.ocn.ne.jp>
	<200710230054.l9N0sVv7031267@po-mbox301.hop.2iij.net>
	<20071023.100645.74754145.nemoto@toshiba-tops.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 23 Oct 2007 10:06:45 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Tue, 23 Oct 2007 09:55:55 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > > These clockevent routines are always called with interrupt disabled,
> > > so I suppose those spin_lock_irqsave/spin_unlock_irqrestore pairs can
> > > be omitted. (or this timer can be used on SMP?)
> > 
> > Yes, it can be used on Malta(SMP).
> 
> Then spin_lock()/spin_unlock() is enough, isn't it?

The timer control register(GT_TC_CONTROL_OFS) is shared with 4 timers.
The 4 timers are connected with separate IRQ. 

clockevents_program_event() and clockevents_set_mode() can be called from
anywhere(in the kernel).

I think that it's necessary for it.

Yoichi
