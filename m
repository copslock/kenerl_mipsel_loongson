Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Nov 2004 23:15:49 +0000 (GMT)
Received: from p508B62F0.dip.t-dialin.net ([IPv6:::ffff:80.139.98.240]:16218
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225247AbUK0XPo>; Sat, 27 Nov 2004 23:15:44 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iARNFhcp014365;
	Sun, 28 Nov 2004 00:15:43 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iARNFh5K014364;
	Sun, 28 Nov 2004 00:15:43 +0100
Date: Sun, 28 Nov 2004 00:15:43 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: sjhill@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20041127231543.GA14252@linux-mips.org>
References: <20041127061929Z8224786-1751+2584@linux-mips.org> <Pine.LNX.4.58L.0411272202100.12787@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0411272202100.12787@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 27, 2004 at 10:05:07PM +0000, Maciej W. Rozycki wrote:

> > Log message:
> > 	Clean up comments, add in new module parameter handling to get rid of compiler
> > 	warnings and Manish's printk patch for ethernet device names shown in email
> > 	(http://www.linux-mips.org/archives/linux-mips/2004-11/msg00116.html).
> 
>  Hmm, shouldn't that be:
> 
> if (sc->rx_hw_checksum == ENABLE)
>         printk(KERN_INFO "%s: enabling TCP rcv checksum\n", sc->sbm_dev->name);
> 
> Otherwise the report doesn't actually reflect the condition.
> 
>  I'll change it thus as obvious.

We're already printing way too much stuff and this is a not very useful
message so why not removing the whole thing for good ...

  Ralf
