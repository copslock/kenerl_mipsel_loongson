Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jun 2004 18:05:37 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:60407 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225206AbUFRRFc>;
	Fri, 18 Jun 2004 18:05:32 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i5IH5U4O003395;
	Fri, 18 Jun 2004 10:05:30 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i5IH5Ujw003394;
	Fri, 18 Jun 2004 10:05:30 -0700
Date: Fri, 18 Jun 2004 10:05:30 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: Re: "No such device" with PCI card
Message-ID: <20040618100530.B3142@mvista.com>
References: <40CEBB36.1030707@kilimandjaro.dyndns.org> <20040618024155.35970.qmail@web16605.mail.tpe.yahoo.com> <20040618061927.GU20632@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040618061927.GU20632@lug-owl.de>; from jbglaw@lug-owl.de on Fri, Jun 18, 2004 at 08:19:28AM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Jun 18, 2004 at 08:19:28AM +0200, Jan-Benedict Glaw wrote:
> On Fri, 2004-06-18 10:41:55 +0800, jospehchan <jospehchan@yahoo.com.tw>
> wrote in message <20040618024155.35970.qmail@web16605.mail.tpe.yahoo.com>:
> > Hi Jan-Benedict,
> >  Thanks. Please refer to the follownig replies. 
> 
> (By the way, think about changing you email client's configuration...)
> 
> > - What kind of MIPS system do you use *exactly*? What
> > board? Which
> >   kernel version? From where did you get your sources.
> > 
> > >>>The MIPS system is R3000 and uses an ADI Media
> > Adapter MB.
> > The kernel is 2.4.16 from the vendor and plus an USB
> > patch which backported from kernel 2.4.26.
> 
> First off, I didn't easily find information for that board...
> 
> Then, porting direction was wrong. You want to diff out vendor's changes
> ontop vanilla 2.4.16 (probably they've started off the mvista or the
> linux-mips.org kernel) and port *those* to current 2.4.x (of same
> vendor, preferring linux-mips.org ...). 

Not from mvista for sure.  We never released a kernel based on 2.4.16.
Also never heard of the board.

Jun
