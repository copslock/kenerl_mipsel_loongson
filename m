Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2008 17:33:25 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:36015 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28576285AbYHOQdQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2008 17:33:16 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KU2El-0008CS-00; Fri, 15 Aug 2008 18:33:15 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 160C6C3170; Fri, 15 Aug 2008 18:33:02 +0200 (CEST)
Date:	Fri, 15 Aug 2008 18:33:02 +0200
To:	C Michael Sundius <Michael.sundius@sciatl.com>
Cc:	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	linux-mips@linux-mips.org, jfraser@broadcom.com,
	Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
Message-ID: <20080815163302.GA9846@alpha.franken.de>
References: <48A4AC39.7020707@sciatl.com> <1218753308.23641.56.camel@nimitz> <48A4C542.5000308@sciatl.com> <20080815080331.GA6689@alpha.franken.de> <1218815299.23641.80.camel@nimitz> <48A5AADE.1050808@sciatl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48A5AADE.1050808@sciatl.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Aug 15, 2008 at 09:12:14AM -0700, C Michael Sundius wrote:
> yes,  actually the top two bits are used in MIPS as segment bits.

you are confusing virtual addresses with physcial addresses. There
are even 32bit CPU, which could address more than 4GB physical
addresses via TLB entries.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
