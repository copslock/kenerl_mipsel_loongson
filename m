Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 21:11:34 +0100 (BST)
Received: from p508B7E6E.dip.t-dialin.net ([IPv6:::ffff:80.139.126.110]:64546
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225288AbUDTULc>; Tue, 20 Apr 2004 21:11:32 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3KKBTxT024774;
	Tue, 20 Apr 2004 22:11:29 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3KKBT62024773;
	Tue, 20 Apr 2004 22:11:29 +0200
Date: Tue, 20 Apr 2004 22:11:28 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20040420201128.GC24025@linux-mips.org>
References: <20040420163230Z8225288-1530+99@linux-mips.org> <20040420105116.C22846@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420105116.C22846@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 20, 2004 at 10:51:16AM -0700, Jun Sun wrote:

> CONFIG_PCI_AUTO was meant to a board attribute.  It should not be changed
> to be a choice at the first place.
> 
> And, the code is not bOrked.  In 2.4 it is a life saver for most MIPS boards
> whose firmware do not do a proper or full PCI resource assignment.

drivers/pci can do that, you just need to supply a few board specific
functions, see for example arch/alpha/kernel/pci.c.  So pci_auto.c isn't
only b0rked, it also duplicates code.

  Ralf
