Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 14:44:04 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:57995 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029143AbXLKOoC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Dec 2007 14:44:02 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBBEhUBF015851;
	Tue, 11 Dec 2007 14:43:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBBEhT8M015850;
	Tue, 11 Dec 2007 14:43:29 GMT
Date:	Tue, 11 Dec 2007 14:43:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cobalt fixes
Message-ID: <20071211144329.GA15843@linux-mips.org>
References: <20071211121220.GA10870@linux-mips.org> <20071211234026.f3de7e7f.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071211234026.f3de7e7f.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 11, 2007 at 11:40:26PM +0900, Yoichi Yuasa wrote:

> > Some may have been following the beginning of this thread on linux-kernel,
> > see for example
> > 
> >   http://www.opensubscriber.com/message/linux-kernel@vger.kernel.org/8161812.html
> > 
> > for non-subscribers.  Linus has reverted the offending patch
> > fd6e732186ab522c812ab19c2c5e5befb8ec8115 in question so now the PCI and
> > I/O port code needs to be fixed up to be able to handle such a setup.
> > 
> > A test report of this patch which is meant to be applied on top of
> > today's lmo git kernel on a Cobalt would be appreciated.
> 
> It breaks all I/O port device(LCD, tulip, VIA ata) drivers.

Thanks, I'll try to sort this out tonight when I'm hopefully going to have
access to an actual machine.

The bootup messages of the failing kernel might be interesting, if you have
them at hand.

  Ralf
