Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 21:07:55 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:10744 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122118AbSKNUHz>;
	Thu, 14 Nov 2002 21:07:55 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gAEK7kS28873;
	Thu, 14 Nov 2002 12:07:46 -0800
Date: Thu, 14 Nov 2002 12:07:46 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: Re: explain to me how this works...
Message-ID: <20021114120746.E28717@mvista.com>
References: <20021005095335.B4079@lucon.org> <20021113174200.A2874@wumpus.internal.keyresearch.com> <20021114193924.A5610@linux-mips.org> <20021114113045.D1494@wumpus.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021114113045.D1494@wumpus.internal.keyresearch.com>; from lindahl@keyresearch.com on Thu, Nov 14, 2002 at 11:30:45AM -0800
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


Look like a good case for using kgdb....

Jun

On Thu, Nov 14, 2002 at 11:30:45AM -0800, Greg Lindahl wrote:
> On Thu, Nov 14, 2002 at 07:39:24PM +0100, Ralf Baechle wrote:
> 
> > Eh?  Nothing on MIPS should use socketcall(2);
> 
> OK, so let's say it's using socket(). How do I go about debugging
> this? I mean, I can start sprinkling printks all over the place, but is
> there a more clever way?
> 
> greg
> 
