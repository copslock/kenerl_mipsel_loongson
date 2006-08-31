Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Aug 2006 04:49:10 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:31781 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037628AbWHaDtI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 31 Aug 2006 04:49:08 +0100
Received: by mo.po.2iij.net (mo30) id k7V3mxRq052951; Thu, 31 Aug 2006 12:48:59 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id k7V3msr8000575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 31 Aug 2006 12:48:54 +0900 (JST)
Date:	Thu, 31 Aug 2006 12:48:54 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, pdh@colonel-panic.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 9/12] removed unused resources for Cobalt
Message-Id: <20060831124854.191dc51a.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060825001113.GA32490@linux-mips.org>
References: <20060822225755.55a055c0.yoichi_yuasa@tripeaks.co.jp>
	<20060824193121.GA23792@colonel-panic.org>
	<20060825081107.45e9996e.yoichi_yuasa@tripeaks.co.jp>
	<20060825001113.GA32490@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Fri, 25 Aug 2006 01:11:13 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Aug 25, 2006 at 08:11:07AM +0900, Yoichi Yuasa wrote:
> 
> > > Is this correct ? These resources maybe unused, but the registers are
> > > there, and should be listed as unavailable.
> > 
> > How about the change of them to "reserved"?
> 
> Afaik the SuperIO chip used in the Cobalt implements those registers but
> due to missing external circuitry touching some of these registers is
> dangerous.  Afaic that is the case for the PS/2 keyboard/mouse controller
> ports.  So those should be marked as reserved.  The remaining registers
> are implemented just not terribly useful, so I think what he have is
> probably right as it is.

OK, I'll update it.

Yoichi
