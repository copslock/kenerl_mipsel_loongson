Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2005 15:23:08 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:44568 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133555AbVKOPWt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Nov 2005 15:22:49 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAFFOfH5023992;
	Tue, 15 Nov 2005 15:24:41 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAFFOc8b023991;
	Tue, 15 Nov 2005 15:24:38 GMT
Date:	Tue, 15 Nov 2005 15:24:37 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	Sergei Shtylylov <sshtylyov@ru.mvista.com>,
	Linux MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [Fwd: mtd/drivers/mtd/nand au1550nd.c,1.13,1.14]
Message-ID: <20051115152437.GA15733@linux-mips.org>
References: <43779854.5040307@ru.mvista.com> <1131911400.11644.84.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131911400.11644.84.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 13, 2005 at 11:49:59AM -0800, Pete Popov wrote:

> On Sun, 2005-11-13 at 22:47 +0300, Sergei Shtylylov wrote:
> > Hello.
> > 
> >     Thought it's worth forwarding this here...
> 
> Just FYI, the patch is in the mtd tree only right now. It will get to
> linux-mips when Ralf does a pull.

(This is less a direct comment to you posting than a general advice to
people about what's going on in the git archive ...)

On the master (that is 2.6) branch I'm doing that about once a day.

This also means people are living dangerous if checking out the head of
the master branch.  Who doesn't want to participate in debugging all this
mess is probably better or to checkout one of the tagged releases.

Also not that Linus only change the version number in the Makefile when
he does a release.  That means for example until he releases 2.6.14-rc1
the Makefile will still say 2.6.14 - even though the diff may be huge,
well above 150,000 lines in this case.

  Ralf
