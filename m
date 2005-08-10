Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2005 16:12:00 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:6152 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225244AbVHJPLl>; Wed, 10 Aug 2005 16:11:41 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7AFFeqT014628;
	Wed, 10 Aug 2005 16:15:40 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7AFFdI1014627;
	Wed, 10 Aug 2005 16:15:39 +0100
Date:	Wed, 10 Aug 2005 16:15:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 24K malta
Message-ID: <20050810151539.GG2840@linux-mips.org>
References: <42FA03D4.5060400@timesys.com> <20050810140243.GD2840@linux-mips.org> <42FA0B9E.4030900@timesys.com> <42FA1311.4060903@timesys.com> <20050810144947.GE2840@linux-mips.org> <42FA1698.2060104@timesys.com> <20050810150934.GF2840@linux-mips.org> <42FA19BF.7040208@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FA19BF.7040208@timesys.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 10, 2005 at 11:14:07AM -0400, Greg Weeks wrote:

> >You have CONFIG_MT enabled but your binutils don't support these new
> >instructions yet.  Since you're using 4K and 24K CPUs only ATM I think
> >you should simply disable CONFIG_MT for now.
> >
> > 
> >
> Just turning off the vpe loading support got me past this one. I don't 
> think I have CONFIG_MT set.

Sorry, I meant CONFIG_MIPS_MT.

  Ralf
