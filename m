Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 22:31:43 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:25335 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225382AbUAMWbn>;
	Tue, 13 Jan 2004 22:31:43 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0DMVb529459;
	Tue, 13 Jan 2004 14:31:37 -0800
Date: Tue, 13 Jan 2004 14:31:37 -0800
From: Jun Sun <jsun@mvista.com>
To: Dimitri Torfs <dimitri@sonycom.com>
Cc: Pete Popov <ppopov@mvista.com>, kph@cisco.com,
	Linux MIPS mailing list <linux-mips@linux-mips.org>,
	jsun@mvista.com
Subject: Re: How stable is 2.6 on a SB1250 processor?
Message-ID: <20040113143137.N11733@mvista.com>
References: <1074027809.20636.91.camel@shakedown> <1074028164.21857.120.camel@zeus.mvista.com> <20040113214454.GA2737@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040113214454.GA2737@sonycom.com>; from dimitri@sonycom.com on Tue, Jan 13, 2004 at 10:44:54PM +0100
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 13, 2004 at 10:44:54PM +0100, Dimitri Torfs wrote:
> On Tue, Jan 13, 2004 at 01:09:25PM -0800, Pete Popov wrote:
> > 
> > I think userland is still broken. Ralf was working on the access_ok
> > problem the last time I talked to him.
> > 
> 
> Yes, if it's a 32-bit kernel then it's definitely broken. You might want
> to check out
> http://www.linux-mips.org/archives/linux-mips/2004-01/msg00000.html.
> 
> After that fix, user space stuff started to work for me.
> 

Yes, that is a temporary fix for the problem.

bcm1250 PCI still have issues though.  I have not looked into it.

What is troubling me most is either rockhopper nor malta works on 2.6.
With rockhopper I had to disable cache in order to run.  I
suspect there is something fundamental still not quite right, possibly
only affecting cache noncoherent systems.

More debugging fun ...

Jun
