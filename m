Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 11:52:57 +0100 (BST)
Received: from p508B5C3F.dip.t-dialin.net ([IPv6:::ffff:80.139.92.63]:43104
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225721AbUEKKw4>; Tue, 11 May 2004 11:52:56 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4BAqtxT023625;
	Tue, 11 May 2004 12:52:55 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4BAqtcR023624;
	Tue, 11 May 2004 12:52:55 +0200
Date: Tue, 11 May 2004 12:52:54 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Emmanuel Michon <em@realmagic.fr>
Cc: linux-mips@linux-mips.org
Subject: Re: new platform
Message-ID: <20040511105254.GA10172@linux-mips.org>
References: <1084199090.12536.1314.camel@avalon.france.sdesigns.com> <20040510214927.GB22442@linux-mips.org> <1084267342.2222.1348.camel@avalon.france.sdesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084267342.2222.1348.camel@avalon.france.sdesigns.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 11, 2004 at 11:22:22AM +0200, Emmanuel Michon wrote:

> > Whatever - the driver API to use is ioremap.
> 
> You mean that after basic probing you always access PCI devices thru the
> TLB?

No.  ioremap knows how to optimize this for physical addresses that are
mapped via KSEG1.  So this just doesn't matter to driver writers.

  Ralf
