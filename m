Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Mar 2003 15:16:55 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:27377 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225193AbTCKPQz>;
	Tue, 11 Mar 2003 15:16:55 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id HAA20341;
	Tue, 11 Mar 2003 07:16:48 -0800
Subject: Re: Mycable XXS board
From: Pete Popov <ppopov@mvista.com>
To: Bruno Randolf <br1@4g-systems.de>
Cc: linux-mips@linux-mips.org
In-Reply-To: <200303111130.57387.br1@4g-systems.de>
References: <3E689267.3070509@prosyst.bg> <20030307133919.P26071@mvista.com>
	 <3E691514.7000907@embeddededge.com>  <200303111130.57387.br1@4g-systems.de>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1047395856.5198.127.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 07:17:36 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-03-11 at 02:30, Bruno Randolf wrote:
> On Friday 07 March 2003 22:54, Dan Malek wrote:
> 
> > That's what I wanted to clarify.  Are we discussing one of the on-chip
> > peripheral USB controllers of the Au1xxx, or is it a PCI USB controller
> > that was plugged into the Au1500.  In the case of the on-chip controller,
> > there aren't any interrupt routing problems, it's identical (and the same
> > code) on all Au1xxx boards.
> 
> we are discussing the on-chip USB controller for the mycable board. and its 
> little endian...
> 
> any ideas where the assignment errors could come from in this case?

There wouldn't be any. So the problem is not irq assignment related.

I'm not what to suggest here but it feels like it might be a hardware
issue.  Try adding some printks (the abatron bdi jtag debugger works
great if you have one) and narrow down what's going on. Do you have any
jumpers on the board that are not setup correctly?


Pete
