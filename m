Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Apr 2004 13:52:56 +0100 (BST)
Received: from p508B6198.dip.t-dialin.net ([IPv6:::ffff:80.139.97.152]:27507
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224921AbUDZMwy>; Mon, 26 Apr 2004 13:52:54 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3QCqrxT020836;
	Mon, 26 Apr 2004 14:52:53 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3QCqrkT020835;
	Mon, 26 Apr 2004 14:52:53 +0200
Date: Mon, 26 Apr 2004 14:52:53 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alex Deucher <agd5f@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: few questions about linux on sgi machines
Message-ID: <20040426125253.GA20409@linux-mips.org>
References: <20040423131706.GA27375@lst.de> <20040423132901.97621.qmail@web11301.mail.yahoo.com> <20040423133106.GA27699@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423133106.GA27699@lst.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 23, 2004 at 03:31:06PM +0200, Christoph Hellwig wrote:

> On Fri, Apr 23, 2004 at 06:29:01AM -0700, Alex Deucher wrote:
> > I assume IP30 has the same problems since they are similarly
> > architected?
> 
> I guess it has the same problems as it's using the bridge ASIC, too.
> 
> > What about IP32?
> 
> It uses a completely different pci subsystem that should be okay.

It's not fully PCI compliant either ...

  Ralf
