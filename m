Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jun 2004 23:27:00 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:63222 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225787AbUFJW04>;
	Thu, 10 Jun 2004 23:26:56 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i5AMQqx6019684;
	Thu, 10 Jun 2004 15:26:52 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i5AMQqe5019683;
	Thu, 10 Jun 2004 15:26:52 -0700
Date: Thu, 10 Jun 2004 15:26:52 -0700
From: Jun Sun <jsun@mvista.com>
To: S C <theansweriz42@hotmail.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Kernel and monitor program
Message-ID: <20040610152652.J10411@mvista.com>
References: <BAY99-F42680lFxUe9t00012257@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <BAY99-F42680lFxUe9t00012257@hotmail.com>; from theansweriz42@hotmail.com on Thu, Jun 10, 2004 at 10:17:52PM +0000
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Jun 10, 2004 at 10:17:52PM +0000, S C wrote:
> Hello all,
> 
> Please pardon the newbie question, but I was wondering what a kernel in 
> general expects a monitor program/bootloader like YAMON to do for it 
> beforehand, if anything at all. I know the answer is very board specific, 
> but if there are any generic things that a kernel expects ready for it 
> before it starts running (caches initialized already? SDRAM control regs set 
> up? Or maybe the kernel has no expectations at all?), I'd be grateful if 
> someone could point them out.

This is almost an FAQ.  (although I don't know if I am giving the
same answer each time ;0)

. initialize system RAM and its controller
. copy kernel to RAM (in normal cases, unless you do XIP)
. initialize and enable cache
. (optionally) pass some args to kernel
. (optionally) initial some board hw.  This is really a negotiation 
   between loader and linux board setup routine.

Jun
