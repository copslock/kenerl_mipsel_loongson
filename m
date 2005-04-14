Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2005 22:07:01 +0100 (BST)
Received: from god.demon.nl ([IPv6:::ffff:83.160.164.11]:23240 "EHLO
	god.dyndns.org") by linux-mips.org with ESMTP id <S8226031AbVDNVGq>;
	Thu, 14 Apr 2005 22:06:46 +0100
Received: by god.dyndns.org (Postfix, from userid 1005)
	id 6AECB4ECB5; Thu, 14 Apr 2005 23:06:45 +0200 (CEST)
Date:	Thu, 14 Apr 2005 23:06:45 +0200
From:	Henk <Henk.Vergonet@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Porting mips based routers
Message-ID: <20050414210645.GB30585@god.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Return-Path: <spam@god.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Henk.Vergonet@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Apr 14, 2005 at 07:05:27PM +0100, Ralf Baechle wrote:
> On Thu, Apr 14, 2005 at 06:26:34PM +0200, Henk wrote:
> > There's an initial wiki page on the openWRT site.
> > http://openwrt.org/Kernel26Firmware
> > 
> > If so I would like to see if we can set up some colaborative effort...
> 
> None of the code for the routers or ASICs has been contributed back to
> linux-mips.org so far so all you'll find there is a little blurb in the
> wiki and a bunch of pointers.

That little blurb in the wiki I contributed yesterday, in the hope of
raising some interest in the openwrt community ;)

I will try to see if I can get a list of 2.4 source files that need to
be contributed back to linux-mips.org, with a quick initial proposal on
how to migrate this to the 2.6 kernel tree.

The list can then be reviewed here (possibly added with comments on expected
code changes) and could serve as an initial porting roadmap.

Regards,
Henk
