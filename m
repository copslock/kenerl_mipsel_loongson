Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Sep 2008 13:32:21 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:29131 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28598908AbYIMMcT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 13 Sep 2008 13:32:19 +0100
Received: from localhost (p1248-ipad201funabasi.chiba.ocn.ne.jp [222.146.64.248])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 33AC6BB73; Sat, 13 Sep 2008 21:32:14 +0900 (JST)
Date:	Sat, 13 Sep 2008 21:32:26 +0900 (JST)
Message-Id: <20080913.213226.106262199.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48CAA498.9090804@ru.mvista.com>
References: <48CA8BEE.1090305@ru.mvista.com>
	<20080913.005904.07457691.anemo@mba.ocn.ne.jp>
	<48CAA498.9090804@ru.mvista.com>
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
X-archive-position: 20483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 12 Sep 2008 21:19:20 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > Well, let me explain a bit.  The datasheed say I should wait _both_
> > XFERINT and HOST interrupt.  So, if only one of them was asserted, I
> > mask it and wait another one.  But on the error case, only HOST was
> > asserted and XFERINT was never asserted.  Then I could not exit from
> > "waiting another one" state, until timeout.
> 
>     Hmm, I got it: you decide whether it's worth waiting more for XFEREND 
> interrupt based on whether ERR is set or not. I suppose IDE_INT doesn't get 
> set in case the command gets endede with ERR set?

IIRC, yes.  And anyway, the interrupt signal from this controller to
CPU is not asserted because HOSTINT was masked by int_ctl register to
wait for XFERINT interrupt.

So, regardless of IDE_INT was set or not, no more interrupt raised to
CPU.

Many of strangeness of interrupt handling in this driver is based on
the fact that the IDE_INT bit in DMA status register does not refrect
the controllers interrupt status directly.  And the implementation of
the IDE_INT bit is actually broken.  Claring the IDE_INT bit also
clears all mask bits in int_ctl registers.  Usually this sort of
behaviour is called "bug". ;)

---
Atsushi Nemoto
