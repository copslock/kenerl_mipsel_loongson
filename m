Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Aug 2004 21:14:20 +0100 (BST)
Received: from p508B7861.dip.t-dialin.net ([IPv6:::ffff:80.139.120.97]:24685
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225011AbUHSUOQ>; Thu, 19 Aug 2004 21:14:16 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7JKE9R8032683;
	Thu, 19 Aug 2004 22:14:09 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7JKE8r2032682;
	Thu, 19 Aug 2004 22:14:08 +0200
Date: Thu, 19 Aug 2004 22:14:08 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] ioc3-eth.c: add missing pci_enable_device()
Message-ID: <20040819201408.GA32343@linux-mips.org>
References: <200408041538.21128.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408041538.21128.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 04, 2004 at 03:38:21PM -0600, Bjorn Helgaas wrote:

> I don't have this hardware, so this has not been tested.

Sure, it's SGI hw ;-)

> Add pci_enable_device()/pci_disable_device().  In the past, drivers
> often worked without this, but it is now required in order to route
> PCI interrupts correctly.

Applied.

  Ralf
