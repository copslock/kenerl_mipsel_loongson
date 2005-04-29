Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2005 12:03:48 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:5655 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225970AbVD2LDe>; Fri, 29 Apr 2005 12:03:34 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3TB30Vk017145;
	Fri, 29 Apr 2005 12:03:00 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3TB2xoc017144;
	Fri, 29 Apr 2005 12:02:59 +0100
Date:	Fri, 29 Apr 2005 12:02:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	linux-mips@linux-mips.org, TheNop@gmx.net
Subject: Re: your mail
Message-ID: <20050429110258.GE5951@linux-mips.org>
References: <20050428191608Z8225923-1340+6320@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428191608Z8225923-1340+6320@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 28, 2005 at 03:15:49PM -0400, Bryan Althouse wrote:

> I would like to use a 2.6.x kernel with my Yosemite/HalfDome board.
> Somehow, I am unable to compile the kernel.  I have tried the 2.6.10 kernel
> trees from ftp.pmc-sierra.com and also the latest 2.6.12 snapshot from
> linux-mips.  I am using the 3.3.x cross compile tools from
> ftp.pmc-sierra.com .  The 2.4.x kernels from PMC compile fine.
> 
> In the case of 2.6.10 from ftp.pmc-sierra.com, my error looks like:
>        Make[3]: *** [drivers/char/agp/backend.o] Error 1

Configuring AGP support for a MIPS kernel is obviously nonsense.  Disable
CONFIG_AGP.

> In the case of 2.6.12 from linux-mips, my error looks like:
> 	drivers/net/titan_ge.c1950: error: 'titan_device_remove"  undeclared
> here (not in a function)

Whoops, a bug.  The function indeed doesn't exist even though it should,
will fix that.  You will hit this bug only if compiling the titan driver
as a module, so workaround set CONFIG_TITAN_GE=y.  Which for the typical
titan-based device seems to be the preferable choice anyway.

  Ralf
