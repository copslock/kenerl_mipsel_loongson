Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 21:39:31 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:64239 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225253AbTCGVjb>;
	Fri, 7 Mar 2003 21:39:31 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h27LdKc24090;
	Fri, 7 Mar 2003 13:39:20 -0800
Date: Fri, 7 Mar 2003 13:39:19 -0800
From: Jun Sun <jsun@mvista.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Bruno Randolf <br1@4g-systems.de>,
	Alexander Popov <s_popov@prosyst.bg>,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Mycable XXS board
Message-ID: <20030307133919.P26071@mvista.com>
References: <3E689267.3070509@prosyst.bg> <1047040846.10649.10.camel@adsl.pacbell.net> <200303071647.13275.br1@4g-systems.de> <20030307101354.N26071@mvista.com> <3E68FD21.5050402@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E68FD21.5050402@embeddededge.com>; from dan@embeddededge.com on Fri, Mar 07, 2003 at 03:12:17PM -0500
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Mar 07, 2003 at 03:12:17PM -0500, Dan Malek wrote:
> Jun Sun wrote:
> 
> > More than likely this is due to the interrupt routing for USB controller
> > not being setup correctly.
> 
> How did you come to this conclusion?  Is this a PCI USB controller or the
> on-chip peripheral?  I have Au1xxx boards were on-chip usb is
> required and is working fine.  There aren't any options to configuring
> on-chip USB interrupts on Au1xxx.  It could just as likely be a Linux kernel
> configuration problem.  We know there is something amiss with Au1xxx USB
> in big endian mode, but all LE boards should work fine.
>

I have seen USB working under BE mode in many instances.  (Acutally
that I have two that work.).  I don't think endianess is the issue.

I have seen "number assign failures" a couple of times before, and it
is all because interrupt not routed correctedly.  That is where "more than
likely" comes from.

Of course, I have only dealt with PCI USB controllers.  On-chip ones may
have another set of additional issues that I am not aware of.

Jun
