Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 15:42:41 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:16392 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224974AbVHZOmW>; Fri, 26 Aug 2005 15:42:22 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7QEm0oY011825;
	Fri, 26 Aug 2005 15:48:00 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7QEm0rJ011824;
	Fri, 26 Aug 2005 15:48:00 +0100
Date:	Fri, 26 Aug 2005 15:47:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kishore K <hellokishore@gmail.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Preemption patch for 2.4.26 - mips
Message-ID: <20050826144759.GA2712@linux-mips.org>
References: <f07e6e050825065756c3ac27@mail.gmail.com> <20050825153219.GB2731@linux-mips.org> <f07e6e0508260717428bbdd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07e6e0508260717428bbdd0@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 26, 2005 at 08:17:43PM +0600, Kishore K wrote:

> On 8/25/05, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Straight Kernel.org kernels don't work for MIPS nor do the mentioned
> > patches.
> > 
> I could bring up the malta board with vanilla linux kernels (2.4.25 -
> 2.4.31) from kernel.org. Just curious to know, what extra features we
> get from linux-mips kernels?

Generally the MIPS code in kernel.org is simply lagging far behind
linux-mips.org and is not tested at all on MIPS.  There are also various
bits in 2.4 that were necessary for some platforms but which for the one
or other reason won't wasn't merged.

  Ralf
