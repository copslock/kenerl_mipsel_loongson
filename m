Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 18:07:28 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:8700 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225223AbTCMSH1>;
	Thu, 13 Mar 2003 18:07:27 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA14833;
	Thu, 13 Mar 2003 10:07:16 -0800
Subject: Re: Mycable XXS board
From: Pete Popov <ppopov@mvista.com>
To: Bruno Randolf <br1@4g-systems.de>
Cc: linux-mips@linux-mips.org
In-Reply-To: <3E70C4F7.4030008@embeddededge.com>
References: <3E689267.3070509@prosyst.bg>
	 <200303131408.05612.br1@4g-systems.de> <3E70ABCE.9030909@embeddededge.com>
	 <200303131823.22343.br1@4g-systems.de>  <3E70C4F7.4030008@embeddededge.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1047578844.819.35.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 10:07:25 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, 2003-03-13 at 09:50, Dan Malek wrote:
> Bruno Randolf wrote:
> 
> > allright, i can do that - but doesn't this create a lot of unnecessary copied 
> > code?
> 
> Initially, perhaps, but over time similar software will be moved into
> common areas.  IMHO, it helps to keep these boards separate because
> it serves to remind us the XXS board is not a PB1500.  You may also
> find more things unique to your board, so the unique board configuration
> will become useful to isolate features.

I agree with that.  Everything that's in common between the Au boards
should be in the common directory, arch/mips/au1000/common. But like Dan
said, by the time you're done with the entire board port, you may find
other unique things to your board which require additional ifdefs, and
keeping the board separate would be cleaner.

If this a board that's available off the shelf to customers?

Pete


> Thanks.
> 
> 
> 	-- Dan
> 
> 
> 
> 
