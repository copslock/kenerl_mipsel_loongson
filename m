Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2008 17:31:10 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:29103 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28576118AbYHOQbD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2008 17:31:03 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KU2Cb-0007Zt-00; Fri, 15 Aug 2008 18:31:01 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 85E8BC316F; Fri, 15 Aug 2008 18:30:20 +0200 (CEST)
Date:	Fri, 15 Aug 2008 18:30:20 +0200
To:	Dave Hansen <dave@linux.vnet.ibm.com>
Cc:	C Michael Sundius <Michael.sundius@sciatl.com>, linux-mm@kvack.org,
	linux-mips@linux-mips.org, jfraser@broadcom.com,
	Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
Message-ID: <20080815163020.GA9554@alpha.franken.de>
References: <48A4AC39.7020707@sciatl.com> <1218753308.23641.56.camel@nimitz> <48A4C542.5000308@sciatl.com> <20080815080331.GA6689@alpha.franken.de> <1218815299.23641.80.camel@nimitz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1218815299.23641.80.camel@nimitz>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Aug 15, 2008 at 08:48:19AM -0700, Dave Hansen wrote:
> My guess would be that Michael knew that his 32-bit MIPS platform only
> ever has 2GB of memory.

that's the point, which isn't quite correct. It's possible for
a 32bit MIPS system to address 4GB of memory (minus IO). That's
one case where the 31bits don't fit, the other case is a 64bit CPU
running a 32 bit kernel (CONFIG_64BIT selects whether it's a 32bit or
64bit kernel). I'm not whether it's worth to cover both cases, but it's
more restrictive than it's without that change.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
