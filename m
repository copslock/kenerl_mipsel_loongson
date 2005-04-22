Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2005 21:27:58 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:43027 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225073AbVDVU1n>; Fri, 22 Apr 2005 21:27:43 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3MKRe0t032696;
	Fri, 22 Apr 2005 21:27:40 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3MKReKY032695;
	Fri, 22 Apr 2005 21:27:40 +0100
Date:	Fri, 22 Apr 2005 21:27:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Clem Taylor <clem.taylor@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: troubles writing to a mmapped PCI BAR
Message-ID: <20050422202740.GY20252@linux-mips.org>
References: <ecb4efd10504211231748d2525@mail.gmail.com> <ecb4efd105042213221c30cac4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb4efd105042213221c30cac4@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 22, 2005 at 04:22:53PM -0400, Clem Taylor wrote:

> So I tried adding this before my io_remap_page_range() and it seems to
> have fixed my problem. My mmap() write to a PCI device is working now.
> I tried setting just the _PAGE_DIRTY bit and that seems to be the
> trick. Any ideas why I would need do to this or what is going on?

Without the process simply won't have access priviledges to that page, see
the TLB chapter of the CPU manual.

(I'm simplifying things alot here.)

  Ralf
