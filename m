Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 18:14:02 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:51696 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225203AbTCGSOC>;
	Fri, 7 Mar 2003 18:14:02 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h27IDsX17772;
	Fri, 7 Mar 2003 10:13:54 -0800
Date: Fri, 7 Mar 2003 10:13:54 -0800
From: Jun Sun <jsun@mvista.com>
To: Bruno Randolf <br1@4g-systems.de>
Cc: Alexander Popov <s_popov@prosyst.bg>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: Mycable XXS board
Message-ID: <20030307101354.N26071@mvista.com>
References: <3E689267.3070509@prosyst.bg> <1047040846.10649.10.camel@adsl.pacbell.net> <200303071647.13275.br1@4g-systems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200303071647.13275.br1@4g-systems.de>; from br1@4g-systems.de on Fri, Mar 07, 2003 at 04:47:13PM +0100
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Mar 07, 2003 at 04:47:13PM +0100, Bruno Randolf wrote:
> hello!
> 
> we are also working with this board and it it supported thru the Pb1500 board 
> configuration of the linux-mips.org kernel. we use the 2_4 branch and some 
> patches of pete (ftp://ftp.linux-mips.org/pub/linux/mips/people/ppopov). with 
> these patches i can already see my pci cards (but i dont yet have a driver 
> for them). usb does not yet work - it complains that it cannot assign new 
> numbers to the devices. 

More than likely this is due to the interrupt routing for USB controller
not being setup correctly.

Jun
