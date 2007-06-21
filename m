Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2007 00:08:18 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:52453 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20021956AbXFUXIQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Jun 2007 00:08:16 +0100
Received: (qmail 15180 invoked by uid 101); 21 Jun 2007 23:07:07 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by mother.pmc-sierra.com with SMTP; 21 Jun 2007 23:07:07 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l5LN73GQ004097;
	Thu, 21 Jun 2007 16:07:06 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNW7TNP>; Thu, 21 Jun 2007 16:07:03 -0700
Message-ID: <467B0492.1080007@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Satyam Sharma <satyam.sharma@gmail.com>
Cc:	Christoph Hellwig <hch@infradead.org>,
	Satyam Sharma <satyam.sharma@gmail.com>,
	Tom Spink <tspink@gmail.com>,
	Toralf F?rster <toralf.foerster@gmx.de>,
	linux-kernel@vger.kernel.org,
	Paolo Giarrusso <blaisorblade@yahoo.it>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
	Brian Oostenbrink <Brian_Oostenbrink@pmc-sierra.com>,
	Dan Doucette <Dan_Doucette@pmc-sierra.com>
Subject: Re: build failure due to ROOT_DEV in mtd module (was Re: linux-2.
	6.22-rc5-g7c8545e build #298 failed ...)
Date:	Thu, 21 Jun 2007 16:06:58 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 21 Jun 2007 23:06:59.0299 (UTC) FILETIME=[DEE48B30:01C7B458]
user-agent: Thunderbird 1.5.0.12 (X11/20070509)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

> On Thu, Jun 21, 2007 at 04:13:27 EST, Satyam Sharma wrote:
> On 6/21/07, Christoph Hellwig <hch@infradead.org> wrote:
>> On Thu, Jun 21, 2007 at 12:22:01PM +0530, Satyam Sharma wrote:
>> > >> The build seems to fail because of:
>> > >> ERROR: "ROOT_DEV" [drivers/mtd/maps/nettel.ko] undefined!
>> > >>
>> > >> After taking a quick look at the code, I can't immediately see why
>> > >> this would be, since there is an include for linux/root_dev.h at the
>> > >> top, there.
>> > >>
>> > >> There's only one occurrence of ROOT_DEV (line 425), and after a quick
>> > >> look at the git history, it seems the include was originally missing,
>> > >> but was put back in, in commit
>> > >> 6cc449c7d0292cb9b993f0df84fd3225e3099492.
>>
>> Please just the reference to ROOT_DEV from this driver.  Just because
>> someone builds this driver there should be no change in the default root
>> device.
> 
> I agree, but this (drivers/mtd/maps/nettel.c) isn't the only modular driver
> referencing ROOT_DEV. We also have drivers/mtd/maps/pmcmsp-ramroot.c
> using ROOT_DEV (in fact the purpose of that driver seems to be precisely
> to special-case the root fs and do something with it ...) but considering
> that other driver's (tristate) Kconfig option depends on another symbol that
> is non-existent in the mainline tree, there is no way someone can build
> pmcmsp-ramroot and so we'll never actually  hit that problem even with an
> allmodconfig build.
> 
> Anyway, I'll leave this up to David / linux-mtd to sort out. [ No other
> modular user of ROOT_DEV in the tree other than the two mtd drivers
> mentioned here. ]han the two mtd drivers
> mentioned here. ]]

Hi Satyam,

The support for the platform which introduced drivers/mtd/maps/pmcmsp-ramroot.c
is being queued in the linux-mips tree at linux-mips.org. At some point it should
work it's way to the main tree and be buildable.

Marc
