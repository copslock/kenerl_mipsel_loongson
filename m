Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2009 22:32:10 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:62470 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20026265AbZEKVcF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 May 2009 22:32:05 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n4BLVsTN006779;
	Mon, 11 May 2009 14:31:54 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 11 May 2009 14:31:54 -0700
Received: from yow-pgortmak-d1.corp.ad.wrs.com ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 11 May 2009 14:31:53 -0700
Received: from paul by yow-pgortmak-d1.corp.ad.wrs.com with local (Exim 4.69)
	(envelope-from <paul.gortmaker@windriver.com>)
	id 1M3d3s-0000Av-Um; Mon, 11 May 2009 17:29:24 -0400
Date:	Mon, 11 May 2009 17:29:24 -0400
From:	Paul Gortmaker <paul.gortmaker@windriver.com>
To:	David VomLehn <dvomlehn@cisco.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/3] mips:powertv: Make kernel command line size
	configurable (resend)
Message-ID: <20090511212924.GA25832@windriver.com>
References: <20090504225719.GA22417@cuplxvomd02.corp.sa.net> <7d1d9c250905080825n62f46b2bk254a736d3bce2ec6@mail.gmail.com> <20090508163400.GA5466@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090508163400.GA5466@cuplxvomd02.corp.sa.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 11 May 2009 21:31:54.0022 (UTC) FILETIME=[E74FDC60:01C9D27F]
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips

[Re: [PATCH 2/3] mips:powertv: Make kernel command line size configurable (resend)] On 08/05/2009 (Fri 09:34) David VomLehn wrote:

> On Fri, May 08, 2009 at 11:25:35AM -0400, Paul Gortmaker wrote:
> > On Mon, May 4, 2009 at 6:57 PM, David VomLehn <dvomlehn@cisco.com> wrote:
> > > Most platforms can get by perfectly well with the default command line size,
> > > but some platforms need more. This patch allows the command line size to
> > > be configured for those platforms that need it. The default remains 256
> > > characters.
> > 
> > The one thing I see when I look at this patch, is that it lands in the
> > arch/mips/Kconfig -- but is there really anything fundamentally
> > architecture specific about the allowed length of the kernel command
> > line?.  It probably belongs somewhere alongside the setting for
> > LOG_BUF_LEN or similar (and then add the other respective changes
> > to make all arch actually respect the setting.)
> > 
> > Paul.
> > 
> > >
> > > Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> > > ---
> > >  arch/mips/Kconfig             |    7 +++++++
> > >  arch/mips/include/asm/setup.h |    2 +-
> 
> The reason I put this configuration configuration in the architecture-
> specific Kconfig is because COMMAND_LINE_SIZE is defined in the
> architecture-specific file arch/mips/include/asm/setup.h. I strongly
> agree that this really should not be an architecture-specific definition,
> but it's much more complex to get a patch to change COMMAND_LINE_SIZE
> in every architecture. Fixing in the MIPS tree seems like a good
> start.

It shouldn't be much more complex, at least from a purely technical
point of view (i.e assuming no arch maintainers have a problem with it).
Now, if we tried to get all arch to agree on the same default value,
then I agree that might be more complex/interesting.

All the arch use pretty much the same boilerplate, so something like
this untested patch should work.  I thought about hiding it behind
CONFIG_EMBEDDED, but in theory a person could have some big server
blade with a long command line argument too....

Paul.
---------
