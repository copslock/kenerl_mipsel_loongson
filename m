Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2007 16:52:39 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:26380 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038946AbXBLQwe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Feb 2007 16:52:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7AB6DE1CD1;
	Mon, 12 Feb 2007 17:51:49 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ijkn9JVpVMFd; Mon, 12 Feb 2007 17:51:49 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 09B8FE1CA0;
	Mon, 12 Feb 2007 17:51:49 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l1CGq2BY012779;
	Mon, 12 Feb 2007 17:52:02 +0100
Date:	Mon, 12 Feb 2007 16:51:57 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] clean up ret_from_{irq,exception}
In-Reply-To: <20070212.234538.25910340.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0702121642010.31592@blysk.ds.pg.gda.pl>
References: <45C8A477.8070906@innova-card.com> <20070211.004020.79071872.anemo@mba.ocn.ne.jp>
 <cda58cb80702120044o6c434032pc2f3da68a7327097@mail.gmail.com>
 <20070212.234538.25910340.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2558/Mon Feb 12 13:54:21 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 12 Feb 2007, Atsushi Nemoto wrote:

> _ret_from_irq is used by dec/int-handler.S directly, so you should not
> remove it (though decstation_defconfig disables CONFIG_PREEMPT).
> 
> But looking at dec/int-handler.S again, I can not see why it uses
> _ret_from_irq, and why it manipulates TI_REGS($28) in handle_it ...
> 
> It seems dec/int-handler.S has been broken for a while.  I'll send a
> patch to fix it.  If it was ACKed, I ACK your patch.

 It works for me with 2.6.18 -- if it needs an update due to more recent 
changes, then I have not got there yet. ;-)  I plan to rewrite this bit in 
C if feasible like other platforms did too.

  Maciej
