Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 23:56:08 +0100 (BST)
Received: from p508B6C80.dip.t-dialin.net ([IPv6:::ffff:80.139.108.128]:59689
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225338AbUJNW4D>; Thu, 14 Oct 2004 23:56:03 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9EMts55013689;
	Fri, 15 Oct 2004 00:55:54 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9EMtrGp013688;
	Fri, 15 Oct 2004 00:55:53 +0200
Date: Fri, 15 Oct 2004 00:55:53 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Manish Lachwani <mlachwani@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
Message-ID: <20041014225553.GA13597@linux-mips.org>
References: <416DE31E.90509@mvista.com> <20041014191754.GB30516@linux-mips.org> <Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl> <416EFBAB.8050600@mvista.com> <Pine.LNX.4.58L.0410142327530.25607@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0410142327530.25607@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 14, 2004 at 11:32:25PM +0100, Maciej W. Rozycki wrote:

> > Honestly, I dont have the manual to determine the port address space 
> 
>  Well, have you considered getting one?

Afaik it's now available without NDA from http://swarm.broadcom.com .

> > bits. Hence, I set it to this value to MAX (i.e. 0xffffffff). Probably, 
> > should have mentioned that when sending the patch. Do you want me to try 
> > with this value (0x01ffffff) ?
> 
>  Absolutely -- unfortunately I cannot test the change myself ATM.

Sure, go ahead.  This btw should match with the pci_controller definition
which is looking fishy also.

  Ralf
