Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2010 19:19:01 +0100 (CET)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:7366 "EHLO
        sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491050Ab0KXSSx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Nov 2010 19:18:53 +0100
Authentication-Results: sj-iport-1.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAFrm7EyrRN+K/2dsb2JhbACjBHGjUJtGhUcEhFuLGA
X-IronPort-AV: E=Sophos;i="4.59,249,1288569600"; 
   d="scan'208";a="384426229"
Received: from sj-core-4.cisco.com ([171.68.223.138])
  by sj-iport-1.cisco.com with ESMTP; 24 Nov 2010 18:18:25 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-4.cisco.com (8.13.8/8.14.3) with ESMTP id oAOIIPCX002523;
        Wed, 24 Nov 2010 18:18:25 GMT
Date:   Wed, 24 Nov 2010 10:18:26 -0800
From:   David VomLehn <dvomlehn@cisco.com>
To:     Michael Ellerman <michael@ellerman.id.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        microblaze-uclinux@itee.uq.edu.au,
        devicetree-discuss@lists.ozlabs.org,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        sparclinux@vger.kernel.org
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Message-ID: <20101124181825.GA17112@dvomlehn-lnx2.corp.sa.net>
References: <1290607413.12457.44.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1290607413.12457.44.camel@concordia>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Thu, Nov 25, 2010 at 01:03:33AM +1100, Michael Ellerman wrote:
> Hi all,
> 
> There were some murmurings on IRC last week about renaming the of_*()
> routines. I was procrastinating at the time and said I'd have a look at
> it, so here I am.
> 
> The thinking is that on many platforms that use the of_() routines
> OpenFirmware is not involved at all, this is true even on many powerpc
> platforms. Also for folks who don't know the OpenFirmware connection it
> reads as "of", as in "a can of worms".
> 
> Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
> it would be nice to get rid of, but it's a lot of churn.
> 
> So I'm hoping people with either say "YES this is a great idea", or "NO
> this is stupid".
> 
> As step one I've just renamed as many routines as I could find to see
> what the resulting patch looks like, so we can quantify the churn. I
> also did device.of_node, which is used quite a bit.
> 
> Thoughts?

I'm looking at it the other way. There are inconsistencies in naming of
symbols and files we definitely should clean up. Since we're doing that,
let's take the opportunity to move from of* to dt*. With multiple
architectures adding device tree support, this is about the last chance
to do this without impacting too many people.
-- 
David VL
