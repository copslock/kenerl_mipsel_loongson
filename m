Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 11:24:25 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2454 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574355AbXLLLYX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 11:24:23 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBCBNj62029796;
	Wed, 12 Dec 2007 11:23:45 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBCBNhOi029795;
	Wed, 12 Dec 2007 11:23:43 GMT
Date:	Wed, 12 Dec 2007 11:23:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cobalt fixes
Message-ID: <20071212112343.GA28868@linux-mips.org>
References: <20071211121220.GA10870@linux-mips.org> <20071211235001.8621bdb9.yoichi_yuasa@tripeaks.co.jp> <20071211153522.GB15843@linux-mips.org> <20071212075309.5172da92.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071212075309.5172da92.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 12, 2007 at 07:53:09AM +0900, Yoichi Yuasa wrote:

> > > > for non-subscribers.  Linus has reverted the offending patch
> > > > fd6e732186ab522c812ab19c2c5e5befb8ec8115 in question so now the PCI and
> > > > I/O port code needs to be fixed up to be able to handle such a setup.
> > > 
> > > It can be fixed my fix PCI resource patch.
> > > 
> > > http://www.linux-mips.org/archives/linux-mips/2007-01/msg00049.html
> > 
> > Modulo a codying style issue that one is the same as the pci.c segment of
> > the patch I've just posted.
> 
> This is a fix proposed before fd6e732186ab522c812ab19c2c5e5befb8ec8115. 
> This patch is still effective. 

Ah, I had already applied the identical patch yesterday.  Thanks anyway!

But it should be considered temporary.  For some configurations there is
no chance for this to work and the patch will probably get in my way for
the planned rewrite of the resource allocation.

  Ralf
