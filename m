Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2005 18:14:03 +0000 (GMT)
Received: from fw.osdl.org ([IPv6:::ffff:65.172.181.6]:44463 "EHLO
	mail.osdl.org") by linux-mips.org with ESMTP id <S8225274AbVATSN4>;
	Thu, 20 Jan 2005 18:13:56 +0000
Received: from build.pdx.osdl.net (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with ESMTP id j0KIDpl09021;
	Thu, 20 Jan 2005 10:13:51 -0800
Received: (from chrisw@localhost)
	by build.pdx.osdl.net (8.11.6/8.11.6) id j0KIDp716721;
	Thu, 20 Jan 2005 10:13:51 -0800
Date:	Thu, 20 Jan 2005 10:13:51 -0800
From:	Chris Wright <chrisw@osdl.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Chris Wright <chrisw@osdl.org>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips default mlock limit fix
Message-ID: <20050120101351.J24171@build.pdx.osdl.net>
References: <20050119175945.K469@build.pdx.osdl.net> <20050120160005.GA5672@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050120160005.GA5672@linux-mips.org>; from ralf@linux-mips.org on Thu, Jan 20, 2005 at 05:00:05PM +0100
Return-Path: <chrisw@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chrisw@osdl.org
Precedence: bulk
X-list: linux-mips

* Ralf Baechle (ralf@linux-mips.org) wrote:
> On Wed, Jan 19, 2005 at 05:59:45PM -0800, Chris Wright wrote:
> 
> > Mips RLIMIT_MEMLOCK incorrectly defaults to unlimited, it was confused
> > with RLIMIT_NPROC.  Found while consolidating resource.h headers.
> 
> Thanks, I applied a recent change off by one line.  To avoid this I've
> changed the code to use named initializers, see
> 
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-cvs-patches&i=95f18dfc8e770c9885b796a676935677%40NO-ID-FOUND.mhonarc.org

That works too.  I made a similar change in the consolidation patch.  This
was just meant to be a very simple stop gap fix, while the consolidation
bits bake in -mm before they go to Linus.  I prefer to leave it as is,
only so I don't have to respin the patches, but it's not that big a deal.
Either way, Linus should pick up one of the mips fixes.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
