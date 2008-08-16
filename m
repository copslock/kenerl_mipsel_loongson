Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Aug 2008 21:08:07 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:44525 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20025183AbYHPUH4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 16 Aug 2008 21:07:56 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KUS42-0000KS-00; Sat, 16 Aug 2008 22:07:54 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 2D738C3171; Sat, 16 Aug 2008 22:07:14 +0200 (CEST)
Date:	Sat, 16 Aug 2008 22:07:14 +0200
To:	Dave Hansen <dave@linux.vnet.ibm.com>
Cc:	C Michael Sundius <Michael.sundius@sciatl.com>, linux-mm@kvack.org,
	linux-mips@linux-mips.org, jfraser@broadcom.com,
	Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
Message-ID: <20080816200714.GA7041@alpha.franken.de>
References: <1218753308.23641.56.camel@nimitz> <48A4C542.5000308@sciatl.com> <20080815080331.GA6689@alpha.franken.de> <1218815299.23641.80.camel@nimitz> <48A5AADE.1050808@sciatl.com> <20080815163302.GA9846@alpha.franken.de> <48A5B9F1.3080201@sciatl.com> <1218821875.23641.103.camel@nimitz> <48A5C831.3070002@sciatl.com> <1218824638.23641.106.camel@nimitz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1218824638.23641.106.camel@nimitz>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Aug 15, 2008 at 11:23:58AM -0700, Dave Hansen wrote:
> On Fri, 2008-08-15 at 11:17 -0700, C Michael Sundius wrote:
> > 
> > diff --git a/include/asm-mips/sparsemem.h
> > b/include/asm-mips/sparsemem.h
> > index 795ac6c..64376db 100644
> > --- a/include/asm-mips/sparsemem.h
> > +++ b/include/asm-mips/sparsemem.h
> > @@ -6,7 +6,7 @@
> >   * SECTION_SIZE_BITS           2^N: how big each section will be
> >   * MAX_PHYSMEM_BITS            2^N: how much memory we can have in
> > that space
> >   */
> > -#define SECTION_SIZE_BITS       28
> > +#define SECTION_SIZE_BITS       27     /* 128 MiB */
> >  #define MAX_PHYSMEM_BITS        35
> 
> This looks great to me, as long as the existing MIPS users like it.

sounds good, I like it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
