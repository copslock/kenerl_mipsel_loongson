Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 21:40:35 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:51704 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225304AbSLQVke>;
	Tue, 17 Dec 2002 21:40:34 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBHLeB207386;
	Tue, 17 Dec 2002 13:40:11 -0800
Date: Tue, 17 Dec 2002 13:40:11 -0800
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
Message-ID: <20021217134011.M11575@mvista.com>
References: <20021216124009.D10178@mvista.com> <Pine.GSO.3.96.1021217131352.7289A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1021217131352.7289A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Dec 17, 2002 at 02:39:21PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Dec 17, 2002 at 02:39:21PM +0100, Maciej W. Rozycki wrote:
> > No MIPS boards are using do_slow_gettimeoffset().  We really should get
> > rid of it.
> 
>  I know none does at the moment.  But are you sure there is no system that
> would need it and might be supported one day?
>

I serisouly don't think so.  Moving forward every CPU will have a CPU counter,
which can be used for timeoffset purpose.  Even if it does not have one,
it will surely have some onboard high resolution timer, which can be used
to intra-jiffy offset purpose.

Anyway, this function is only defined in old-time.c, which will go away 
soon (hopefully). :-)

 
>  Here is an example (untested) code that I would recommend.  It sends
> explicit ACKs to the i8259As, which has the following advantages:
> 
<snip>

Cool.  This code works for me.

I studied it a little bit and I am convinced it is a better choice.
It should work for MIPS in general.

In my original code I did verify that the IRR bit is not cleared,
which apparently will be a problem in cases.

The only catch with your code is that we don't have iob() macro (which 
apparently is very useful).  Any suggestions on this?  Otherwise  
I will probably remove it.

Jun
