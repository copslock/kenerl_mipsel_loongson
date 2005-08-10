Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2005 14:59:02 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:32778 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225233AbVHJN6q>; Wed, 10 Aug 2005 14:58:46 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7AE2iSv012086;
	Wed, 10 Aug 2005 15:02:44 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7AE2hWl012085;
	Wed, 10 Aug 2005 15:02:43 +0100
Date:	Wed, 10 Aug 2005 15:02:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 24K malta
Message-ID: <20050810140243.GD2840@linux-mips.org>
References: <42FA03D4.5060400@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FA03D4.5060400@timesys.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 10, 2005 at 09:40:36AM -0400, Greg Weeks wrote:

> I'm seeing something strange on a 24K malta and I'm wondering if anyone 
> else has ran into something like it.
> 
> This is a 2.6.12 based kernel. I've not had a chance to try the current 
> CVS yet. The last time I checked the current CVS didn't boot as is on a 
> 4Kc malta so I've not been keeping current with CVS.
> 
> When I try a simple
> 
> strace ls
> 
> I either hang or seg fault on a 24Kc or 24Kec processor, but a 4Kc or 
> 4Kec works. If I turn off the cache on the 24K it works as well. Without 
> cache it's unbearably slow of course. This is the same exact build of 
> the kernel and root file system for all boards.

I cannot reproduce this problem on 24KEc Malta, sorry.

  Ralf
